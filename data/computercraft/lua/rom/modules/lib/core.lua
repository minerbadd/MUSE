--[[
## Core: A Collection of Generally Useful Functions for MUSE
```md
--:! {core: []: (:)} <- **Core Functions Library** -> muse/docs/lib/core.md
--:| core: _Strings, session state, cloning, error handling, reporting, UI, math, iterators, lowest level turtle support._ -> core
```Lua
--]]
---@diagnostic disable-next-line: undefined-field
package.path = _G.Muse.package
---@diagnostic disable-next-line: undefined-field
local rednet, turtle = _G.rednet, _G.turtle or require("mock").turtle -- mock out game
local core = {}; core.hints = {}; --- @module "signs.core"                     
--[[
```
<a id="clone"></a>
#Deep Copy
Note the <a href="https://en.wikipedia.org/wiki/Recursion_(computer_science)" target="_blank"> _recursion_ </a> in the following function. If the function encounters a table containing a table while accumulating the `result`, it calls itself, `core.clone`, on the contained table. It does so recursively so that if that table in turn contains a table, the function goes deeper (and deeper) into the recursion calling itself each time to do so. Finally, the recursion "bottoms out" and starts its return when the function is either not called on a table or the table it's been called on does not contain a table. The `result` from each level of the recursion is then incorporated in the `result` of the next higher level of the recursion till we've reached the original call.

Finally although MUSE makes no use of them, the <a href="https://www.lua.org/pil/13.html" target="_blank"> _metatable_</a> properties of the returned table are set to those of the original table.
```Lua
--]]
--:# **Managing state: clone table, generate closure for session (non-persistent) state, cache loads**
function core.clone(source)
  --:: core.clone(source: {:}|any) -> _Deep copy source table or return source if not table._ -> `{:}|any`
  if type(source) ~= "table" then return source end; local result = {}
  for key, value in pairs(source) do
    if type(value) == "table" then
      result[key] = core.clone(value)
    else
      result[key] = value
    end
  end; setmetatable(result, getmetatable(source));
  return result
end

--[[
```<a id="state"></a>
#Affairs of State
Another way to manage state is to "close over" a variable. The `core.state` function creates a function to set and return a  variable whose scope is local (within the compass of the returned function) and whose extent is indefinite (useable throughout a session as long as there is a reference to the returned function preventing its collection as garbage.) The variable may be set to any non `nil` value including `false`. As an access optimization, if a table (external to the closure) is specified, the table entry is also set to any non `nil` value.
```Lua
--]]
--:> closing: _Returns value or sets it and optional table entry to non `nil` `value`._  -> `(value: any): value: any`

function core.state(table, key)
  --:: core.state(table: {:}?, key: ":"?) -> _Returns closure over closure variable_ -> `closing`
  local variable = nil
  return
      function(value)
        if type(value) == "nil" then return variable end
        variable = value; if table then table[key] = value end
        return variable
      end
end

--[[
```
<a id="merge"/a>
#Setting the Table
Lua supports functions whose arguments are tables containing any type. It also supports functions with a variable number of arguments with `select` operator and the `...` syntax.
```Lua
--]]
--:# **Table Utilities: merging tables and finding common items in a pair of tables**
function core.merge(...) --:: core.merge(...: {:}) -> _Merge any number of flat tables into one, allowing repeats._ -> `{:}`
  local result = {}
  for this = 1, select("#", ...) do
    local thisTable = select(this, ...)
    for item = 1, #thisTable do result[#result + 1] = thisTable[item] end
  end; return result
end

function core.match(tableA, tableB)
  --:: core.match(tableA: any[], tableB: any[]) -> _Find first matching item in pair of item tables._ -> `nil` | `any`
  for _, itemA in ipairs(tableA) do for _, itemB in pairs(tableB) do if itemA == itemB then return itemA end end end
end

