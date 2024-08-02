--[[
## Plan Execution: lib/worker.lua from lib/planner.lua
```md
--:! {worker:[]: (:)} <- **Functions Library to Execute Plans** -> muse/docs/lib/worker.md  
--:| worker: _Run what's been created by_ `planner` _while attempting to deal with a turtle's situational difficulties._ -> worker
```
```Lua
--]]
local worker = {} ---@module "signs.worker" -- for functions exported from library

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local places = require("places"); local moves = places.moves ---@module "signs.places"
--[[
```
<a id="failures"></a> 
Try recovery for 'lost` or 'blocked` conditions. If successful, <a href="https://dspace.mit.edu/bitstream/handle/1721.1/5753/AIM-443.pdf?sequence=2&isAllowed=y" target="_blank"> go to</a> `operate` as a<a href="https://en.wikipedia.org/wiki/Tail_call" target="_blank"> tail call</a> with the same index into `pathOperations` and the `remaining` blocks for `more`.
```Lua
--]]
-- # **Mutual recursions with `operate` to attempt recovery from `blocked` and `lost` failures.** 
local operate -- declared here for recursion 

local function empty(plan, _, index, direction, remaining, at, movement, motion) 
  error("worker.empty: no fuel at "..core.string(at, plan.name, index, direction, remaining, movement, motion))
end -- rescue needed

local function bedrock(plan, _, index, direction, remaining, at, movement, motion)
  error("worker.bedrock: at "..core.string(at, plan.name, index, direction, remaining, movement, motion))
end-- can't proceed

local function lost(plan, pathOperations, index, direction, remaining, at, movement, motion) -- get new gps fix, continue 
  local x, y, z = core.where(); if not (x and y and z) then error("worker.lost: GPS failed, turtle lost in "..
      plan.name.." plan. Last seen at "..at.. " heading "..direction.." "..plan.name.." "..movement.." "..motion)
  end; operate(plan, pathOperations, index, remaining)  -- what was lost was found, GPS reset dead reckoning
end

local function blocked(plan, pathOperations, index, direction, remaining, at, movement, motion) -- attempt unblock
  core.status(3, "worker", "blocked so unblocking at", at, "for", plan.name,  movement, motion) 
  turtle.unblock(direction, 5); move[direction](0) -- unblocking failure raises error, `operate` if unblocked
  -- turned in original direction, work not done, continue current operation for remaining blocks
  turtle.block(false) -- for out-game operation, imagine that the blockage has been removed
  return operate(plan, pathOperations, index, remaining) -- plan, pathOperations, index, more; 
end 
--[[
```
<a id="step"></a> 
The `operateStep` function sets up `workStep`, catches its errors, and dispatches to recovery operations using error conditions for its <a href="#failures"> failures</a>.
```Lua
--]]
local function workStep(plan, stepItem, direction, distance) -- `stepItem` is iterator (closure)
  for code, remaining in stepItem(distance) do -- errors to `stepOperation` if lost, empty, or blocked
    core.status(5, "work", "step to work", direction, "over", distance, "blocks", code, remaining) 
    if plan.work then plan.work(plan, direction) end-- **do the work here**, errors to `stepOperation` 
  end; return "done", 0, move.at() -- successfully steped work through path in plan
end

local failures = {blocked = blocked, lost = lost, empty = empty, bedrock = bedrock,} -- actions to handle failure

-- # **Step movement and marker and fixture placement operations. Windup for plan completion.**

