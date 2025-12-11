-- Preface for tests (takes place of startup for test environment)

local here = arg[0]:match('.*[/\\]') -- path to this executable

local function splitFiles(path)   -- make a table split by \ or /
  local files = {}; for name in string.gmatch(path, "([^/\\]+)") do table.insert(files, name) end 
  --local files = {}; for name in string.gmatch(path, "([^/\\]+)[/\\]?") do table.insert(files, name) end 
  return files
end

local files = splitFiles(here); 
local rom =  table.concat(files, "/", 1, #files - 2).."/"
_G.Muse = _G.Muse or {}; 
_G.Muse.data = here.."data/"  -- local to each computer in a world (for `logs`)
_G.Muse.path = rom.."modules/"  -- shared across all worlds (most of Muse)
_G.Muse.lib = rom.."modules/lib/"  -- shared across all worlds (for convenience)
_G.Muse.tests = rom.."modules/tests/" -- directory of test executables
_G.Muse.checks = rom.."modules/tests/checks/" -- directory of resources for regression testing
_G.Muse.testSetName = "00musechecks.lua"
-- regression test file names in `checks/00regression` as well as files with expected results for those tests
--[[ TODO: needed?
_G.Muse.package = _G.Muse.lib.."?.lua"
package.path = _G.Muse.package
--]]

_G.Muse.landed = {farmer = true, logger = true, miner = true,} -- roles of turtles local to each site
_G.Muse.tracking = {limit = 500, enabled = nil}; 
_G.Muse.delays = {gps = 1, dds = 3} -- for game setup before running dds
_G.Muse.stack, _G.Muse.slots, _G.Muse.attempts = 64, 16, 5
_G.Muse.permutations = {"x", "y", "z"}



