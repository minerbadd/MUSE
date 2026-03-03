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
-- use map text instead
map.point("fromPlace", "from", {100, 200, 300, "east"}); map.point("toPlace", "to", {600, 300, 700, "north"}) 

port.available(inventory01)
test(4, port.book("testBooking", "testing", "fromPlace", "toPlace", 1, orderB)) -- use testing interface
test(5, port.op {"port", "testBooking"} )
port.available({})

--:# **Command Computer Position and Port Commands** (e.g., `porter locate gantry launch``)

--:- kit "base"|"site" -> _Kit up player for specifed `set` of items._
test(30, "porter", "kit", {"base", "testing"}); test(30.1, "porter", "kit", {"site", "testing"})
--:- locate name label -> _Create point having Minecraft coordinates above `porter` Command Computer_
test(31, "porter", "locate", {"gantry", "located", 100, 200, 300, {nbt = {Label = "rover"}, state = {facing = "north"}}})
--:- activate range -> _Add bounds from west and north to east and south of range for forceload._
test(32, "porter", "activate", {"excursion"})
--]]

---use map.test instead
map.point("fromPlace", "from", {100, 200, 300, "east"}); map.point("toPlace", "to", {600, 300, 700, "north"}) 
port.available({iron = 200, gold = 50, redstone = 100, coal = 400})

--:- book name label from to [span [item ...] ] -> _Spanned range with (default) items as properties; return cost less bank._
test(33, "porter", "book", {"testBooking", "testing", "fromPlace", "toPlace", "1", "iron", "gold", "redstone"})
--:- port booking -> _As laid out in booking, consume player inventory to teleport entities from one area to another._
test(34, "porter", "port", {"testBooking"}); port.available({})
