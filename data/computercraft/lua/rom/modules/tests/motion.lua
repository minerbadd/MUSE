--[[
##Test: `tests/motion` for `move` and `step` interfaces of `lib/motion`
```md
--:? muse/docs/tests/motion.txt <- **Test `lib/motion`** -> muse/docs/tests/motion.md 

So here we are, exploring our first MUSE test. It is meant to fit into the MUSE regression jig implemented by `lib/check`. It's neither a library nor a ComputerCraft program. It is an executable though. Just execute it as you would any Lua program. 

The HELP file mark above specifies that there will be a help text file and a summary markdown document. The markdown document will be processed to produce an html file describing the test using the HEAD comments in the test.

```Lua
--]]
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move, step = motion.move, motion.step ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle" -- just for blocking

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()
local test = check.open(testName, text, regression) --:# Create the test object for this test

turtle.blocking(false) 

--:# **Test simple `move` motions**
test.part("east", move.east)
test.part("forward 10", move.forward, 10)
test.part("back 10", move.back, 10)
test.part("right 10", move.right, 10)
test.part("left 10", move.left, 10)
test.part("east 10", move.east, 10)
test.part("north 10", move.north, 10)
test.part("south 10", move.south, 10)
test.part("west 10", move.west, 10)
test.part("back", move.back)
test.part("east", move.east)
test.part("north 0", move.north, 0)
test.part("south 0", move.south, 0)
test.part("up 10", move.up, 10)
test.part("down 10", move.down, 10)

--:# Test blocked move
turtle.blocking(true) -- blocked in lib/motion xyzMotion
test.part("forward 10 blocked", move.forward, 10)
turtle.blocking(false)

--:# **Test compound operations**
test.part("to 100 150 200 west", move.to, {100, 150, 200, "west"})

--:# **Test simple `step` operations**
for code, remaining, ats in step.east(3) do 
  test.part("step.east(3)", check.echo, code, remaining, ats)
end

for code, remaining, ats in step.south(3) do
  test.part("step.south(3)", check.echo, code, remaining, ats)
end

for code, remaining, ats in step.west(3) do
  test.part("step.west(3)", check.echo, code, remaining, ats)
end

for code, remaining, ats in step.north(3) do 
  test.part("step.north(3)", check.echo, code, remaining, ats)
end

--:# Test `step` iterator exhaustion
local more = step.forward(3)
test.part("steps 1 forward 3", more, move.ats())
test.part("steps 2 forward 3", more, move.ats())
test.part("steps 3 forward 3", more, move.ats())
test.part("steps 4 forward 3", more, move.ats()) 

--:# Check "step.to 105 156 207 west")
for code, remaining, at, direction, all in step.to({105, 156, 207}) do 
  test.part(move.ats(), check.echo, code, remaining, core.string(at), direction, all)
end; 

test.part("stepped to", check.echo, core.ats())

local function blockedStep(target) -- so `step.to` is protected in `test.part` `pcall`
  for code, remaining, at, direction, all in step.to(target) do 
    test.part(move.ats(), check.echo, code, remaining, at, direction, all)
  end 
end

--:# Check blocked step operations
turtle.blocking(true) -- blocked in lib/motion xyzMotion
test.part("blocked step", blockedStep, {106, 157, 208})
turtle.blocking(false) -- unblocked in lib/motion xyzMotion

--:# Test tracking
test.part("start tracking", move.tracking, true)
move.forward(5); move.up(5); move.back(5); move.down(5)
test.part("situations", move.situations)
test.part("end tracking", move.tracking, false)

--:# Close test object, report completion if we got here without errors
test.close("Test "..testName.." complete") 
