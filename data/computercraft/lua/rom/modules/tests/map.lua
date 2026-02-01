--[[
##Test: `tests/map` for `place` Persistence and Command
```md
--:? muse/docs/tests/map.txt <- **Test `lib/map`** -> muse/docs/tests/map.md 
--:# Test 
```Lua
--]]
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local places = require("places"); local place = places.place ---@module "signs.place"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle" -- just for blocking
local maps = require("map"); local map = maps.map ---@module "signs.map"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `false`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

turtle.blocking(false); place.site("TM")

local test = check.open(testName, text, regression) --:# Create the test object for this test

local path = _G.Muse.path.."tests/"
map.map(path.."maps/TM.map"); map.charts(path.."charts/")
core.log.level(3); core.setComputerLabel("tester")

test.part("test setup", map.op, {"test", "test0", "label0", "199", "66", "262", "east"})
test .part("", move.where, 10, 20, 30, "east")
-- face (dx, dz, ew, we, ns, sn) -- face(dx, dz, "east", "west", "south", "north") -> 
test.part("facing north", map.testFacing, 0, -10, {"east", "west", "south", "north"})

test.part("fix 10, 20, 30, east", place.fix, {10, 20, 30,"east"})
test.part("point test1", map.op {"point", "test1", "label1"})
test.part("fix 10, 20 40, east", place.fix, {10, 20, 40,"east"})
test.part("point test2", map.op, {"point","test2", "label2"})
test.part("test rome", map.op, {"test", "rome", "home", "15", "25", "35", "east"})
test.part("test test3", map.op {"test", "test3", "label3", "10", "20", "30", "east"})

test.part("near", map.op, {"near"})
test.part("near 10", map.op, {"near", "10"}) -- span as placeName
test.part("near test1", map.op, {"near", "test1"})
test.part("near test1 10", map.op, {"near", "test1", "10"})

test.part("where nil, nil, 10, 20, 20", map.op, {"where", nil, nil, 10, 20, 20})
test.part("where 2, nil, 10, 20, 20", map.op, {"where", 2, nil, 10, 20, 20})
test.part("where nil, nil, 15, 20, 25", map.op, {"where", nil, nil, 15, 20, 25})
test.part("where test1, nil, 15, 20, 25", map.op, {"where","test1", nil, 15, 20, 25})
test.part("where test1, 2, 15, 20, 25", map.op, {"where", "test1", "2", "15", "20", "25"})
test.part("where nil, nil, 10, 20, 30", map.op, {"where", nil, nil, "10", "20", "20"})
test.part("where, 2, nil, 10, 20, 20", map.op, {"where", 2, nil, 10, 20, 20})
test.part("where, nil, nil, 15, 20, 25", map.op, {"where", nil, nil, 15, 20, 25})
test.part("where,test1, nil, 15, 20, 25", map.op, {"where","test1", nil, 15, 20, 25})
test.part("where, test1, 2, 15, 20, 25", map.op, {"where", "test1", "2", "15", "20", "25"})

test.part("range", map.op, {"range", "tests", "range", "test1", "test2", "fields", "trees"})
test.part("view", map.op, {"view", "tests"}); 

move.set(100, 150, 200, "west"); move.to({100, 150, 200,"west"}); 
test.part("point trail20", map.op, {"point", "trail20", "test20", "head20"})
move.set(100, 150, 200, "west"); move.to({100, 160, 210, "west"})
move.to({110, 170, 220, "east"}); move.to({120, 170, 220, "north"})
test.part("trail2021", map.op, {"trail", "tail21", "trail2021"})

test.part("view trail20", map.op, {"view", "trail20"}) -- name, label, features, situations
test.part("view head20", map.op, {"view", "head20"}) 
test.part("view tail21", map.op, {"view", "tail21"})

-- map.borders({range}) -> _Get range_ -> `{:borders}, {:features}, {:xyzFirst}, {:xyzSecond}`
test.part("borders", map.borders, "trail20") 

-- map.put(name: ":", key: ":", [::value]) -> _Set feature, cast as Muse Update if named place._ ->  `false | (key: ":", ::value) & !`
test.part("map.put trueKey", map.put, "trail20", "trueKey")
test.part("map.put textKey", map.put, "trail20", "textKey", "theText")
test.part("map.put tableKey", map.put, "trail20", "tableKey", {1, 2, 3})

-- map.get(name: ":", key: ":") -> _Get feature value for key if named place._ -> `::value | false`
test.part("map.get trueKey", map.get, "trail20", "trueKey")
test.part("map.get textKey", map.get, "trail20", "textKey") 
test.part("map.get tableKey", map.get, "trail20", "tableKey")

test.part("map.get trail20", map.get, "trail20", "unknown")
test.part("view trail20", map.op, {"view", "trail20"})
  
-- erase name -> _Remove named place and broadcast Muse eXcise (MX) to units._ 
test.part("erase trail20", map.op, {"erase", "trail20"})
test.part("view trail20", map.op, {"view", "trail20"})

test.part("store", map.op, {"store", "happyplace"})

test.part("chart", map.op, {"chart", "TX", "fancy echo", {charted = "table"}, "something else"})

--:# Close test object, report completion if we got here without errors
test.close("Test "..testName.." complete") 
