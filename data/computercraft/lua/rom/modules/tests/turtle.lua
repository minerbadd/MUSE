--[[
##Test: `tests/turtle` for extensions to ComputerCraft turtle operations
--:? muse/docs/tests/places.txt <- **Test `lib/places`** -> muse/docs/tests/places.md 
```Lua
--]]
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local mocks = require("mock"); local mock = mocks.turtle ---@module "signs.mock"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

local test = check.open(testName, text, regression) --:# Create the test object for this test

--:# turtle.inspects east and up (two arms of makeDirections)
test.part("inspects east", turtle.inspects.east)
test.part("inspects up", turtle.inspects.up)

--:# turtle.inventory -- returns currrent turtle inventory as table
test.part("inventory", turtle.inventory)

--:# turtle.check(targets, itemDetail) -- item inspected by turtle is in targets?
local ores = {"minecraft:coal_ore", "minecraft:iron_ore", "minecraft:gold_ore",}
test.part("check ores", turtle.check, ores, {name = "minecraft:coal_ore"})
do local result = turtle.check(ores, {name = "minecraft:coal_ore"}); print(2, result) end

--:# turtle.category check: test, dirt, nomatch, fill
test.part("category test", turtle.category, "test")
test.part("category dirt", turtle.category, "dirt")
test.part("category nomatch", turtle.category, "nomatch")
test.part("category fill", turtle.category, "fill")

--:# turtle.fuel -- energy available in turtle slots
test.part("turtle.fuel", turtle.fuel)

--:# turtle.unblock(direction, limit) --waits, retrys for gravel; attacks
test.part("turtle.unblock normal", turtle.unblock, "east", 5)
mock.blocking(true) -- the mock turtle supports blocking for testing
test.part("turtle.unblock fail", turtle.unblock, "down")
mock.blocking(false)

--:# digTo unblocks and fails
move.to({10, 20, 30})
move.to({10, 20, 35}) -- setup moving forward on z- coordinate
mock.blocking(2) -- should unblock
test.part("dig to unblocked ok", turtle.digTo, {10, 20, 40})
mock.blocking(6)
test.part("dig to unblocked fail", turtle.digTo, {10, 20, 40})
mock.blocking(false)

--:# digAround ok and fails
test.part("digAround ok", turtle.digAround, "east", {"north", "west", "south"})
mock.blocking(true)
test.part("digAround fails", turtle.digAround, "north", {"up", "down", "east"})
mock.blocking(true)

--:# Close test object, report completion if we got here without errors
test.close("Test "..testName.." complete") 
