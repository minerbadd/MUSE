--[[
##Work Functions for Navigation and Mining Grid Plans: lib/grid
```md
--:! [grid: [":"]: (:)] <- **Grid Mining Functions Library** -> muse/docs/lib/grid.md  
--:| grid: _Work functions boring, navigating, and mining ore in a grid of tunnels._ -> grid
```
The `grid` library provides the _how_ extending mining plans run by the `lib/mine` CLL. It provides the means for `worker.execute` to navigate, bore, and mine a grid of tunnels at some level in a mine. There are three bored access tunnels: an `inner` one to the shaft and two `outer` ones at the edges of the bored area. Ores are mined in tunnels perpendicular to these.
```Lua
--]]
local grid = {} ---@module "signs.grid" -- for functions exported from library

local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local planners = require("planner"); local planner = planners.planner ---@module "signs.planner"
local places = require("places") ---@module "signs.places"
local place, moves = places.place, places.moves

---@module "signs.mine" -- import the interface

--[[
```
<a id="navigation"></a> 
A mining turtle uses `grid.post` to navigate to the `post` at a given level and wait there for commands from the player. The function adheres to the `mine.post` interface. Navigating the grid of tunnels is done using markers for named `places`. The general idea for navigating is to go directly to the shaft between levels or to a `target` (a named `place`) if is either is `reachable`, that is if the y coordinate and either the x or the z coordinate is within one block of the current turtle `position`. If this is the case, the turtle has arrived. If that's not possible, go instead to an `inner` tunnel if that's `reachable` or to an `outer` tunnel if that's not. Then try again (and again) until the turtle can get to a shaft or the `target`. Prefer tunnels `closer` to the `target`. Here are some utility functions used for navigation: 
```Lua
--]]
--:# **Navigation for grids:  use placed markers to find posts for turtles.**

local function reachable(xyzPlace) -- can the turtle get there from here (where it's currently `at`)
  local x, y, z = table.unpack(move.at()); -- only grid movement in tunnels; only within level 
  local xPlace, yPlace, zPlace = table.unpack(xyzPlace)
  return (math.abs(x - xPlace) <= 1 or math.abs(z - zPlace) <= 1) and math.abs(y - yPlace) <= 1 
end

local function closer(placeName, markerName, xyzTarget) -- placeName is being tried
  local distancePlace = place.distance(place.xyzf(placeName), xyzTarget)
  local distanceMarker = place.distance(place.xyzf(markerName), xyzTarget)
  return distancePlace < distanceMarker -- current marker
end

local mineLabels = {shaft = true, inner = true, outer = true} -- the labels of places for mine navigation 

local function bin(targetBase, xyzTarget, placeName, placeLabel, xyzPlace, names)
  -- bin: set `names.target`, `names.inner`, or `names`.outer` to place being tried
  -- only if it's `reachable` from where the turtle is currently `at` and `closer` than whatever is currently in that `name` 
  if not mineLabels[placeLabel] or not reachable(xyzPlace) then return end -- of all the places, disqualify this
  core.status(5, "grid reachable", placeName, placeLabel, names) -- try this place
  local _, _, placeBase = planner.mark(placeName) -- parse marker; if found target, nice, but `binMarkers` continues
  if targetBase == placeBase or placeLabel == "shaft" then names.target = placeName; return names end
  if closer(placeName, names[placeLabel], xyzTarget) then names[placeLabel] = placeName end -- `inner` or `outer`
  return names -- label: `inner` (main) hall or `outer` (back) hall
end

local function binMarkers(markerName) -- look at all the named `places` to bin those useful in moving to target marker
  local _, _, targetBase = planner.mark(markerName); local xyzTarget = place.xyzf(markerName)
  assert(targetBase and xyzTarget, "grid: binMarkers "..markerName.." failed as target")
  local names = {}; -- names.target will hold name of target marker or shaft marker

  for placeName, placeLabel, xyzPlace in place.near() do -- `bin` all the places for target marker
    bin(targetBase, xyzTarget, placeName, placeLabel, xyzPlace, names)  
  end; return names -- for target, inner, and outer at current level 

end

function grid.post(markerName, borePlans) -- in level, **specified by bore plan**, `mine.post` interface --:= mine.post:: grid.post
  local names = binMarkers(markerName) -- target (shaft or base), inner, and outer marker names
  core.status(4, "grid", "binned markers for", markerName, names) 
  if names.target then moves.to(names.target, "y"); return names -- **at specified post (base) or at shaft within this level**
  elseif names.inner then moves.to(names.inner, "y"); return grid.post(markerName, borePlans) -- move and try for shaft|base
  elseif names.outer then moves.to(names.outer, "y"); return grid.post(markerName, borePlans) -- move and try for inner
  else error("mine.post: Can't navigate to "..markerName.." for "..borePlans.bores.name..
      " at "..move.ats().." with "..core.string(names).." markers")
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
--:> grid.guide: _Instructions for cut_ -> `[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`
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
  --:: grid.ores(plan: crossplan, :direction:, guide: grid.guide, :ores:) -> _Extract ores._ -> `"done" &!`
  --:+ _Given the guide for a vein, mine ores in each of the guide's cuts for that vein._
  --:> crossplan: _Bore and mine, minimal movement_ -> `{:bores:, ores: {name: ":", fixtures: ":"[], path: ":"[], work: plan.work} }`
  for _, cut in ipairs(guide) do mineCut(plan, direction, cut, ores) end 
  return "done"
end

return {grid = grid}
