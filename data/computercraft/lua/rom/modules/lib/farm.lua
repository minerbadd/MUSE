--[[ 
## Turtle Work Functions for Preparing, Planting, Harvesting Fields: lib/farm.lua
```md
--:! {farm: []: (:)} <- **Turtle Work Functions Support Library** -> muse/docs/lib/farm.md  
--:| farm: _Planting through blockages and in several directions. Putting item and replacing blocks._-> farm
--:> farmOpName: _Specifies operation on field_ -> `"quarry"|"layer"|"cover"|"finish"|"fence"|"harvest"|"path"|"test"`
```Lua
--]]
local farm = {}; farm.hints = {} ---@module "signs.farm" -- for functions exported from library

local cores = require("core"); local core = cores.core ---@module "signs.core"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"

local sides = {
  -- north = {"up"}, east = {"up"}, south = {"up"}, west = {"up"}, up = {"up"}, down = {"up"}, -- for debug: force unblocking
  north = {"down", "east", "west"}, east = {"down", "south", "north"}, 
  south = {"down", "east", "west"}, west = {"down", "south", "north"},
  up = {"north", "south", "east", "west", "up"}, down = {"north", "south", "east", "west", "down"}, 
}

function farm.logs(seedlings, direction) -- direction of movement
  --:: farm.logs(seedlings: ":"[], :direction:) -> _Logs down and sides, plants found seedlings._ -> `report: ":" &!`
  turtle.digAround(direction, "logs", sides[direction]); 
  if not turtle.find(seedlings) then error("farm.logs: Can't find "..core.string(seedlings)) end
  local plantOK, failure = turtle.puts["down"](); local report = plantOK and "done" or failure
  core.status(4, "farm", direction, "tree planting", report); return report
end

function farm.plant(planting) --:: farm.plant(planting: ":") -> _Tills and plants found planting._ -> `report: ":" &!` 
  turtle.digs["down"](); if not turtle.find({planting}) then error("farm.plant: Can't find "..planting) end
  local plantOK, failure = turtle.puts["down"](); local report = plantOK and "done" or failure
  core.status(5, "farm:planting", planting, report); return report
end

function farm.put(putAim, item) -- `putAim` not direction of travel
--:: farm.put(putAim: direction, item: ":"[]|":") -> _Puts found item in aimed direction._ ->  `report: ":" &!`
  local items = type(item) == "table" and item or turtle.category(item) -- turtle.find side effects for put
  if not turtle.find(items) then error("farm.put: Can't find "..core.string(items)) end 
  local putOK, failure = turtle.puts[putAim](); local report = putOK and "done" or failure
  core.status(5, "farm:put", item, report); return report
end

local function replace(direction, putAim, item) 
  turtle.digAround(direction, "replace", {putAim}); return farm.put(putAim, item) 
end

function farm.replacer(putAim, item, removables) -- not direction of travel, only replace removables
  --:: farm.replacer(putAim: direction, item: ":"[]|":", removables: ":"[]) -> _Remove, put._ -> `(_:, :direction:): ":" &!` 
  --:+ _Returns a function used by `lib/worker` to inspect aimed direction, farm out any removeable, replace with found item._
  --:+ _The direction of movement parameter in that function is used to reface turtle after replacement._
  return function (_, direction) -- ignore `plan` argument provided by `lib/worker.execute`
    local _, detail = turtle.inspects[putAim](); local name = detail and detail.name or ""
    for _, removable in ipairs(removables) do if name == removable then return replace(direction, putAim, item) end end
  end
end

farm.hints["field "] = {["quarry|layer|cover|finish|harvest|path ?range ??first ???last"] = {}}
--:- field `quarry|layer|cover|finish|harvest|path` -> _Prepare and harvest field for farming._ 

farm.hints["quarry "] = {["?range ??first ???last"] = {}}
farm.hints["layer "] = {["?range ??first ???last"] = {}}
farm.hints["cover "] = {["?range ??first ???last"] = {}}
farm.hints["finish "] = {["?range ??first ???last"] = {}}
farm.hints["harvest "] = {["?range ??first ???last"] = {}}
farm.hints["path "] = {["?range ??first ???last"] = {}}

--:# **Remote Commands for farm operations (`fieldOpNames`) on plots of fields bounded by ranges**
--:- quarry range firstPlot? lastPlot?? -> _Dig out the field to level it._
--:- layer range firstPlot? lastPlot?? -> _Put foundation material in place for field._
--:- cover range firstPlot? lastPlot?? -> _Replace field material (for tree farm grid)._
--:- finish range firstPlot lastPlot?? -> _Complete field preparation for farming._
--:- harvest range firstPlot lastPlot?? -> _Harvest (and replant if needed)._
--:- path range firstPlot lastPlot?? -> _Test harvest path (safely)._

return {farm = farm}