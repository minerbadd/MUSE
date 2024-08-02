--[[
## Plan Prototype for Traversal Along Path of a Rectagular Solid in a Range
```md
--:~ {start: plan, odd: plan, even: plan, last: plan }, yDelta: #: <- **Path** ->  muse/docs/plans/path.md  
--:+ _Returns plans with paths from `field.paths` and does no work but may cause damage. Use as check before preparing farm._ 
```Lua
--]]
package.path = _G.Muse.package
local fields = require("field"); local field = fields.field ---@module "signs.field"

local bounds = table.unpack(...) 

local points = function() end

local paths, yDelta = field.paths(bounds) 

local plans = {
  start = {name = "path start", path = paths.start, work = points},
  odd = {name = "path odd", path = paths.odd, work = points},
  even = {name = "path even", path = paths.even, work = points},
  last = {name = "path last", path = paths.last},
}
return plans, yDelta

