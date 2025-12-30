--:? muse/docs/tests/exec.txt <- **Run Regression Test for Muse** -> muse/docs/tests/exec.md  
-- **Tests for lib/exec interfaces**

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, place, map, exec = require("core").core, require("places").place, require("map").map, require("exec").exec
local path = _G.Muse.path.."tests/maps/TE.map"; map.map(path); place.site("TE"); core.log.level(4)

local function test(number, ...) print(".."..number.." done", ...) end

-- : exec.locateTest(name: ":", label: ":", #:, #:, #:, {:blockAboveTest}) -> _For testing._ -> ": `role`..at..`qualifiedName` "
-- > blockAboveTest: _For testing_ -> `{nbt = {Label = ":"}, state = {facing = ":"}}`
test(1, core.string(exec.op {"locate", "test1", "located", 100, 200, 300, 
      {nbt = {Label = "rover"}, state = {facing = "north"}}}))

place.fix({10, 20, 30, "east"}); map.op {"point", "test1", "label1"} 
place.fix({10, 20, 40, "east"}); map.op {"point","test2", "label2"}
map.op {"range", "tests", "range", "test1", "test2", "fields", "trees"}

test(2, core.string(exec.op {"activate", "tests"} ))




