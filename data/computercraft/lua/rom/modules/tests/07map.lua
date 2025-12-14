--:? muse/docs/tests/07map.txt <- **Run Regression Test for Muse** -> muse/docs/tests/07map.md  
-- **Tests for lib/map** interfaces

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, move, place = require("core").core, require("motion").move, require("places").place
local map, turtle = require("map").map, require("turtle").turtle
local path = _G.Muse.path.."tests/"

map.map(path.."maps/TM.map"); place.site("TM"); map.charts(path.."charts/")
core.log.level(4); turtle.blocking(false); core.setComputerLabel("tester")
local function test(number, ...) print(".."..number, ...) end

test(0, map.op({"test", "test0", "label0", "199", "66", "262", "east"}))
local x, y, z, f = move.where(10, 20, 30, "east"); test(0.1, x, y, z, f)
-- face (dx, dz, ew, we, ns, sn) -- face(dx, dz, "east", "west", "south", "north") -> 
local facing = map.testFacing(0, -10, {"east", "west", "south", "north"})
test(0.2, facing, "expect north")
do local xyzf = place.fix({10, 20, 30,"east"});test(0.3,core.string(xyzf)) end

test(1, core.string(map.op {"point", "test1", "label1"} ))
do local xyzf = place.fix({10, 20, 40,"east"}); test(1.1, core.string(xyzf)) end
test(1.2, core.string(map.op {"point","test2", "label2"} ))
test(1.3, core.string(map.op {"test", "rome", "home", "15", "25", "35", "east"}))
test(1.4, core.string(map.op {"test", "test3", "label3", "10", "20", "30", "east"}))

test(2, core.string(map.op {"near"}))
test(2.1, core.string(map.op {"near", "10"})) -- span as placeName
test(2.2, core.string(map.op {"near", "test1"}))
test(2.3, core.string(map.op {"near", "test1", "10"}))
--[[
test(3, core.string(map.op {"where", nil, 10, 20, 20}))
test(3.1, core.string(map.op {"where", nil, 2, 10, 20, 20}))
test(3.2, core.string(map.op {"where", nil, nil, 15, 20, 25}))
test(3.3, core.string(map.op {"where","test1", nil, 15, 20, 25}))
test(3.4, core.string(map.op {"where", "test1", "2", "15", "20", "25"}))
--]]
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

--:: map.get(name: ":", key: ":") -> _Get feature value for key if named place._ -> `::value | false`
test(9, map.get("trail20", "trueKey")); test(9.1, map.get("trail20", "textKey")); 
test(9.2, map.get("trail20", "tableKey"))

test(9.3, map.get("trail20", "unknown")); test(9.4, map.op {"view", "trail20"})
  
--:- erase name -> _Remove named place and broadcast Muse eXcise (MX) to units._ 
test(10, map.op {"erase", "trail20"} ); test(10.1, map.op {"view", "trail20"})

test(11, map.op {"store", "happyplace"})

local results = map.op {"chart", "TX", "fancy echo", {charted = "table"}, "something else"}
test(12, results)
