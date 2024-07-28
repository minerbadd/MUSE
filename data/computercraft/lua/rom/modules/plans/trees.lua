--[[
## Plan Prototype to Harvest Trees and Plant Saplings
```md
--:~ {start: plan, odd: plan, even: plan}, yDelta: #: <- **Trees: To Log Start, Odd, and Even Rows** -> muse/docs/plans/trees.md
--:+ _Plan prototype returns plans to log one level of a birch tree farm given bounds. Work function is `farm.logs`._
```Lua
--]]
local fields = require("field"); local field = fields.field ---@module "signs.field"
local farms = require("farm"); local farm = farms.farm ---@module "signs.farm"

local bounds = table.unpack(...) --from, to
local paths, yDelta =  field.paths(bounds) 
local function log(_, direction) return farm.logs({"minecraft:birch_sapling"}, direction) end --direction of motion

local plans = {
  start = {name = "trees start", path = paths.start, work = log},
  odd = {name = "trees odd", path = paths.odd, work = log},
  even = {name = "trees even", path = paths.even, work = log},
}
return plans, yDelta


