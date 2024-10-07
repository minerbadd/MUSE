--[[
## Quarry, Layer, Cover, Finish, Harvest, Path, and Test Operations for a Tree Farm
```md
--:~ field.plot() <- **Create Tree Farm Spacing Trees by Threes and Harvest Them** -> muse/docs/fields/tree.md
--:+ _Loaded by `field.make` with operation name, span of plots for the operation, and field bounds._
--:+ _Calls `field.plot` with specified plot span, field operation function, and total field plots for that operation._
--:+ **Supported operations are `quarry`, `layer`, `cover`, `finish`, `harvest`, `path`, and `test`**
--:+ _Operation functions call `field.plan` with plot bounds, xyz offset, and prototype plan for the operation._
--:+ _Harvesting along tree lines starts above trees. Adjacent blocks are broken to get saplings from leaves._
--:+ _Makes and harvests the fields for the tree farm: excavates and fills with dirt. Then covers and finishes with sand._
--:+ _The cover and finish operations replace dirt and grass with two block wide strips of sand in the x and z directions._
--:+ _Result is blocks of dirt three blocks apart in horizontal directions with sand elsewhere to restrict planting._
--:+ _Planting (`plan.puts` as `minecraft:sapling`) only succeeds above dirt/grass/podzol._
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local fields = require("field"); local field = fields.field ---@module "signs.field"

local vectorPairs = core.vectorPairs

local commands, bounds, faced = ... -- **parameters from the `lib/field` call of the field function for this file** 
local strides = {quarry = 3, layer = 3, cover = 3, finish = 3, harvest = 3 }
local nplots, slots, stride, run, striding, turn = field.extents(bounds, strides, faced)
local vW, vE, vN, vS = stride[1], stride[2], run[1], run[2] -- vN to vS run axis and vW to VE stride axis for each plot
local orient = function(xyzAB) return turn and core.orient(xyzAB) or xyzAB end -- rotate -90 degrees or turn

local bottom, top = bounds.bottom, bounds.top; local cross = turn and {3, 0, 0} or {0, 0, 3}-- rotated for crosswise sand
nplots.finish = math.floor((vS - vN + 1) / 3) -- sand finish is crosswise to runs

core.status(2, "tree", nplots.cover, "by", nplots.finish, "plots", slots, "slots each plot to level")
--[[
```
<a id="plots"><IMG SRC="../../drawings/07Tree.png" ALIGN="right" hspace="10" /></a> 
The field is parcelled into `plots` appropriate to each _field operation_. Each `plot` is generated referencing the virtual `stride` and  `run` axes. If there is no `turn` property, `orient` performs no transform. The `stride` axis is then simply west to east in game coordinates and operations will `run` along north to south game coordinates.

<a href="../../drawings/07TreesField.pdf" target="_blank"> 
<IMG SRC="../../drawings/07TreesField.png" ALIGN="right" hspace="10"/> </a>

The `quarry` operation for the `field` digs out 3 block wide `plots` along each `run`. The `layer` operation provides a layer of dirt at the bottom of the `field`. The `cover` and `finish` operations replace the dirt with sand in 2 block wide `plots` crosswise along the `stride` and `run` axes. This leaves dirt 3 blocks apart along both axes for the `tree` plan prototype.
```Lua
--]]
local plots = {-- quarry & layer to plane, replace dirt/grass with sand in 2 wide strips in run then stride directions
  quarry = vectorPairs(orient { {vW, top, vN}, {vW + 2, bottom, vS} }, striding.quarry, nplots.quarry),
  layer = vectorPairs(orient { {vW, bottom, vN}, {vW + 2, bottom, vS} }, striding.layer, nplots.layer), -- dirt
  cover = vectorPairs(orient { {vW, bottom, vN}, {vW + 1, bottom, vS} }, striding.cover, nplots.cover), -- sand
  finish = vectorPairs(orient { {vW, bottom, vN}, {vE, bottom, vN + 1} }, cross, nplots.finish), -- sand crosswise
  harvest = vectorPairs(orient{ {vW + 2, bottom + 8, vN + 2}, {vW + 2, bottom + 1, vS}}, striding.harvest, nplots.harvest), 
  path = vectorPairs(orient{ {vW + 2, bottom + 8, vN + 2}, {vW + 2, bottom + 1, vS}}, striding.harvest, nplots.harvest), 
} 
core.status(2, "tree", "cover to", plots.cover[#plots.cover])
core.status(2, "tree", "finish to", plots.finish[#plots.finish])
core.status(2, "tree", "harvest to", plots.harvest[#plots.harvest])
--[[
```
<a id="ops"></a> 
Each `operation` supported by this field (`quarry`, `layer`, `cover`, `finish`, `harvest`, `path`, and `test`) corresponds to a `lib/farm operation`. Functions supporting each operation call `field.plan` with the name of a _plan prototype_ file in the `plans` directory and the `fieldParameters` including the `plots` that the _plan prototype_ will need. 
```Lua
--]]
local replaces = {"minecraft:dirt", "minecraft:grass_block"}

local function quarryOp(index)
  local quarryResult = field.plan("quarry", {plots.quarry[index]})
  core.status(4, "tree", "quarrying", index, quarryResult)
  return quarryResult
end

local function layerOp(index)
  local layerResult = field.plan("layer", {plots.layer[index], {"minecraft:dirt"}})
  core.status(4, "tree", "layering", index, layerResult)
  return layerResult
end

local function coverOp(index) -- do the  sand cover for one plot of the `tree` field
  local coverResult = field.plan("layer", {plots.cover[index], {"minecraft:sand"},  replaces})
  core.status(3, "tree", "covering", index, coverResult)
  return coverResult
end

local function finishOp(index) -- finish the sand cover for one plot of the `tree` field
  local finishResult = field.plan("layer", {plots.finish[index], {"minecraft:sand"},  replaces})
  core.status(3, "tree", "finishing", index, finishResult)
  return finishResult
end

local function harvestPath(index, plan) --  harvest one plot of tree field
  local harvestResult = field.plan(plan, {plots.harvest[index]})
  core.status(3, "tree", "harvestPath", index, harvestResult)
  return harvestResult
end 

local function harvestOp(index) return harvestPath(index, "tree") end

local function pathOp(index) return harvestPath(index, "path") end

local function testOp() return "tree "..#plots.harvest.." plots "..(vS - vN + 1).." long" end
--[[
```
<a id="plot"></a> 
Call `field.plot` with a _field operation_ callback as well as the number of plots for the operation.
```Lua
--]]
local fieldOps = {
  quarry = quarryOp, layer = layerOp, cover = coverOp, finish = finishOp, harvest = harvestOp, path = pathOp, test = testOp}
local fieldOpName = commands[1]; local fieldsOp = fieldOps[fieldOpName]; 
if not fieldsOp then error("tree: doesn't "..fieldOpName) end

return field.plot(commands, fieldsOp, fieldOpName, #plots[fieldOpName]) -- back to `lib/field` without selector 
