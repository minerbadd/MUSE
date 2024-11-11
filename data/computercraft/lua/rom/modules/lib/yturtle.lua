--[[
## Consistency for Turtle Operations: `lib/turtle.lua` for Turtle Abstractions
```md
--:! {turtle: []: (:) } <- **Turtle Operations Overlay Library** -> muse/docs/lib/turtle.md  
--:| turtle: _Replaces game definitions, unifies operations to all directions: north, east, south, west, up, down._ -> turtle
--:+ _Provides low level item finding, naming and turtle inventory utilities; out-of-game simulated blocking._  
```
The MUSE `turtle` module introduction is much like any other. One thing is a little different: a <a href="../CodeMark/Annotations.html" target="_blank"> CodeMark </a> `VALUE` mark, describing `direction` as a unification of the four cardinal and two vertical directions. We've seen a limited bit of this in `lib/motion`.  Providing this abstraction on a broader scale is more or less the whole point of this library. The turtle operations defined by the game (or, out-of-game, those provided by `lib/mock`) are accessed in the `mock` table.
```Lua
--]]
local turtle = {} ---@module "signs.turtle" -- for functions exported from library

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion =  require("motion"); local move = motion.move ---@module "signs.motion"
local mocks = require("mock"); local mock = _G.turtle or mocks.turtle ---@module "signs.mock"
-- if no _G.turtle then mock turtle: out-of-game

--:> direction: _Four compass points and verticals_ -> `"north"|"east"|"south"|"west"|"up"|"down"`
--[[
```
<a id="operations"></a>
Each appropriate `turtle` operation is redefined to support the new abstraction as a table of functions for that operation in the six possible directions and `forward`. When the library is loaded, `makeOperations` makes entries in the table that the `turtle` library exports. Generating functions for the `turtle` library with `makeOperations(operations, turtle)` lets us specify the suite of turtle operations concisely with a table. (The `mock` functions are real Computercraft `turtle` functions in-game.)
```Lua
--]]
--:# **Turtle operations north, east, south, west, up, down**

local cardinals = {"north", "east", "south", "west"}

local function makeDirections(front, up, down, op, lib) -- TODO: extend `directions` and `operations` to include `right` and `left`
  lib[op] = {}; for _, cardinal in ipairs(cardinals) do 
    lib[op][cardinal] = function(q) move[cardinal](0) return front(q) end 
  end
  lib[op].up = function(q) return up(q) end; lib[op].down = function(q) return down(q) end; 
  lib[op].forward = function(q) return front(q) end -- `q` is argument if needed
end

local function makeOperations(operations, lib) -- for movement
  for operation, ops in pairs(operations) do makeDirections(ops.front, ops.up, ops.down, operation, lib) end
end

--:# **Operation dictionaries keyed by direction, values are generally functions of no arguments calling which return a boolean.**
-- compare, detect, inspect, 
local operations = {
  attacks = {up = mock.attackUp, down = mock.attackDown, front = mock.attack}, 
  --:> turtle.attacks: _Attack in direction and return attack success._ -> `[:direction:]: (): ^:, ":"?`
  compares = {up = mock.compareUp, down = mock.compareDown, front = mock.compare},
  --:> turtle.compares: _Check block in direction has the same ID as selected slot_ -> `[:direction:]: (): same: ^:`
  detects = {up = mock.detectUp, down = mock.detectDown, front = mock.detect},
  --:> turtle.detects: _Check block in direction is solid: not air, mob, liquid or floater._ -> `[:direction:]: (): ^:`
  digs = {up = mock.digUp, down = mock.digDown, front = mock.dig},
  --:> turtle.digs: _Try to dig block in direction and call_ suck(). -> `[:direction:]: (side: ":"?): ^:, ":"?`
  --:+ _Sucked items go to inventory. If a hoe is used to attempt to "dig" a dirt block, it will be tilled instead._
  --:+ _Tilling is also possible if the space in front of the turtle is empty but dirt exists below that point._
  drops = {up = mock.dropUp, down = mock.dropDown, front = mock.drop},
  --:> turtle.drops: _Drop count [or all] items in selected slot to inventory._ -> `[:direction:]: (count: #:?): ^:, ":"?`
  --:+ _Returned function drops and returns_ `false` _if there's inventory on the side specified by direction which is full._
  inspects = {up = mock.inspectUp, down = mock.inspectDown, front = mock.inspect}, --returns `false` for air
  --:> turtle.inspects: _If true, get detail block information in direction._ -> `[:direction:]: (): `^:`, `detail?`
  puts = {up = mock.placeUp, down = mock.placeDown, front = mock.place},
  --:> turtle.puts:  _Attempt placing block of the selected slot in direction._ -> `[:direction:]: (text: ":"?): ^:, ":"?`
  --:+ _Collects water or lava if the currently selected slot is an empty bucket. Text is used for placed sign._ 
  --:+ _Value of `turtle.puts[:direction:]` is a function of one optional argument calling which returns a boolean._
  sucks = {up = mock.suckUp, down = mock.suckDown, front = mock.suck},
  --:> turtle.sucks: _Move count [or all] from direction to inventory._ -> `[:direction:]: (count: #:?): ^:, ":"?`
  --:+ _Move from ground or first non empty slot of adjacent inventory enabled block to selected or next turtle slot._
  --:+ _Value of `turtle.sucks[:direction:]` is function of one optional argument calling which returns a boolean._
}

makeOperations(operations, turtle) -- fills in the table exported by this `turtle` library 
--[[
```
<a id="references"></a> 
Passing interfaces through as if they were part of the `turtle` library completes the operations abstraction. 
```Lua
--]]

--:# **Function References**
turtle.find = core.findItems --:= core.findItems:: turtle.find
turtle.select = mock.select --:: turtle.select(slot: #:) -> _Attempts to select the specified slot._ -> `selected: ^:`
turtle.item = mock.getItemDetail --:: turtle.item(slot: #:?) ->  _Detail of specified or currently selected slot._ -> `nil | detail`
--[[
```
<a id="inventory"></a> 
More abstractions: categories of items and the detail of which slot of turtle inventory an item is in.
```Lua
--]]
--:# **Item name and turtle status utilities**
function turtle.inventory() 
  --:: turtle.inventory() -> _Returns currrent turtle inventory as turtle detail table_. -> `detail[]`
  local inventoryTable = {}; for i = 1, _G.Muse.slots do local detail = mock.getItemDetail(i)
    if detail then inventoryTable[#inventoryTable + 1] = {detail.name, detail.count, detail.damage} end
  end; return inventoryTable 
end;

function turtle.items() return core.string(turtle.inventory()) end --:- items -> _Returns items in turtle inventory as string._

function turtle.check(targets, detail) -- item inspected by turtle is in targets?
  --:: turtle.check(targets: ":"[], :detail:) -> _Tries to match each target against_ `detail.name`. -> ``matched: ^:`
  for _, target in ipairs(targets) do if detail.name == target then return detail.name end end
end

--:# _Categories provide names for sets of minecraft items._

local fuels = {"minecraft:coal", "minecraft:coal_block", "minecraft:charcoal", "minecraft:lava"} 

local ores = {"minecraft:coal_ore", "minecraft:iron_ore", "minecraft:lapis_ore", "minecraft:gold_ore",
  "minecraft:diamond_ore", "minecraft:redstone_ore", "minecraft:emerald_ore", "minecraft:nether_quartz_ore",
  "minecraft:prismarine", "minecraft:obsidian"}

--:> ore: _Minecraft_ -> `"minecraft:coal_ore"|"minecraft:iron_ore"|"minecraft:lapis_ore"|"minecraft:gold_ore"|"minecraft:diamond_ore"|"minecraft:redstone_ore"|"minecraft:emerald_ore"|"minecraft:nether_quartz_ore"|"minecraft:prismarine"|minecraft:obsidian"`
--:> ores: _Category_ -> `ore[]`
--:> minecraft: _For Language Server_ -> ":"

local stones = {
  "minecraft:diorite", "minecraft:cobblestone", "minecraft:granite", "minecraft:andesite", 
  "minecraft:sandstone", "minecraft:terracotta", "minecraft:stone",}

local fences = { 
  "minecraft:birch_fence", "minecraft:oak_fence", "minecraft:acacia_fence", "minecraft:bamboo_fence", 
  "minecraft:cherry_fence", "minecraft:chrimson_fence", "minecraft:dark_oak_fence", "minecraft:mangrove_fence", 
}

local dirts = {"minecraft:dirt", "minecraft:coarse_dirt",}
local fills, tests = core.merge(stones, dirts), {"found item"}

local categories = {fuel = fuels, ore = ores, fill = fills, dirt = dirts, stone = stones, fence = fences, test = tests}
--:> group: _Materials_ -> `"fuel" | "ore"| "fill" | "dirt" | "stone" | "fence" | "test"`

local function qualify(name) local prefix = string.match(name, "(%a*):(%a*)"); return prefix and name or "minecraft:"..name end

local fencings = { --:# **Fence material specified by short name (e.g. `oak`) along points specified by `range`**
  birch = "minecraft:birch_fence", acacia = "minecraft:acacia_fence", bamboo = "minecraft:bamboo_fence", 
  cherry = "minecraft:cherry_fence", chrimson = "minecraft:chrimson_fence", ["dark oak"] = "minecraft:dark_oak_fence", 
  mangrove = "minecraft:mangrove_fence", oak = "minecraft:oak_fence", 
} --:> fencings: _Wooden materials_ `-> "birch" | "acacia" | "bamboo" | "cherry" | "chrimson" | "dark oak" | "mangrove" | "oak"`

function turtle.category(name) return name and (categories[name] or {fencings[name] or qualify(name)}) or {} end
--:: turtle.category(name: ":") -> _Names in category or fencings matching `name` or_ `{"minecraft:"..name}`. -> `":"[]` 

local fuelEnergy = 
{["minecraft:coal"] = 80, ["minecraft:coal_block"] = 800, ["minecraft:charcoal"] = 80, ["minecraft:lava"] = 1000} 

function turtle.fuel() --:- fueling -> _Returns energy available in turtle slots._
  --:: turtle.fuel() -> _Total energy actually available in turtle slots plus turtle fuel level._ -> `fuelTotal: #:`
  local fuelTotal =  0; for i = 1, 16 do local detail = mock.getItemDetail(i)
    if detail then local energy = fuelEnergy[detail.name] or 0; fuelTotal = fuelTotal + (energy * detail.count) end
  end; return fuelTotal + mock.getFuelLevel()
end; 
--[[
```
<a id="unblock"></a> 
Abstracting away the difficulties in moving and digging is also a kind of information hiding.
```Lua
--]]
local undug = {"minecraft:water", "minecraft:lava"} -- cant'dig the undug

local function attemptDig(direction) -- "done if air or the undug, else attack (mob); then return dig success (or not)
  local inspectOK, found = turtle.inspects[direction](); if found and found.name == "minecraft:bedrock" then 
    error("turtle.attemptDig: Bedrock at "..move.ats().." "..direction) -- no recovery
  end; local untarget = turtle.check(undug, found); -- water or lava?
  if untarget then core.status(4, "turtle", "attempt dig", found, "undug:", untarget) end
  if not inspectOK or untarget then return "done", "undug" end -- air, water, or lava
  turtle.attacks[direction](); local dug, report = turtle.digs[direction](); return dug, report or found.name
end 

function turtle.unblock(direction, limit, attempts) -- returns "done" or raises an error
  --:: turtle.unblock(direction: ":", limit: #:?) -> _Retrys (default `_G.Muse.attempts`) dig to limit or bedrock._ -> `"done", nil|"undug" &!` 
  --:+ _Returns "done, "undug" if dig attempt was for air, water, or lava. Raises error for bedrock or dig limit reached._
  limit = limit or _G.Muse.attempts; attempts = attempts or 0; -- waits, arbitrary default retrys for gravel; attacks
  if attempts > limit then error("turtle.unblock: Failed at "..move.ats().." "..direction)
  end; -- failed: not air, water, lava, bedrock, sand, gravel (or succesful attack of mobs)
  local done, report = attemptDig(direction); if done then return done, report end -- **dig succeeded**
  core.status(2, "turtle", "Unblocking", direction, attempts) -- report blockage
  core.sleep(0.5); -- wait for gravel or sand to finish falling... and then try again
  return turtle.unblock(direction, limit, attempts + 1) -- try again, dig failure or the undug?
end

function turtle.digTo(xyzf, limit)
  --:: turtle.digTo(:xyzf:, limit: #:?) -> _Unblocking move._ -> `code: ":", remaining: #:, xyzf: ":" &: &!` 
  --:+ _Try to move to position, dig to unblock if needed, catch (table) and raise error(string) for "lost" or "empty"._
  --:+ _Also catch and raise error (string) if attempt to dig to unblock failed for bedrock or other reason._
  --:+ _Normally return just what a successful move would: "done", 0 remaining, current position._
  local moveOK, result, condition = core.pass(pcall(move.to, xyzf)); if moveOK then return result end
  core.status(2, "turtle", "bad move", xyzf, result, condition)
  if type(condition) ~= "table" then error("turtle.digTo: Unblock failed because "..result) end
  local _, report, fail, remaining, _, direction, from = table.unpack(condition) -- failures: `blocked`, `lost`, `empty`
  if fail ~= "blocked" then error("turtle.digTo: Unblock "..remaining.." failed because "..report) end
  if not direction then error("turtle.digTo: no direction for unblock "..from.." "..report) end
  core.status(2, "turtle", "Unblocking move", direction, "to", xyzf)
  return turtle.unblock(direction, limit)  -- returns true or raises error (and a report for bedrock) 
end

function turtle.digAround(orientation, name, diggings)
  --:: turtle.digAround(orientation: ":", name: ":", diggings: ":"[]) -> _Unblocking dig._ -> `"done" &: &!`
  --:+ _Dig (unblocking) in diggings directions, catch failure and raise error(string) re-orienting in original orientation._
  for _, digging in ipairs(diggings) do core.status(5, "turtle", "around", orientation, diggings)
    local OK, fail = core.pass(pcall(turtle.unblock, digging)); if not OK then
      move[orientation](0); error("turtle.digAround: "..name.." "..digging.." failed, "..fail..", refacing "..orientation)
    end
  end; return "done"
end
--[[
```
<a id="block"></a> 
Lastly, allow blocking to be simulated for out-of-game debug.
```Lua
--]]
--:: turtle.block(blocked: ^:) -> _Out-of-game debug: sets blocking for simulating turtle being blocked._ ->  `blocked: ^:`
function turtle.block(blocked) -- enable/disable blocking for out-game test
---@diagnostic disable-next-line: undefined-field
  if not _G.turtle then return mock.block(blocked) end 
end
--:: turtle.blocking(^:) -> _Isolate global to control blocking for out-of-game debug._ -> `^:`
function turtle.blocking(blocking) _G.Muse.blocking = blocking; return _G.Muse.blocking end
--]]
return {turtle = turtle}
--[[
```
And we're done making the new and improved `turtle`. No more the old. Return to <a href="../../MiningMUSE.html#roam"> MiningMUSE</a> 
to see how these functions are used to roam around a Minecraft world.
--]]