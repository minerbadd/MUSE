--[[
##Work Functions for Navigation and Mining Grid Plans: lib/grid.lua
```md
--:! {grid: []: (:)} <- **Grid Mining Functions Library** -> muse/docs/lib/grid.md  
--:| grid: _Work functions boring, navigating, and mining ore in a grid of tunnels._ -> grid
```
The `grid` library provides the _how_ extending mining plans run by the `lib/mine` CLL. It provides the means for `worker.execute` to bore and mine a grid of tunnels at some level in a mine. Ores are mined in tunnels perpendicular to three bored access tunnels: an `inner` one to the shaft, `outer` ones at the edges of the bored area.
```Lua
--]]
local grid = {}; grid.hints = {} ---@module "signs.grid" -- for functions exported from library

local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local maps = require("map"); local map = maps.map---@module "signs.map"
local planners = require("planner"); local planner = planners.planner ---@module "signs.planner"
local places = require("places") ---@module "signs.places"
local place, moves = places.place, places.moves

---@module "signs.mine" -- import the interface

--:> crossplan: _Bore and mine, minimal movement_ -> `{:bores:, ores: {name: ":", fixtures: ":"[], path: ":"[], work: plan.work} }`

--[[
```
<a id="navigation"></a> 
Navigating the grid of tunnels is done using markers for named `places`. The general idea for navigating is to go directly to the shaft between levels or to a (named place) `target` if is either is `reachable`, that is if the z coordinate and either the x or z coordinate is within one block of the current turtle `position`. If this is the case, the turtle has arrived. If that's not possible, go instead to an `inner` tunnel if that's `reachable`, to an `outer` tunnel if that's not. Then try again. Prefer tunnels `closer` to the `target`. Here are some utility functions used for navigation: 
```Lua
--]]
--:# **Navigation for grids:  use placed markers to find posts for turtles.**
local function reachable(xyzPlace) 
  local x, y, z = table.unpack(move.at()); -- only grid movement in tunnels; only within level 
  local xPlace, yPlace, zPlace = table.unpack(xyzPlace)
  return (math.abs(x - xPlace) <= 1 or math.abs(z - zPlace) <= 1) and math.abs(y - yPlace) <= 1 
end

local function closer(namePlace, nameMarker, xyzTarget) -- namePlace is tentative replacement
  local distancePlace = place.distance(place.xyzf(namePlace), xyzTarget)
  local distanceMarker = place.distance(place.xyzf(nameMarker), xyzTarget)
  return distancePlace < distanceMarker
end

local binLabels = {shaft = true, inner = true, outer = true}
-- examine (marker) place, bin its name as `target`, `inner`, or `outer` 
-- only if it's `reachable` and `closer` than curretly in that bin

local function bin(tagTarget, xyzTarget, namePlace, labelPlace, xyzPlace, markers)
  if not binLabels[labelPlace] or not reachable(xyzPlace) then return end
  core.status(5, "grid reachable", namePlace, labelPlace, markers)
  local _, _, tagPlace = planner.mark(namePlace) -- parse marker; if found target, done
  if tagTarget == tagPlace or labelPlace == "shaft" then markers.target = namePlace; return markers end 
  if closer(namePlace, markers[labelPlace], xyzTarget) then markers[labelPlace] = namePlace end
  return markers -- label: inner (main) hall or outer (back) hall
end

local function binMarkers(markerName) -- look at all the named `places` to bin those useful in moving to target
  local _, _, tagTarget = planner.mark(markerName); local xyzTarget = place.xyzf(markerName)
  assert(tagTarget and xyzTarget, "grid: binMarkers missing targets for "..markerName)
  local markers = {}; -- markers.target holds name of target marker or shaft marker
  for namePlace, labelPlace, xyzPlace in place.near() do 
    bin(tagTarget, xyzTarget, namePlace, labelPlace, xyzPlace, markers)  
  end; return markers -- for target, inner, and outer at current level 
end
--[[
```
<a id="mark"></a>
Markers are created according to a `marking` format that includes the name of the shaft for the minehead, the level in the mine, and the rest of the marker name that's specified by the `plan` file for the mine. The format is used for finding a `post` for a turtle and going there in the grid of tunnels. The `lib/mine` library has added supplementary information to the `plan`. This is used in creating the marker and providing its feature list with the `key` and `value` for the `plan`. A mining turtle uses `grid.post` to navigate to the `post` at a given level and wait there for commands from the player. The function adheres to the `mine.post` interface.
```Lua
--]]

function grid.mark(plan, marking) -- called by `worker.execute`, **specified in shaft and bore plans** 
--:: grid.mark(:plan:, :marking:) -> _Make place name, report result._ -> `markerName: ":", label: ":", report: ":"`
--:+ _Called by `worker.execute` to make marker name and use it to add map point for navigation in mine._
--:+ _Puts plan name value in marker (keyed by `"shaft"` or `"bore"`) so marker is enough for navigating in shaft or bore._
--:+ _Marker place name formed as `head:level:base` or `head:base` or `head` with place labelled as `"outer"|"inner"|"shaft"`._
  local prefix, base, label = table.unpack(marking); local length = string.len(prefix) --shaftName and level
  local shaftName, level, key, value = plan.head, plan.level, plan.key, plan.value -- **added by lib/mine**
  local levelName = length > 1 and string.format("%02d", level) or "" -- more than 1 colon in prefix => put level in name
  base = (base == "") and "" or ":"..base; local markerName = shaftName..":"..levelName..base; 
  local report = map.op {"point", markerName, label}; 
  map.put(markerName, key, value) -- marker gets plan key and value
  return markerName, label, report 
end

function grid.post(markerName, borePlans) -- in level, **specified by bore plan**, `mine.post` interface --:= mine.post:: grid.post
  local markers = binMarkers(markerName) -- target (shaft or tag), inner, and outer markers
  core.status(3, "grid", "binned markers for", markerName, markers) 
  if markers.target then moves.to(markers.target, "y"); return markers -- **at specified post or at shaft within this level**
  elseif markers.inner then moves.to(markers.inner, "y"); return grid.post(markerName, borePlans) -- try for shaft|tag
  elseif markers.outer then moves.to(markers.outer, "y"); return grid.post(markerName, borePlans) -- try for inner
  else error("mine.post: Can't navigate to "..markerName.." for "..borePlans.bores.name..
      " at "..move.ats().." with "..core.string(markers).." markers")
  end
end
--[[
```
<a id="ores"></a> 
The work to be done is factored into functions each of which is intended to convey how it is part of the work.  There's a bunch of tables used to separate out the detail from the procedural flow. The functions support `mineVein` which is where the work is actually done. The `grid.ores` function is mostly just an interface for `mineVein`. 

A `guide` is used to explore a vein for ore and extract the ore from it. There are four places that are adjacent to a mining  mining turtle and not in the direction a mining turtle is moving. The turtle can rotate and inspect these four for ore without using fuel. There is a excavation `guide` for each of these four. Each `guide` specifies where to `look` for ore, where to `dig` if it finds it, where to look for more if it does, and where to dig if it does find more. The details of the geometry are the _what_. The `grid` library provides the _how_ for mining in the pattern of bores and mining tunnels it supports.
```Lua
--]]
--:# **Mining Ore: look around for ore and if found, mine adjacent ore as well**

local function digIn(direction) 
  local digOK, digReport = core.pass(pcall(turtle.unblock, direction)) -- **dig found ore**
  if not digOK then error("mine.dig: "..direction.." failed because "..digReport) end
end

local opposites = {up = "down", down = "up", north = "south", south = "north", east = "west", west = "east" }
local go = {up = move.up, down = move.down, north = move.north, south = move.south, east = move.east, west = move.west }
local liquids = {"minecraft:water", "minecraft:lava"}

local function digInspect(ores, direction) -- direction to check, dig if air, water, lava, or ore
  local notAir, detail = turtle.inspects[direction](); -- `notAir` `false` for air 
  local ore, liquid = turtle.check(ores, detail), turtle.check(liquids, detail); 
  if notAir and not (liquid or ore) then return false end -- not air, water, lava, or ore
  digIn(direction); core.status(3, "grid", "inspected ore", ore, direction, notAir, liquid)
  return ore or not notAir, notAir; -- found ore or air: return `true`, `notAir` (not `nil` if ore, water, or lava)
end

local function moveIn(direction) -- simple moves (no unblocking)
  local moveOK, moveCode = core.pass(pcall(go[direction], 1)) -- go is move.xxxx(1) table
  if not moveOK then error("mine.moveIn: "..direction.." failed because "..moveCode) end
end

local function backOut(direction) -- use `opposites` to back out of digging for found ore
  local backOK, backCode = core.pass(pcall(go[opposites[direction]], 1)) -- back out
  if not backOK then error("mine.backOut: "..direction.." failed because "..backCode) end
end

local function digDeep(more, digMore, ores) -- dig and go in `more` direction, then dig around from there
  digIn(more); moveIn(more); core.status(3, "grid deep", more, digMore) -- not air
  for _, direction in ipairs(digMore) do digInspect(ores, direction) -- dig out any ore in digMore directions
  end; backOut(more); 
end

--:# **Definitions for finding and extracting ores**
--:> grid.cut: _Directions to dig in vein_ -> `"up"|"down"|"north"|"south"`
--:> grid.guide: _Instructions for cut_ -> `:[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`
-- + _`look`: direction to look for ore; `dig`: first digs in cut; `lookMore`: try direction for more ore; `digMore`: more digs._

local function mineCut(plan, direction, cut, ores) 
  local look, dig, lookMore, digMore = table.unpack(cut); local digIt, something = digInspect(ores, look)
  if digIt then moveIn(look); core.status(3, "grid in vein", digIt, look, dig) -- `digIt`: ore|lava|water|air
    for _, direction in ipairs(dig) do digInspect(ores, direction) end -- excavate into vein
    if something then digDeep(lookMore, digMore, ores) end -- found ore|lava|water, dig deeper for potentailly more ore
    backOut(look) -- back out of excavating cut, cut is done
  end; core.status(5, "grid cut done", direction, plan.name, look, lookMore)
  local moving = move[direction] --[[@as function]] -- `move` is a table of functions
  local moveOK, code = core.pass(pcall(moving, 0)) -- need to face in the original direction 
  if not moveOK then error("grid.mineVein: Can't return "..direction.." while digging because "..code) end
  return "done"
end

function grid.ores(plan, direction, guide, ores)
  --:: grid.ores(:plan:, :direction:, guide: grid.guide, :ores:) -> _Extract ores._ -> `"done" &!`
  --:+ _Given the guide for a vein, mine ores in each of the guide's cuts for that vein._
  for _, cut in ipairs(guide) do mineCut(plan, direction, cut, ores) end 
  return "done"
end

return {grid = grid}
