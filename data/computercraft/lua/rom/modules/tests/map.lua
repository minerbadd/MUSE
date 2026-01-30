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
local tasks = require("task"); local task = tasks.task ---@module "signs.roam"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

turtle.blocking(false); place.site("TM")

local test = check.open(testName, text, regression) --:# Create the test object for this test

local core, move, place = require("core").core, require("motion").move, require("places").place
local map, turtle = require("map").map, require("turtle").turtle

local path = _G.Muse.path.."tests/"
map.map(path.."maps/TM.map"); map.charts(path.."charts/")
core.log.level(3); core.setComputerLabel("tester")

test.part("test setup", map.op, {"test", "test0", "label0", "199", "66", "262", "east"})
test .part("", move.where, 10, 20, 30, "east")
-- face (dx, dz, ew, we, ns, sn) -- face(dx, dz, "east", "west", "south", "north") -> 
test.part("facing north", map.testFacing, 0, -10, {"east", "west", "south", "north"})

test.part("fix 10, 20, 30, east", place.fix, 10, 20, 30,"east"})
test.part("point test1", map.op {"point", "test1", "label1"})
test.part("fix 10, 20 40, east", place.fix, {10, 20, 40,"east"})
test.part("point test2", map.op, {"point","test2", "label2"})
test.part("test rome", map.op, {"test", "rome", "home", "15", "25", "35", "east"})
test.part("test test3", map.op {"test", "test3", "label3", "10", "20", "30", "east"})

test.part("near", map.op, {"near"})

test.part("near 10", map.op, {"near", "10"})) -- span as placeName
test.part("near test1", map.op, {"near", "test1"}))
test.part("near test1 10", map.op, {"near", "test1", "10"}))

test(3, core.string(map.op {"where", nil, 10, 20, 20}))
test(3.1, core.string(map.op {"where", nil, 2, 10, 20, 20}))
test(3.2, core.string(map.op {"where", nil, nil, 15, 20, 25}))
test(3.3, core.string(map.op {"where","test1", nil, 15, 20, 25}))
test(3.4, core.string(map.op {"where", "test1", "2", "15", "20", "25"}))
test(3, core.string(map.op {"where", "10", "20", "20"}))
test(3.1, core.string(map.op {"where", 2, 10, 20, 20}))
test(3.2, core.string(map.op {"where", nil, nil, 15, 20, 25}))
test(3.3, core.string(map.op {"where","test1", nil, 15, 20, 25}))
test(3.4, core.string(map.op {"where", "test1", "2", "15", "20", "25"}))

test(4, core.string(map.op {"range", "tests", "range", "test1", "test2", "fields", "trees"}))
test(5, map.op {"view", "tests"}); 

move.set(100, 150, 200, "west"); move.to({100, 150, 200,"west"}); 
test(6, core.string(map.op {"point", "trail20", "test20", "head20"}))
move.set(100, 150, 200,"west"); move.to({100, 160, 210,"west"}); move.to({110, 170, 220,"east"}); move.to({120, 170, 220,"north"})
test(6.1, core.string(map.op {"trail", "tail21", "trail2021"}))
test(6.2, map.op {"view", "trail20"}); -- name, label, features, situations
test(6.3, map.op {"view", "head20"}); 
test(6.4, map.op {"view", "tail21"})

test(7, map.borders("trail20")) -- map.borders({range}) -> _Get range_ -> `{:borders}, {:features}, {:xyzFirst}, {:xyzSecond}`

-- map.put(name: ":", key: ":", [::value]) -> _Set feature, cast as Muse Update if named place._ ->  `false | (key: ":", ::value) & !`
test(8, map.put("trail20", "trueKey")); 
test(8.1, map.put("trail20", "textKey", "theText"))
test(8.2, map.put("trail20", "tableKey", {1, 2, 3}))

-- map.get(name: ":", key: ":") -> _Get feature value for key if named place._ -> `::value | false`
test(9, map.get("trail20", "trueKey")); test(9.1, map.get("trail20", "textKey")); 
test(9.2, map.get("trail20", "tableKey"))

test(9.3, map.get("trail20", "unknown")); test(9.4, map.op {"view", "trail20"})
  
--:- erase name -> _Remove named place and broadcast Muse eXcise (MX) to units._ 
test(10, map.op {"erase", "trail20"} ); test(10.1, map.op {"view", "trail20"})

test(11, map.op {"store", "happyplace"})

local results = map.op {"chart", "TX", "fancy echo", {charted = "table"}, "something else"}
test(12, results)
