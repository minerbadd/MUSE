--:? muse/docs/tests/remote.txt <- **Run Regression Test for Muse** -> muse/docs/tests/remote.md  
-- **Tests for `lib/remote` (out-of-game with `lib/remote` test interfaces)**

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, place, map, dds = require("core").core, require("places").place, require("map").map, require("dds").dds
local remote, roam, port = require("remote").remote, require("roam").roam, require("port").port

local path = _G.Muse.path; map.map(path.."tests/maps/".."TR.map"); place.site("TR"); core.log.level(0); 

local function prints(index, part, value, validation) --
  print(core.string(index, part, value, validation or ""))
end

local function test(index, server, command, arguments, validation)
  -- testCall = prepareCall, -- (server: ":", command: ":", {arguments: ":"[]} -> serverID: #:, request: ":"
  local callOK, serverID, request = core.pass(pcall(remote.testCall, server, command, arguments))
  if callOK then prints(index, ">", {serverID, request}, validation) 
  else prints(index, "call", {"FAIL ", server, command.." "..core.string(arguments), serverID})
  end
  -- testRequest = serverRequest, -- (clientID: ":", request: ":") -> result: ":"
  local requestOK, result = core.pass(pcall(remote.testRequest, 0, request))
  if requestOK then prints(index, "<", result)
  else prints(index, "result", {"FAIL ", "player", request, core.string(result)})
  end
  -- testResult = clientResult, -- (serverID: #:, result: ":", callback{}) -> `nil`
  local resultOK, report = core.pass(pcall(remote.testResult, serverID, result, 
      function(value) prints(index, "=", core.string(value)) end)) -- callback
  if not resultOK then prints(index, "=", {"FAIL ", core.string(request), core.string(report)}) end
end

print("0.0 DDS Mapping")
for host, id in dds.map() do -- for each MQ host
  print(host, id)
end

--:# **Remote Status Logging Control in lib/core**
test(1, "miner", "echo", {"echo 1", "echo 2", "echo 3"})
test(2, "rover", "status", {"3"}); test(2.1, "rover", "status", {}, 3); test(2.2, "rover", "status", {"4"})
test(2.3, "rover", "status", {}, 4); test(2.4, "rover", "status", {"1"})

--:# **Remote turtle operations not subsumed by lib/task**
test(3, "miner", "fuel") --:- fuel -> _Returns energy available in turtle slots._
test(4, "miner", "items") --:- items -> _Returns items in turtle inventory._

--:# **Remote Low Level Turtle Operations in lib/task**
test(5, "miner", "nonesuch", {"apples"}, "expected fail")
--:- find name...? -> Report and select first slot found [or if no name, just report inventory].
test(6, "logger", "find", {"fuel", "ores"}); test(6.1, "logger", "find", {"unobtanium"}, "expected fail")
--:- attack direction -> Attempts attack in specified direction.
test(7, "farmer", "attack", {"east"})
--:- look direction -> Detect and inspect direction, return report.
test(8, "miner", "look", {"down"}); test(8.1, "miner", "look", {"around"}, "expected fail")
--:- drop item direction quantity? -> Drop quantity of selected items [or all].
test(9, "miner", "drop", {"fuel", "up", "6"})
--:- suck direction quantity? -> Suck quantity items [or all] into available slot.
test(10, "miner", "suck", {"up", "2"})
--:- compare item direction+ -> _Named item matches block in any of specified directions?_
test(11, "miner", "compare", {"minecraft:dirt", "up", "down"})
--:- dig direction distance hoeings...? -> Direction and distance to (possibly blocked) move, hoeings directions to hoe.
test(12, "farmer", "dig", {"down", "5", "east", "south"})
--:- put filling direction distance puttings+ -> Direction, distance to move, placing filling in puttings directions.
test(13, "farmer", "put", {"dirt", "east", "3", "up", "down"})
--:- change target filling direction distance puttings+ -> Move distance in direction replacing target with filling.
test(14, "logger", "change", {"dirt", "stone", "down", "4", "north", "down"})

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

--:# **GPS Positioning**
test(35, "rover", "launch", {"paris"})

--:# **Mining Operations**
map.write(map.map()); map.op {"test", "neathe", "testing", 100, 70, 200, "east"}; map.write(map.map())
test(36, "miner", "shaft", {"neathe", "4", "snake"})
test(37, "miner", "bore", {"neathe:03", "cross"})
test(38, "miner", "post", {"neathe:03"})
test(38.1, "miner", "post", {"neathe:03:SW21"})
test(39, "miner", "ores", {"neathe:03:N03"})

--:# **Field Operations** (Simple Ones First)
map.op {"test", "farm00", "testing", "90", "20", "290", "west"}
map.op {"test", "farm30", "testing", "100", "20", "300", "west"}
map.op {"range", "farm3000", "testing", "farm30", "farm00", "fences"}
roam.op {"trace", "farm3000"} -- range as really short trail

test(40, "farmer", "cut", {"farm30", "farm00"})
test(41, "farmer", "fill", {"farm30", "farm00", "dirt"})
test(41.1, "farmer", "fill", {"farm30", "farm00","potato", "dirt"})
test(42, "farmer", "till", {"farm30", "farm00", "dirt", "potato"})

test(43, "farmer", "fence", {"farm3000"})
test(43.1, "farmer", "fence", {"farm3000", "birch"})
map.op {"test", "farm40SE", "testing", "100", "20", "300", "east"}
map.charts(_G.Muse.path.."charts/"); map.op {"chart", "farm40", "farm40SE", "SE", "64"}; 
test(43.2, "farmer", "fence", {"farm40SE:east", "birch"})

test(44, "farmer", "path", {"farm40SE:pens", "2", "2"})
test(44.1, "farmer", "quarry", {"farm40SE:trees", "2", "2"})
test(44.2, "farmer", "layer", {"farm40SE:trees", "2", "2"})
test(44.3, "farmer", "quarry", {"farm40SE:trees", "2", "2"})
test(44.4, "farmer", "cover", {"farm40SE:trees", "2", "2"})
test(44.5, "farmer", "finish", {"farm40SE:trees", "2", "2"})
test(44.6, "farmer", "harvest", {"farm40SE:trees", "2", "2"})

test(45, "farmer", "field", {"harvest", "farm40SE:trees", "2", "2"})

test(99, "rover", "quit", "quitting")
core.status(1, "Should be quitting")
test(999, "miner", "echo", {"echo 1", "echo 2", "echo 3"})
