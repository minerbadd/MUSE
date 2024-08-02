--[[
## Quarry, Layer, Finish, harvest, Path, and Test Operations for Common Crop Fields
```md
--:~ field.plot() <- **Create and harvest Crops Fields, Water Strips Every Eight Blocks** -> muse/docs/fields/crops.md
--:+ _Loaded by `field.make` with operation name, span of plots for the operation, and points bounding field._
--:+ **Supported operations are `quarry`, `layer`, `finish`, `harvest`, `path`, and `test`**
--:+ _Calls `field.plot` with the specified field operation function and all the field's plots for that operation._
--:+ _Operation functions call `field.plan` with plot bounds, xyz offset, and the prototype plan for the operation._
--:+ _Plots other than 1 block wide `harvest` plots are 8 blocks wide along east-west axis with water assumed on either side._
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local fields = require("field"); local field = fields.field ---@module "signs.field"

local vectorPairs = core.vectorPairs

local commands, bounds, faced = ... -- **parameters from the `lib/field` call of the field function for this file** 
local bottom, top = bounds.bottom, bounds.top

local strides = {quarry = 8 + 1, layer = 8 + 1, finish = 1, harvest = 1, test = 1}
local nplots, slots, stride, run, striding, turn = field.extents(bounds, strides, faced) -- `faced`: unvirtualized runs north-south
local vW, _, vN, vS = stride[1], stride[2], run[1], run[2] -- vN to vS run axis and vW to VE stride axis for each plot
local orient = function(xyzAB) return turn and core.orient(xyzAB) or xyzAB end -- transform for turn
--[[
```
<a id="plots"><IMG SRC="../../drawings/07Crops.png" ALIGN="right" hspace="10" /></a> 
The field is parcelled into `plots` appropriate to each _field operation_. Each `plot` is generated referencing the virtual `stride` and  `run` axes. If there is no `turn` property, `orient` performs no transform. The `stride` axis is then simply west to east in game coordinates and operations will `run` along north to south game coordinates.

The `quarry` operation for the `field` digs out `plots` for `crops` 9 blocks wide and a `first` strip adjacent to the `field` for water. Each `plot` has only an 8 block wide dirt `layer`. The 9th block is left open for water. The `finish` operation for `crops` plants a `run` for each 1 block wide `stride` that is one block above the level of the `layer`. The `harvest` operation harvests `crops` one block above that.
```Lua
--]]
local first = orient { {vW, bottom, vN}, {vW, top, vS} } -- runs north - south off west bound
local plots = {-- pattern is 8 parts of crops, 1 water; extra first quarry plot is water strip; `harvest` to harvest then plant
  quarry = vectorPairs(orient { {vW + 1, bottom, vN}, {vW + 9, top, vS} }, striding.quarry, nplots.quarry + 1, first),
  layer = vectorPairs(orient { {vW + 1, bottom, vN}, {vW + 9, bottom, vS} }, striding.layer, nplots.layer), -- dirt/sand
  finish = vectorPairs(orient { {vW + 1, bottom + 1, vN}, {vW + 1, bottom + 1, vS} }, striding.finish, nplots.finish), -- till
  harvest = vectorPairs(orient { {vW + 1, bottom + 1, vN}, {vW + 1, bottom + 1, vS} }, striding.harvest, nplots.harvest),
  path = vectorPairs(orient { {vW + 1, bottom + 1, vN}, {vW + 1, bottom + 1, vS} }, striding.harvest, nplots.harvest),
  test = vectorPairs(orient { {vW, bottom, vN}, {vW + 1, bottom + 1, vS} }, striding.test, nplots.test),
}
--[[
```
<a id="ops"></a> 
Each `operation` supported by this field (`quarry`, `layer`, `finish`, `harvest`, and `test`) corresponds to a `field operation` function. These call `field.plan` with the name of a _plan prototype_ file in the `plans` directory and the `fieldParameters` including the `plots` that the _plan prototype_ will need. The `finish` and `harvest` operations also provide the `index`.
```Lua
--]]
local function quarryOp(index)
  local quarryResult = field.plan("quarry", {plots.quarry[index]})
  core.status(3, "crops", "quarrying", index, slots, quarryResult)
  return quarryResult
end

local function layerOp(index)
  local layerResult = field.plan("layer", {plots.layer[index], {"minecraft:dirt"}})
  core.status(3, "crops", "layering", index, slots, layerResult)
  return layerResult
end

local function finishOp(index)
  local finishResult = field.plan("till", {plots.finish[index], index}) -- index is plot number
  core.status(3, "crops", "finishing", index, slots, finishResult)
  return finishResult
end

local function harvestPath(index, plan)
  local harvestResult = field.plan(plan, {plots.harvest[index], index})
  core.status(3, "crops", "harvestPath", index, slots, harvestResult)
  return harvestResult
end

local function harvestOp(index) return harvestPath(index, "crops") end
local function pathOp(index) return harvestPath(index, "path") end

local function testOp() 
  local reports = {}; for i, plot in ipairs(plots.test) do reports[i] = core.string(plot) end
  return "crops "..core.string(nplots, "\n", table.concat(reports, "\n")) 
end
--[[
```
<a id="plot"></a> 
Call `field.plot` with a _field operation_ callback as well as the number of plots and offsets for the operation.
```Lua
--]]
local fieldOps = {quarry = quarryOp, layer = layerOp, finish = finishOp, harvest = harvestOp, path = pathOp, test = testOp}; 
local fieldOpName = commands[1]; local fieldsOp = fieldOps[fieldOpName]
if not fieldsOp then error("crops: doesn't "..fieldOpName) end

return field.plot(commands, fieldsOp, fieldOpName, #plots[fieldOpName]) -- to `lib/field` 
