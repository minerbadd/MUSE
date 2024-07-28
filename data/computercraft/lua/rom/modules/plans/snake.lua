--[[
## Plan for Digging and Navigating A Mine Shaft
```md
--:~ snake <- **Plan to Dig Vertical Mine Shaft 3 Wide and 4 Down** -> muse/docs/plans/snake.md
--:+ _Markers include shaft plan and bore plan file names, providing defaults for mine operations._ 
--:+ _One torch, six ladders, and six fill required per level. Fill may be supplied by dig._
```
<a id="introduction"></a>
The introduction to this (mostly declarative) `plan` is like that of libraries in that it includes the usual loading of the libraries it depends on. There are plans for digging the shaft going down and plans going back up to the minehead for placing fixtures and shelves for the player to safely stand. There are plans for simply going lower or higher in the shaft.
```Lua
--]]
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local grids = require("grid"); local grid = grids.grid ---@module "signs.grid"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
--[[
```
<a id="constants"></a> 
There are a number of advantages in defining plan files as Lua files. One of them is shown below. To make the plan easier to understand, some constants are defined that are used (repetitively) to create the plan. One constant defined here is the `funds` function used to dig a shaft. It's quite specific to digging this kind of shaft so it's just included here.
```Lua
--]]
local fixtures = {"minecraft:torch", "fill", "minecraft:ladder"} -- in north cutouts 
local marker = " ::|shaft 2s u1 1n 2s " -- mark, fill south, then up 1 to ladder north and fill south
local ladder = " d1 2s 3n " -- at each block down, fill south and ladder north
local fill = " d1 2n 2s" -- at bottom of ladder run, fill north and south to support player
local down = ladder .. ladder .. ladder .. ladder .. ladder .. ladder .. fill -- 4 for between levels, plus overlap
local up = " 2n 2s u2 " -- fill north and south for support then up to next mark point

local function funds(_, direction) -- up, down, north, and south....and forward direction
  turtle.digAround(direction, "funds", {"up", "down", "north", "south"})
  turtle.digAround(direction, "funds", {direction}); move[direction](0); -- turn to direction of movement 
  return "done" 
end
--[[
```
<a id="snake"></a> 
The actual plan for digging the shaft comes directly from looking at the <a href="../../drawings/06SnakeShaft.pdf" target="_blank"> drawing </a> for a so-called "snake" shaft. As understanding develops of what exact shape is to be dug out and provisioned, the plan is adjusted more easily and reliably than writing detailed code. We'll hold off on the discussion of the `grid.mark` function till when we deal with digging tunnels and mining ore.
```Lua
--]]
return {name = "snake",
  down = { -- at even level marker going down to odd level (or vice versa)
    even = 
    {name = "shaft down even", mark = grid.mark, work = funds, 
      fixtures = fixtures, path = {marker.." w1 "..down.." e1 2w ".. up}}, -- "e1 2w" to fill behind
    odd = 
    {name = "shaft down odd", mark = grid.mark, work = funds, 
      fixtures = fixtures, path = {marker.." e1 "..down.." w1 2e ".. up}},  -- "w1 2e" to fill behind
    last = {name = "shaft down last", mark = grid.mark, path = {"::|shaft"}}, -- mark last level dug
  },

  back = {-- 1 above marker going back from even to odd level (or vice versa)
    even = {name = "shaft back even", fixtures = fixtures, path = {" e1 u4 2u w1 2u "}}, -- fill above in plane
    odd = {name = "shaft back odd", fixtures = fixtures, path = {" w1 u4 2u e1 2u "}}}, -- fill above in plane

  lower = { -- to traverse shaft going down
    even  = {name = "level down even", path = {"w1 d4 e1"}},
    odd = {name = "level down odd", path = {"e1 d4 w1"}}},

  higher = {  -- to traverse shaft going up
    even = {name = "level back even", path = {"e1 u4 w1"}},
    odd = {name = "level back odd", path = {"w1 u4 e1"}}}, 
}

