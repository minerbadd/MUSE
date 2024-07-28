--[[
##Startup Operations for MUSE Computers
```md
--:~ parallel.waitForAny(remote.wait) <- **MUSE start: Restore Places, DDS, Turtles Wait** -> muse/docs/daemons/.start.md  
--:+ _Autorun daemon by `startup.lua` for all MUSE (not GPS) computers (pocket and command computers, turtles)._  
--:+ `startup.lua` for MUSE computers is `shell.run('rom/modules/.start.lua')`  
``` 
```Lua
--]]
_G.Muse = _G.Muse or {}; 
_G.Muse.path = "rom/modules/"; local path = _G.Muse.path -- shared across all worlds (most of Muse)
_G.Muse.charts = _G.Muse.path.."charts/"

---@diagnostic disable-next-line: undefined-field
local peripheral, parallel = _G.peripheral, _G.parallel -- to supress static analysis lint warnings

---@diagnostic disable-next-line: undefined-field
local rednet = _G.rednet -- nil for out-game debug
---@diagnostic disable-next-line: undefined-field
local player = _G.pocket; -- only the player has a pocket computer
---@diagnostic disable-next-line: undefined-field
local turtle = _G.turtle; -- GPS computers are not turtles
---@diagnostic disable-next-line: undefined-field
local command = _G.commands -- table or nil (if not a command computer)

--:# _Set Configuration Variables: landed turtles, default site, tracking, delays, turtle `data` directory_
_G.Muse.landed = {farmer = true, logger = true, miner = true,} -- roles of turtles local to each site
_G.Muse.IDs, _G.Muse.roles = {}, {}
_G.Muse.defaultSite = "base" -- change site with `site` program
_G.Muse.tracking = {limit = 500, enabled = nil}; -- _G.Muse.stack = 64 TODO:
_G.Muse.delays = {gps = 1, dds = 3, map = 5} -- for game setup before running dds
_G.Muse.data = "muse/"-- local to turtle/computer
_G.Muse.map = _G.Muse.data.."map.map" -- name of map in _G.Muse.data
_G.Muse.log = _G.Muse.data.."log.log"; 

if rednet then package.path = "/rom/modules/lib/?.lua" end

local cores = require("core"); local core = cores.core ---@module "signs.core"
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.dds"
local places = require("places"); local place = places.place ---@module "signs.places"
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
local nets = require("net"); local net = nets.net ---@module "signs.net"

--:# _Set status and logging control parameters_
local level, file = 5, "status"; core.logging({level, file})
--[[
```
<a id="host"></a> 
#Register turtles and computers that run this script as Muse Query (`MQ`) hosts for discovery service.
```Lua
--]]
local function identity() -- temporary label as computer ID if needed for MQ registration
  local role = core.getComputerLabel() or (player and "player" or (command and "porter")); core.setComputerLabel(role)
  local label = core.getComputerLabel(); if label then return label end --maybe not yet sited
  local id = tostring(core.getComputerID()); core.setComputerLabel(id); return id
end
--:# **Get ready to run: turn on modems, setup for turtle registration**
peripheral.find("modem", rednet.open); shell.openTab(path..".status.lua"); shell.openTab("bg"); 
rednet.host("MQ", identity()) -- **start dds registration**, and give it time to settle
--[[
```
<a id="complete"></a>
#Set up hints as shell command completions from `lib/net`
Using <a href="../lib/core.html#completer" target="_blank"> `core.completer`</a>.
```Lua
--]]
--:# _Register completions for local and remote commands_
local function complete(completions)
  for command, completion in pairs(completions) do 
    shell.setCompletionFunction(command, core.completer(completion)) 
  end
end; complete(net.hints)
--[[
```
<a id="dds"></a> 
#Create dictionaries associating IDs to (role) labels and associating (role) labels to IDs.
```Lua
--]]
--:# _Setup `dds` IDs and labels. Needed for remote calls (which can report errors back to player)_
---@diagnostic disable-next-line: undefined-field
if rednet then os.sleep(_G.Muse.delays.dds); dds.hosts(); os.sleep(0); end -- need os.sleep for gps!

if player or turtle or command then shell.openTab(path..".update.lua"); shell.openTab(path..".erase.lua"); end -- no GPS
  --os.sleep(_G.Muse.delays.map)
--[[
```
<a id="fix"></a> 
#Say where command computer and turtles are, store site and map with remote calls (reporting errors)
```Lua
--]]
--:# _Report turtle situations and number of places in map; persist site in site file and places in map (reporting errors)_

local site = place.site() or place.site(_G.Muse.defaultSite); 
print("\n"..site..", `site` to change")

local function printings(host, id) return function(results) print("\n"..id.." "..host..":\n"..results) end end
if player then 
  for host, id in dds.map() do -- for each dds host, `fix` and `store` in `lib/map`
    remote.call(host, "fix", {}, printings(host, id)) -- printings generates callback
    remote.call(host, "store", {site}, printings(host, id)) -- new `site` established in `lib.dds`, needs persisting
  end
end
---@diagnostic disable-next-line: undefined-field
os.getComputerLabel() -- to show turtle nameplate
--[[
```
<a id="wait"></a> 
#Finish startup in-game by putting turtles and command computer in wait loops.
(GPS computers have their own startup. They don't run this one.)
```Lua
--]]
--:# **Turtles and Command Computer wait for remote command from player**
if rednet and not player then parallel.waitForAny(remote.wait) end-- wait for net command (in game)
