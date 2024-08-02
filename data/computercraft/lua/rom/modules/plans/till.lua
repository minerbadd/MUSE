--[[
## Plan Prototype for Tilling Fields Along Path of a Rectagular Solid in a Range
```md
--:~ {start: plan, odd: plan, even: plan}, yDelta: #: <- **Till One Layer** -> muse/docs/plans/till.md  
--:+ _Plan prototype loaded by `field.plan` with bounds. Returns plans with paths from `field.paths`. Turtle needs hoe._
```Lua
--]]
package.path = _G.Muse.package
local fields = require("field"); local field = fields.field ---@module "signs.field"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"

local bounds = table.unpack(...); local paths, yDelta =  field.paths(bounds) 

local plans = {start = {name = "till start", path = paths.start, work = turtle.digs.down, } } -- only one layer to `till`

return plans, yDelta

