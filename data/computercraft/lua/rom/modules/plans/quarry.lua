--[[
## Plan Prototype for Quarry Digging Along Path of a Rectagular Solid in a Range
```md
--:~ {start: plan, odd: plan, even: plan, last: plan }, yDelta: #: <- **Quarry** -> muse/docs/plans/quarry.md  
--:+ _Plan prototype loaded by `field.plan`. Returns `field.paths`. Digs one level with `turtle.unblock("down")`._  
```Lua
--]]
local fields = require("field"); local field = fields.field ---@module "signs.field"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"

local bounds = table.unpack(...) -- `fieldsOpParameters`

local digUnblock = function() turtle.unblock("down") end

local paths, yDelta =  field.paths(bounds) 

local plans = {
  start = {name = "quarry start", path = paths.start, work = digUnblock},
  odd = {name = "quarry odd", path = paths.odd, work = digUnblock},
  even = {name = "quarry even", path = paths.even, work = digUnblock},
  last = {name = "quarry last", path = paths.last},
}

return plans, yDelta

