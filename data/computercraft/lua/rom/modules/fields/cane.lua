--[[
## Quarry, Layer, Cover, Finish, Harvest, Path, and Test Operations for Cane Fields
```md
--:~ field.plot() <- **Layer Sand and Reeds, Harvest Cane Field Plots Separated by a Row of Water** -> muse/docs/fields/cane.md
--:+ _Loaded by `field.make` with operation name, span of plots for the operation, and field bounds._
--:+ **Supported operations are `quarry`, `layer`, `cover`, `finish`, `harvest`, `path`, and `test`**
--:+ _Calls `field.plot` with specified plot span, field operation function, and total number of field plots for operation._
--:+ _Operation functions call `field.plan` with plot bounds, xyz offset, and prototype plan for the operation._
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local fields = require("field"); local field = fields.field ---@module "signs.field"

local vPairs = core.vectorPairs

local commands, bounds, faced = ... -- **parameters from the `lib/field` call of the field function for this file** 
local strides = {quarry = 3, layer = 3, cover = 2 + 1, finish = 2 + 1, harvest = 2 + 1 } -- 2 blocks plus 1 for water strips
local nplots, slots, stride, run, striding, turn = field.extents(bounds, strides, faced)
local vW, _, vN, vS = stride[1], stride[2], run[1], run[2] -- vN to vS run axis and vW to VE stride axis for each plot
local orient = function(xyzAB) return turn and core.orient(xyzAB) or xyzAB end -- transform for turn

local bottom, top = bounds.bottom, bounds.top 

core.status(2, "cane", slots, "slots each plot")
--[[
```
<a id="plots"><IMG SRC="../../drawings/07Cane.png" ALIGN="right" hspace="10" /></a> 
The field is parcelled into `plots` appropriate to each _field operation_. Each `plot` is generated referencing the virtual `stride` and  `run` axes. If there is no `turn` property, `orient` performs no transform. The `stride` axis is then simply west to east in game coordinates and operations will `run` along north to south game coordinates.

The `plots` are defined so that `quarry` operates on the entire three block wide `slice` from `vW` through `vW+2` to let water into the `bottom` level of field. The dirt `layer` is at that same level but only on a two block wide part of the slice from `vW` through `vW+1`. The sand `cover` is one level up from the bottom on the same part of the slice. Cane is planted one level above that to `finish` the field. Finally, to `harvest` operations are done for kelp `offset :0, 1, 0}` and at the top of mature cane, `offset {0, 4, 0}`.
```Lua
--]]
local first = orient { {vW, bottom - 1, vN}, {vW, top, vS} } -- for kelp; runs north - south on virtual west bound for water
local plots = {-- layer dirt, cover sand, finish cane; allowing water strip between sand plots; first: water
  quarry = vPairs(orient { {vW + 1, bottom - 1, vN}, {vW + 3, top, vS} }, striding.quarry, nplots.quarry + 1, first), 
  layer = vPairs(orient { {vW + 1, bottom - 1, vN}, {vW + 2, bottom - 1, vS}}, striding.layer, nplots.layer), --  dirt
  cover = vPairs(orient { {vW + 1, bottom, vN}, {vW + 2, bottom, vS}}, striding.cover, nplots.cover), -- sand
  finish = vPairs(orient { {vW, bottom, vN}, {vW, bottom, vS}}, striding.finish, nplots.finish + 1), -- plant
  harvest = vPairs(orient { {vW, bottom, vN}, {vW, bottom, vS}}, striding.harvest, nplots.harvest + 1), -- harvest
  path = vPairs(orient { {vW, bottom, vN}, {vW, bottom, vS}}, striding.harvest, nplots.harvest + 1), -- path
}
core.status(2, "cane", slots, "slots each plot")
--[[
```
<a id="ops"></a> 
Each `operation` supported by this field (`quarry`, `layer`, `cover`, `finish`, `harvest`, `path`, and `test`) corresponds to a `field operation` function. These call `field.plan` with the name of a _plan prototype_ file in the `plans` directory and the `fieldParameters` including the `plot` that the _plan prototype_ will need. 
```Lua
--]]
local function quarryOp(index) -- called by `field.make`
  local result = field.plan("quarry", {plots.quarry[index]})
  core.status(4, "cane", "quarry", index, result)
  return result
end

local function layerOp(index) -- called by `field.make`
  local result = field.plan("layer", {plots.layer[index], {"minecraft:dirt"}})
  core.status(4, "cane", "layer", index, result)
  return result
end

local function coverOp(index) -- called by `field.make`
  local result = field.plan("layer", {plots.cover[index], {"minecraft:sand"}})
  core.status(4, "cane", "cover", index, result)
  return result
end

local function finishOp(index) -- called by `field.make`
  local crops = {"minecraft:kelp", "minecraft:reeds", "minecraft:reeds"}; local crop = crops[(index % #crops) + 1]
  local offsets = { {0, 0, 0}, {0, 1, 0}, {0, 1, 0} }; local offset = offsets[(index % #offsets) + 1]
  local result = field.plan("layer", {plots.finish[index], {crop} }, offset)
  core.status(4, "cane", "finish", index, result)
  return result
end

local function harvestPath(index, plan) -- called by `field.make`; harvest one plot of cane field
  local offsets = { {0, 1, 0}, {0, 4, 0}, {0, 4, 0} }; local offset = offsets[(index % #offsets) + 1]
  local result = field.plan(plan, {plots.harvest[index]}, offset)
  core.status(4, "cane", "harvestPath", index, result)
  return result
end

local function harvestOp(index) return harvestPath(index, "cane") end
local function pathOp(index) return harvestPath(index, "path") end

local function testOp() return "cane "..#plots.harvest.." plots "..(vS - vN + 1).." long" end
--[[
```
<a id="plot"></a> 
Calling the field function calls `field.plot` with a _field operation_ callback as well as the number of plots and offsets for the operation.
```Lua
--]]
local fieldOps = {
  quarry = quarryOp, layer = layerOp, cover = coverOp, finish = finishOp, harvest = harvestOp, path = pathOp; test = testOp,
  }
local fieldOpName= commands[1]; local fieldsOp = fieldOps[fieldOpName]; 
if not fieldsOp then error("cane: doesn't "..fieldOpName) end

return field.plot(commands, fieldsOp, fieldOpName, #plots[fieldOpName]) -- back to `field.plot` 
