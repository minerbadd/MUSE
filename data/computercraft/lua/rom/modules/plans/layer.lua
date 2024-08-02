--[[
## Plan Prototype for Layering Along Path of a Rectagular Solid in a Range
```md
--:~ {start: plan, odd: plan, even: plan, last: plan }, yDelta: #: <- **Layer** ->  muse/docs/plans/layer.md  
--:+ _Plan prototype loaded by `field.plan` with bounds, fills, and, optionally, removeables (to be replaced with fills)._  
--:+ _Returns plans with paths from `field.paths` and work as `farm.put` or `farm.replacer` (for removeables)._  
``` 
```Lua
--]]
package.path = _G.Muse.package
local fields = require("field"); local field = fields.field ---@module "signs.field"
local farms = require("farm"); local farm = farms.farm ---@module "signs.farm"

local bounds, fills, removables = table.unpack(...) -- replace if `removeables`

local replace = removables and farm.replacer("down", fills, removables) or function() farm.put("down", fills) end

local paths, yDelta = field.paths(bounds) 

local plans = {
  start = {name = "layer start", path = paths.start, work = replace},
  odd = {name = "layer odd", path = paths.odd, work = replace},
  even = {name = "layer even", path = paths.even, work = replace},
  last = {name = "layer last", path = paths.last},
}
return plans, yDelta

