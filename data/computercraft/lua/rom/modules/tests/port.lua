--:? muse/docs/tests/port.txt <- **Run Regression Test for Muse** -> muse/docs/tests/port.md  
-- **Tests for lib/exec interfaces**

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, place, map, port = require("core").core, require("places").place, require("map").map, require("port").port

local path = _G.Muse.path.."tests/maps/TP.map"; map.map(path); place.site("TP"); core.log.level(4)

local function test(number, ...) print(".."..number, ...) end

local inventory01 = {iron = 200, gold = 50, redstone = 100, coal = 400}
local orderA = {"iron", "copper", "gold", "redstone"}
local orderB = {"iron", "gold", "redstone"}
local orderC = {"redstone", "gold", "iron", "coal"}

test(1, core.string(port.inventory(10000, orderA, inventory01))) 
test(2, core.string(port.inventory(8000, orderB, inventory01)))  
test(3, core.string(port.inventory(8000, orderC, inventory01)))

map.point("fromPlace", "from", {100, 200, 300, "east"}); map.point("toPlace", "to", {600, 300, 700, "north"}) 

port.available(inventory01)
test(4, port.book("testBooking", "testing", "fromPlace", "toPlace", 1, orderB)) -- use testing interface
test(5, port.op {"port", "testBooking"} )
port.available({})
