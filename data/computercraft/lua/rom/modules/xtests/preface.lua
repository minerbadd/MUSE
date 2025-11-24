-- Preface for tests (takes place of startup for test environment)

local here = arg[0]:match('.*[/\\]') -- tests directory
local checks = here.."checks" -- two tables: test file names 

local function splitFiles(path)   -- make a table split by \ or /
  local files = {}; for name in string.gmatch(path, "([^/\\]+)[/\\]?") do table.insert(files, name) end 
  return files
end

local files = splitFiles(here); 
local rom =  table.concat(files, "/", 1, #files - 2).."/"

_G.Muse = _G.Muse or {};  
_G.Muse.checks = checks; -- files each holding ordered test file name table and correct results for each test file
_G.Muse.path = rom.."modules/";  -- shared across all worlds (most of Muse)
_G.Muse.lib = rom.."modules/lib/";  -- shared across all worlds (for convenience)
_G.Muse.data = here.."data/"  -- local to each computer in a world (for `logs`)

_G.Muse.landed = {farmer = true, logger = true, miner = true,} -- roles of turtles local to each site
_G.Muse.tracking = {limit = 500, enabled = nil}; 
_G.Muse.delays = {gps = 1, dds = 3} -- for game setup before running dds
_G.Muse.stack, _G.Muse.slots, _G.Muse.attempts = 64, 16, 5
_G.Muse.sequenced = true

_G.Muse.package = _G.Muse.lib.."?.lua"
package.path = _G.Muse.package

