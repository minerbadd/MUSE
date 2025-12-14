--:? muse/docs/tests/02task.txt <- **Run Regression Test for Muse** -> muse/docs/tests/06task.md  
-- **Tests for lib/task operations** 

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, move, place, task = require("core").core, require("motion").move, require("places").place, require("task").task

core.log.level(3); place.site("TT")

local function test(number, ...) print(".."..number, core.string(...)) end

test(1, "look", task.op {"look", "east"})
test(1.1, "look", task.op {"look", "up"})
test(2, "attack", task.op {"attack", "east"})
test(3, "find coal", task.op {"find", "coal"})
test(4, "find fuel", task.op {"find", "fuel"})
test(5, "drop east 1", task.op {"drop", "coal", "east", "1"})
test(6, "drop east", task.op {"drop", "coal", "east"})
local result = task.op {"find", }
test(7, "found the following\n"..result)
test(8, "suck", task.op {"suck", "east"})
test(9, "inspect air", task.op {"look", "up"})
test(10, "dig up", task.op {"dig", "up", "6", "up"})
test(11, "dig e 10 e d", task.op {"dig", "e", "10", "e", "d"})
test(12, "put dirt w 10 e d", task.op {"put", "dirt", "w", "10", "e", "d"})
test(13, "change sand dirt w 10 e d", (task.op {"change", "sand", "dirt", "w", "10", "e", "d"}))
test(14, "put dirt here d", task.op {"put", "dirt", "here", "d", "e"})

place.fix({10, 120, 230}); move.to({15, 125, 235}); move.to({20, 130, 240})
place.trail("start", "end", "test"); move.to({5, 115, 225})
test(15, "dig along start", task.op {"dig", "along", "start"})
test(16, "put dirt along end", task.op {"put", "dirt", "along", "end"}) 
test(17, "change sand dirt along start", task.op {"change", "sand", "dirt", "along", "start"})

--[[

--]]
-- :: place.fix(xyzf, ^:noTrack) -> _Sets situation position, can start tracking for trail._ -> `xyzf` 
-- :: move.to(xyzf, [first: ":"]) -> _Current situation to x, z, y, and optionally face._ -> `("done, 0, xyzf: ":") | !recovery` 
-- :: place.trail(headName: ":", tailName: ":", label: ":") -> _Makes two places._ -> `headSerial: ":", tailSerial: ":"`
-- :+ _Trail places share a label and represent trails from head to tail and tail to head; head set by_ `place.fix`.
