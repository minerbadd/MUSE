--[[
## Plan Prototype for Common Crop Fields
```md
--:~ {start: plan, odd: plan, even: plan}, yDelta: #: <- **To Plant and Harvest Crops** -> muse/docs/plans/crops.md  
--:+ _Plan prototype given borders, returns plans to harvest and plant with `farm.plant`._  
```
Each `run` is planted and harvested with the crop specified by the `plots` `index`. The work function uses the upvalues of the plan prototype rather than the arguments it's called with.
```Lua
--]]
package.path = _G.Muse.package
local fields = require("field"); local field = fields.field ---@module "signs.field"
local farms = require("farm"); local farm = farms.farm ---@module "signs.farm"

local bounds, index = table.unpack(...) -- crops `fieldsOpParameters` bounds:[from: xyz, to: xyz]; index is plot number
local paths, yDelta =  field.paths(bounds) 

local plots = {"", "minecraft:wheat_seeds", "minecraft:potato", "minecraft:carrot", "minecraft:beetroot_seeds",
  "minecraft:wheat_seeds", "minecraft:potato", "minecraft:carrot", "minecraft:beetroot_seeds"}

local function reap() return farm.plant(plots[(index % #plots) + 1]) end 

local plans = {start = {name = "crops start", path = paths.start, work = reap} } -- only one layer for `crops`
 
return plans, yDelta
