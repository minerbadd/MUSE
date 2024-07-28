--[[
## Task Commands for Turtles: lib/roam.lua
```md
--:! {task: []: (:) } <- **Command Line Library for Tasks: Low Level Turtle Operations** -> muse/docs/lib/task.md  
--:| task: _Dispatch targets for_ `net` _library._ -> task, _task
```
There's nothing much to see here. The `task` library uses the same implementation pattern for CLI support as other CLLs. But do look if you want to see another example. 
 ```Lua
--]]
local task, _task = {}, {}; task.hints =  {} ---@module "signs.task" -- internal and exported library functions and CLI hints

local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move, step = motion.move, motion.step ---@module "signs.motion"
local places = require("places"); local moves, place = places.moves, places.place ---@module "signs.places"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
--[[
```
#Simple Tasks
```Lua
--]]
local abbreviations = {u = "up", d = "down", n = "north", e = "east", w = "west", s = "south", f = "front"} 
--:< **Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`ront_**

local function getDirection(directionCode, supress) -- `supress` `true` to deal with `here`, a fake direction
  assert(directionCode, "task: Please specify direction")
  local letter = string.sub(directionCode, 1, 1); local direction = abbreviations[letter]
  if not direction and not supress then error("task.getDirection: Invalid direction ".. directionCode) end
  return direction
end

local function inventory() --return a report of turtle inventory and fuel available
  local inventoryTable, items = turtle.inventory(), {}; for i, item in ipairs(inventoryTable) do
    local name, count = table.unpack(item); items[i] = count.." "..name
  end; return table.concat(items, "\n").."\nFuel: "..tostring(turtle.fuel())
end

local function find(target) --:- find name...? -> _Report and select first slot found [or if no name, just report inventory]._
  if not target then return inventory() end
  local targets = turtle.category(target); local detail = turtle.find(targets) 
  return detail and core.string(detail)   -- _Selects found slot_ -> ({name = ":", count = #: damage = #:})?
end; task.hints["find"] = {["??item"] = {}}

local function attack(...) --:- attack direction -> _Attempts attack in specified direction._ 
  local direction = getDirection(...); local success = turtle.attacks[direction]() and " succeeded" or " failed"
  return "Attack "..direction..success
end; task.hints["attack"] = {["?direction"] = {}}

local function look(...) --:- look direction -> _Detect and inspect direction, return report._
  local direction = getDirection(...); if not turtle.detects[direction]() then return "No block "..direction end
  local success, data = turtle.inspects[direction](); if not success then return data.." "..direction end
  local name, state = data.name, core.string(data.state); local report = name..": "..state; return report
end; task.hints["look"] = {["?direction"] = {}}

local function compare(...) --:- compare item direction... -> _Named item matches block in any of specified directions?_
  local arguments = {...}; local item, directions = table.unpack(arguments), {table.unpack(arguments, 2)}
  -- TODO: local item, direction = select(1, ...), {select(2, ...)}
  assert(item and directions, "task.compare: Need item and directions")
  local targets = turtle.category(item); local target = turtle.find(targets); local targetName = target and target.name
  local found = {}; for _, direction in ipairs(directions) do
    local success, data = turtle.inspects[direction](); local dataName = success and data.name
    if dataName and targetName and dataName == targetName then found[#found + 1] = {direction, dataName} end
  end; 
  return core.string(found), found
end; task.hints["compare"] = {["?item ?direction..."] = {}} 

local function drop(...) --:- drop item direction quantity? -> _Drop quantity of selected items [or all]._ 
  local item, direction, quantity = ...; local found = find(item); if not found then return "Found no "..item end
  local released = turtle.drops[getDirection(direction)](tonumber(quantity))
  return released and core.string(turtle.detail()) or "Release "..direction.." failed"
end; task.hints["drop"] = {["?item ?direction ??count"] = {}}

local function suck(...) --:- suck direction quantity? -> _Suck quantity items [or all] into available slot._ 
  local direction, quantity = ...; local sucked = turtle.sucks[getDirection(direction)](quantity)
  return sucked and core.string(turtle.detail()) or "Suck "..direction.." failed"
end; task.hints["suck"] = {["?direction ?count"] = {}}
--[[
```
#Movement For Tasks
```Lua
--]]
local to = {[0] = "here", [2] = "west", [3] = "east", [4] = "down", [5] = "up", [8] = "north", [9] = "south"}

local function getAim(situation) -- `situation` is target, get direction to aim the movement
  local x, y, z = move.get(); local sx, sy, sz = move.get(situation); local dx, dy, dz = sx - x, sy - y, sz - z
  local flip = dx + dy + dz; local distance = math.abs(dx) + math.abs(dy) + math.abs(dz); -- **flip: only one dx, dy, dz ~= 0**
  local aims = (dx == 0 and 0 or 2) + (dy == 0 and 0 or 4) + (dz == 0 and 0 or 8) -- missing elements for errors
  local code = aims + (flip > 0 and 1 or 0); local direction = to[code] -- `here` is 0, `west/east` etc +/- for `flip`
  assert(direction, "task.getAim: too many directions to move at once")
  return direction, distance
end

local function doOnce(puttings, op, fill, targets) 
  for _, direction in ipairs(puttings) do 
    local ok, result = core.pass(pcall(op, getDirection(direction, true), fill, targets)) -- **do it**
    if not ok then return "Task failed "..direction.." because "..result end
  end;  
  return "done "..table.concat(puttings, " ").." to "..move.ats() 
end

local function doMany(distance, towards, puttings, op, clear, fill, targets)
  if clear then turtle.unblock(towards, 5) end -- 5 is arbitrary number of tries to unblock for dig
  if not distance then move[towards](0); return doOnce(puttings, op, fill, targets) end
  for code, remaining, ats in step[towards](tonumber(distance)) do -- e.g., step.east
    if code ~= "done" then return false, "Failed: "..code.." at "..ats..", "..remaining.." blocks remaining" end
    if clear then turtle.unblock(towards, 5) end
    doOnce(puttings, op, fill, targets); move[towards](0) -- and reorient after op
  end; return "done "..distance.." blocks "..towards.." "..table.concat(puttings, " ").." to "..move.ats()
end

local function doAlong(trail, puttings, op, clear, fill, targets)
  moves.to(trail); local name, label, situations = place.track(trail); 
  for _, situation in ipairs(situations) do 
    local towards, distance = getAim(situation)
    if distance > 0 then doMany(distance, towards, puttings, op, clear, fill, targets) end
  end
  return "done "..name.." ("..label..") to "..move.ats()
end

function _task.doTask(arguments, op, clear, fill, targets) 
  --:: `_task.doTask(arguments: _task.puts, op: (:), clear: ^:, fill: ":"?, targets: ":"[]?)`-> _Tasks_ -> ":" &!`
  --:> `_task.puts: _Common arguments_ -> :[direction: ":", distance: #:, puttings: ":"[] ]`
  local direction, distance = table.unpack(arguments); local puttings = {table.unpack(arguments, 3)} -- puttings: ":"[]
  if direction == "along" then return doAlong(distance, puttings, op, clear, fill, targets) end -- `distance` alias `trail`
  direction, distance = core.optionals(direction, distance) -- 
  local toward = getDirection(direction, true) -- supress error for bogus directions like "here"
  if toward then return doMany(distance, toward, puttings, op, clear, fill, targets) end -- `doMany` checks no distance
  table.insert(puttings, 1, distance); return doOnce(puttings, op, fill, targets) -- `distance` alias `direction`
end
--[[
```
#The Tasks Themselves
```Lua
--]]
local function dig(...) return _task.doTask({...}, function(direction) turtle.digs[direction]() end, true) end
--:- dig direction distance hoeing... -> _Direction and distance to (possibly blocked) move, hoeings directions to hoe._
--:+ _Dig along trails by specifying `direction` as `along` and trailname as `distance`. Can dig `here`._
--:+ _Tilling down, the common case for tilling, requires an air block beneath and a dirt block beneath that._
task.hints["dig"] = {["?direction ?distance ?direction..."] = {}}

local function puts(direction, filling, target) -- for change and put commands; put once, direction is a putting
  assert(find(filling), "task: "..filling.." not found"); local targets = turtle.category(target); 
  if #targets > 0 then local inspected, detail = turtle.inspects[direction](); -- change only targets
    if inspected and turtle.check(targets, detail) then -- found target to change
      assert(turtle.digs[direction](), "task: dig "..direction.." failed") -- dig it out
    end
  end; assert(turtle.puts[direction](), "task put "..direction.." failed") -- replace it
end

local function put(...) 
  --:- put filling direction distance putting... -> _Direction, distance to move, placing filling in puttings directions._
  --:+ _Put along trails by specifying `direction` as `along` and trailname as `distance`. Can put `here`._
  local filling = ...; return _task.doTask({select(2, ...)}, puts, false, filling) end -- [direction distance puttings...]
  task.hints["put"] = {["?item ?direction ?distance ?direction..."] = {}}

  local function change(...) local target, filling = ...; -- `{select(n: #:, ...}` to make a table of the rest including nth
    --:- change target filling direction distance putting... -> _Move distance in direction replacing target with filling._
      --:+ _Change along trails by specifying `direction` as `along` and trailname as `distance`. Can change `here`._
    return _task.doTask({select(3, ...)}, puts, false, filling, target) -- [direction distance puttings+] 
  end; task.hints["change"] = {["?target ?item ?direction ?distance ?direction..."] = {}} 
--[[
```
#Dispatch
```Lua
--]]
  local ops = {
    attack = attack, change = change, find = find, look = look, drop = drop, suck = suck, dig = dig, put = put, compare = compare
  }

  function task.op(commands) 
    --:: task.op (commands: :[ op: ":", arguments: ":"[] ] ) -> _Execute tasks for low level turtle operations:_ -> `":" &:`
    local ok, report = core.pass(pcall(ops[commands[1]], table.unpack(commands, 2)))
    if ok then return report else return "task: "..core.string(report) end -- report failure for error
  end 

  return {task = task}
--[[
```
Return to <a href="../../Mining MUSE.html#Chapter5"> Mining MUSE</a> to continue the exploration.
--]]