--[[
```
<a id="serialize"></a>
#Stringing It Out
The function `core.serialize`, <a href="https://www.lua.org/pil/12.1.html" target="_blank"> adapted from PiL 12.1.1 </a>, turns an arbitrary structure into a string that can be turned back into that structure by Lua's `load` facilities. The function shares a rover function, `inSerialize` with `core.string` that provides more human readable string representations. The small differences (controlled by the `simple` argument) in what is done in order to serialize or just provide readable strings allow code sharing. As long as the differences are small, this kind of sharing makes for a more maintainable implementation: just the one, shared function needs to be tested, validated, and understood.
```Lua
--]]
--:# **Making Strings: both instantiable strings and simple single quoted strings for printing**
local function inSerialize(input, partial, simple) -- adapted from PiL 12.1.1; `simple` generates non-instantiable string
  partial = partial or ""; local separator = ", "
  if type(input) == "table" then
    local tstring = "{"
    for k, v in pairs(input) do
      if type(k) == "number" then
        tstring = tstring .. inSerialize(v, partial, simple) .. separator
      else
        local kstring = "" .. k .. "=";
        local vstring = inSerialize(v, partial, simple);
        tstring       = tstring .. kstring .. vstring .. separator
      end
    end; return partial .. tstring .. "}"
  elseif type(input) == "number" then
    return partial .. input                                 -- _in this case, the `elseif` structure reads easily_
  elseif type(input) == "string" then
    return simple and partial .. input or partial .. string.format("%q", input)
  elseif type(input) == "boolean" then
    return partial .. tostring(input)
  elseif type(input) == "nil" then
    return simple and partial .. "" or partial .. tostring(input)
  elseif type(input) == "function" then
    return partial .. ' function() ...[skipped]...'
  else
    error("core.inSerialize: " .. type(input) .. " failed")
  end
end

--:: core.serialize(input: any) -> _Executable string to instantiate input._ -> `"return "..":" &!`
function core.serialize(input) return "return " .. (input and inSerialize(input) or "{}") end

