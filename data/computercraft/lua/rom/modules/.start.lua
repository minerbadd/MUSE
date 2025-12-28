--[[
##Startup Operations for MUSE Computers
```md
--:~ parallel.waitForAny(remote.wait) <- **MUSE start: Restore Places, DDS, Turtles Wait** -> muse/docs/daemons/.start.md  
--:+ _Autorun daemon by `startup.lua` for all MUSE (not GPS) computers (pocket and command computers, turtles)._  
--:+ `startup.lua` for MUSE computers is `shell.run('rom/modules/.start.lua')`  
``` 
```Lua
--]]
_G.Muse = _G.Muse or {}
_G.Muse.path = "rom/modules/"; local path = _G.Muse.path -- shared across all worlds (most of Muse)
_G.Muse.package = "/rom/modules/lib/?.lua"
_G.Muse.charts = path.."charts/" -- modified by tests to keep game undisturbed by tests

local peripheral, parallel = _G.peripheral, _G.parallel -- to supress static analysis lint warnings

local rednet = _G.rednet -- nil for out-game debug
local player = _G.pocket; -- only the player has a pocket computer
local turtle = _G.turtle; -- GPS computers and the command computer are not turtles
local command = _G.commands -- table or nil (if not a command computer)

--:# _Set Configuration Variables: landed turtles, default site, tracking, delays, turtle `data` directory_
_G.Muse.landed = {farmer = true, logger = true, miner = true,} -- roles of turtles local to each site
_G.Muse.IDs, _G.Muse.roles, _G.Muse.defaultSite = {}, {}, "base" -- with `site` program
_G.Muse.tracking = {limit = 500, enabled = false}
_G.Muse.delays = {gps = 1, dds = 3, map = 5} -- for game setup before running dds
_G.Muse.slots = 16 -- in turtle inventory (just to avoid a magic number)
_G.Muse.attempts = 5 -- `lib/turtle` attempts to remove a blockage
_G.Muse.rates = {}; _G.Muse.rate.headings = 5; _G.Muse.rates.tail = 0.5
_G.Muse.permutations = {"y", "z", "x"} -- axes order in permutations
-- {"y", "z", "x"} -> z x y, x z y, x y z, y x z, z y x, y z x
-- {"x", "y", "z"} -> y z x, z y x, z x y, x z y, y x z, x y z


_G.Muse.data = "muse/"-- local to turtle/computer
_G.Muse.map = _G.Muse.data.."map.map" -- name of map in _G.Muse.data
_G.Muse.log = _G.Muse.data.."log.log"; 

package.path = _G.Muse.package -- needed for each module
local cores = require("core"); local core = cores.core ---@module "signs.core"
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.dds"
local places = require("places"); local place = places.place ---@module "signs.places"
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
local nets = require("net"); local net = nets.net ---@module "signs.net"

--:# _Set status and logging control parameters_
local level, file = 5, "status"; core.logging({level, file})

local site = place.site() or place.site(_G.Muse.defaultSite); 
print("\nsite: "..place.site() or "?"..", `site` to change")
--[[
```
<a id="host"></a> 
#Register turtles and computers that run this script as Muse Query (`MQ`) hosts for discovery service.
```Lua
--]]
local function identity() -- temporary label as computer ID if needed for MQ registration
  local label = core.getComputerLabel(); local labelled = not tonumber(label)
  local role = labelled and label or (player and "player" or (command and "porter"))
  local id = tostring(core.getComputerID()); -- for temporary label
  core.setComputerLabel(role or id) -- if role nil, set temporary label
  return core.getComputerLabel()
end
--:# **Get ready to run: turn on modems, setup for turtle registration**
peripheral.find("modem", rednet.open)

if player or turtle or command then -- not for GPS computers
  shell.openTab(path..".update.lua"); shell.openTab(path..".erase.lua"); 
  shell.openTab(path..".status.lua"); shell.openTab("bg") -- TODO: too many shells?
end

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
if rednet then -- TODO: Are all these delays needed?
  os.sleep(_G.Muse.delays.dds); dds.hosts(); os.sleep(_G.Muse.delays.map); os.sleep(0) --  -- need os.sleep(0) for gps!
end
--[[
```
<a id="fix"></a> 
#Say where command computer and turtles are, store site and map with remote calls (reporting errors)
```Lua
--]]
--:# _Report turtle situations and number of places in map; persist site in site file and places in map (reporting errors)_

local function printings(host, id) return function(results) print(id.." "..host..": "..results) end end
if player then 
  for host, id in dds.map() do -- for each dds host, `fix` and `store` in `lib/map`
    remote.call(host, "fix", {}, printings(host, id)) -- printings generates callback
    remote.call(host, "store", {site}, function(results) print(results) end) -- persist new `site` established in `dds`
  end
end
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
