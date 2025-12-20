--[[ 
## Framework for Field Operations: lib/field
```md
--:! [field: [":"](:)] <- **Field Functions Library: Produce and Execute Field Plans** -> muse/docs/lib/field.md  
--:| field: _Fields are rectangular solids defined by a range (a `situation` pair with `fields` keyed properties)._ -> field, _field
--:+ _Fields are made up of plots, each plot at least small enough to deal with turtle inventory limitations._
```
```Lua
--]]
local field, _field = {}, {}; field.hints = {} ---@module "signs.field" -- exports, internals for analysis, hints 

local cores = require("core"); local core = cores.core ---@module "signs.core"
local moves = require("motion");local move = moves.move ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local places = require("places"); local place = places.place ---@module "signs.places"
local maps = require("map"); local map = maps.map ---@module "signs.map"
local planners = require("planner"); local planner = planners.planner ---@module "signs.planner"
local workers = require("worker"); local worker = workers.worker ---@module "signs.worker"
--[[
```
<a id="make"></a> 
The `field.make` command interface is called with a command table which specifies(directly or indirctly) a `range`, a kind of `place` as described in <a href="../lib/map.html" target="_blank">`lib/map`</a>. The `range` is used by `map.borders` to compute the three dimensional `bounds` of the field and find its `features`, a dictionary of properties. The operations on a `field` make use of that dictionary, retrieving the name of a `field file`, for example, `crop` as a property accessed by the dictionary's `fields` key. The `field.make` function loads the named _field file_ from the `fields` directory as, for example, `fields/crop.lua`, to get what we'll call the _field function_. The `fields.make` function calls this function with the command table it received and the `bounds` it computed.

The _field function_ uses the command table and the `bounds` to compute values it will pass to `field.plot` back here in `lib/field`. One of these values is a function we'll call the _field operation_. It is selected for the operation (for example, farm's `quarry` operation) specified in the command table and defined in the _field file_. Another of these values is the number of plots in the field for that operation.

This is the beginning of the execution train in `lib/field` that runs from here to `field.plot` to `field.plan` to `_field.execute`. There are excursions to files in the `fields/` and `plans` diectories.

TODO: Use this framework for something other than a `farm`. Perhaps something like a schoolroom, a village, or an underground city.
```Lua
--]]
local function getSelectorRange(ranger) -- ranger could be site.farm:canes, farm:canes, canes
  local _, _, site, first, second = string.find(ranger, "(%w-)%.?(%w*):?(%w*)$")
  local nosite, nosecond = site == "", second == ""; local sited = nosite and first or site.."."..first
  return not nosecond and sited, nosecond and sited or second -- farm, selector (selector is range name if no farm)
end

--:# **Execution train runs from `field.make` to `field.plot` to `field.plan` to execute the plan**
function field.make(commands, faced) -- loads and runs `fields/` file which calls `field.plot`
  --:: field.make(commands: fieldCommands, faced: ^:) -> _Load field files; return their `field.plot` calls_ -> `report: ":" &:`
  --:> fieldCommands: _For CLI_ -> `:[fieldOpName: ":", ranger: ":",  firstPlot: #:?, lastPlot: #:??]`
  --:+ _The second entry, `ranger` in `fieldCommands` is a string which may simply be a name for a `range`, (a kind of `place`)._
  --:+ _If so, the range name gets the range's features dictionary and the field file name to load (keyed as `features.fields`)._
  --:+ _It could also be a string specifying the name of a farm and a farm field name in that farm (separated by a colon)._
  --:+ _If so, the farm name specifies the farm's `range` and so the farm range's features dictionary._
  --:+ _The `fields` entry in that dictionary is itself a dictionary, keyed by the farm's field name to specify its range name._
  --:+ _With the proper range name in hand, either directly as above, or from the farm, the field file to load is specified._
  local _, ranger = table.unpack(commands); local farm, selector = getSelectorRange(ranger) -- if not farm, ranger is range name 
  local range = farm and map.get(farm, "fields")[selector] or selector -- if farm, field range name is one of the fields
  local borders, features = map.borders(range); -- features.fields specifies field file
  local fieldFile = _G.Muse.path.."fields/"..features.fields..".lua"
  local field = loadfile(fieldFile) -- get the field function (TODO: cache?)
  local _, report = core.pass(pcall(field, commands, borders, faced)) -- **run field file** (calling `field.plots`)
  return report
end;
--[[
```
<a id="plot"></a> 
The `field.plot` function does command line processing to select plots and handles error conditions raised by the _field operation_ in the `fields/` file that it calls for each plot (step 3). The dance continues as the _field operation_ for the plot calls `field.plan` (next as step 4) to provide parameters for the particular `plans/` file (for example, `plans/quarry.lua`). This (prototype) plans file is the one specified for the operation (for example, `"quarry"`). The `field.plan` call by the _field operation_ includes the `fieldParameters` that the prototype plan will need.
```Lua
--]]
local function home(xyz, result)
  local OK, failure = core.pass(pcall(turtle.digTo, xyz)); return OK and result or error("field: can't go home: "..failure)
end

function field.plot(commands, fieldsOp, fieldOpName, plots, offset) -- `field.make` -> field -> `field.plot`
--:: field.plot(commands: field.plotSpan, fieldsOp: (:), fieldOpName: ":", plots: #:, offset: xyz?) -> _Plots_ -> `report: ":" &: &!`
--:+ _Called by field files. Calls `fieldsOp` from field file (which calls `field.plan`)._
--:> field.plotSpan: _`{}` spans all plots; if only first, default plots after first ->_ `:[_:, _:, first: #:?, last: #:??]`
  local first, last = table.unpack(commands, 3); local hx, hy, hz = table.unpack(place.xyzf())
  if not (hx and hy and hz) then error("field.plot: No home") end
  core.status(4, "field", "plot start", hx, hy, hz, fieldOpName, first, last, plots, offset) 
  local possibleFirstPlot, possibleLastPlot = tonumber(first) or 1, tonumber(last) or plots 
  local firstPlot, lastPlot = math.min(possibleFirstPlot, plots), math.min(possibleLastPlot, plots)
  assert (firstPlot >= 1 and lastPlot >= 1, "field: "..plots.." selected plots less than 1")
  local results = {}; for i = firstPlot, lastPlot do -- field file provides `fieldsOp` in call to `field.plot` 
    core.status(4, "field", fieldOpName, "plot", i, "begun")
    local ok, fieldResult = core.pass(pcall(fieldsOp, i, offset)); -- **run field's operation** (`fieldsOp` which calls `field.plan`)
    if not ok then return home({hx, hy, hz}, "Plot "..i.." failed: "..fieldResult) end -- go back home
    core.status(4, "field", fieldOpName, "plot", i, "done") 
    results[#results + 1] = "Plot "..i.." of "..plots.." "..fieldResult.." done"  
  end; return home({hx, hy, hz}, table.concat(results, "\n")) -- unblocks as needed, done, back to home 
end
--[[
```
<a id="plan"></a> 
The `field.plan` function moves the turtle to the computed start position for the plot (including any offset) and loads the prototype plan to generate the _plan function_. It calls this function (step 5) with the `fieldParameters` (including the plot bound). The _plan function_ uses the `field.paths` utility and the plot bound to compute the `start`, `even`, `odd`, and (optionally) `last` paths to fill in the rest of the information from the plan prototype (step 6) to produce a complete `plan` (next). The computed paths define a "three dimensional ox plow" to minimize turtle motion in moving to every block in the three dimensional rectangular solid defined by the plot `bound`.
```Lua
--]]
function field.plan(planName, fielding, offset) -- `fieldsOp` calls `field.plan` for each plot 
--:: field.plan(planName: ":", fielding: fieldParameters, offset: xyz?) -> _Run plan, default offset {0,0,0}._ -> `report: ":" &: &!`
--:+ _Loads and executes the prototype plan (which calls `field.paths`) for each (odd, even, or last) level of a plot._
--:> fieldParameters: _`bounds` (and materials to fill and replace)_ -> `:[bounds, fieldParameters.fills?, fieldParameters.removeables??]`
--:> fieldParameters.fills: _Group or list of craft items for fill material_ -> `group|craft[]`
--:> fieldParameters.removeables: _Material replaced by fill_ -> `group|craft[]`
--:> craft: _Minecraft item `detail.name` without `minecraft:` prefix_ -> `":"`
  local bound = table.unpack(fielding); -- plot bound for start and finish
  local sx, sy, sz = table.unpack(bound[1]); local fx, fy, fz = table.unpack(bound[2]); -- s*: start, f*: finish
  local ox, oy, oz = table.unpack(offset or {0, 0, 0}) -- offset is optional
  local start, finish = {sx + ox, sy + oy, sz + oz}, {fx + ox, fy + oy, fz + oz}
  local xyzfstart, xyzfFinish = core.xyzf(start), core.xyzf(finish) 
  core.status(4, "field", "plan", planName, xyzfstart, "to", xyzfFinish)
  local moveOK, moveReport = core.pass(pcall(move.to, start, "y")) 
  if not moveOK then core.status(2, "field", "plan move.to", moveReport); return moveReport end
  local planFile = _G.Muse.path.."plans/"..planName..".lua"; 
  local planFunction = assert(loadfile(planFile), "field.plan: "..planFile.." failed") -- TODO: cache?
  local plans, yDelta = planFunction(fielding) -- **prototype plan file** calls `field.paths` utility
  local levels = math.abs(yDelta) + 1; core.status(4, "field", "starting", planName, levels, "levels")
  return _field.execute(plans, levels, fielding, planName)
end
--[[
```
<a id="execute"></a> 
Finally, `field.plan` calls `execute` (step 7) to do the work for completed plan that the previous steps have produced and handles any errors.
```Lua
--]]
local function executePlan(thisPlan, level) -- executePlan(thisPlan: plan, level: #:) -> _Run plan at level._ -> `^:, ":" &:`
  local pathOK, pathOperations, fuelOK, pathDistance = core.pass(pcall(planner.make, thisPlan))
  if not pathOK then return pathOK, pathOperations end -- `pathOperations` is failure string
  if level == 1 and pathOperations[1] then -- do work before first step iteration of first level
    local operation, _, direction = table.unpack(pathOperations[1]) -- direction if "step" operation
    if operation == "step" and thisPlan.work then thisPlan.work(thisPlan, direction) end 
  end; local fuel = fuelOK and "fuel OK" or "empty!"
  core.status(4, "field", "executing", thisPlan.name, "at", level, "for", #pathOperations, "of", pathDistance, fuel)
  --for debug: core.pass(xpcall(worker.execute, core.trace, thisPlan, pathOperations, fuelOK, pathDistance));
  return core.pass(pcall(worker.execute,thisPlan, pathOperations, fuelOK, pathDistance)) -- ok, completion or failure report
end

function _field.execute(plans, levels, fieldings, planName) 
  --:: `_field.execute(plans: _field.plans, levels: #:, fieldings: fieldParameters, planName: ":")` ->  _Run plans for the levels._ -> `":" &!`
  local ok, report = executePlan(plans.start, 1); if not ok then error("field.execute: Start "..report) end -- no y
  for level = 2, levels do 
    local ok, report = executePlan(level % 2 == 0 and plans.even or plans.odd, level) 
    if not ok then error("field.execute: "..report) end 
  end; if plans.last then local ok, report = executePlan(plans.last, levels); 
    if not ok then error("field.execute: Last "..report) end 
  end-- finish with y-movement to position for fill (if any)
  turtle.blocking(0) -- out-game testing: disable blocking for finish operations 
  return planName..": "..core.string(fieldings) 
end
--[[
```
That's the end of the control flow for the `lib/fields` framework. The following are the utilities used by `fields/` and `plans/` files/
<a id="extents"></a> 
The `field.extents` function, a utility for _field functions_ in `fields/` files, defines a (virtual) coordinate system in terms of `stride` (default shorter) and `run` (default longer) axes. Defaults are overridden if the extent is `faced`. Each ``plot`` of a field is positioned relative to the next ``striding`` increment along the `stride` axis to cover the specified `bounds`. The `striding` is determined by the size of the `stride` in the `strides` dictionary as keyed by the name of the field operation, the `opName`. Each _field file_ defines its `plots` in terms of the `stride` and `run` coordinate system. The number of plots, `nplots` in the `bounds` is computed given the extent along the `stride` axis and the `stride` for a given field operation. An indication for the number of turtle `slots` in the turtle's inventory that are expected to be involved in each field operation for each `plot` is also returned. 

As we've said, one reason fields are sliced into `plots` of a given size is to deal with the limits of turtle inventory. The size of the slices for a field operation is also determined by the geometry needed, for example, to grow specific crops in the field. The number of `plots` for each operation is determined by the size of the slices for that operation and the extent along the `stride` axis.
```Lua
--]]
function field.extents(bounds, strides, faced) 
--:: field.extents(:bounds:, :strides:, faced: ":"?) -> _Plots placed_ -> `field.count, field.count , eP, eP, striding, ^:, ^:`
--:+ Returns `nplots: #:, slots: #:, strides: eP, run: eP, striding: xyz, turn: ^:, back: ^:`
--:+ _Extents for `stride` (shorter) and `run` (longer) virtual axes for each `opName` in the `strides` entries unless `faced`._
--:> field.count: _dictionary keyed by 'opName` for number of elements in field for that operation_ -> `[fieldOp]: #:`
--:> strides: _dictionary keyed by `opName` for the distance along the stride axis for a striding_ -> `[fieldOp]: #:`
--:> striding: _dictionary keyed by `opName` of vectors incrementing game coordinate positions for `turn`_ -> `[fieldOp]: xyz`
--:> eP: _pair of coordinates for extents_  -> `bounds`
--:> fieldOp: _Operation name in the set for a particular kind of field_ -> ":"

  local west, east, north, south, top, bottom = bounds.west, bounds.east, bounds.north, bounds.south, bounds.top, bounds.bottom 
  local turn = not faced and (east - west) > (south - north) -- re-orient runs and strides; `faced` runs: north-south
  local long = {turn and west or north, turn and east or south} -- extent coordinates of the other, the run axis
  local short = {turn and north or west, turn and south or east} -- extent coordinates of the other, the stride axis
  local stacks = ((south - north + 1) * (top - bottom + 1) * (east - west + 1))/_G.Muse.stack

  local striding, nplots, slots = {}, {}, {}; for opName, stride in pairs(strides) do
    striding[opName] = turn and {0, 0, stride} or {stride, 0, 0} ; -- xyz for addend; stride stridings
    nplots[opName]  = (short[2] - short[1] + 1)/stride-- number of plots
    slots[opName] = stacks/nplots[opName] -- turtle stack fill
  end; return nplots, slots, short, long, striding, turn
end
--[[
```
<a id="paths"></a> 
The `field.paths` function might be thought of as a utility for a _plan prototype_. The function uses `_field.runElements` to figure out how to travel back and forth (ox plow) over all of a three dimensional rectangular solid with an efficient path. The details of how to do this are picky. Perhaps <a href="../../drawings/07Paths.pdf" target="_blank"> this drawing </a> will help.
```Lua
--]]
--:# **Path generator: flying ox plow paths through given three dimensional rectangular bounds.**
--:+ _Ox plow paths minimize travel to plow a field. Flying oxen (aka turtles) do that in three dimensions._

function _field.runElements(bounds) -- run elements, y delta, edge length, and edge direction for `plotPath`
  --:: `_field.runElements(bounds: [xyzStart: xyz, xyzFinish: xyz])` -> _Fly ox._ -> `runs:_field.runs, yDelta: #:, xzDelta: #:, xzEdge: facing`
  --:> `_field.runs`: _Plans for runs at even and odd numbered levels._ -> `{oddlevel: _field.plans, evenlevel: _field.plans}`
  --:> `_field.plans`: _At each level, start, even numbered, odd numbered, last run._ -> `{start: plan, odd: plan, even: plan, last: plan}`
  local xyzstart, xyzFinish = table.unpack(bounds); 
  local xstart, ystart, zstart = table.unpack(xyzstart); local xFinish, yFinish, zFinish = table.unpack(xyzFinish)
  local xDelta, yDelta, zDelta = math.abs(xFinish - xstart), yFinish - ystart, math.abs(zFinish - zstart); 
  local xLonger, goEast, goSouth = xDelta > zDelta, xFinish > xstart, zFinish > zstart
  local updown = yDelta > 0 and "u1 " or (yDelta < 0 and "d1 " or " ")

  -- `xLonger` selects to prefer longer runs: `true` for east|west; `false` for north|south
  -- there and back again: east|west `xMany[1]`, `xMany[2]`, `xMany[1]`, ....; north|south `zMany[1]`, `zMany[2]`, `zMany[1]`, ....  
  -- `goEast` `true`: `xMany[1] = `e*|w*` ; `xMany[2]: = w*|e*`; `goSouth` `true`: zMany[1] = `s*|n*` ; `zMany[2] = n*|s*`

  local xMany = goEast and {"e"..xDelta.." ", "w"..xDelta.." "} or {"w"..xDelta.." ", "e"..xDelta.." "}
  local xOnce = goEast and {"e1 ", "w1 "} or {"w1 ", "e1 "}
  local xEdge = goEast and "west" or "east" -- opposite to direction of operation

  local zMany = goSouth and {"s"..zDelta.." ", "n"..zDelta.." "} or {"n"..zDelta.." ", "s"..zDelta.." "}
  local zOnce = goSouth and {"s1 ", "n1 "} or {"n1 ", "s1 "}
  local zEdge = goSouth and "north" or "south" -- opposite to direction of operation

-- for odd levels: `start` (start of plot) or `first` (just the first at level), `evenRun`, `oddRun`, `evenRun`, ....
  local oddLevelstart = xLonger and xMany[1] or zMany[1] --  **e*/w*** or **s*/n*** (begin plot: no updown for start)
  local oddLevelFirstRun = xLonger and (updown..xMany[1]) or (updown..zMany[1]) -- **u1/d1 e*/w*** or **u1/d1 s*/n*** (first at level)
  local oddLevelEvenRun = xLonger and (zOnce[1]..xMany[2]) or (xOnce[1]..zMany[2]) -- **s1/n1 w*/e*** or **e1/w1 n*/s***
  local oddLevelOddRun =  xLonger and (zOnce[1]..xMany[1]) or (xOnce[1]..zMany[1]) --  **s1/n1 e*/w*** or **e1/w1 s*/n***
  local oddLevel = {
    start = oddLevelstart, first = oddLevelFirstRun, even = oddLevelEvenRun, odd = oddLevelOddRun
  }
-- even levels: crosswise runs even: `oddLevelEvenRun`, `evenLevelOddFirst`; odd: `oddLevelOddRun`, `evenLevelEvenFirst` (there and back)
  local evenLevelEvenFirst = xLonger and (updown..xMany[2]) or (updown..zMany[2])-- **u1/d1 w*/e*** or **u1/d1 n*/s*** (first at level)
  local evenLevelOddFirst = xLonger and (updown..xMany[1]) or (updown..zMany[1])-- **u1/d1 e*/w*** or **u1/d1 s*/n***
  local evenLevelEvenRun = xLonger and (zOnce[2]..xMany[2]) or (xOnce[2]..zMany[2]) -- **n1/s1 w*/e*** or **w1/e1 n*/s***
  local evenLevelOddRun = xLonger and (zOnce[2]..xMany[1]) or (xOnce[2]..zMany[1]) -- **n1/s1 e*/w*** or **w1/e1 s*/n***
  local evenLevel = {
    evenFirst = evenLevelEvenFirst, oddFirst = evenLevelOddFirst, even = evenLevelEvenRun, odd = evenLevelOddRun}

  local xzDelta, xzEdge = xLonger and zDelta or xDelta, xLonger and zEdge or xEdge -- length of runs crosswise for longer runs
  local runs = {oddLevel = oddLevel, evenLevel = evenLevel, lastLevel = updown} 
  return runs, yDelta, xzDelta, xzEdge -- 
end

function field.paths(bounds) -- `startPath`, `evenLevelPath`, `oddLevelPath`, `evenLevelPath`, `oddLevelPath`, ..., `lastLevelPath`
  --:: field.paths(bounds: xyz[]) -> _Called by plan prototype file to generate plans for plot._ -> `paths, yDelta: #:, xzEdge: facing`
  --:> paths: __Flying ox traverse of three dimensional rectangular solid_ -> {start: ":"[], odd: ":"[], even: ":"[], last: ":"[]}`
  --:+ _Returns paths, vertical traverse (`yDelta: #:`), and orientation of longest horizontal edge for bounded block._
  local runs, yDelta, xzDelta, xzEdge = _field.runElements(bounds); 
  -- `runs.evenLevel.evenFirst` and `runs.evenLevel.oddFirst` for first entry edge cases 
  local run = 1;  -- runs (odd and even: there and back again) 

  local startPath = {runs.oddLevel.start}; -- first run at odd and even levels has y movement if not beginning of plot

  for _ = 2, xzDelta + 1 do run = run + 1; -- xzDelta + 1 = number of crosswise runs; odd xzDelta => even number of such runs
    local thisRun = (run % 2 == 0) and runs.oddLevel.even or runs.oddLevel.odd
    table.insert(startPath, thisRun) -- build up `startPath`
  end; run = run + 1; -- for first entry for `evenLevelPath; run` odd if crosswise length even

  local evenLevelPath = (run % 2 == 0) and {runs.evenLevel.evenFirst} or {runs.evenLevel.oddFirst};  -- first entry

  for _ = 2, xzDelta + 1 do run = run + 1; 
    local thisRun = (run % 2 == 0) and runs.evenLevel.even or runs.evenLevel.odd
    table.insert(evenLevelPath, thisRun) -- build up `evenLevelPath`
  end; run = run + 1; -- `run` odd if crosswise length odd

  local oddLevelPath = {runs.oddLevel.first}; -- first entry of `oddLevelPath`

  for _ = 2, xzDelta + 1 do run = run + 1; 
    local thisRun = (run % 2 == 0) and runs.oddLevel.even or runs.oddLevel.odd
    table.insert(oddLevelPath, thisRun) -- build up `oddLevelPath`
  end; run = run + 1; -- `run` odd if crosswise length odd

  local lastLevelPath = {runs.lastLevel} -- just the one run (`"u1"` or `"d1"`) at last level
  local paths = {start = startPath, odd = oddLevelPath, even = evenLevelPath, last = lastLevelPath}
  return paths, yDelta, xzEdge
end
--[[
```
<a id="volumes"></a> 
That's the end of the framework control flow and support function definitions. Next up, the simpler stuff.

In lieu of a `field file`, a pair of points as named places will do for simple operations on volumes.
```Lua
--]]
--:# **Cut, fill, till, and traverse points defining rectangular volumes** using `field.plan` to optimize traversal.

local function protect(op, parameters, selector) -- catch bad parameters and other errors
  local ok, report = core.pass(pcall(op, parameters, selector)) -- finish turtle operation, report failures to player
  if ok then return report else return "field.protect: Failed operation because "..report end
end

function _field.makeBounds(nearPlace, farPlace)
  --:: `_field.makeBounds(nearPlace: ":", farPlace: ":")` -> _Get coordinate pair for named places._ -> `xyz, xyz, #:, #:`
  local xyzNear, xyzFar = place.xyzf(nearPlace), place.xyzf(farPlace) 
  assert(xyzNear and xyzFar, "field.makeBounds: "..nearPlace.." or "..farPlace.." place unknown")
  local xN, yN, zN = table.unpack(xyzNear); local xF, yF, zF = table.unpack(xyzFar)
  return {xN, yN, zN}, {xF, yF, zF}, yN, yF; -- start, finish
end

function _field.cut(places)
  --:: `_field.cut(places: [nearPlace: ":", farPlace: ":"])` -> _Use plan.quarry to cut._ -> `report: ":" &:`
  local nearPlace, farPlace = table.unpack(places) -- ["nearPlace", "farPlace"]
  local near, far, nearY, farY = _field.makeBounds(nearPlace, farPlace)
  local start, finish = nearY >= farY and near or far, nearY >= farY and far or near
  local ok, report = core.pass(pcall(field.plan, "quarry", { {start, finish} }, {0, 1, 0}))
  if ok then return report else return "field.cutPath: Failed because "..report end
end; 

function field.cut(places) return protect(_field.cut, places) end
--:: field.cut(places: [nearPlace: ":", farPlace: ":"]) -> _Quarry out blocks from one place to the other._ -> `":" &:`
--:- cut point point -> _Quarry out blocks bound by named points (defining a rectangular solid)._
field.hints["cut"] = {["?point "] = {["?point"] = {}}}

function _field.put(thePlan, start, finish, filling, target)
  --:: `_field.put(thePlan: ":", start: #:, finish: #:, filling: ":", target: ":"?)` -> _Use`layer` or `till` plan._ -> `":" &:`
  local fillings, targets = turtle.category(filling), target and turtle.category(target)
  local found = turtle.find(fillings); if not found then return ("field.put: can not find "..filling) end
  local ok, report = core.pass(pcall(field.plan, thePlan, { {start, finish}, {found.name}, targets}, {0, 1, 0})) 
  if ok then return report else return "field.put: Failed because "..report end
end 

function _field.fillTill(thePlan, parameters) 
  --:: `_field.fillTill(thePlan: ":", parameters: [nearPlace: ":", farPlace: ":", filling: ":", target: ":"?])` -> _To `put``._ -> `":"`
  local nearPlace, farPlace, filling, target = table.unpack(parameters);
  local near, far, nearY, farY = _field.makeBounds(nearPlace, farPlace)
  local start, finish = nearY <= farY and near or far, nearY <= farY and far or near
  return _field.put(thePlan, start, finish, filling, target)
end

function field.fill(parameters) return protect(_field.fillTill, "layer", parameters) end
--:: field.fill(parameters: [nearPlace: ":", farPlace: ":", fill: ":", target: ":"?]) -> _Fill, Till, Replace._ -> `":" &:`
--:< _Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:` 
--:- fill point point filling ?target -> _Layer fill bounds by points; optionally swaps out only target blocks._
field.hints["fill"] = {["?point "] = {["?point "] = {["?filling "] = {["??target"] = {}}}}}

function field.till(parameters) return protect(_field.fillTill, "till", parameters) end
--:: field.till(parameters: [nearPlace: ":", farPlace: ":", seed: ":"]) -> _Till the seed from one place to the other._ -> `":" &:`
--:< _Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `"minecraft:"`
--:- till point point seed -> _Till the seed bounds by named points (defining a rectangular solid)._
field.hints["till"] = {["?point "] = {["?point "] = {["?seed" ] = {}}}} 
--[[
```
<a id="fences"/a>
Fences expect a linear traversal between points at the same height. They may be made of any wooden material. Fences will only be placed for ranges whose `fields` features include `fences`.
```Lua
--]]
local function fence(parameters)
  local ranger, fencing = table.unpack(parameters); assert(ranger, "field.fence: need range"); 
  local farm, selector = getSelectorRange(ranger); -- farm40:canes gets range name
  local range = farm and map.get(farm, "fields")[selector] or selector -- range from farm fields property
  local _, features, from, to = map.borders(range) -- got the range from the farm (or given directly)
  assert(features and features.fences, "field.fence: missing fences feature")
  local xyzFrom, xyzTo = {from.x, from.y, from.z}, {to.x, to.y, to.z}
  return _field.put("layer", xyzFrom, xyzTo, fencing or "fence") -- put the fence as filling using `layer` plan
end; field.hints["fence"] = {["?range "] = {["??fencing"] = {}}}

function field.fence(parameters) return protect(fence, parameters) end
--:: field.fence(parameters: [ranger: ":", fencing: ":"?]) -> _Put fencing using `layer` plan._ -> `":"`
--:- fence range [item] -> _Put item or available wooden fence from one point to another in range._

return {field = field}