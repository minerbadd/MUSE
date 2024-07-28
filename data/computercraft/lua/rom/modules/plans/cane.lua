--[[
## Plan Prototype for Cane Fields
```md
--:~ {start: plan, odd: plan, even: plan}, yDelta: #: <- **Start Layer for Farming Cane** -> muse/docs/plans/cane.md  
--:+ _Plan protype loaded by `field.plan` with bounds. Returns `field.paths`, work as `turtle.digs.down`._  
```Lua
--]]
local fields = require("field"); local field = fields.field ---@module "signs.field"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"

local borders = table.unpack(...) -- cane fieldsOpParameters from, to
local paths, yDelta =  field.paths(borders)

local plans = {start = {name = "cane start", path = paths.start, work = turtle.digs.down} } -- only one layer; note: not front
  
return plans, yDelta

