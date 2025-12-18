--[[
## Bore and Ore Cross Plan for Odd and Even Mine Levels
```md
--:~ crossplan <- **Horizontal Tunnels 6 Blocks Apart for One (Odd or Even) Level** -> muse/docs/plans/cross.md  
--:+ _Markers include shaft plan and bore plan file names in order to provide defaults for mine operations._ 
```
<a id="definitions"></a> 
This `cross` plan file to mine ores works for a particular tunnel geometry as shown in the <a href="../../drawings/06CrossSection.pdf" target="_blank"> cross-section drawing </a>. Looking at the drawing, tunnel geometry is offset for odd and even levels. The `odd` and `even` `bores` plans here deal with the offset. As you'll see, there's a lot of detail here that is best expressed by the declarative _what_ rather than the procedural _how_. Or have we said that?

A grid of tunnels is bored first to mine ores. The tunnels running east and west are where the mining is done. The three tunnels running north and south provide ways to get to to those tunnels. The `inner` bore connects with the `shaft`. The `outer ones are on the east and west edges of the dug level. Digging the bores near the shaft messes up ladders. The `fix` bore deals with that and puts a barrel near the shaft to store ore.

As advertised, rather than go beyond the limits of what is reasonably expressed declaratively, we just use Lua. In this case, we use the functions in `lib/grid` to complement the declarative plan in order to dig bores, mine ores, and navigate grids. The `grid.post` function uses placed markers for turtles to get to their `post` by moving around the grid at a level and using the shaft to get between levels. Navigation makes use of specifically formatted marker names and labels to do this. The `lib/grid` functions are summarized <a href="../../docs/lib/grid.html" target="_blank"> here</a>. Look at the <a href="../../code/lib/grid.html" target="_blank"> implementation</a> to see how they work with the (declarative) plan.

The function produced by loading this file returns tables as defined below:
```Lua
--]]
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local mines = require("mine"); local mine = mines.mine ---@module "signs.mine"
local grids = require("grid"); local grid = grids.grid ---@module "signs.grid"
--[[
```
<a id="bores"></a> 
The `eastIn`, `eastOut`, `westIn`, and `westOut` bores are where we'll dig tunnels. The `outer`, `mid`, and `inner` digs are just part of those bores where we'll put stone or dirt and torches. Dirt rather than stone is placed under torches in the `inner` bores as a clue for visual navigation by a player. Torches are placed at mid points of ore mining tunnels so there's sufficient light to prevent mob spawning. Using Lua to build the constants needed to describe the geometry means we can keep the declarative "language" simple.
```Lua
--]]

-- TODO: rotate plan 90 degrees and/or extend plan from three bores to five (provide alternate to `lib/grid`)

local outer, mid, inner = " d1 2d u1 1d ", " d1 2d u1 1d ", " d1 3d u1 1d " -- bores: fill on cross bottom, torch on fill

local eastIn, eastOut = outer.." e12 "..mid.." e12 "..inner, " e12 "..mid.. " e12 "..outer -- 48 long bores with torches
local westIn, westOut = outer.." w12 "..mid.." w12 "..inner, " w12 "..mid.. " w12 "..outer -- at outer, middle, inner

--[[
```
<a id="guide"></a> 
When exposed ore is found, there is a particular `guide` pattern for adjacent ore in each of the cuts. The pattern depends on which exposed vein is to be explored. It is done using the <a href="../../code/lib/grid.html#ores" target="_blank"> `grid.ores` function in just such a way as to find ore in the 12 numbered sets of 2 x 2 blocks shown in the drawing. In a way, using tables to drive functions is another way of (declaratively) keeping intent clear.
```Lua
--]]
local guides = { 
  top = { -- `theVein`: look in direction for ore; `digVein`: first pass digs; `more`: direction for more; `digMore`: get more ore
    {"up", {"north", "south"}, "up", {"north", "south"}, }, -- numbered sets 1 and 2
    {"north", {"north"}, "up", {"north"}, }, -- numbered set 3
    {"south", {"south"}, "up", {"south"}, }, -- numbered set 4
  },
  north = { {"north", {"up", "down"}, "north", {"up", "down"}, } },  -- numbered sets 5 and 6 
  south = { {"south", {"up", "down"}, "south", {"up", "down"}, } },  -- numbered sets 7 and 8  
  bottom = {
    {"north", {"north"}, "down", {"north"}, }, -- numbered set 9
    {"south", {"south"}, "down", {"south"}, }, -- numbered set 10
    {"down", {"north", "south"}, "down", {"north", "south"}, }, -- numbered sets 11 and 12
  }
}
--[[
```
<a id="constants"></a> 
The `stone` and `dirt` constants specify how mining ore is done in the bottom cut. The path for that cut provides replacement of torches (and the fill on which they are put) after digging out ore.

The ore mining (`grid.ore`) and navigation (`mine.mark` and `grid.post`) functions are the procedural helpers of the declarations in a `cross` plan.
```Lua
--]]
local stone, dirt, targets = " 2d w1 1e w11 ", " 3d w1 1e w11 ", turtle.category("ore") -- any ore will do
local fixtures = {"minecraft:torch", "stone", "dirt", "minecraft:ladder", "minecraft:barrel"} -- dirt for `inner`

