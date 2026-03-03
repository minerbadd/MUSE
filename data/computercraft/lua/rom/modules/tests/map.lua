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

--:# `turtle.blocking false`; `place.site TM`; `maps/TM.map`; `charts`; `core.setComputerLabel("tester")`
turtle.blocking(false); place.site("TM")

local test = check.open(testName, text, regression) --:# Create the test object for this test

local path = _G.Muse.path.."tests/"map.map(path.."maps/TM.map"); map.charts(path.."charts/")
core.log.level(3); core.setComputerLabel("tester")

--:# **Check turtle dance for facing witout dancing**
test.part("test setup", map.point, "test0", "label0", "199", "66", "262", "east"})
test.part("move to 10, 20, 30, east", move.where, 10, 20, 30, "east")
-- face (dx, dz, ew, we, ns, sn) -- face(dx, dz, "east", "west", "south", "north") -> 
test.part("facing north", map.testFacing, 0, -10, {"east", "west", "south", "north"})

--:# **Populate map**
test.part("fix 10, 20, 30, east", place.fix, {10, 20, 30,"east"})
test.part("point test1", map.op {"point", "test1", "label1"})
test.part("fix 10, 20 40, east", place.fix, {10, 20, 40,"east"})
test.part("point test2", map.op, {"point","test2", "label2"})
-- test.part("test rome", map.op, {"test", "rome", "home", "15", "25", "35", "east"})
test.part("test test3", map.op {"test", "test3", "label3", "10", "20", "30", "east"})

--:# **Look for what's near**
test.part("near", map.op, {"near"})
test.part("near 10", map.op, {"near", "10"}) -- span as placeName
test.part("near test1", map.op, {"near", "test1"})
test.part("near test1 10", map.op, {"near", "test1", "10"})

--:# **Look at where**
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

--:# **Check range and view**
test.part("range", map.op, {"range", "tests", "range", "test1", "test2", "fields", "trees"})
test.part("view", map.op, {"view", "tests"}); 

--:# **Test maps for trails**
move.set(100, 150, 200, "west"); move.to({100, 150, 200,"west"}); 
test.part("point trail20", map.op, {"point", "trail20", "test20", "head20"})
move.set(100, 150, 200, "west"); move.to({100, 160, 210, "west"})
move.to({110, 170, 220, "east"}); move.to({120, 170, 220, "north"})
test.part("trail2021", map.op, {"trail", "tail21", "trail2021"})

--:# **View trails**
test.part("view trail20", map.op, {"view", "trail20"}) -- name, label, features, situations
test.part("view head20", map.op, {"view", "head20"}) 
test.part("view tail21", map.op, {"view", "tail21"})

--:# **Test borders**
-- map.borders({range}) -> _Get range_ -> `{:borders}, {:features}, {:xyzFirst}, {:xyzSecond}`
test.part("borders", map.borders, "trail20") 

--:# **Test features**
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
  
--:# **Try erase**
-- erase name -> _Remove named place and broadcast Muse eXcise (MX) to units._ 
test.part("erase trail20", map.op, {"erase", "trail20"})
test.part("view trail20", map.op, {"view", "trail20"})

--:# **Test store operation (reads and writes map**
test.part("store", map.op, {"store", "happyplace"})
-- check read? 
-- remove site file?
-- test join?

-- test update

--:# **Check chart**
test.part("chart", map.op, {"chart", "TX", "fancy echo", {charted = "table"}, "something else"})

--:# Close test object, report completion if we got here without errors
test.close("Test "..testName.." complete") 



--:# **Remote Turtle Motion Commands** (e.g., `farmer go`)
map.op {"test", "london", "home", "199", "66", "262", "south"}  -- setup
map.op {"test", "paris", "away", "299", "166", "362", "north"}
map.op {"range", "trip", "eurostar", "london", "paris", "visa", "brexit", "schengen"}

-- to name | x y z [face] -> To named place or position and face. Retry for different first direction.
test(15, "farmer", "to", {"paris"})
-- go (first letter of) directions followed by optional counts, e.g. r 10 u east 3 u 4 d n -> Chained movement.
-- Movements are r[ight], l[eft], f[orward], b[ack], u[p], d[own], n[orth], e[ast], s[outh], w[est].
test(16, "rover", "go", {"up", "1"})
-- trace trailname -> Move along situations in named trail from one end of trail to the other.
test(17, "farmer", "trace", {"trip"})
-- roam.come({xyz}) -> Move turtle (close to) player's GPS xyz from remote.roam. -> &! &:
print(18, core.string(remote.testCome("farmer", "come")))

--:# **Remote Map Operations for Turtles and Player.**

--:# Map File Operations
--:- sync -> Muse Update (MU) broadcast local map to units at current site.
test(19, "rover", "sync")
--:- erase name -> Remove named place and broadcast Muse eXcise (MX) to units at current site.
test(20, "porter", "erase", {"paris"}); test(20.1, "porter", "erase", {"paris"}, "expected fail")
--:- site [name] -> _Remote operation to report or change site after, e.g., porting `rover`._test(23, "logger", "site")
test(21, "logger", "site", {"happyplace"}); test(21.1, "logger", "site")

--:# Places - Points, Trails, and Ranges of Maps
--:- point name label -> Add named and labeled point, broadcast updated map with (MU) Muse Update. (Player needs GPS.)
test(22, "miner", "point", {"paris", "france"}); test(22.1, "miner", "point", {"london", "england"})
--:- trail name -> Include named point at head and (current situation) tail of a new trail, update map.
test(23, "miner", "trail", {"eurostar", "outgoing"})
--:- range name label point point key value -> Define volume by named points, specify key and value of range property.
test(24, "miner", "range", {"excursion", "views", "london", "paris", "sights", "Dover", "Calais"})

map.charts(_G.Muse.path.."tests/charts/")
--:- chart chartfilename ... -> _Loads and runs named chart file in `charts` directory to create named point and associated ranges._
test(25, "miner", "chart", {"TX", "charted", "something", {charted = "table"}}) -- ... gets returned

--:# Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?
--:- at -> Report current (dead reckoning) turtle position and facing or player GPS position.
test(26, "farmer", "at")
--:- where [place] [count = 3] -> Report movement direction, distance to named place, and to count closest places.
test(27, "farmer", "where", {"paris", "2"})
--:- near [place] [span] -> Report points within span blocks (or all) of named place (or current player or turtle position).
test(28, "farmer", "near", {"paris", "10"}); test(28.1, "farmer", "near", {"paris"}); test(28.2, "farmer", "near")
--:- view place -> Report place details including all situations and properties.
test(29, "farmer", "view", {"excursion"})
