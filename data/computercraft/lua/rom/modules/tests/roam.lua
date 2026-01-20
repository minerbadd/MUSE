--[[
##Test: `tests/roam` for the turtle movement command library: `go`, `to`, `trace`, `come` `tail` 
```md
--:? muse/docs/tests/roaam.txt <- **Test `lib/roam`** -> muse/docs/tests/roam.md 
```Lua
--]]
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local places = require("places"); local place, moves = places.place, places.moves ---@module "signs.place"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle" -- just for blocking
local roams = require("roam"); local roam = roams.roam ---@module "signs.roam"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

local test = check.open(testName, text, regression) --:# Create the test object for this test

turtle.blocking(false); place.site("TR")

--:# Setup place and trail names for tests
place.fix({10,25,35,"west"}); place.name("test2", "label2")
place.fix({10,20,30,"east", true}); place.name("test1", "label1"); moves.to("test2") -- situations from from test1 to test2
place.trail("head1", "tail2", "trail12") -- head1: from test1 to test2; tail2: from test2 back to test1

--:# Test commands: `go`, `to`, `trace`, `come`
test.part("go and return", roam.op, {"go", "e", "4", "w", "4", "d", "u"})
test.part("to test1", roam.op, {"to", "test1"}) -- to 10,20,30,"east"
test.part("to {20,30,40,'east'}", roam.op, {"to", "20", "30", "40", "east"})
test.part("trace head1", roam.op, {"trace", "head1"}) -- to 10, 20, 30
test.message("From "..core.string(place.xyzf()).." to near "..core.string{15,25,35})
test.part("come {15,25,35}", roam.come, {15,25,35})

--:# Test "empty" (too far for fuel)
local fuel, at = turtle.fuel(), move.at(); local atx, aty, atz = table.unpack(at)
test.part("to too far", roam.op, {"to", atx + fuel + 1, aty, atz})

--:# Test successful and failing permutation retry
roam.op({"to", "test1"}); turtle.blocking(3)
test.part("retry ok", roam.op, {"to", "test2"})
turtle.blocking(7)
test.part("retry fails", roam.op, {"to", "test1"})

--:# Close test object, report completion if we got here without errors
test.close("Test "..testName.." complete") 