local function makeString(item) return inSerialize(item, "", true) end -- third argument `true` for simple
--[[
```
<a id="string"></a>
The `core.string` function turns a variable number of input structures into a string intended to be read by users. It shares a helper function, `inSerialize` with <a href="#serialize"> `core.serialize` </a>. The `makeString` function supplies `true` for the `simple` argument of `inSerialize` to allow code sharing implementing similar capabilities.
```Lua
--]]
function core.string(...) --:: core.string(...: any) -> _Makes string from any inputs, simplifies single entry tables._ -> `":"`
  local n = select("#", ...); local strings = {};
  for i = 1, n do
    local item = select(i, ...)
    strings[#strings + 1] = makeString(item)
  end; return table.concat(strings, " ")
end

function core.xyzf(xyzf) --:: core.xyzf(:xyzf:) -> _Returns specially formatted string for `xyzf`._ -> `":"`
  --:> xyzf: _Position and facing as table_ -> `{x: #:, y: #:, z: #:, facing: ":"}`
  assert(xyzf and type(xyzf == "table"), "core: Need xyzf as table for string")
  local x, y, z, f = table.unpack(xyzf); f = f or ""
  return "{" .. core.round(x) .. ", " .. core.round(y) .. ", " .. core.round(z) .. "} " .. f
end

--[[
```
<a id="ats"></a>
The `lib/motion` library binds `core.ats` to the same function bound to <a href="motion.html#ats" target="_blank">`move.ats`</a> by loading `lib/motion`. If `lib/motion` has not been loaded, a dummy function is bound to it. Reloading `lib/core` after `lib/motion` is loaded does not change the binding.
```Lua
--]]
core.ats = core.ats or function() return "{...}" end -- = move.ats:: core.ats:
--[[
```
<a id='pass'></a>
#Que Pasa
The `core.pass` function acts as a filter and a chokepoint for Lua `pcall` functions. It's a useful place to put a breakpoint when looking for the conditions that led to an error. It returns a string made from the conditions for reporting. It also returns the conditions themselves for potential recovery operations.
```Lua
--]]
--:# **Handling errors and reporting operations**
function core.pass(ok, ...)
  --:: core.pass(ok: ^:, ...: any) -> _Pass input but report string if not ok._ -> ok: `true|false, result: ...|":", any?`
  if ok then return true, ... end
  local report, conditions = core.string(...), ...
  return false, report, conditions
end -- failure returns false, report

--[[
```
<a id="where"></a>
The `core.where` implementation binds a dummy function, `function() end` (which returns `nil`), to `gpslocate` in the out-of-game environment. This takes the place of the in-game function `gps.locate`. Follow the <a href="places.html#nearby" target="_blank"> link to see another example of this technique </a> which uses a dummy (null) function as a default. An optional function argument only implementable at the higher level overrides the dummy default when calling the lower level function.

As it turns out, the in-game `gps.locate` returns `NaN`, Not A Number, rather than `nil` when it can't compute a position. The idiom `gx == gx` is used to detect NaN since the IEEE spec requires that `NaN` is not equal to anything including "itself".
```Lua
--]]
function core.where() --:: core.where() -> _GPS location if available._ -> `x: #:?, y: #:?, z: #:?`
  ---@diagnostic disable-next-line: undefined-field
  local gps = _G.gps; local gpslocate = gps and gps.locate or function() end
  ---@diagnostic disable-next-line: redundant-parameter
  local timeout = _G.Muse.delays.gps; local debug = false; local gx, gy, gz = gpslocate(timeout, debug)
  local isNumber = type(gx) == "number" and gx == gx; -- NaN (from `gps.locate`) is not equal to anything (IEEE spec)
  return isNumber and gx, isNumber and gy, isNumber and gz
end

--[[
```
<a id="status"></a>
#Monitoring Status, Logging, Quitting
Reporting and logging on-going turtle status is an essential part of in-game debug (and useful in the out-of-game test environment as well). Providing a way to record status in a file allows off-line examination of suspect operation.

The `log` table controls the level of status detail reported and potentially logged (`log.level`), the file name for log records (`log.file`), if any, in the computer's `muse` directory, and the file handle (`log.handle`) for file log operations. The table is bound to a global reference so it is guaranteed to stick around through session garbage collections but, for the usual reasons, no access to the global is made outside `lib/core`. Instead a closure is provided <a href="#state"> using `core.state` </a> to access each of the `log` fields.

There's a <a href="../status.html" target="_blank"> truly paper thin command line interface (_CLI_)</a> for setting the `log.level` and setting up the `log.file` and `log.handle` to record status. It just packages the arguments, whatever they are, into a table of strings. The arguments from this CLI are passed directly to `core.logging` which sets up the filename and file handle for `core.record` which is called by the `.status` <a href = "https://en.wikipedia.org/wiki/Daemon_(computing)" target="_blank"> _daemon_ </a>. For convenience, <a href="../.start.html" target="_blank"> startup operations </a> set up defaults.

In-game, a status message (a string including the current dead-reckoning position) is sent over the `rednet` network to the player as a "MS", Muse Status protocol, message. MUSE uses the `.status` daemon, to print `MS` messages received by the player's pocket computer. Follow the <a href="../.status.html" target="_blank">link to take a look at the implementation</a>. It's just an endless loop responding to selected network events, receipt of `MS` protocol messages, by printing and potentially recording those messages.

As a piece of <a href="https://www.drdobbs.com/defensive-programming/184401915" target="_blank"> _defensive programming_ </a>, `status` operations use the GPS and the `reckon` function to see if a turtle is where it's expected to be. If it isn't it resets the turtle's position according to the GPS and tacks a (really loud) notice onto the status message.The `core.report` function does much of the same thing for operations where turtle position isn't relevant.
```Lua
--]]
local function reckon(message)                                    -- find bad reckoning for turtles if GPS
  ---@diagnostic disable-next-line: undefined-field
  if not _G.turtle then return message end                        -- pointless if not for turtles (in-game)
  local tx, ty, tz = core.get(); local gx, gy, gz = core.where(); --overloaded by lib/motion
  if not gx then return message end                               -- no GPS assume reckoned
  local matched = core.round(tx) == core.round(gx) and core.round(ty) == core.round(gy) and
  core.round(tz) == core.round(gz)
  if matched then return message end
  local xyz = "x: " .. tx .. " " .. gx .. ", y: " .. ty .. " " .. gy .. ", z: " .. tz .. " " .. gz
  core.set(gx, gy, gz)  -- **SETTING GLOBAL muse.situation.position** (core.set = move.set in lib/places.lua)
  return "\n!!!FIXED!!! " .. xyz .. "\n" .. message
end

--:# **Logging and Quit Control Globals**
_G.Muse.log = _G.Muse.log or {};  -- log controls
_G.Muse.quit = false; 

function core.quit(value)
  if value then _G.Muse.quit = value end; return _G.Muse.quit
end

local function resume() _G.Muse.quit = false end

--:- quit message -> _Set `quit` flag to message; next `core.status` throws `error` to abort operations._
local function quitting() -- actually quitting, send notice to player
  local message = "Quitting: "..core.quit(); resume();
  if rednet then rednet.send(_G.Muse.playerID, message, "MS") else print(message) end
  error("core.quit: operation aborted, RPC waiting "..message) -- clear stack back to remote call; turtle waits for next RPC
end

local logs = {}; --:> core.log: _Closure variable_ -> `{level: closing, file: closing, handle: closing}`
core.log = {level = core.state(logs, "level"), file = core.state(logs, "file"), handle = core.state(logs, "handle")} --closures

function core.status(level, ...)                                                                                  -- selected messages to player (lower levels are more important, higher are more detailed)
  --:: core.status(level: #:, ...: any) -> _If level less than (elimination) threshold, then report rest as string._ -> `nil`
  --:+ _If player, status report is printed and potentially logged. Otherwise sent to player using Muse Status (MS) protocol._
  --:+ _If for in-game turtle with GPS and the dead reckoning and GPS disagree, include that in report._
  if core.log.level() and level < core.log.level() then
    local message = core.string(...) .. " " .. core.ats()
    if rednet then rednet.send(_G.Muse.playerID, reckon(message), "MS") else print(message) end
  end; return _G.Muse.quit and quitting()
end; core.hints["status "] = { ["?level ??file"] = {} }

function core.report(level, ...) -- skip looking at dead reckoning vs. gps
  --:: core.report(level: #:, ...: any) -> _If level less than `status` threshold, report `rest` as string._ -> `nil`
  if core.log.level() and level < core.log.level() then
    local rest = core.string(...)
    if rednet then rednet.send(_G.Muse.playerID, rest, "MS") else print(rest) end
  end; return _G.Muse.quit and quitting()
end; core.hints["report "] = { ["?level ??file"] = {} }

function core.logging(arguments)
  --:: core.logging(arguments: :[level: #:, filename: ":"]) -> _Set threshold level [and local log file] for status reports_ -> `nil`
  local level, filename = table.unpack(arguments); level = tonumber(level)
  if not level then return "Status "..core.log.level().." > "..(core.log.file() or "~") end -- **just reporting**
  core.log.level(level); local handled = core.log.handle() -- set level, get handle for open log file if any
  if not filename and handled then
    handled:close(); return "Status logging "..core.log.file().." done"
  end
  if not filename then return "Status "..core.log.level().." > "..(core.log.file() or "~") end -- no file operation, level set
  local logfile = _G.Muse.data..filename..".log"; core.log.file(logfile) -- new log file!
  local removeOK, removeReport = io.open(logfile, "w"):close() -- clear old status log file
  if not removeOK then error("core.logging: Can't remove log file "..logfile.." because "..removeReport) end
  local filehandle, createReport = io.open(logfile, "a")                              --write file cleaned by read
  if not filehandle then error("core.logging: Can't create new ".. logfile.. " because "..createReport) end
  core.log.handle(filehandle); -- save the file handle for use by .status daemon call on core.record
end

function core.record(message) -- file status messages used by `.status` daemon
  --:: core.record(message: ":") -> _Appends (status) message to log file on player._ -> `nil & !`
  if not core.log.handle() then return end
  ---@diagnostic disable-next-line: undefined-field
  local appendOK, appendReport = core.log.handle():write(message, "\n")
  if not appendOK then error("core.record: Can't update "..core.log.file.." ".. appendReport) end
  ---@diagnostic disable-next-line: undefined-field
  core.log.handle:flush()
end

--[[
```
<a id="trace"></a>
In-game examination of the call stack on errors is provided by `core.trace`. Desperate times, desperate measures.
```Lua
--]]
--:: core.trace(err: any) -> _Reports traceback for xpcalls._ -> `err: any`
function core.trace(err)
  core.status(1, "core", "trace", debug.traceback())
  return err
end                                                                                        -- for `xpcall`

--[[
```
<a id="UI"></a>
#Command Completion
As an aid for remembering CLI arguments, `core.completer` enables shell completions in ComputerCraft's CraftOS. They are produced from tables that are defined by libraries creating a CLI and registered during <a href="../.start.html#complete" target="_blank"> session startup</a>. There are two other simple support functions: one, `core.echo` that just returns all of its (variable number of) arguments and one, `core.optionals` that deals with optional arguments distinguished by their type.
```Lua
--]]
--:# **User interface utilities**
local function complete(current, commands, completions)
  -- adapted from https://www.computercraft.info/wiki/Shell.setCompletionFunction
  local tree = completions; for i = 2, #commands do
    local key = tree[commands[i] .. " "]      -- start tree traversal with pattern
    if not key then return {} end; tree = key -- at end of match or traverse the tree to current node for commands so far
  end; local results = {};                    -- traversed to current node; now accumulate possible completions at its leaves
  for word, _ in pairs(tree) do
    if word:sub(1, #current) == current then results[#results + 1] = word:sub(#current + 1) end
  end; return results
end

function core.completer(completions) --:: core.completer(completions: {:}) -> _Register command completions for shell_ -> `(:)`
  return function(_, _, current, commands) return complete(current, commands, completions) end
end

--:: core.echo(...: any) -> _For testing; just returns its arguments._ -> ...: `any`
function core.echo(...) return ... end --:- echo arguments ... -> _For testing: just returns its arguments._

function core.optionals(string, number, ...)
  --:: core.optionals(string: ":"?, number: #:?, ...: any) -> _Optional number and/or string._ -> `string: ":"?, number: #:?, ...: any`
  local stringIsNumber = tonumber(string); string = not stringIsNumber and string;
  number = stringIsNumber or number; return string, number, ...
end

--[[
```
<a id="compose"/>
Adapted <a href="https://stackoverflow.com/questions/27170825/composing-two-functions-in-lua" target="_blank"> composition function</a>.
```Lua
--]]
function core.compose(...)
  local functions = { ... };
  local function compose(i, ...)
    if i == #functions then return functions[i](...) end
    return compose(i + 1, functions[i](...))
  end
  return function(...) return compose(1, ...) end
end

--[[
```
<a id="math"></a>
#Doing the Math
In what is a common pattern, the exported `core.vectorPairs` function sets up the `inVectors` recursion.
```Lua
--]]
--:# **Math utilities**
local function inVectors(start, addends, number, result, count)
  if count > number then return result end
  local inner = {}; for j = 1, #addends do                    -- each addend is an x, y, z vector
    local sx, sy, sz = table.unpack(start[j])                 -- assume same number of addend vectors as start vectors
    local ax, ay, az = table.unpack(addends[j])               -- for clarity rather than efficiency
    inner[j] = { sx + ax, sy + ay, sz + az }                  -- make one of the result vectors
  end; result[count] = inner                                  -- include it in the accumulated result for next start vector
  return inVectors(inner, addends, number, result, count + 1) -- and cumulatively produce the next result
end

function core.vectorPairs(start, addend, number, partial) -- each table element cumulatively offset by addend
  --:: core.vectorPairs(start: bounds, addend: xyz, number: #:, partial: bounds?) -> _Make plots._ -> `bounds[]`
  --:+ _Addend is used to create a vector pair to be added cumulatively beginning with start bounds for result._
  --:+ _The number n is the number of bounds in result where each bound is offset by addend from the prior bounds._
  --:+ _Optionally the partial bounds are included as the first bounds in the result._
  --:> bounds: _Vector pair defining a rectangular solid_ -> :`[xyz, xyz]`
  --:> xyz: _Minecraft coordinates: +x: east, +y: up, +z: south_ -> :[x: #:, y: #:, z: #:]
  partial = partial and { partial } or {}; partial[#partial + 1] = start
  return inVectors(start, { addend, addend }, number, partial, #partial + 1) -- #addends = 2 for pairs
end

--[[
```
More vector arithmetic. And a simple example of <a> href="https://en.wikipedia.org/wiki/Function_composition" target="_blank"> function composition </a>.
```Lua
--]]
local faces = { -- north (NW: +z, +x); south (SE: -z, -x); west (SW: -z, +x); east (NE: +z, -x)
  north = function(x, y, z) return x, y, z end,
  south = function(x, y, z) return -x, y, -z end,
  east = function(x, y, z) return -x, y, z end,
  west = function(x, y, z) return x, y, -z end,
  up = function(x, y, z) return x, y, z end,
  down = function(x, y, z) return x, -y, z end,
  rotate = function(x, y, z) return z, y, x end
}
local function composition(f, g) return function(...) return f(g(...)) end end -- and see <a href="compose">core.compose</a>
local function facing(face, rotate) return composition(faces[face], faces[rotate] or function(...) return ... end) end

function core.orient(vectors, face, rotate)
  --:: core.orient(vectors: xyzMap, face: ":"?, rotate: ":"??) -> _Three dimensional rotation_ -> `xyzMap`
  --:+ _Turn from up north to face, default for no face is to rotate -90 degrees._
  --:> xyzMap: _Table of vectors either an array or dictionary_ -> `xyz[] | [core.faces]: xyz`
  --:> core.faces: _Key for composed function dictionary_ -> "north"|"south"|"east"|"west"|"up"|"down"|"rotate"
  local oriented = {}; for index, xyz in pairs(vectors) do -- key of array item  is index of item
    oriented[index] = { facing(face or "rotate", rotate)(table.unpack(xyz)) }
  end
  return oriented
end

--[[
```
<a id="round"></a>
Here's a simple definition for `round`. Nothing subtle: for its application in MUSE, there's no need.
```Lua
--]]
--:: core.round(n: #:) -> _Next integer down if below half fraction_ -> `#:`
function core.round(n) return n % 1 >= 0.5 and math.ceil(n) or math.floor(n) end

--[[
```
<a id="inext"></a>
#Fun With Functions
How to make an iterator that exposes its index.
```Lua
--]]
--:# **Example iterator, restartable at index**
local function iter(a, i)
  i = i + 1; local v = a[i]; if v then return i, v end
end

--:: core.inext(table: {:}, index: #:) -> _Iterator over table beginning at index._ -> `(:), {:}, #:`
function core.inext(table, index)
  index = index or 0; return iter, table, index
end

--[[
```
<a id="findItems"></a>
A completely straight forward implementation (for a change).
```Lua
--]]
--:# **Lowest level turtle and mock turtle support used by several libraries including lib/motion**
function core.findItems(targets) -- nil if no slot with target otherwise slot detail, does selection
  --:: core.findItems(targets: ":"[]) -> _Selects found slot._ -> `detail?`
  --:> detail: _Defined by Computercraft_ -> `{name: detail.name, count: detail.count, damage: detail.damage}`
  --:> detail.name: _Prepended by the mod name `"minecraft:"`._ -> `":"`
  --:> detail.count: _Available in inventory_ -> `#:`
  --:> detail.damage: _Distinguishing value_ -> `#:`
  ---@diagnostic disable-next-line: undefined-field
  local slots = _G.turtle and 16 or #turtle.slots                                     -- for out-of-game testing
  for i = 1, slots do
    local detail = turtle.getItemDetail(i)
    for _, target in ipairs(targets) do                                               -- if target == "" then return true end --TODO: OK??
      if detail and detail.name == target then return detail, i, turtle.select(i) end -- select if success
    end
  end; return nil
end

--[[
```
<a id="outgame"></a>
Support for out-of-game (debugging) operations.
```Lua
--]]
--:: core.sleep(#:?) -> _Mocks sleep as null operation out of game._ -> `nil`
---@diagnostic disable-next-line: undefined-field
core.sleep = os.sleep or function() return nil end -- mock out-of-game

--:: core.getComputerID(id: #:?) -> _Out of game returns id; id ignored in game._ -> `id: #:`
---@diagnostic disable-next-line: undefined-field
core.getComputerID = os.computerID or function(id) return id end -- mock out-of-game

--:: core.getComputerLabel(label: ":"?) -> _Out of game returns label; label ignored in game._ -> `label: ":"`
---@diagnostic disable-next-line: undefined-field
core.getComputerLabel = os.computerLabel or function(label) return label or _G.Muse.label end -- mock out-of-game

--:: core.setComputerLabel(label: ":") -> _Sets (out-of game global) label_ -> `label: ":"`
---@diagnostic disable-next-line: undefined-field
core.setComputerLabel = os.setComputerLabel or function(label) _G.Muse.label = label end

return { core = core }
