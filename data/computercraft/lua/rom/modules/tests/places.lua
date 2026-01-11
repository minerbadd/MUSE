--[[
##Test: `tests/places` for `place`, `moves` and `steps` interfaces of `lib/places`


```Lua
--]]
--:? muse/docs/tests/places.txt <- **Test `lib/places`** -> muse/docs/tests/places.md 
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local turtles = require("mock"); local turtle = turtles.turtle ---@module "signs.mock"
local places = require("places"); local steps, moves, place = places.steps, places.moves, places.place ---@module "signs.places"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

local test = check.open(testName, text, regression) --:# Create the test object for this test

turtle.blocking(false) -- `lib/motion` loaded `lib/mock`

--:# Name and rename some places and verify their coordinates
test.part("Set test site", place.site, "TP")

test.part("1st place.fix", place.fix, {10, 20, 30, "east"})
test.part("1st place.name", place.name, "test1", "label1")
test.part("2nd place.fix", place.fix, {20, 30, 40, "west"})
test.part("2nd place.name", place.name, "test2", "label2")
test.part("1st place.xyzf", place.xyzf, "test1")
test.part("2nd place.xyzf", place.xyzf, "test2")

--:# Match a place and find distance between places
test.part("1st place.match", place.match, "test1") 
test.part("place.distance", place.distance, place.xyzf("test1"), place.xyzf("test2"))

--:# Iterate over places near specified coordinate
for name, label, xyz, index, situations in place.near(20, {10, 20, 30}) do 
   test.part("place.near", check.echo, name, label, xyz, index, #situations) 
end
--:# Apply place.near to get distance sorted table of all named places
test.part("place.nearby", place.nearby, {20,35,40})
--:# Then erase one place and get one fewer
test.part("place.erase", place.erase, "test1")
test.part("less nearby", place.nearby, {20,35,40})

--:# Move between two places
test.part("new 2nd fix", place.fix, {10, 15, 25, "west"})
test.part("replace 2nd", place.name, "test2", "label2")
test.part("moves.to", moves.to, "test2", "y") -- test2: 10, max(15, 50), 25, "west" 

--:# Setup to create a trail
test.part("new 1st fix", place.fix, {10, 20, 30,"east"})
test.part("replace 1st", place.name, "test1", "label1")
test.part("start trail", place.fix, {10, 25, 35, "west"}, true) -- track == true
test.part("at test2", place.name, "test2", "label2") 
for name, label, xyz, order, situations in place.near() do -- check places
  test.part("check places", check.echo, name, label, xyz, order, #situations) 
end
test.part("to test1", moves.to, "test1") -- from test2
test.part("make trail", place.trail, "head2", "tail1", "trail21")

--:# Check that trail is created and move along it
for name, label, xyz, order, situations in place.near() do -- check places with trails
  test.part("trail places", check.echo, name, label, xyz, order, #situations) 
end
--:# test2	{10, 25, 35, }	test1	{10, 20, 30, }	head2	{10, 25, 35, }	tail1	{10, 20, 30, }
test.part("moves.along", moves.along, "tail1")

--:# Then step along it forward and reverse
for code, remaining, at, direction, all in steps.to("test1") do -- {10, 25, 35, } to {10, 20, 30, }
  test.part("step to", check.echo, code, remaining, at, direction, all)
end
for code, remaining, at, direction, all, index in steps.along("tail1") do -- reverse to {10, 25, 35, }
  test.part("step along", check.echo, code, remaining, at, direction, all, index)
end

--:# Get situation and provide a feature
test.part("add feature", place.name, "test1", "label1", move.situation(), {"feature", "value"})

--:# Close test object, report completion if we got here without errors
test.close("Test "..testName.." complete") 
