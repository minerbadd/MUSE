--[[
**Tests for `move` and step` interfaces of lib/motion**
```Lua
--]]
--:? muse/docs/tests/motion.txt <- **Run Regression Test for Muse** -> muse/docs/tests/motion.md  

dofile(arg[0]:match('.*[/\\]').."/_preface.lua") -- set test environment 
local testName = arg[0]:match('%w*%.%w*$') -- the last words in the execution path

local core = require("core").core 
local motion = require("motion") 
local move, step = motion.move, motion.step
local check = require("check").check

core.log.level(5) -- just a default, set lower to report less, higher to report more

local testMotion = check.open(_G.Muse.checks, _G.Muse.testSetName, testName) 
local function checking(partID, result) testMotion.part(testName, partID, result) end

print("beginning "..testName.." at "..move.ats())
checking(1, "east", move.east())
checking(2, "forward 10", move.forward(10))
checking(3, "back 10", move.back(10))
checking(4, "right 10", move.right(10))
checking(5, "left 10", move.left(10))
checking(6, "east 10", move.east(10))
checking(7, "north 10", move.north(10))
checking(8, "south 10", move.south(10))
checking(9, "west 10", move.west(10))
checking(10, "back", move.back())
checking(11, "east", move.east())
checking(12, "north 0", move.north(0))
checking(13, "south 0", move.south(0))
checking(14, "up 10", move.up(10))
checking(15, "down 10", move.down(10))

checking(17, "to 100 150 200 west", move.to({100, 150, 200,"west"}))

print("BEGINNING STEPS TEST")

local east = 18; for code, remaining, ats in step.east(3) do east = east + 0.1
  checking(east, "step.east(3)", code, remaining, ats)
end

local south = 19; for code, remaining, ats in step.south(3) do south = south + 0.1
  checking(south, "step.south(3)", code, remaining, ats)
end

local west = 20; for code, remaining, ats in step.west(3) do west = west + 0.1
  checking(20, "step.west(3)", code, remaining, ats)
end

local north = 21; for code, remaining, ats in step.north(3) do north = north + 0.1
  checking(north, "step.north(3)", code, remaining, ats)
end

local more = step.forward(3)

checking(22, "steps 1 forward 3", more(), move.ats())
checking(23, "steps 2 forward 3", more(), move.ats())
checking(24, "steps 3 forward 3", more(), move.ats())
checking(25, "steps 4 forward 3", more(), move.ats()) 

checking(26, "step to 105 156 207 west")

local stepping = 26
for code, remaining, at, direction, all in step.to({105, 156, 207}) do stepping = stepping + 0.001
  print (stepping, code, remaining, core.string(at), direction, all)
end  
checking(28, "stepped to", core.ats())

testMotion.close("Test "..testName.." complete") 
