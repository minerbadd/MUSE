--[[
## Mine Operations for Shafts and Tunnels: `lib/mine.lua` 
```md
--:! {mine: []: (:)} <- **Mine Command Line Library** -> muse/docs/lib/mine.md  
--:| mine: _CLL operates plan to manage mines: shaft, bore, move to posts (between and within levels), and get ores._ -> mine, _mine
```
<a id="introduction"></a> 
```Lua
--]]
local _mine, mine = {}, {}; mine.hints = mine.hints or {} ---@module "signs.mine" -- for functions local to and exported from library

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local places = require("places"); local place, moves = places.place, places.moves
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local planners = require("planner"); local planner = planners.planner ---@module "signs.planner"
local maps = require("map"); local map = maps.map ---@module "signs.map"
local workers = require("worker"); local worker = workers.worker ---@module "signs.worker"

--:# **Interface for mining plans: digging and navigating shafts and bores, extracting ore**

--:# **Plan elements for digging shafts going down, furnishing them going back up, and moving between levels.** 
--:> shafts: _Dig_ -> `{shafts.name: ":", shafts.down: downs, shafts.back: levels, shafts.lower: levels, shafts.higher: levels}`
--:> shafts.name: _Included in error and status reports_ -> `":"`
--:> shafts.down: _Plan for digging shaft one level through even and odd levels_ -> `downs`
--:> shafts.back: _Plan for returning to minehead, placing fixtures and safety shelves for player_ -> `levels`
--:> shafts.lower: _Plan for navigating from one (even or odd) level to the next lower_ -> `levels`
--:> shafts.higher: _Plan for navigating from one (even or odd) level to the next higher_ -> `levels`

--:# **Plan definitions for digging shafts down from even to odd and from odd to even levels**
--:> downs: _Mark, dig, ladder, and fill one level (for landing platforms)_  -> `{downs.even: plan, downs.odd: plan, downs.last: plan }`
--:> downs.even: _Mark, dig, ladder, and fill an even level (for landing platforms) -> `plan`
--:> downs.odd: _Mark, dig, ladder, and fill an odd level (for landing platforms)_ -> `plan`
--:> downs.last: _Mark last level dug_ -> `plan`

--:# **Plan definitions for just moving between odd and even levels**
--:> levels: _Traverse (and fill shelves for  player safety in back plan) shaft_  -> `{levels.even: plan, levels.odd: plan}`
--:> levels.even: _Plan for navigating from one even level to the next -> `plan`
--:> levels.odd: _Plan for navigating from one even level to the next_ -> `plan`

--:# **Plan elements for boring and furnishing horizontal access tunnels at odd and even levels for mining**
--:> bores: _Horizontals_ -> `{bores.name: ":", bores.post: mine.post, bores.even: plan, bores.odd: plan, bores.fix: plan }`
--:> bores.name: _Included in error and status reports_ -> `":"`
--:> bores.even: _Plan for boring tunnels at even levels_ -> `plan`
--:> bores.odd: _Plan for boring tunnels at odd levels_ -> `plan`
--:> bores.fix: _Plan for fixtures: shaft area ladders and placing barrel_ -> `plan`

--:# **Interface definition for implemented bore navigation functions in mines**
--:> mine.post: _Navigate shaft and bores to go to marker._ -> (markerName: ":", :bores:):  `marking[]`
--[[
```
<a id="atWork"></a> 
The `atWork` function actually does the digging (and furnishing) of the bores and shafts at a specified level. It also sets up supplementary information in the fields of the `plan` for the work functions of the `plan` that are called by `worker.execute`. 
```Lua
--]]
-- # **Set up and do work for mine plan at level.**
local function atWork(plan, head, level, key, value) 
  --:: `_mine.atWork(:plan:, head: ":", level: #:, key: ":", value: any)` -> _Make, fill in, execute at level._ -> `":", ":" &: &!`
  local pathOperations, fuelOK, pathDistance = planner.make(plan)  -- **instantiate plan** if no errors thrown
  plan.head = head; plan.level = level; plan.key = key; plan.value = value -- _add fields for execution_
  core.status(3, "mine at work", plan.name, pathDistance, #pathOperations)
  local workOK, result, report = core.pass(pcall(worker.execute, plan, pathOperations, fuelOK, pathDistance))
  if workOK then return result, report end 
  error("mine: Failed working at "..level.." in "..head.." mine because "..result)
end
--[[
```
<a id="shaft"></a> 
Digging and furnishing a shaft is done going down and then back up beginning at and returning to the minehead. The work to be done is different at odd and even levels and at the last level to be dug. Other than selecting the appropriate plan for the level, the code is mostly just error checking, status reporting, and passing control to `atWork`.
```Lua
--]]
--:# **Go to minehead, dig shaft and return to minehead if no errors.**
local function mineHead(mineheadName) -- move to minehead
  local _, place = place.match(mineheadName); 
  if not place then error("mine.mineHead: Can't find minehead "..mineheadName) end
  local moveOK, headCode, remaining, ats = core.pass(pcall(moves.to, mineheadName))
  if not moveOK then error("mine.mineHead", "Can't move to "..mineheadName.." because "..headCode) end
  core.status(5, "mine", "At", mineheadName)
  return headCode, remaining, ats
end

function _mine.down(mineheadName, targetLevel, shaftPlansDown, shaftPlansName) 
  --:: `_mine.down(mineheadName: ":", targetLevel: #:, shaftPlansDown: downs, shaftPlansName: ":")` -> _Dig shaft_ -> `"done" &!`
  --:+ _Start dig down from minehead, finish by placing marker one level below target level, error raised for failure._
  --:+ _Add "shaft" and shaft plans name as key and value to shaft plans for inclusion in marker._
  mineHead(mineheadName); for level = 0, targetLevel do -- marks minehead 00
    local plan = (level % 2) == 0 and shaftPlansDown.even or shaftPlansDown.odd; 
    local planResult = atWork(plan, mineheadName, level, "shaft", shaftPlansName) -- "shaft" key and value
    core.status(5, "mine", "down", mineheadName, plan.name, "plan", planResult, "at level", level)
  end; local plan = shaftPlansDown.last; -- finish shaft with marker one level below the target level
  local planResult = atWork(plan, mineheadName, targetLevel + 1, "shaft", shaftPlansName) -- "shaft" key and value
  core.status(4, "mine", "down", mineheadName, plan.name, "plan"..planResult.."done at level", targetLevel + 1)
  return "done", planResult
end

function _mine.back(mineheadName, targetLevel, shaftPlansBack, shaftPlansName) 
  --:: `_mine.back(mineheadName: ":",  targetLevel: #:, shaftPlansBack: shafts, shaftPlansName: ":")` -> _To minehead_ -> `":", ":"  &!`
  --:+ _Execute shaft plans back to return to minehead from one below target level_
  --:+ _Add "shaft" and shaft plans name as key and value to shaft plans for inclusion in marker_
  local workResult, workReport; for level = targetLevel + 1, 1, -1 do -- end up shaft from level 1 to 0
    local plan = (level % 2) == 0 and shaftPlansBack.even or shaftPlansBack.odd
    workResult, workReport = atWork(plan, mineheadName, level, "shaft", shaftPlansName) -- "shaft" key and value
    core.status(4, "mine", mineheadName.." "..plan.name.." level "..level.." "..move.ats().." "..workResult)  
  end return workResult, workReport
end

--:# **Do the `shaft` operation for the command line interface.**
function _mine.shaftOp(mineheadName, levels, shaftPlans) 
  --:: `_mine.shaftOp(mineheadName: ":", levels: #:, shaftPlans: shafts)` -> _Dig shaft through levels._ -> `":", ":", #:` &!
  --:- shaft minehead levels shaftPlans -> _Dig down number of levels under named minehead place using specified plans._
  if not shaftPlans then error("mine.shaftOp: Need plan") end
  local downResult, downReport = _mine.down(mineheadName, levels, shaftPlans.down, shaftPlans.name)--down.even/down.odd
  -- go to <mineheadName> using `place.to` then dig down (marking and furnishing) the shaft <levels> as dug
  local downInventory = turtle.inventory() -- as a result of digging down
  core.report(2, "Inventory digging down ", downInventory, downResult, downReport)

  move.up(1) -- back up at one block above markers

  local backResult, backReport = _mine.back(mineheadName, levels, shaftPlans.back, shaftPlans.name) 
  local backInventory = turtle.inventory() -- as a result of getting back up shaft to minehead
  core.report(2, "Inventory digging back ", downInventory)
  return backResult, backReport, #backInventory -- back at minehead, returns `"done"` and inventory table size
end; mine.hints["shaft"] = { ["?minehead ?levels ?shaftplans" ] = {}}
--[[
```
<a id="post"></a> 
Use the shaft plan to move the turtle from odd to even and even to odd shaft levels until it arrives at the target level. Assume the shaft has already been dug and provisioned. The `checkLevel` and `changeLevel` functions just help with the `post` operation, moving the turtle to the designated post `point`. Navigation is done either from a shaft (at some level) to a marked `point` or from there to a shaft at the level specified by its `marker`.
```Lua
--]]
-- # **Navigate to post using markers, changing level if necessary**
local function changeLevel(directionPlans, direction, thisLevel, targetLevel)
  local even, odd = {planner.make(directionPlans.even)}, {planner.make(directionPlans.odd)}
  local OK, result, report; local movement = direction == "higher" and -1 or 1
  local finallyFrom = targetLevel - (1 * movement) -- last level before target

  for level = thisLevel, finallyFrom, movement do -- each level to next in appropriate direction
    core.status(4, "mine change level", level, finallyFrom, movement)
    local operations, fuel, distance = table.unpack(level % 2 == 0 and even or odd)
    local plan = level % 2 == 0 and directionPlans.even or directionPlans.odd
    OK, result, report = core.pass(pcall(worker.execute, plan, operations, fuel, distance))
    if not OK then error("mine.changeLevel: Failed move to "..targetLevel.." from "..thisLevel.." because "..result) end
  end; core.status(4, "mine change level done", result, report)

  return result, report, #turtle.inventory() -- successfully moved to level (but not to post)
end

local function checkLevel(markerName, borePlans, shaftPlans, markers)
  local _, targetLevel, _ = planner.mark(markerName) 
  assert(targetLevel, "mine checkLevel: missing "..markerName)
  local thisShaft, thisLevel, thisTag = planner.mark(markers.target)
  assert(thisShaft and thisLevel and thisTag, "mine checkLevel unknown level")
  core.status(3, "mine check level", thisLevel, thisTag, "in", thisShaft)
  -- if target marker is at a different level than current level, turtle has been moved to shaft
  local lower, higher = targetLevel > thisLevel, targetLevel < thisLevel

  if not (higher or lower) then core.status(3, "mine check level at", thisLevel, markerName)
    return "post" , "At "..markerName.." "..borePlans.bores.name, thisLevel 
  end -- already at post

  local direction = higher and "higher" or "lower"; local directionPlans = shaftPlans[direction];
  return changeLevel(directionPlans, direction, tonumber(thisLevel), tonumber(targetLevel))
end
--[[
```
Getting to the `post` requires navigating to its level. That's the tricky part (above). The rest is here.
```Lua
--]]
function _mine.toPost(markerName, borePlans, shaftPlans) 
  --:: `_mine.toPost(markerName: ":", borePlans: bores, shaftPlans: shafts)` -> _Navigate to post_ -> `"done", ":", #: &!`
  -- + _Uses post operation specified by bore plan to navigate to post, returns level reached by post._
  if not place.match(markerName) then error("mine.toPost: "..markerName.." not found") end
  local markers = borePlans.bores.post(markerName, borePlans); -- navigation to shaft (or post) 
  local levelDone, levelReport, doneLevel= checkLevel(markerName, borePlans, shaftPlans, markers) 
  core.status(3, "mine", "level", levelDone, levelReport)
  if levelDone == "post" then return "done", levelReport, doneLevel end-- already at level and thus at post
  -- Not at level. Go there to get to post
  markers = borePlans.bores.post(markerName, borePlans)-- at shaft target, effect navigation to post -- was , shaftPlans)
  local postDone, postReport, shaftLevel = checkLevel(markerName, borePlans, shaftPlans, markers)
  if postDone == "post" then return "done", postReport, shaftLevel end 
  error("mine.toPost: Changed level but not at "..markerName.." "..postReport)
end

--:# **Do the `post` operation for the command line interface**.
local function postOp(markerName, borePlansFile, shaftPlans) 
  --:- post marker borePlans?  -> _Go to marker (and up 1 block) from current level with saved or specified plans._
  local boreFileName = borePlansFile or map.gets(markerName, "bore")
  assert(boreFileName, "mine.postOp: need bore plan")
  --go to marker post (and up 1) in specified level from somewhere in current level
  local boreOK, borePlans = core.pass(pcall(planner.load, boreFileName)) 
  if not boreOK then return "mine", boreOK, "Can't load bore plan "..boreFileName, borePlans end
  local atMarker, markReport, shaftLevel = _mine.toPost(markerName, borePlans, shaftPlans)
  if not atMarker then error("mine.postOp: Unable to return to "..markReport) end
  move.up(1) -- **turtle stays above marker between operations to stay out of the way**
  return atMarker, markReport, shaftLevel
end; mine.hints["post"] = { ["?marker ??boreplans"] = {} }
--[[
```
<a id="bore"></a> Bores start at the shaft for the level specified by the `markerName`. The only interesting thing in this code is the use of the feature list key and value support from `lib/map` to simplify the CLI for mining ores. 
```Lua
--]]
--:# **Bore horizontal tunnels and mine tunnels branching off the main tunnel for ore**
function _mine.bore(markerName, borePlans, shaftPlans) -- **returns `"done"` and inventory table size**
  --:: `_mine.bore(markerName: ":", borePlans: bores, shaftPlans:shafts)` -> _Go to marker and bore_ -> `"done", ":", #: &: &!`
  --:+ _Use shaft plans and bore plans to navigate to marker, bore horizontal tunnels using bore plans._
  --:+ _Add "bore" and bore plans name as key and value to bore plans for inclusion in marker._
  --:+ _Bores plans at even or odd level, potentially leaves place marks and torches._
  local targetShaft, targetLevel = planner.mark(markerName); local boreName = borePlans.bores.name; 
  assert(map.puts(markerName, "bore", boreName), "mine: bore no marker "..markerName)
  local OK, result = core.pass(pcall(_mine.toPost, markerName, borePlans, shaftPlans)) -- **go to marker**
  if not OK then
    error("mine.bore: Can't reach "..markerName.." in "..shaftPlans.name.." to bore "..boreName.." because "..result)
  end; -- at level, in center channel
  local plan = targetLevel % 2 == 0 and borePlans.bores.even or borePlans.bores.odd
  local boreResult, boreReport = atWork(plan, targetShaft, targetLevel, "bore", boreName) -- **do bore** bore key and value
  local postDone, postReport, shaftLevel = _mine.toPost(markerName, borePlans, shaftPlans) -- **return to shaft**
  if not postDone == "done" then error("mine.bore: Failed return to shaft at level "..shaftLevel.." "..postReport) end
  local fixResult, fixReport= atWork(borePlans.bores.fix, targetShaft, targetLevel, "bore", boreName) -- **fix the mess**
  return boreResult, boreReport, #turtle.inventory(), fixResult, fixReport
end 

local function boreOp(markerName, borePlansFile, shaftPlans) 
  --:- bore marker borePlans  -> _Dig horizontally from marker using saved or specified bore and shaft plans._ 
  if not borePlansFile then error("mine.boreOp: Need plan") end
  local OK, borePlans = core.pass(pcall(planner.load, borePlansFile)) 
  if not OK then return "mine", OK, "Can't load bore plan "..borePlansFile, borePlans end
  move.down(1) -- **need to move (not bore) to center channel from turtle placement between operations**
  local boreOK, boreReport, inventory = _mine.bore(markerName, borePlans, shaftPlans)
  move.up(1) -- **turtle stays above marker between operations to stay out of the way**
  return boreOK, boreReport, inventory
end; mine.hints["bore"] = { ["?marker ?boreplans"] = {} }
--[[
```
<a id="ores"></a> There's not much to deal with here procedurally in digging ores: it's all in the declarative plan and the work functions in `lib/grid`.  This code just picks the right plans, loads them, causes them to be executed, and check for errors.
```Lua
--]]
function _mine.ores(markerName, thisLevel, borePlans) -- **returns `done`and inventory table size**
  --:: `_mine.ores(markerName: ":", thisLevel: #:, borePlans: bores)` -> _Excavate ores_ -> "done", `":", #: &: &!`
  --:+ _Use shaft plans and instantiated bore plans to go to marker and execute mining operations_
  for _, plan in pairs(borePlans.ores) do 
    local operations, fuelOK, distance = planner.make(plan) -- **instantiate plan** if no errors thrown
    local mineOK, result = core.pass(pcall(worker.execute, plan, operations, fuelOK, distance))
    if not mineOK then error("mine.ores: Failed "..plan.name.." at "..markerName.." level "..thisLevel.." because "..result) end
  end; return "Mined ores at "..markerName, #turtle.inventory() 
end

local function oresOp(markerName, borePlansFile, shaftPlans) -- get ores from side tunnel near marker 
  --:- ores marker borePlans?  -> _Excavate ores from side tunnel near marker, return up 1 from marker._
  local boreFileName = borePlansFile or map.gets(markerName, "bore") 
  if not type(boreFileName) == "string" then error("mine.oresOp: Missing file name for at "..markerName) end
  local boreOK, borePlans = core.pass(pcall(planner.load, boreFileName)) 
  if not boreOK then return "mine", boreOK, "Can't load bore plan "..(borePlansFile or ""), borePlans end
  local _,  _, thisLevel = _mine.toPost(markerName, borePlans, shaftPlans) -- go to target marker at start of each ores plan
  local report, inventory = _mine.ores(markerName, thisLevel, borePlans) -- `"done"` and inventory table size
  move.up(1) -- **return to above marker (without digging) between operations to stay out of the way**
  return report, inventory
end; mine.hints["ores"] = { ["?marker ??boreplans"] = {} }
--[[
```
<a id="mine"></a> 
Supporting the CLI for `mine` is just loading the shaft plan (which may be associated with a marker), dispatching to the function for the indicated operation, and checking for errors.
```Lua
--]]
local function getShaftPlans(placeName, shaftPlansFile) -- from 
  local shaft, level = planner.mark(placeName); 
  assert(shaft, "mine.getShaftPlans: missing for "..placeName); 
  local shaftName = shaft..":"..level
  local fileName = shaftPlansFile or map.gets(shaftName, "shaft"); 
  local _, shaftPlans = core.pass(pcall(planner.load, fileName)) 
  return shaftPlans 
end

local dispatch = {s = _mine.shaftOp, b = boreOp, p = postOp, o = oresOp, }

function mine.op(arguments) -- 
--:: mine.op(arguments: :[op: ":", placeName: ":", borePlansFileOrLevels: ":"|#:, shaftPlansFile: ":"]) -> _Dig._ -> `^:, ":", #: &:`
--:+ _Dig shaft; go to post at level; bore, mark, and torch; get ores. Markers hold saved plans._
  local op, placeName, borePlansFileOrLevels, shaftPlansFile = table.unpack(arguments)
  local shaftPlans = getShaftPlans(place.qualify(placeName), shaftPlansFile); 
  local letter = string.sub(op, 1, 1); local operation = dispatch[letter]
  if not shaftPlans then return "mine", false, "Can't load shaft plan "..shaftPlansFile, shaftPlans end
  local _, done, report, inventory = core.pass(pcall(operation, place.qualify(placeName), borePlansFileOrLevels, shaftPlans))
  return done, report, inventory -- for errors, report is error report (and nil inventory)
end

return {mine = mine}
