--:? muse/docs/tests/headings.txt <- **Run Regression Test for Muse** -> muse/docs/tests/headings.md  
-- **Test heaadings -- head ["#rate"] "place" ["#lines"]; head "#rate" ["#lines"]; head ["#rate"]**

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, place, map = require("core").core, require("places").place, require("map").map

map.map(_G.Muse.path.."tests/maps/TH.map"); place.site("TH"); core.log.level(5)

local ok, result = map.op({"test", "rome", "home", "210", "68", "262", "west"})
if not ok then error(result) end

map.op{"headings", "rome"}