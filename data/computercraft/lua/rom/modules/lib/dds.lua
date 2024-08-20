--[[
## MUSE Distributed Discovery Service: lib/dds.lua
```md
--:! {dds: []: (:)} <- **In-game (only) MUSE Discovery Service Library** -> muse/docs/lib/dds.md  
--:| dds: _Associates computer IDs with labels (as Muse roles) using Muse Query (MQ) rednet protocol._ -> dds
```
This module provides a library handling the mapping of numbers (ComputerCraft computer IDs) to names (ComputerCraft computer labels standing in for MUSE roles) with `dds.role` and back again with `dds.roleID`. These are filled in in-game by a call to `lib/dds.hosts` during session startup by running <a href="../.start.html#dds" target="_blank"> `.start.lua` </a>. 

Some MUSE roles are native to a MUSE `site`. Unsited turtles in these `landed` roles will be given the player's site. 

This library provides the DDS facilities needed for remote calls. Remote calls allow errors to be reported back to the player. Otherwise, errors would only be visible locally so this library's file operation errors, for example, wouldn't be seen by player.

The so-called DDS facilities only work in-game. The ComputerCraft network interfaces are not mocked. However, the library exports a default mapping.
```Lua
--]]

local dds = {}; dds.hints = {} ---@module "signs.dds" -- for functions exported from library

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local places = require("places"); local place = places.place ---@module "signs.places"

---@diagnostic disable-next-line: undefined-field
local rednet, parallel = _G.rednet, _G.parallel -- for static analysis

---@diagnostic disable-next-line: undefined-field
local player = _G.pocket -- only the player has the (only) pocket computer

_G.Muse.IDs = _G.Muse.IDs or -- for out-game 
--:> IDs: _Dictionary of ComputerCraft computer IDs keyed by MUSE role_ -> `[role]: ID`
--:> ID: _ComputerCraft computer ID_ -> `#:`
---@diagnostic disable-next-line: undefined-field
(_G.rednet and {} or {player = 0, porter = 1, rover = 5, miner = 6, logger = 7, farmer = 8}) 

_G.Muse.roles = _G.Muse.roles or -- for out-game
---@diagnostic disable-next-line: undefined-field
(_G.rednet and {} or {[0] = "player", [1] = "porter", [2] = "rover", [3] = "miner", [4] = "logger", [5] = "farmer"})
--:> roles: _Dictionary of Computercraft labels for MUSE roles keyed by Computercraft (string) IDs_ -> `[ID]: ":"`
--:> role: _ComputerCraft label as MUSE role_ -> `":"`

local IDs, roles, landed = _G.Muse.IDs, _G.Muse.roles, _G.Muse.landed

function dds.roleID(role) return IDs[role] end --:: dds.roleID(role: ":") -> _ID for a Muse role_ -> `ID: #:` 
function dds.role(ID) return roles[ID] end --:: dds.role(ID: ":") ->  _Label for a Muse role_ -> `role: ":"`
--[[
```
<a id="request"></a> 
The player sends a `request` for MUSE roles (as ComputerCraft labels) to all computers registered as `MQ protocol hosts and gets a count of them. 
```Lua
--]]

function dds.playerID(id) if id then _G.Muse.playerID = id end; return _G.Muse.playerID end

local function request() -- player sends its ID and site to all computers registered as `MQ` protocol hosts.
  dds.playerID(core.getComputerID(0)) -- out-game force ID = 0
  local hosts = {rednet.lookup("MQ")}; core.report(1, "Hosting "..#hosts)
  for _, id in pairs(hosts) do rednet.send(id, place.site(), "MQ") end 
  return #hosts
end
--[[
```
<a id="respond"></a> 
All computers other than the player's pocket computer wait to `respond`. If a responding turtle is a `landed` turtle that is as yet, unsited, it attaches itself to the player's `site`. In any case, it sends back a message that provides information for mapping between its computer ID and its label (its MUSE role).
```Lua
--]]
local function respond()  
  local id, playerSite = rednet.receive("MQ"); dds.playerID(id) -- set global on remote responder
  local label, sitedFile = core.getComputerLabel(), io.open(_G.Muse.data.."site.txt", "r") -- no file if recently joined
  local site = sitedFile and sitedFile:read(); place.site(site or playerSite) -- player's site if not already established
  local newFile = not sitedFile and io.open(_G.Muse.data.."site.txt", "w"); 
  print("dds.respond: ", id, playerSite, label, sitedFile, site, newFile) -- **TODO: remove**
  assert(newFile or sitedFile, "dds.respond: can't write site.txt")
  if newFile then newFile:write(place.site()) end -- new (player's) site
  local sitedLabel = landed[label] and place.qualify(label) or label; 
  core.setComputerLabel(sitedLabel); -- landed turtles in their place
  core.report(1, "MQT "..id.." "..sitedLabel); -- DDS Turtle now sited
  rednet.send(id, sitedLabel, "MQ") -- need to send `count` messages 
end
--[[
```
<a id="receive"></a>
The player waits to `receive` each of the responses and populates two tables, `IDs` and `labels`, that provide a mapping between names and numbers and back again`. When it has the full `count` of responses, the work of `dds.hosts` is done. 
```Lua
--]]
local function receive(count) -- on player for each DDS host
  for _ = 1, count do
    local ddsID, received = rednet.receive("MQ") -- next, deal with rednet send to self behavior
---@diagnostic disable-next-line: undefined-field
    local ddsLabel = (ddsID == dds.playerID()) and "player" or received -- player sends garbage to self
    IDs[ddsLabel] = ddsID; roles[ddsID] = ddsLabel -- the point of it all
    core.report(1, "MQ "..ddsID.." "..ddsLabel) -- DDS Player
    rednet.send(ddsID, "DDS OK on "..core.getComputerLabel(), "MS") -- to .status
  end 
end
--[[
```
<a id="hosts"></a> 
The `dds.hosts` function kicks off the interactions above between a player and other DDS hosts to populate a mapping between roles and computer IDs. The interactions begin by a <a href="#request"> `request`</a> for a count of computers registered with the `MQ` protocol. This was set up during session <a href="../.start.html" target="_blank"> startup </a>. The MQ registered computers <a href="#respond"> `respond` </a> with a message allowing a mapping between the turtle's computer ID and its label (its MUSE role). This is done by the <a href="#receive"> `receive` </a> function. The `parallel.waitForAny` function is called with an anonymous closure to `receive` a `count` of these messages.
```Lua
--]]
function dds.hosts() 
  --:: dds.hosts() -> _Populates players IDs and labels using a MQ rednet protocol._ -> `IDs, roles`
  print("Waiting on MQ"); if not player then print("Need pocket computer for DDS") end
  if not player then parallel.waitForAny(respond) 
  else local count = request(); print(tostring(count).." DDS hosts (expected?)")  -- player
    parallel.waitForAny(function() receive(count) end) -- wait to get all MQ host responses
    --IDs[core.getComputerLabel("player")] = core.getComputerID(0) -- the player has a label: "player" 
  end; 
end

function dds.join(role, idGiven) -- on player
  --:: dds.join(role: ":", id: #:?) -> _Fix ID role association for next startup, id given by player._ -> `sitedLabel: ":"`
  local sitedLabel = landed[role] and place.qualify(role) or role; core.setComputerLabel(sitedLabel); -- qualify landed
  local id = idGiven or core.getComputerID(); IDs[sitedLabel] = id; roles[id] = sitedLabel 
  return sitedLabel.." joined ID "..tostring(id)
end
--[[
```
<a id="map"></a> 
The table of associations between labels (MUSE roles) and ComputerCraft computer IDs established for the session is isolated by exporting a function that returns an iterator for the elements of the table.
```Lua
--]]
function dds.map() return pairs(IDs) end --:: dds.map() -> _Returns associations from Muse roles to ComputerCraft IDs_ -> `IDs`

return {dds = dds}
