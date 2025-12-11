-- **Tests for `lib/roam` ....also needs to be run with `turtle.blocking(true)`**

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, places, turtle, roam = require("core").core, require("places"), require("turtle").turtle, require("roam").roam
local place, moves = places.place, places.moves

turtle.blocking(false); core.log.level(4); place.site("TR")

place.fix({10,25,35,"west"}); place.name("test2", "label2")
place.fix({10,20,30,"east"}); place.name("test1", "label1"); moves.to("test2") -- situations from from test1 to test2
place.trail("head1", "tail2", "trail12") -- head1: from test1 to test2; tail2: from test2 back to test1

print(1, roam.op({"go", "e", "4", "w", "4", "d", "u"})) -- from test2 to test2: 10,25,35  "r", "10", "left", "10", 
print(2, roam.op({"to", "test1"})) -- 10,20,30,"east"
print(3, roam.op({"to", "20", "30", "40", "east"}))
print(4, roam.op({"trace", "head1"})) -- to 10, 20, 30
print(5, "From "..core.string(place.xyzf()).." to near "..core.string{15,25,35})
print(5, roam.come({15,25,35}))
print(6, roam.op({"go", "e", "4", "w", "4", "d", "u"})) -- from test2 to test2: 10,25,35  "r", "10", "left", "10", 
print(7, roam.op({"to", "test1"})) -- 10,20,30,"east"
print(8, roam.op({"to", "20", "30", "40", "east"}))
print(9, roam.op({"trace", "head1"})) -- to 10, 20, 30
print(10, "From "..core.string(place.xyzf()).." to near "..core.string{10,20,30})
for _  = 1, 2 do
print(11, roam.come({10,20,30}))
end

