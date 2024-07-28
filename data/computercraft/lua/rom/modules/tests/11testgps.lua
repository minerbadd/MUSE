-- **out-game test of lib/gps for gps launch**

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, place, map, gps = require("core").core, require("places").place, require("map").map, require("gps").gps

place.site("TG")

-- Creates `install` and `startup` files in `test` directory 
-- copy these out of game into a computer's disk and reboot the computer for additional testing

map.op({"test", "rome", "home", "-1532", "63", "324", "west"})
print(core.string(gps.op({"launch", "rome"})))