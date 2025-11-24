-- **Tests for `move` and step` interfaces of lib/motion**

dofile(arg[0]:match('.*[/\\]').."/preface.lua") -- set test environment using `preface` in execution path

local core = require("core").core 
local motion = require("motion") 
local move, step = motion.move, motion.step

core.log.level(5) -- just a default, set lower to report less, higher to report more

local function prints(n, op, code, remaining, xyzf)
  print(n, xyzf, code, remaining, "...", op)
end

print("beginning movesTest.lua at "..move.ats())

prints(1, "east", move.east())
prints(2, "forward 10", move.forward(10))
prints(3, "back 10", move.back(10))
prints(4, "right 10", move.right(10))
prints(5, "left 10", move.left(10))
prints(6, "east 10", move.east(10))
prints(7, "north 10", move.north(10))
prints(8, "south 10", move.south(10))
prints(9, "west 10", move.west(10))
prints(10, "back", move.back())
prints(11, "east", move.east())
prints(12, "north 0", move.north(0))
prints(13, "south 0", move.south(0))
prints(14, "up 10", move.up(10))
prints(15, "down 10", move.down(10))

prints(17, "to 100 150 200 west", move.to({100, 150, 200,"west"}))

print("BEGINNING STEPS TEST")

for code, remaining, ats in step.east(3) do 
  print(18, "step.east(3)", code, remaining, ats)
end

for code, remaining, ats in step.south(3) do 
  print(18, "step.south(3)", code, remaining, ats)
end

for code, remaining, ats in step.west(3) do 
  print(18, "step.west(3)", code, remaining, ats)
end

for code, remaining, ats in step.north(3) do 
  print(18, "step.north(3)", code, remaining, ats)
end

local more = step.forward(3)

print(19, "steps 1 forward 3", more(), move.ats())
print(20, "steps 2 forward 3", more(), move.ats())
print(21, "steps 3 forward 3", more(), move.ats())
print(22, "steps 4 forward 3", more(), move.ats()) 

print(23, "step to 105 156 207 west")
for code, remaining, at, direction, all in step.to({105, 156, 207}) do
  --print(23, code, remaining, core.string(at), direction, all)
end  
print(23, "stepped to", core.ats())

print("Test Complete")
