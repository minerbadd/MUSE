--[[
## Functions, State, and History: `lib/motion` for Turtle Motion

The first chunk of code using ComputerCraft that we'll look at is the `lib/motion` module. Of course, it's about moving turtles. Each <a href="https://en.wikipedia.org/wiki/Library_(computing)" target="_blank">
_library_</a>, in the module is a collection of code elements for moving turtles in some way. Libraries often build upon each other. That's the case for MUSE and since `lib/motion` is fundamental in that build, it's where we'll start our exploration. It's the first module we'll look at so we'll be thrashing through some basic code organization and code fundamentals pretty hard. Spoonful of sugar time I'm afraid.

We'll use this module to illustrate how functions, a fundamental part of Lua, are used to implement these libraries. We'll also use it to introduce some ideas for managing the <a href="https://en.wikipedia.org/wiki/State_(computer_science)" target="_blank">
_state_</a> of a turtle and handling the history of that state.

#Introduction and Exports: the overview
To help readers and maintainers understand a module, it's useful to organize it by leading it off with an introductory section. We can look at the introduction of this module to get an overall understanding of what it does, its <a href="https://en.wikipedia.org/wiki/Global_variable" target="_blank">
_global_</a> references to elements outside the module, and its local constants. As shown below, a MUSE module starts off with a description of the module, the first part of the introduction. The `motion` module includes two libraries, `move`, and `step` as noted in the CodeMark `API` <a href = "../CodeMark/Annotations.html#file-marks " target = "_blank"> file mark</a>. Following the `API` filemark, the `LIB` <a href = "../CodeMark/Annotations.html#reference-marks " target = "_blank"> reference mark</a> lists the libraries included in the module. Since it's not otherwise named, the module name itself is included with the libraries in the `LIB` reference mark. Annotated type declarations not particular to either the `move` or `step` library are saved in the project's API file in a dictionary with that name.
```Lua
--]]
--:! {move: []: (:), step: []: (:): (:) } <- **Move and Step Function Libraries** -> muse/docs/lib/motion.md  
--:| motion: _Libraries to move turtles and move turtles by steps allowing operations at each step._ -> motion, move, step
--:+ move: **Position setting, tracking, and reporting by dead reckoning checked by fuel consumption.**  
--:+ step: **Iterators (closures) for moving block by block, potentially doing operations at each block.**

--:# _Provide fuel level check to validate a dead reckoning move, can track movement for retracing move as a trail._  
--:+ _Report error conditions `"blocked"`, `"lost"` (for apparent but invalid movement), `"empty"` (for no fuel)._  
--:+ _Throw some errors as tables rather than strings to allow for attempted recovery operations._ 
--[[
```
The first line of the introduction above sets the stage. It tells us that moving turtles is implemented using tables (as dictionaries) of `move` functions and of something we've called `step` functions (producing <a href="https://en.wikipedia.org/wiki/Closure_(computer_programming)" target="_blank">
_closures_)</a> . It exports these functions as libraries producing APIs whose <a href="https://en.wikipedia.org/wiki/Markdown" target="_blank">_Markdown_</a> documentation, `muse/docs/lib/motion.md`, is found in the `docs` sub-directory of the `muse` project directory. Below are those tables of exported functions. We'll fill them in as we go.
```Lua
--]]
local move, step = {}, {} -- for exports
--[[
```
The library checks to see that fuel is consumed for all turtle movements that are supposed to have consumed fuel. <a href="https://en.wikipedia.org/wiki/Dead_reckoning" target="_blank">
_Dead reckoning_</a> 
keeps track of the whereabouts of the turtle depending on its supposed movement. It does this by updating the <a href="https://en.wikipedia.org/wiki/State_(computer_science)" target="_blank">
_state_</a> representing turtle position and orientation, that is, the `xyz` co-ordinates and the direction the turtle is facing. Doing this for every instructed turtle movement, it assumes a valid starting position and orientation. It checks that each instructed movement actually occurred. If fuel was not consumed by a movement that was reported to have been done successfully, dead reckoning has failed: the turtle is presumed `"lost"`.  If movement was attempted but reportedly failed, the turtle is said to be `"blocked"`. If the turtle is out of fuel, and the attempt to refuel failed, the turtle is presumed `"empty"`.

The `"lost"`, `"blocked"`, and `"empty"` conditions each raise an `error` reported to callers of `lib/motion` (and to their callers in turn).  The caller, for example `lib/roam` (discussed in another chapter), may attempt recovery operations depending on the error information or might just report the error.

As mentioned, the exported APIs for these libraries is provided in two tables of functions: `move` and `step`.  We populate these tables with function definitions as we go through the implementation. Doing this will make clear that the function is visible outside the library. Loading the library with `require` returns these tables. Just below we'll see that done for libraries that `lib/motion` depends on.

The `lib/motion` libraries fit into a larger context.  That context is described by global references and dependencies on other libraries. (The `@diagnostic` annotation below signals to the IDE nanny that I know what I'm doing: there's nothing to see here.) The `@module` anotations tell the <a href="https://luals.github.io/wiki/annotations/" target="_blank"> Lua Language server</a>, LLS, where to find the information needed to check references to functions exported, used by and external to this module. (The particular way the external references are made local to this module seemed to be how LLS needed them.) 

Here's what all that looks like for these libraries:
```Lua
--]]
---@module "signs.motion"
---@diagnostic disable-next-line: undefined-field
local rednet, Muse = _G.rednet, _G.Muse -- globals preserved across programs, not persistent
local cores = require("core"); local core = cores.core ---@module "signs.core" 
---@diagnostic disable-next-line: undefined-field
local turtles = require("mock"); local turtle = _G.turtle or turtles.turtle ---@module "signs.mock"
--[[
```  
All the MUSE globals are collected in a single global table, `_G.Muse`, to avoid litter. The table is initialized <a href="../.start.html" target="_blank"> at startup</a> to the empty table if it doesn't yet exist. It is bound to a variable, `Muse`, local to the module (just to save a few cycles when referencing it). The `rednet` local variable is used to determine whether execution is in the game or in a test environment we'll discuss in just a bit: it is bound to `nil` unless running in the game environment.

Each ComputerCraft computer including turtles and pocket computers have their own set of globals. These globals are not persistent. They don't stick around after server shutdown, that is, between <a href="https://en.wikipedia.org/wiki/Session_(computer_science)" target="_blank">_sessions_</a>.  
However, they do stick around between program executions within a session; they survive <a href="https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)" target="_blank">
_garbage collection_</a>. Except for the MUSE and ComputerCraft globals, each program stands on its own, loading just those libraries it needs. (Later we'll look at the programs available in the MUSE environment.) 

The `lib/motion` libraries are quite low level.  A number of other libraries are built upon the functions exported here. As indicated however, they do use some functions exported from `lib/core`, a collection of generally useful routines for MUSE libraries and programs. We'll get to those as we come across them. The functions are made available to these libraries in a table generated by applying the `require` function on the `lib/core` library file. 

The `_G.turtle` table includes references to the ComputerCraft turtle API functions in-game. However, it turns out to be very helpful to do development in an <a href="https://en.wikipedia.org/wiki/Integrated_development_environment" target="_blank">
_IDE_</a>, an integrated development environment, outside the ComputerCraft game. To do so we need mock ups of the most critical `turtle` functions. These are in the `lib/mock.lua` library file. The `turtle` table provides references to functions from ComputerCraft when running in the game environment. It provides references to corresponding mock turtle functions when running in the IDE (for testing and debugging).

We spoke about dead reckoning turtle state earlier. This state is collected in the `_G.Muse.situation` <a href="https://en.wikipedia.org/wiki/Associative_array" target="_blank">
_dictionary_</a>, a table indexed (keyed) by named fields. If there isn't one of these when the `lib/motion` library is loaded, a default set is provided (generally, for testing out of game in the IDE). Cleanly managing this state is one of the implementation issues we'll need to address. 

A turtle's `situation` includes its position (as a keyed table of numbers) for its `x`, `y`, and `z` Minecraft coordinate values, its orientation (as a string) for the direction it's facing), its fuel (as a number), and an indication (as a string) of whether its level, the y-coordinate in ComputerCraft, is rising, falling, or staying the same . A `situation` table includes named fields, keys, for `position`, `facing`, `fuel`, and `level`. Here's how that's annotated with CodeMark type declarations. We'll use the definitions for `position` and `facing` throughout MUSE so we document those independently from their inclusion in a `situation`.
```lua
--]]
--:# **State variables for turtle motion:** (maintained across programs within session, not persistent beyond that).
--:> situation: _Dead reckoning_ -> `{position:position, facing:facing, fuel: situation.fuel, level: situation.level}`
--:> situation.fuel: _Simulated fuel level checked against reported fuel to validate dead reckoning_ -> `#:`
--:> situation.level: _For tracking_ -> `"same"|"rise"|"fall"`

--:> position: _Computercraft co-ordinates (+x east, +y up, +z south)_ -> `{x: #:, y: #:, z: #:}`
--:> facing: _For movement in four NESW cardinal directions_ -> `"north"|"east"|"south"|"west"` 

--:> situations: _Tracking history_ -> `situation[]`

Muse.situation = Muse.situation or {position = {x=0, y=0, z=0}, facing = "north", fuel = 0, level = "same"} -- out game testing
Muse.situations = Muse.situations or {}; -- for session
--[[
  ```
As we'll see, these libraries provide a tracking facility for repeated movement back and forth along a `trail` defined by certain changes in a turtle's `situation`. Trails (`Muse.situations`) represent a history of turtle state accumulated in a numerically indexed table, each element of which is a (copy of a) `situation`. Generally turtles are not tracked but they can be by calls to `turtle.tracking(true)`. 

Data structures like these are some of the most pervasive and long lasting elements of a design. You and the aliens from another planet will be working with them for a long time. Some thought about that could payoff in maintenance.

So much for the introduction.  To know what a MUSE module file exports look at the end of the file. At the end of `lib/motion` we find:
```Lua
return {move = move, step = step}
```
No surprise here. As promised in the first lines of the file, this module exports a table providing two tables of functions. Each table for each exported library. One table is for `move` functions. These functions are fairly obvious in nature. The other, a mostly parallel set, is for `step` functions. These, as noted in the introduction, produce Lua <a href="https://www.lua.org/pil/7.1.html" target="_blank">_iterators_</a>. The `lib/motion` iterators step turtle movement through a count (default 1) of movements in a direction (or to a position) one step at a time.  Operations defined in the body of the `do` loop controlled by the iterator are executed at each step of the movement. This turns out to be useful later.

The module's CodeMark <a href="../../docs/lib/motion.html" target="_blank"> documentation</a> tells you about each (exported) function in terms of its `parameters` `->` `operation` `->` `values` (returned). Some parameters are documented as optional: `?` and may suggest a default value. The <a href = "../CodeMark/Annotations.html#type" target = "_blank"> type</a> of parameters and return values are also documented: numbers as `#:`, strings as `":"`, tables as `{:}`, functions as `(:)` The unspecified type is annotated as `any`. An ignored item is indicated by `_:`. Parameters and return values may be tagged with a label followed by a colon to provide information to the language server. Sometimes a parameter's name is the same as its definition as in the annotation for `move.get` below. We'll see these annotations when looking at a library's summary documentation.

#Foundation (Utility) Functions
It helps to define utility functions used in the module toward the beginning of the file. They are referenced throughout. The ones for `lib/motion` are pretty simple. They define an interface to a turtle's `situation` state to provide better hygiene than working directly with the corresponding globals.
```Lua
--]]
--:## **Some Utilities: position reporting and setting:**
function move.get(situation) 
  --:: move.get(:situation:?) -> _Default current situation._ -> `x: #:, y: #:, z: #:, facing: ":", fuel: #:, level: ":"`
  local s = situation or Muse.situation; local p = s.position; 
  return tonumber(p.x), tonumber(p.y), tonumber(p.z), s.facing, s.fuel, s.level
end

core.get = move.get -- overrides the dummy binding in `lib/core`

local function facing(situation) local s = situation or Muse.situation; return s.facing end 
-- facing(:situation:?) -> _Default current situation's facing._ -> `facing: ":"`
local function fuel(situation) local s = situation or Muse.situation; return s.fuel end
-- fuel(:situation:?) -> _Default current situation's fuel_ -> `fuel: #:`
local function setFuel(value) Muse.situation.fuel = value; return value end
-- setFuel(value: #:) -> _Set current situation's fuel._ -> `fuel: #:`
function move.track(enable) Muse.tracking.enabled = enable; return enable end
--:: move.track(enable: ^:) -> _Set tracking condition_ -> `enable: ^:`
function move.set(x, y, z, f, fuel, level)
  --:: move.set(x: #:, y: #:, z: #:, f: facing?, fuel: #:??, level: ":"???) -> _Set position, optionally rest of situation._ -> `nil`
  local s = Muse.situation; s.position = {x = tonumber(x), y = tonumber(y), z = tonumber(z)}; 
  if f then s.facing = f end; if fuel then s.fuel = fuel end; if level then s.level = level end
end

core.set = move.set -- protect from override 
--[[
```
<a id="globals"/> ```
#Globals Considered Harmful
Globals are often <a href="https://dl.acm.org/doi/pdf/10.1145/953353.953355" target="_blank">bad hygiene</a>, a hole into which much maintenance can be and has been poured. They're used here as discussed earlier, because they will hang around in the face of garbage collection. Setting globals (changing their value) is particularly stinky hygiene. There's often a long, expensive chase to track down where a global's value has been changed. Lua has good support for <a href="https://en.wikipedia.org/wiki/Information_hiding" target="_blank">
_information hiding_</a> as Lua locals are not visible outside the file chunk (or block) in which they are defined.  Globals break that model. Exposing the `move.set` API covers a mutation with a critical fig leaf. We can put a 
<a href="https://en.wikipedia.org/wiki/Breakpoint" target="_blank">
_breakpoint_</a> on  calls to this fig leaf. This is better hygiene than fiddling with the associated global directly. The function is made available in the `lib/core` library. (There's special attention in loading that library to prevent overriding this binding and that of `core.get` and `core.ats` needed for bootstrapping).

The local function global mutators are collected together here as well. (Yes, that's pretty fastidious.)

There's a design decision in foregoing the introduction of 
<a href="https://en.wikipedia.org/wiki/Object-oriented_programming" target="_blank">
_objects_</a>. Lua provides primitives that can be used to organize state into objects, another means of localizing state. We don't need to introduce the associated concepts here since we:
<ul>
<li>get information hiding from Lua's scoping rules for chunks, and</li>
<li>don't need to build an 
<a href="https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)" target="_blank">
_inheritance_</a> system for what's done, for example, with a `situation`.</li>
</ul>

Implicitly there's another design decision in arranging to modify `situation` state rather than creating a new `situation` for each change (and relying on the garbage collector to dispose of the detritus) . A 
<a href="https://en.wikipedia.org/wiki/Functional_programming" target="_blank">
_purely functional style_</a> would require creating a new `situation` table for every change in turtle position or orientation. At the cost of that purity, the decision here is to only create a new situation, cloning one from the current `situation`, when we need the old situation in `situations`, a `situation` history. MUSE uses that history to optionally provide `tracking`. The history records (and clones) position and orientation only when either orientation or the kind of vertical movement changes.
```Lua
--]]
function move.situations(situations) Muse.situations = situations; return situations end
--:: move.situations(:situations:) -> _Set `_G.Muse.situations` to situations._ -> situations
function move.clone() -- easy cloning
--:: move.clone() -> _Clone current situation_ -> situation
  local x, y, z, facing, fuel, level = move.get() 
  return {position = {x = x, y = y, z = z}, facing = facing, fuel = fuel, level = level} 
end

function move.clones() return core.clone(Muse.situations) end
--:: move.clones() -> _Deep copy `_G.Muse.situations`._ ->  situations
--[[
```
<a id="clone"/>
#Here Come the Clones
The history of `situations` represented by the global state `_G.Muse.situations` needs isolation just as `G.Muse.situation` does.

There is a bigger issue here though. Making a copy of a table is an explicit operation. Binding a name to a Lua table (for example the `situations` table) just provides a name for the underlying table. It doesn't make a copy of the table; binding a table to a new name does only that. No new table is created. If some operation changes something in that table, any references to that table, new name or old, will reflect that change. In the code above, we make a new table to save <a href="https://en.wikipedia.org/wiki/Cloning_(programming)" target="_blank">
(_clone_)</a> a `situation` just as it was when added to the `situations` table.

(Cloning the `_G.Muse.situations` history in `move.clone` needs a more general approach to cloning than cloning a single situation as in `move.clone`. Follow the <a href="core.html#clone" target="_blank"> link</a> to the `lib/core` function, `core.clone`, to see how this is done.)

Back to simple stuff, here are some utilty functions to provide turtle position data:
```Lua
--]]
function move.at(situation) local x, y, z, f = move.get(situation); return {x, y, z, f} end
--:: move.at(:situation:?) -> _(Current) situation xyzf._ -> `xyzf`
function move.ats(situation)
--:: move.ats(:situation:?) -> _(Current) situation position and facing string (`""` in game if not turtle)._ -> `xyzf: ":"`
---@diagnostic disable-next-line: undefined-field
  local x, y, z, f = move.get(situation); return (_G.turtle or not rednet) and "{"..x..", "..y..", "..z.."}, "..(f or "") or ""
end
--[[
```
<a id="ats"></a>
#Where Oh Where
The function `move.ats` returns a string representation of a turtle's position. It parallels `move.at` which returns a table of numbers for that position. There's a bit of complexity introduced in the implementation of `move.ats` since it's used out-of-game in the IDE as well as in-game. A Lua idiom for the <a href="http://lua-users.org/wiki/TernaryOperator" target="_blank"> _ternary operator_</a> is used to return a string representing the `situation.position` if the condition, `(_G.turtle or not rednet)`, is met and the empty string, `""`, if it is not. In the out-of-game test environment `rednet` is `nil` (as is `_G.turtle`) so a string including the turtle's position and orientation is returned. In-game, `rednet` is `true` and `_G.turtle` is true only for turtles so in-game other than for turtles just the empty string is returned.

Calls to the <a href="core.html#ats"> `core.ats` </a> function supports an instrumentation system defined in `lib/core` that we'll discuss later.
```Lua
--]]
core.ats = move.ats -- protect from override
--[[
```
Look at the <a href="core.html#where" target="_blank"> implementation </a> of `core.where` to see how function bindings are used to handle in-game and out-game environments.
```Lua
--]]
function move.where(tx, ty, tz, tf) -- where's the turtle?
--:: move.where(tx: #:?, ty: #:?, tz: #:?, tf: ":"?) -> _Returns GPS results if available._ -> `x: #:, y: #:, z: #:, facing: ":", ^: ok`
--:+ _If no GPS, returns the optional (testing) parameters or, if not supplied, current dead reckoning position in situation._
  local px, py, pz, pf = table.unpack(move.at()); local gx, gy, gz = core.where() -- gx is nil if GPS fails or no GPS
---@diagnostic disable-next-line: undefined-field
  return gx or tx or px, gy or ty or py, gz or tz or pz, tf or pf, (gx or not _G.gps) -- ok if no GPS (out-game)
end
--[[
```
<a id="tables"></a>
#Tables of Motion
Tables are an important Lua construct.  MUSE uses a lot of them.  The tables below tie together changes in turtle `situation.position` due to movements (`advance`, `retreat`, `rise`, and `fall`) with the direction a turtle is `facing`. A trick uses the `%` modulo function to circle around the `facings` from "west" back to "north".  A reciprocal `directions` table maps direction names (as strings) back to `facings` indices (as numbers). The `getRight` and `getLeft` functions get a number from `directions` to do modulo arithmetic and get a string from the result from `facings`.
```Lua
--]]
-- Translation and rotation constants: Computercraft co-ordinate system (y is vertical)
local facings = {[0]="north", "east", "south", "west"} -- %4: after "west" is "north"
local directions = {north = 0, east = 1, south = 2, west = 3} -- reciprocal of `facings`
local advance = {north = {0, 0, -1}, east = {1, 0, 0}, south = {0, 0, 1}, west = {-1, 0, 0}} -- changes in position
local retreat = {north = {0, 0, 1}, east = {-1, 0, 0}, south = {0, 0, -1}, west = {1, 0, 0}}
local rise = {north = {0, 1, 0}, east = {0, 1, 0}, south = {0, 1, 0}, west = {0, 1, 0}} --facings irrelevant
local fall = {north = {0, -1, 0}, east = {0, -1, 0}, south = {0, -1, 0}, west = {0, -1, 0}}

local function getRight(direction) return facings[(directions[direction] + 1) % 4] end -- %4: "west" to "north"
local function getLeft(direction) return facings[(directions[direction] - 1) % 4] end -- %4: "north" to "west"

local function setRight() 
  local prior = Muse.situation; Muse.situation = Muse.tracking.enabled and move.clone() or Muse.situation
  Muse.situation.facing = getRight(Muse.situation.facing); Muse.situation.level = "same" 
  return prior
end

local function setLeft() 
  local prior = Muse.situation; Muse.situation = Muse.tracking.enabled and move.clone() or Muse.situation
  Muse.situation.facing = getLeft(Muse.situation.facing); Muse.situation.level = "same" 
  return prior
end
--[[
```
<a id="direction"></a>
#Turning the Turtle: Implementing An Abstraction
The "direction" abstraction, considering the four cardinal diretions, is built on turtle primitives to `turnRight` or `turnLeft`. The functions end by returning a status code. The turn is done immediately and (maybe) can fail. The status code in such case is `"blocked"`. Turtle rotations don't use fuel and, blocked or not, will have happened even in the face of an untimely Minecraft server shutdown. (So dead reckoning remains valid.) Otherwise the code returned is "done" (after potentially tracking the turn and  updating the `_G.Muse.situations` history table). The turtle's `_G.Muse.situation.facing` is changed by these functions. Recall that the functions `setRight` or `setLeft` use a bit of modulo arithmetic and access to the `directions` and `facings` table entries to get the new facing.

Normally, Lua files build upon function definitions from the beginning of a file to the end. If we did that, the last things done to move a turtle would show up in the file before the first things to be done. Making the file harder to understand. We handle the issue by introducing a dummy forward reference for functions whose definitions will come later.
```Lua
--]]
local trackMotion -- forward reference

local function turnRight() -- make turn and adjust facing
  local moved, prior = turtle.turnRight(), setRight()
  return not moved and "blocked" or (Muse.tracking.enabled and trackMotion(prior) or "done")
end

local function turnLeft() -- make turn and adjust facing
  local moved, prior = turtle.turnLeft(), setLeft()
  return not moved and "blocked" or (Muse.tracking.enabled and trackMotion(prior) or "done")
end

local function turnAround() -- make turn and adjust facing
  local halfAround = turnRight(); if halfAround ~= "done" then return halfAround end -- return error code
  return turnRight() -- return "done" or error code
end
--[[
```
<a id="way"></a>
#Finding the Way
MUSE encapsulates the parameters of motion in each of the four `way` tables (below). These supply the arguments for actual turtle `motion` (like `turtle.forward`), the kind of `movement` (like `"advance"`, the nature of any change in `level` (like `"same"`), and the `direction` of movement (for reporting and debugging convenience). In this way they effectively package up the variations in handling turtle movement so that all the variations can be dealt with by common routines. Which we'll be coming to shortly. 

As suggested, the (cardinal) direction abstraction is built on the `turnRight` and `turnLeft` primitives. The function `turnFacing` uses the `directions` constant table from the introduction part of `lib/motion` to get numbers for the four cardinal directions with which to do arithmetic.  The amount to turn, a value from 0 to 3, is used to select one of the appropriate `turns` primitives (including a `noop`). After the left or right turn is made, the turtle might be moved or stepped a `count` of blocks. We're on our way. Maybe.
```Lua
--]]

-- **The `way` tables and the parameters of (trackable) motion**

local wayForward, wayBack = {turtle.forward, advance, "same", "forward"}, {turtle.back, retreat, "same", "back"}
local wayUp, wayDown = {turtle.up, rise, "rise", "up"}, {turtle.down, fall, "fall", "down"}
local vertical = {up = wayUp, down = wayDown} -- primitives for vertical movement

local function noop() return "done" end --neither left nor right
local turns = {[0] = noop, turnRight, turnAround, turnLeft} -- turn functions

local function turnFacing(direction) -- Given NESW compass points, finds and performs turn operation from turns table
  local from, to = directions[facing()], directions[direction] -- numbers for arithmetic
  if not from or not to then return turns[0]() end -- no turns for up or down 
  local turnOperation = turns[(to - from) % 4] -- -1 % 4 = 3; -3 % 4 = 1; e.g. ("south" - "west") % 4 = turnLeft
  return turnOperation() -- noop, turnRight, turnAround, turnLeft
end
--[[
```
<a id="face+turn"></a>
#Facing and Turning for Movement
There are a lot of moving parts needed to move a turtle. In what's below, each is defined separately to keep each part an easily readable chunk of code. While it's not always reasonable to do this, this sort of thing makes reading (and thus maintaining) the code easier. 

As we mentioned earlier, the ordering here using forward references is an unnatural act (for Lua anyway). The aim is to provide a natural order in the sequence of moving parts.

Before any movement, the turtle needs to be turned. Either in a cardinal direction or just left or right. The `direction` abstraction is extended here to include `up` or `down`, not just north, east, west, and south.

If turning the turtle encounters trouble, the chain of functions we've been exploring returns something other than `"done"`. In this case MUSE raises an error supplying a `recovery` table that might be used to recover from the error, perhaps by resolving the turtle's `"blocked"` condition.
```Lua
--]]

--:> recovery: _For some errors_ -> `{call: ":", failure: ":", cause: ":", remaining: #:, :xyzf:, :direction:, operation: ":"}`

local moveCount, stepCount; local ops = {} -- forward reference

local function face(direction, count, op) -- cardinal directions now including `up` and `down`
  local turnResult = turnFacing(direction); -- first turn in specified direction, ignoring `up` or `down`
  local moves = vertical[direction] or wayForward -- if not `up` or `down` just figure on going forward
  if turnResult == "done" then return ops[op](moves, count, direction) end -- move or step the count
  error {"motion.face", "Failed because ", turnResult, count, move.ats(), direction, "faceMove"} --recovery
end

local function turn(turnOperation, count, direction, op) --primitive: left or right, provide for turn failure
  local turnResult = turnOperation(); -- `turnLeft` or `turnRight`
  if turnResult == "done" then return ops[op](wayForward, count, direction) end -- move or step the count
  error {"motion.turn", "Failed because ", turnResult, count, move.ats(), direction, "turnMove"} --recovery
end
--[[
```
<a id="move+step"></a>
#Moving or Stepping the Count
The `lib/motion` library provides for simple movement in `moveCount`. (Defined here to resolve the forward reference from above.) It also provides a way to do operations at each step of a turtle's movements. This turns out to be useful to clients of `lib/motion`. Here's how that's implemented. The `stepCount` function produces Lua iterators. First it sets up what Lua calls `upvalues`. These are within the <a href="https://www.lua.org/pil/6.1.html" target="_blank"> _lexical scoping_</a>
of the iterator, a function that is a <a href="https://en.wikipedia.org/wiki/Closure_(computer_programming)" target="_blank"> _closure_</a>, Notice that each call of `stepCount` creates and returns a distinct iterator each with its own upvalues. Once the upvalue index `i` is greater than the `count` for that iterator, further calls will immediately return `nil`. The iterator is "exhausted". Otherwise, unless there's an error, each call of the iterator will move the turtle one block in the specified direction and return control to its caller to do work at the turtle's new position.
```Lua
--]]
--:# **Forward! Up! Down! move, step ... again (raising errors, providing for recovery)**
-- Moving (xyz) by distances, possibly stepping there with iterator, need to deal with fueling
local checkFuel -- forward reference

moveCount = function (way, count, direction) --xyz only, way: wayUp, wayDown, wayForward
  if count and count == 0 then return "done", count, move.ats() end -- to just report xyzf
  for i = 1, count do local result = checkFuel(way, count, direction) -- check fuel, try way 
    if result ~= "done" then direction = direction or "???" -- handling possibility of unspecified direction
      error {"motion.moveCount", "Failed because ", result, count - i + 1, move.ats(), direction, "moveCount"} -- recover
    end-- for all failures: could be "empty", "lost", or "blocked"
  end; return "done", 0, move.ats() -- nothing left to do, completed the sequence of move operations
end

stepCount = function (way, count, direction) --return a closure to iterate step operation 
  count = count or 0; local i = 0 -- upvalues for closure
  return function() -- this is the iterator, returns nil when exhausted, errors on "empty", "lost", "blocked"
    local turnResult = turnFacing(direction); if turnResult ~= "done" then 
      error {"motion.stepCount", "Failed turn because ", turnResult, count - (i-1), move.ats(), direction, "stepCount"} 
    end
    i = i + 1; if count - i < 0 then return nil end -- exhausted, terminate iteration
    local result = checkFuel(way, direction) -- check and try doing specified movement
    if result == "done" then return "done", count - i, move.ats(), direction end -- success
    error {"motion.stepCount", "Failed because ", result, count - (i-1), move.ats(), direction, "stepCount"} --recovery
  end
end

ops = {move = moveCount, step = stepCount} -- now that moveCount and stepCount have values for functions 

--[[
```
<a id="fueling"></a>
#Fueling Around
Before we actually move the turtle (I know, I know), we need to see if there's fuel to do so. In the `checkFuel` function, there's there are possible `nil` values returned for `detail` and `slot` from `core.findItems`. The Lua idiom using the boolean `or` operator binds a useful value to these variables. This is then used to bind a value to `detailName`. 

If the turtle has no fuel, no movement is possible so the function returns `"empty"`. Otherwise it returns the call on `refuel` which in turn, if refueling is successful, calls `xyzMotion` to (finally) move the turtle one Minecraft block just as if there had been no needed fueling. If refueling is not successful, `refuel` raises an error indicating in its report string where in the project's code the error occurred and other, presumably helpful information (like where the turtle is so that a rescue party can bring fuel to the empty turtle.).

Here's the interface for <a href="core.html#findItems" target="_blank"> `core.findItems`</a> and the definitions for what Computercraft provides for the detail of what is found. The <a href="core.html#findItems" target="_blank"> implementation</a> is straight forward. 
```Lua
-- :: core.findItems(target: ":"[]) -> _Selects found slot._ -> `nil | detail`

-- :> detail: _Defined by Computercraft_ -> `{name: ":", count: #: damage: #:}`
-- :^ name: _Prepended by the mod name `"minecraft:"_ -> `":"`
-- :^ count: _Available in inventory_ -> `#:`
-- :^ damage: _Distinguishing value_ -> `#:`
```
And here's how it's used:
```Lua
--]]
local fuels = {"minecraft:coal", "minecraft:coal_block", "minecraft:charcoal", "minecraft:lava_bucket"} 

local xyzMotion, refuel -- forward references

checkFuel = function (way, count, direction) -- from move/step count
  if turtle.getFuelLevel() > 0 then return xyzMotion(way) end
  local detail, slot = core.findItems(fuels); slot = slot or "_none_"
  local detailName = detail and detail.name or "_no fuel_"
  core.status(4, "motion", "Refueling?", detailName, "in slot", slot)
  return detail and refuel(way, count, direction) or "empty" -- if fuel found try refueling
end

function refuel(way, count, direction) 
  if turtle.refuel() then setFuel(turtle.getFuelLevel()) end 
  local fueled = fuel(); if fueled <= 0 then 
    error("motion.refuel: Empty with "..count.." remaining at "..move.ats().." "..direction) -- no recovery
  end; core.status(5, "motion", "Refueling "..tostring(fuel))
  return xyzMotion(way); -- now that there's fuel, try the way from checkFuel
end 
--[[
```
<a id="motion"></a>
#Motion! (Finally)
The `xyzMotion` function actually calls the turtle API to request movement using a particular `motion` function as the first argument. Passing a function as an argument effectively encapsulates what needs to be done. It looks for successful movement and the effect of that movement on turtle fuel.

This is how turtles actually get moved in the chain of calls we mentioned. A change in position requires an update to dead reckoning by `xyzUpdate`. If there will be a change in vertical movement and tracking is enabled, we'll need to clone the current situation as history for `trackMotion` before making the change . 

The actual change in position is determined by which of the one of the four cardinal directions the turtle is `facing` and the kind of `movement`, whether an `"advance"`, a `"retreat"`, a `"rise"`, or a `"fall"` (referencing the `way` tables above). Thus `movement[facing]` directly gets the `dx`, `dy`, and `dz` offsets for the movement using the table referenced. Tables provide a concise way to get the job done. 

Some attempts to move a turtle lead to trouble. If the requested movement happened, the trouble must be that the fuel didn't get used: the turtle is `"lost"`. If the movement didn't happen, the turtle is `"blocked"`. 

In the normal case (and if there's no tracking), `xyzMotion` reports the motion and then just returns what `xyzUpdate` returns. The call is done at that point, its locals (on the call stack) are no longer needed. Consequently, during debug such <a href="https://www.lua.org/pil/6.3.html" target="_blank"> _tail calls_</a> can't be expected to be visible on the call stack. If this turns out to be awkward, it's easy to turn a tail call into something less fancy.
```Lua
--]]
local xyzUpdate -- forward reference

function xyzMotion(way) 
  local moving, movement, level, direction = table.unpack(way) --  moving: turtle function to move
  local preFuel = setFuel(turtle.getFuelLevel()) -- just before attempting motion
  local moved = moving() -- actually call the requested turtle function (mock uses fuel)
  local postFuel = turtle.getFuelLevel(); local depletion = preFuel > postFuel -- less fuel now?

  if not (moved and depletion) then return moved and "lost" or "blocked" end -- moved but no depletion: `lost`; else `blocked`

  core.status(5, "motion", direction, level, preFuel, postFuel)
  return xyzUpdate(movement, level) -- normal case, update situation and tracking, no problem: "done" 
end

xyzUpdate = function (movement, newLevel) -- update dead reckoning x,y,z situation and track
  local px, py, pz, facing, fuel, level = move.get(); local tracking = Muse.tracking.enabled and newLevel ~= level
  local situation = tracking and move.clone() or Muse.situation
  local prior = Muse.situation; Muse.situation = situation
  local dx, dy, dz = table.unpack(movement[facing]) -- `movement`: advance/retreat/rise/fall
  move.set(px + dx, py + dy, pz + dz, facing, fuel - 1, newLevel); -- dead reckoning fuel and position 
  return tracking and trackMotion(prior) or "done"-- trackMotion returns "done" and adds to `situations`
end
--[[
```
<a id="tracking"/>
#Tracking Motion (Optionally)
If we got here, we're at the end of the (ahem) trail. The `return` peels all the way back to `moveCount` or `stepCount`.
```Lua
--]]
local resetTrack -- forward reference --:# **Tracking Movement: completing movement**

trackMotion = function (current) -- from turn operations and xyzUpdate, add a situation only for changes 
  Muse.situations[#Muse.situations + 1] = current; 
  local reset = (Muse.tracking.limit and #Muse.situations > Muse.tracking.limit) 
  return reset and resetTrack(current) or "done" -- #situations and at() returned by `moveCount` or `stepCount`
end

resetTrack = function (current) -- dealing with tracking overflow
  core.status(3, "motion", "Trail reset, was longer than", Muse.tracking.limit)
  Muse.situations = {current}; return "done"
end
--[[
```
#Exposing the Move and Step Functions
After all that, what's actally exposed by the library looks pretty simple. All the commonality has been squeezed out. You might think of what we've been through as just really big utility functions for moving or stepping the turtle. 
```Lua
--]]
--:# **Exposed APIs for move functions: turn left|right or face cardinal if needed, then repeat count forward**
--:: move.moves(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery` 
-- each of these move functions have common definitions and indirectly call  `moveCount(goForward, count, direction)` 

function move.left(count) count = count or 1; return turn(turnLeft, count, "left", "move") end --:= move.moves:: move.left:
function move.right(count) count = count or 1; return turn(turnRight, count, "right", "move") end --:= move.moves:: move.right:
function move.north(count) count = count or 1; return face("north", count,"move") end --:= move.moves:: move.north:
function move.east(count) count = count or 1; return face("east", count, "move") end --:= move.moves:: move.east:
function move.south(count) count = count or 1; return face("south", count, "move") end --:= move.moves:: move.south:
function move.west(count) count = count or 1; return face("west", count, "move") end --:= move.moves:: move.west:

function move.up(count) count = count or 1; return moveCount(wayUp, count, "up") end --:= move.moves:: move.up:
function move.down(count) count = count or 1; return moveCount(wayDown, count, "down") end --:= move.moves:: move.down:
function move.forward(count) count = count or 1; return moveCount(wayForward, count, "forward") end --:= move.moves:: move.forward:
function move.back(count) count = count or 1; return moveCount(wayBack, count, "back") end --:= move.moves:: move.back:

--:# **Exposed APIs for step functions: turn or face direction if needed then step count forward in that direction** 
--:: step.steps(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`
--:> stepping: _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`
-- Each of these step functions have common definitions and indirectly call `stepCount(goForward, count, direction)`

function step.left(count) count = count or 1; return turn(turnLeft, count, "left", "step") end --:= step.steps:: step.left: 
function step.right(count) count = count or 1; return turn(turnRight, count, "right", "step") end --:= step.steps:: step.right:
function step.north(count) count = count or 1; return face("north", count, "step") end --:= step.steps:: step.north:
function step.east(count) count = count or 1; return face("east", count, "step") end --:= step.steps:: step.east: 
function step.south(count) count = count or 1; return face("south", count, "step") end --:= step.steps:: step.south:
function step.west(count) count = count or 1; return face("west", count, "step") end --:= step.steps:: step.left:

function step.up(count) count = count or 1; return stepCount(wayUp, count, "up") end --:= step.steps:: step.up:
function step.down(count) count = count or 1; return stepCount(wayDown, count, "down") end --:= step.steps:: step.down: 
function step.forward(count) count = count or 1; return stepCount(wayForward, count, "forward") end --:= step.steps:: step.forward:
function step.back(count) count = count or 1; return stepCount(wayBack, count, "back") end --:= step.steps:: step.back:
--[[
```
These functions only return values if there have been no errors in the functions they call (and that are called in turn). They mostly return a status code (as a string), the number of Minecraft blocks remaining to traverse (as a number), the position and orientation of the turtle (as a string produced by the call to `move.ats`), and in which way it was supposed to move (as a string). Of course, if there have been no errors in a `move`, the number remaining is zero. However if there is an error raised, the number of blocks remaining is non-zero as included in the error recovery table we talked about earlier.

This populates most of the two tables of functions returned by loading this library file.  There's just a few more, higher level operations that, of course, build on what we've already discussed.

#Moving to a Target

We might just want to move to a specified set of xyz coordinates. To deal with potential blockages, `move.to` includes an optional argument to specify in which coordinate to move first. In each of the three <a href="https://en.wikipedia.org/wiki/Anonymous_function" target="_blank">
_anonymous functions_</a> of the `moving` table, the turtle movement function calls follow each other in line to emphasize sequence. 

This prompts a sermon. How code is laid out on the page is an important way to communicate design. It's an issue of style to write code as poetry or prose. The choice here as prose leads to a concise representation allowing more code to be seen at once. This is often helpful in understanding a body of code. Whitespace is used to draw attention to what seem to be important points in execution. Repeated patterns on the page emphasize common operations. Oddly enough for prose, reading it generates a sort of rhythm. (If you're working in a team though, you may need to compromise layout to fit in with what others are doing.)
```Lua
--]]
--:# **Move or Step to target xyzf position**
local moving = { --table of the functions handling different orderings of motion
  x = function(xOp, adx, zOp, adz, yOp, ady) xOp(adx); zOp(adz); yOp(ady) end, -- xyz
  y = function(xOp, adx, zOp, adz, yOp, ady) yOp(ady); xOp(adx); zOp(adz) end, -- yxz
  z = function(xOp, adx, zOp, adz, yOp, ady) zOp(adz); yOp(ady); xOp(adx) end} -- zyx

function move.to(xyzf, first) -- no navigation, y last unless `first` specified
--:: move.to(xyzf: xyzf, first: ":"?) -> _Current situation to x, z, y, and optionally face._ -> `"done", #:, xyzf &!recovery` 
--:+ _Optional argument_ `first` _is "x", "y", or "z" to select first move in that direction to deal with blockages._
  if not xyzf then error("motion.move.to: attempt to go to nil (road unpaved)") end
  local x, y, z, face = table.unpack(xyzf); local sx, sy, sz = move.get(); local dx, dy, dz = x - sx, y - sy, z - sz
  local xD, xOp = dx < 0 and "west" or "east", dx < 0 and move.west or move.east; local adx = math.abs(dx)
  local yD, yOp = dy < 0 and "down" or "up", dy < 0 and move.down or move.up; local ady = math.abs(dy)
  local zD, zOp = dz < 0 and "north" or "south", dz < 0 and move.north or move.south; local adz = math.abs(dz)
  core.status(4, "motion", "move.to", xD, yD, zD, "to", xyzf)
  local movement = not first and moving.x or moving[first]; -- pick the function for `moving`
  if not movement then error("motion.move.to: first to "..first.." not supported") end
  movement(xOp, adx, zOp, adz, yOp, ady); if face then turnFacing(face) end  -- call the `moving` function
  return "done", 0, move.ats() -- if not "done", error has been thrown
end
--[[
```
The form of the code is intended to convey relationships. No poetry here. The variables `dx`, `dy`, and `dz` are bound "in parallel" to values as indicated. The same goes for `xD`, `yD`, and `zD` to the corresponding movement operations 

The bindings for movement operations such as `move.west` and `move.east` reference functions defined earlier in the file. As we've seen in Lua, functions are handled like any other entity in the language. Here they determine what action is to be repeated.  In debugging Lua code, it's often difficult to figure out references to functions. Since the function can be referenced by whatever variable or structure element it has most recently been bound to, there's no real "name" of the function. To ease debug, a little extra information, such as `xD`, `yD`, and `zD`  is provided. These strings indicate the direction of the movement.

#Stepping There: Iterators For Movement

The `stepTo` function uses iterators created by `stepCount` to create a composite iterator.
```Lua
--]]
function step.to(xyzf, situation) -- iterator closure returns nil only if all directions done
--:: step.to(:xyzf:, situation:situation?) -> _Step to position from (current) sItuation._ -> (`:): nil &!recovery`
--:+ _Iterate first in x direction to completion, then z, and finally y. Once complete, each iterator is exhausted._
--:+ _Finally turn to face if supplied. Returned iterator returns_ `nil` _when iterators for all directions are exhausted._
  if not xyzf then error("motion.step.to: attempt to step to nil (road unpaved)") end
  if type(xyzf) ~= "table" then error("motion.step.to: expected table", xyzf) end
  local x, y, z, face = table.unpack(xyzf); local target = situation or Muse.situation
  local tx, ty, tz = move.get(target); local dx, dy, dz = x - tx, y - ty, z - tz; 
  local xD, xOp, adx = dx < 0 and "west" or "east", dx < 0 and step.west or step.east, math.abs(dx)
  local zD, zOp, ady = dz < 0 and "north" or "south", dz < 0 and step.north or step.south, math.abs(dy)
  local yD, yOp, adz = dy < 0 and "down" or "up", dy < 0 and step.down or step.up, math.abs(dz) 
  core.status(4, "motion", "step.to", xD, yD, zD, "to", xyzf)
  local iterators, dxyz = {xOp(adx), zOp(adz), yOp(ady)}, adx + ady + adz; -- total distance 
--[[
```
We've lead off with some error checking and then dealt with the two positions we're concerned with: where we are, and where we're going. The function takes an optional argument `situation`. If this is not provided, the function body uses the turtle's current situation and gets values for operations (like `step.west`), distances (like `dx`), and directions (like `xD`). And then it does something completely different: it gets iterators by calling functions which, eventually, call `stepCount`. Finally, it computes the total distance to be traversed and the `direction` to start that traversal. (The distance is a so-called "Manhattan distance" since turtles move only in a grid.)

But wait, there's more.  So far, we've just setup the upvalues. The `step.to` function returns a function, the iterator that we can use to step the turtle from where it is to where it's going and do operations at each step of the way:
```Lua
--]]
  return function() -- iterators throw errors if code not "done", return nil when steps in direction complete
    for index, iterator in ipairs(iterators) do 
      for code, remaining, at, direction in iterator do -- iterator returns nil if complete or exhausted
        core.status(3, "motion", "step.to", index, code, remaining, at, direction, xyzf)
        if code then dxyz = dxyz - 1; return code, remaining, at, direction, dxyz end 
      end; 
    end; if face then turnFacing(face) end; return nil end; -- end of iterator closure
    end
--[[
```
There are three internal iterators setup as _upvalues_. Each is responsible for movement on one of the three axes in the Minecraft co-ordinate system. The results from each iterator are checked to see if that iterator is exhausted (by checking to see if it returns `nil` according to the Lua convention). If it's not exhausted, the inner `do` updates the total distance, and as other functions in this library, returns the status code, the distance remaining to be traversed in that direction, and a string indicating where the position and orientation of the turtle.  Additionally it returns the direction for the movement and the total distance remaining to be traversed. These will be ignored by some callers.

If a given iterator is exhausted, the next iterator is called by the outer `do`. When all three iterators are exhausted, the function turns the turtle to face a specified direction.  It returns `nil` (as befits a Lua iterator) to indicate that its work here is done.

We've been able to use a `for` loop in the iterator of iterators above since executing an exhausted iterator has no effect. We need more care in other situations. Here's a <a href="places.html#near" target="_blank"> link to an example</a>.

Iterators keep track of where they are in traversing tables. Just for interest, here's <a href="core.html#inext" target="_blank"> an example</a> of exposing that information to explicitly control the iteration.

Finally, finishing up, the library ends with exporting a table of tables as advertised.
```Lua
--]]
    return {move = move, step = step}
--[[
```
With that, our work with `lib/motion` is done, except, of course for using it.....oh, and testing it.

As for using it, one such use is by the `lib/places` library. It records positions for bearings to a spot and makes use of `lib/motion` to move and step turtles to such spots and to move turtles along a track of such spots. Follow the link to explore its <a href="places.html" target="_blank"> implementation</a>. Alternatively, you can get a sense of the API the library exports by looking at its <a href = "../../docs/lib/places.html" target = "_blank">summary</a>.

The important issue, though, is testing.

#One More Thing: Lest We Forget

Testing. Developing the tests for a library is just part of developing that library. If done as the library is developed, the tests can be really help in keeping the development on course. The test is also a check on the utility and expressiveness of the library's interface. Done during library development, it's easier to change. A test provides usage examples as a complement to interface documentation. Perhaps most importantly, when a library's code (inevitably) needs to be restructured for whatever reason (clarity, better fit into its context, whatever), the tests support the will to make the necessary changes. In the case of development for environments such as ComputerCraft with limited debugging support, it's a crucial aid (together with an IDE). Additionally, tests provide a sandbox where errors have limited, easily repaired, consequences.

Most of the `lib/motion` test is straightforward and needs no discussion. (You'll need to look at the `lua/rom/modules/tests` directory if you're interested.) The steps facility, however, might be worth a look:
```Lua
for code, remaining, ats in step.east(3) do 
  print(18, "step.east(3)", code, remaining, ats)
end
```
The output looks like this:
<pre>
18	step.east(3)	done	2	{11, 15, 20}, east
18	step.east(3)	done	1	{12, 15, 20}, east
18	step.east(3)	done	0	{13, 15, 20}, east
</pre>
At each step east, the body of the `do` statement is executed and the result of moving that step printed.  Of course, other work could have been done (and will be in libraries dependent on `lib/motion`).

Here's another example:
```Lua
local function prints(n, op, code, remaining, xyzf)
  print(n, xyzf, code, remaining, "...", op)
end

local more = step.forward(3)

prints(19, "steps 1 forward 3", more())
prints(20, "steps 2 forward 3", more())
prints(21, "steps 3 forward 3", more())
prints(22, "steps 4 forward 3", more()) 
```
The variable `more` is bound to the result of calling `steps.forward(3)` This is an iterator that_  -> you might imagine, steps forward three blocks, one block at a time.  Here each call to `more`, moves one step and provides its results as the last three arguments to the `prints` statement. The output looks like this:
<pre>
19	{10, 15, 19}, north	done	2	...	steps 1 forward 3
20	{10, 15, 18}, north	done	1	...	steps 2 forward 3
21	{10, 15, 17}, north	done	0	...	steps 3 forward 3
22	{10, 15, 17}, north	nil	0	...	steps 4 forward 3
</pre>
Notice that the fourth attempt to step three blocks forward makes no change to turtle position and outputs `nil`  rather than `"done"`.
  ```
That's the end of this excursion. Next up is <a href="places.html"> `lib/places` </a> or follow the <a href="../../Mining MUSE.html#Chapter3"> link </a> to return to _Mining MUSE_.
--]]
