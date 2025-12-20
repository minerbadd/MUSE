--[[
## The Plan "Language" : lib/planner for lib/worker
```md
--:! [planner: [":"]: (:)] <- **Functions Library to Build a Plan** -> muse/docs/lib/planner.md
--:| planner: _Given a_ `plan`, _create a table of operations to be performed by_ `worker.execute`. -> planner, plan, moves, steps
```
The `lib/planner` introduction outlines the parts of a `plan` represented by a Lua file.

A MUSE `plan` includes at least one `path` which may have `step` elements (specifying movement), `put` elements (specifying `fixture` placement), and `mark` elements (specifying `point` creation). Each element is separated by spaces. It may also include a `work function` to be applied at each step of the turtle's movement along the path. A `step` element consists of a letter specifying one of the six movement directions followed by an optional number indicating how many blocks to move in that direction. A `put` element consists of a digit followed by a letter specifying one of the six movement directions. The digit selects which of the plan `fixtures` is to be used for the element's placement. A `mark` element begins with a colon. The element is used by the `mark` function of the `plan` to create a point used for turtle navigation.
```Lua
--]]
local planner = {} ---@module "signs.planner" -- for functions exported from library

local motion = require("motion"); local step = motion.step ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"

--:> plan: _How to do work_ -> `{name: plan.name, path: plan.path, work: plan.work, fixtures: plan.fixtures, mark: plan.mark}`
--:> plan.name: _for status and error reporting_  -> `":"`
--:> plan.path: _table of space separated character sequence strings describing path_ -> `":"[]`
--:> plan.work: _for execution at every_ `step` _iteration in plan movement direction_ -> `(:plan:, direction: ":"): ":"?`
--:> plan.fixtures: _for placement as specified by path elements beginning with a digit_ -> `":"[]`
--:> plan.mark: _for execution as specified by_ `plan.path` _markers_ -> `(:plan:, :marking:): markerName: ":", label: ":", report: ":"`

--:> marking: _literals table of marker parts_ -> `:[prefix: ":", base: ":", label: ":"]`
--:> markings: _dictionary of markings keyed by a label_ -> `[label: ":"]: marking`

--:# **Plan elements beginning with a letter indicate stepped movement in one of six directions: u, d, n, e, s, or w.**
--:+ _Optionally, the letter may be followed by a number of blocks for the movement. The element ends with a space._
--:+ _Elements beginning with a digit (indexing plan's fixtures table) are followed by a letter specifying direction._
--:+ _Plan elements beginning with a colon indicate placement of a `mark`, a named and labelled `place`._
--:+ The `plan.mark` function might replace each colon in a marker string prefix with, for example, a shaft name and level. 
--:+ _Characters between the last colon and a_ "|" _vertical bar character are the `base` argument for `plan.mark`._
--:+ _Characters following the_ "|" _are the marker label for `plan.mark._
--[[
```
<a id="load"></a> 
Plans are just Lua files. When loaded they produce a function whose application produces a table. The `planner.make` function uses that table to make a `pathElements` table used by `lib/worker` to execute the plan. Each `pathElements` entry will step the turtle, put a fixture in place, or mark the turtle's current situation as named place.
```Lua
--]]
function planner.load(planFileName) 
  --:: planner.load(planFileName: ":") -> _Instantiates what is returned from a plan file._ -> `plan &!` 
  local thePlan = _G.Muse.path.."plans/"..planFileName..".lua"; 
  local operations = assert(loadfile(thePlan), "planner.load: "..thePlan.." failed") --TODO: cache?
  return operations() 
end

local steps = {u = step.up, d = step.down, n = step.north, e = step.east, w = step.west, s = step.south}
local directions = {u = "up", d = "down", n = "north", e = "east", w = "west", s = "south", }

function planner.make(plan) 
--:: planner.make(plan:plan) -> _Create path operations table for plan._ -> `pathElements, fuelOK: ^:, pathDistance: #:`
--:> pathElements: _Used by `worker.execute` to run plan_ -> `(stepElement|putElement|markElement)[]`
--:> stepElement: _Iterate steps function in direction for distance_ -> `:[op: "step", :stepping:, direction: ":", distance: #:]`
--:> putElement: _Put fixture in specified direction_ -> `:[op: "put", direction: ":", fixture: ":"]`
--:> markElement: _Current situation in named places_ -> `[op: "mark", :marking:]`

  local pathElements, pathDistance = {}, 0 -- initial state
  for _, stringPart in ipairs(plan.path) do -- deal with all path strings together
    for part in string.gmatch(stringPart,"%S+") do -- for each of space separated tokens
      local first = string.sub(part, 1, 1); local rest = string.sub(part, 2)

      if string.match(first, "%a") then -- direction then number: step movement
        local distance = tonumber(rest); pathDistance = pathDistance + distance
        pathElements[#pathElements + 1] = {"step", steps[first], directions[first], distance} 

      elseif string.match(first, "%d") then -- number then direction: put fixtures
        if not plan.fixtures then error("planner.make: No fixtures in "..plan.name) end
        pathElements[#pathElements +1] = {"put", directions[rest], plan.fixtures[tonumber(first)]}

      else  -- it's a mark operation; `plan.mark` is a function to name places given a prefix, base, and label;
        if not plan.mark then error("planner.make: Unknown operation specified for "..plan.name) end
        local prefix = string.sub(string.match(part, ("%W+")), 1, -1)
        local basePart = string.match(part, "%w+|") or ""; local base = string.sub(basePart, 1, -2) 
        local label = string.sub(string.match(part, "|%w+"), 2) -- label
        local marking = table.pack(prefix, base, label) 
        pathElements[#pathElements + 1] = {"mark", marking}-- a marking
      end
    end
  end return pathElements, turtle.fuel() > pathDistance, pathDistance
end

--:# **Marker parsing utility function**
function planner.mark(markerName) 
--:: planner.mark(markerName: ":") -> _Parse marker name into parts._ -> `shaft: ":"?, level: ":"?, tag: ":"?)`
  if not markerName then return nil end
  local _, _, _, shaft, level, tag = string.find(markerName, "(%w-)%.?(%w*):?(%w*):?(%w*)$")
  return shaft, level, tag
end

return {planner = planner}
