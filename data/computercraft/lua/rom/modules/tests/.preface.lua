--[[
##Test: `tests/.preface` Sets Up `_G.Muse`Globals for Tests

There's a bunch of common housekeeping  

```Lua
--]]
--:? muse/docs/tests/.preface.txt <- **Set _G.Muse Globals for Tests** -> muse/docs/tests/.preface.md  
-- Preface for tests takes place of `.start` in the games ennvironment for the test environment

local here = arg[0]:match('.*[/\\]') -- path to this executable

local function splitFiles(path)   -- make a table split by \ or /
  local files = {}; for name in string.gmatch(path, "([^/\\]+)") do table.insert(files, name) end; return files
end

local files = splitFiles(here); local rom =  table.concat(files, "/", 1, #files - 2).."/" -- MUSE file arrangement

_G.Muse = _G.Muse or {}; 
_G.Muse.data = here.."data/"  -- local to each computer in a world (for `logs`)
_G.Muse.path = rom.."modules/"  -- shared across all worlds (most of Muse)
_G.Muse.lib = rom.."modules/lib/"  -- shared across all worlds (for convenience)

_G.Muse.landed = {farmer = true, logger = true, miner = true,} -- roles of turtles local to each site
_G.Muse.tracking = {limit = 500, enabled = false}; 
_G.Muse.delays = {gps = 1, dds = 3} -- for game setup before running dds
_G.Muse.stack, _G.Muse.slots, _G.Muse.attempts = 64, 16, 5
_G.Muse.permutations = {"x", "y", "z"}