local diggings = {  up = {}, down = {}, north = {"up", "down", "north" }, south = {"up", "down", "south" },
  east = {"up", "down", "south", "north", "east" }, west = {"up", "down", "south", "north", "west" },
} --:+ _Dig all directions in a cross if movement is horizontal, otherwise just dig vertically._
local function dig(_, orientation) return turtle.digAround(orientation, "cross", diggings) end -- work: `plan, direction: ":"`

return {
  bores = {name = "cross", post = grid.post,  -- navigation using markers for `grid` tunnel plans

    -- put fixtures near shaft again: 
    fix = {name = "bore fix", fixtures = fixtures, path = {" e1 n1 3n s1 4n u1 4n d2 4n w2 4n e2 5s u1 w1 1d "}},

    even = {name = "bore even", mark = mine.mark, work = dig, fixtures = fixtures, -- 48 x 48 bore from shaft marker
      path = {-- need to move (not bore) to center channel for cross bore
        "n24 e24 s48 w24 n24 s24 w24 n48 ",-- as inner N, outer E, S, NS (shaft and back), outer W to NW corner
        "::NW24|outer"..eastIn.." ::N24|inner"..eastOut.."::NE24|outer", 
        "s06 ::NE18|outer"..westIn.." ::N18|inner"..westOut.."::NW18|outer", -- ox plow 
        "s06 ::NW12|outer"..eastIn.." ::N12|inner"..eastOut.."::NE12|outer",
        "s06 ::NE06|outer"..westIn.." ::N06|inner"..westOut.."::NW06|outer", 
        "s06 ::NW00|outer"..eastIn.." ::N00|inner"..eastOut.."::NE00|outer", 
        "s06 ::SE06|outer"..westIn.." ::S06|inner"..westOut.."::SW06|outer", 
        "s06 ::SW12|outer"..eastIn.." ::S12|inner"..eastOut.."::SE12|outer", 
        "s06 ::SE18|outer"..westIn.." ::S18|inner"..westOut.."::SW18|outer",
        "s06 ::SW24|outer"..eastIn.." ::S24|inner"..eastOut.."::SE24|outer", -- need to move (not bore) to shaft for torches
      }},

    odd = {name = "bore odd", mark = mine.mark, work = dig, fixtures = fixtures, -- 42 x 42 bore from shaft marker
      path = {-- need to move (not bore) to center channel for cross bore
        "n21 e24 s42 w24 n21 s21 w24 n42", -- as inner N, outer E, S, NS (shaft and back), outer W to NW corner
        "::NW21|outer"..eastIn.."::N21|inner"..eastOut.."::NE21|outer", 
        "s06 ::NE15|outer"..westIn.."::N15|inner"..westOut.."::NW15|outer", 
        "s06 ::NW09|outer"..eastIn.."::N09|inner"..eastOut.."::NE09|outer",
        "s06 ::NE03|outer"..westIn.."::N03|inner"..westOut.."::NW03|outer", 
        "s06 ::SW03|outer"..eastIn.."::S03|inner"..eastOut.."::SE03|outer",
        "s06 ::SE09|outer"..westIn.."::S09|inner"..westOut.."::SW09|outer",
        "s06 ::SW15|outer"..eastIn.."::S15|inner"..eastOut.."::SE15|outer",
        "s06 ::SE21|outer"..westIn.."::S21|inner"..westOut.."::SW21|outer", -- need to move (not bore) to shaft for torches
      }},
  },
--[[
```
<a id="ores"></a> 
The `ores` table describes a sequential table of excavations with specific ore `guide` for each cut. They start from the marker in an `inner` bore at a given (east-west) ore mining tunnel.
```Lua
--]]
  ores = { -- assumes turtle moved to and is at marker post
    {name = "ores topEast", fixtures = fixtures, path = {" u1 e24 "},
      work = function(thePlan, direction) grid.ores(thePlan, direction, guides.top, targets) end },
    {name = "ores bottom", fixtures = fixtures, path = {" d2 ", stone..stone..dirt..stone, " 2d u1 1d "}, --replace torches
      work = function(thePlan, direction) grid.ores(thePlan, direction, guides.bottom, targets) end },
    {name = "ores topWest", fixtures = fixtures, path = {" u1 e24 "},
      work = function(thePlan, direction) grid.ores(thePlan, direction, guides.top, targets) end },

    {name = "ores southEast", fixtures = fixtures, path = {" d1 s1 e24 "},
      work = function(thePlan, direction) grid.ores(thePlan, direction, guides.south, targets) end },
    {name = "ores north", fixtures = fixtures, path = {" n2 w22 s1 w4 n1 w22 "},
      work = function(thePlan, direction) grid.ores(thePlan, direction, guides.north, targets) end },
    {name = "ores southWest", fixtures = fixtures, path = {" s2 e24 n1 "},
      work = function(thePlan, direction) grid.ores(thePlan, direction, guides.south, targets) end },
  }
}