local function operateStep(elements, plan, index, pathOperations, more) -- step (and work), recovery for failures
  local _, stepItem, direction, distance  = table.unpack(elements) -- `stepItem` is iterator (closure)
  local domore = more or distance; -- `more` from recovered operation
  core.status(5, "work", "step", direction, "more", domore, plan.name) 
  local stepOK, result, condition = core.pass(pcall(workStep, plan, stepItem, direction, domore)) -- **work**

  if stepOK then return operate(plan, pathOperations, index + 1) end -- ok, continue to `operate` next path operation

  move[direction](0) -- need to handle failure, first turn back toward direction of travel
  if type(condition) ~= "table" then -- something unrecoverable has happened
    error("work.operateStep: failed hard "..plan.name.." "..direction.." "..distance.." "..index.." "..result)
  end -- otherwise get `move` failure type and remaining blocks for stepping the recovery
  local _, _, fail, remaining, at, movement, motion = table.unpack(condition) -- handle step failures
  return failures[fail](plan, pathOperations, index, direction, remaining, at, movement, motion)
end

local function operateMark(elements, plan, index, pathOperations)
  local _, marks = table.unpack(elements); local markerName, markerLabel = plan.mark(plan, marks); 
  core.status(3, "worker", "marker", markerName, markerLabel, "added in", plan.name)
  return operate(plan, pathOperations, index + 1)
end

local function operatePut(elements, plan, index, pathOperations)
  local _, direction, item = table.unpack(elements); -- try to find item and if found, select for `turtle.puts`
  local items = turtle.category(item) -- `turtle.find` expects a list
  if not turtle.find(items) then error("worker.operatePut: no "..item .." found in ".. plan.name.." plan") end
  turtle.unblock(direction, 5); turtle.puts[direction](); return operate(plan, pathOperations, index +1)
end

local function finishOperations(plan)
  if plan.base then local baseOK, report = core.pass(pcall(moves.to, plan.base))-- operations done
    if not baseOK then error("work.finishOperations: move to base failed at "..move.ats().." in "..plan.name..": "..report) end
  end; return "done", "Execution of " .. plan.name .. " plan complete." 
end
--[[
```
<a id="operate"></a> 
After `worker.execute` checks for error conditions and attempts to move the turtle to the `plan.base`, the `operate` function serves as half of the mutual recursion that drives the work of the plan. A dispatch is made to deal with `step`, `put`, and `mark` operations in the `pathOperations` for the plan made by `lib/planner`. If there are no more operations to do, the work of the plan is finished by a call to `finishOperations` which attempts to move the turtle back to `plan.base`. Follow the link for the (fairly tricky) operation to <a href="#step"> step</a> movement and deal with `blocked`, `lost`, `bedrock`, and `empty` conditions.
```Lua
--]]
local operations = {step = operateStep, mark = operateMark, put = operatePut}

function operate(plan, pathOperations, index, more) -- `more` to continue `operate` from error condition `remaining`
  if index > #pathOperations then return finishOperations(plan) end
  local elements = pathOperations[index]; local operation = table.unpack(elements)
  core.status(4, "work", "operate on", index, "of", #pathOperations, "in", plan.name)
  return operations[operation](elements, plan, index, pathOperations, more) -- **do** `step`, `mark`, `put` 
end; 

--:: worker.execute(plan, pathOperations, fuelOK: ^:, pathDistance: #:) -> _Do plan._ ->  `"done", report: ":" &: &!`
--:+ _Attempt recovery for_ `blocked` _or_ `lost` _conditions; raise error for_ `empty` _or_ `bedrock` _or if recovery fails._
function worker.execute(plan, pathOperations, fuelOK, pathDistance)
  core.status(4, "worker", "execute plan", fuelOK, pathDistance, "blocks")
  if not fuelOK then error("worker.execute: insufficient fuel for "..pathDistance.." block plan") end 
  if plan.base then local moveOK, report = core.pass(pcall(moves.to, plan.base)) -- start from base
    if not moveOK then error("worker.execute: failed at "..move.ats().." for "..plan.name.." because "..report)
    end; core.status(2, "work", "at plan base") -- couldn't even get to first base
  end; 
  turtle.block(turtle.blocking())-- block in next operation if blocking has been enabled for out-game test
  return operate(plan, pathOperations, 1); -- **do it all** (uncaught errors thrown if anything fails)
  -- plan, pathOperations, index, more (`more` is nil at start of plan operation)
end

return {worker = worker}
