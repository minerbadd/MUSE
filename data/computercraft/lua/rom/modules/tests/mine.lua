--:? muse/docs/tests/mine.txt <- **Run Regression Test for Muse** -> muse/docs/tests/mine.md  
-- Test for mine functions 

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, place, map, mine = require("core").core, require("places").place, require("map").map, require("mine").mine

map.map (_G.Muse.path.."tests/maps/".."TM.map"); place.site("TM"); core.log.level(2)

map.write(map.map()); map.op {"test", "neathe", "testing", 100, 70, 200, "east"}; print(0, map.write(map.map()))

do local success, report, inventory = mine.op {"shaft", "neathe", "4", "snake"}; print(1, success, report, inventory) end

do local success, report, inventory = mine.op {"bore", "neathe:03", "cross"}; print(2, success, report, inventory) end
do local success, report, level = mine.op {"post", "neathe:03"}; print(3, success, report, level) end
do local success, report, level = mine.op {"post", "neathe:03:SW21"}; print(4, success, report, level) end
do local success, report, level = mine.op {"post", "neathe:03:NW21"}; print(5, success, report, level) end
do local success, report, level = mine.op {"post", "neathe:03:NE21"}; print(6, success, report, level) end
do local success, report, level = mine.op {"post", "neathe:03:SW21"}; print(7, success, report, level) end

do local success, inventory = mine.op {"ores", "neathe:03:N03"}
  print(8, success, core.string(inventory))
end


