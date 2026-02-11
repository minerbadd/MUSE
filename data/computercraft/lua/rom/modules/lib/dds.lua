---@diagnostic disable: duplicate-set-field
--[[
## MUSE Distributed Discovery Service: lib/dds
```md
--:! {dds: [":"]: ():} <- **In-game (only) MUSE Discovery Service Library** -> muse/docs/lib/dds.md  
--:| dds: _Associates computer IDs with labels (as Muse roles) using Muse Query (MQ) rednet protocol._ -> dds
```
This module provides a library handling the mapping of numbers (ComputerCraft computer IDs) to names (ComputerCraft computer labels standing in for MUSE roles) with `dds.role` and back again with `dds.ID`. These are filled in in-game by a call to `lib/dds.hosts` during session startup by running <a href="../.start.html#dds" target="_blank"> `.start.lua` </a>. 

Some MUSE roles are native to a MUSE `site`. Unsited turtles in these `landed` roles will be given the player's site. 

The library provides the DDS facilities needed for remote calls. The DDS facilities only work in-game because the ComputerCraft network interfaces are not mocked. However, the library does export a default mapping and its support functions can be tested out-of-game.
```Lua
--]]

local ddss = require("signs.dds"); ddss.dds = {}; local dds = ddss.dds ---@module "signs.dds"

local cores = require("core"); local core = cores.core ---@module "signs.core"
local places = require("places"); local place = places.place ---@module "signs.places"

---@diagnostic disable-next-line: undefined-field
local rednet, parallel = _G.rednet, _G.parallel -- for static analysis

---@diagnostic disable-next-line: undefined-field
local player = _G.pocket -- only the player has the (only) pocket computer

--[[
```
The library deals with identity. As mentioned, this is in terms of the correspondence between roles and IDs. For _landed_ turtles, roles are _qualified_ by the _site_ where the landed turtle is found. Sometimes it's convenient to refer to a landed turtle without the qualifying site information. The `dds.ID` function supplies that as needed. Functions are provided for the player to `join` a newly hatched turtle to the network and once connected for it to persist its `qualified role` and its `site` in its local storage.
```Lua
--]]

_G.Muse.IDs = _G.Muse.IDs or -- for out-game 
--:> IDs: _Dictionary of ComputerCraft computer IDs keyed by MUSE role_ -> `[role]: ID`
--:> ID: _ComputerCraft computer ID_ -> `#:`
---@diagnostic disable-next-line: undefined-field
(_G.rednet and {} or {player = 0, porter = 1, rover = 5, miner = 6, logger = 7, farmer = 8}) 

_G.Muse.roles = _G.Muse.roles or -- for out-game
---@diagnostic disable-next-line: undefined-field
(_G.rednet and {} or {[0] = "player", [1] = "porter", [5] = "rover", [6] = "miner", [7] = "logger", [8] = "farmer"})
--:> roles: _Sparse array of Computercraft labels for MUSE roles indexed by Computercraft IDs_ -> `role[]`
--:> role: _ComputerCraft label as MUSE role (may be qualified by_ `site` _for landed turtles)_ -> `":"`

local IDs, roles, landed = _G.Muse.IDs, _G.Muse.roles, _G.Muse.landed

function dds.ID(role) --:: dds.roleID(role: ":") -> _ID for a Muse role (qualified if need be)_ -> `ID: #:` 
  local qualified = landed[role] and place.qualify(role) or role
  return IDs[qualified]
end

function dds.role(ID) return roles[ID] end --:: dds.role(ID: #:) ->  _Muse role (label) for a computer ID_ -> `role: ":"`

function dds.join(role, id) 
  --:: dds.join(role: ":", id: #:) -> _Qualify ID role association (label), id given by player._ -> `name: ":"`
  --:+ _On player to join a turtle to network and give it a role (and then over network through_ `lib/map` _to turtle)_
  local qualified = landed[role] and place.qualify(role) or role -- qualify landed
  IDs[qualified] = id; roles[id] = qualified   -- each site can have its own landed turtles
  return qualified 
end  

function dds.site(site) -- on turtle to site it (or player to change site)
  --:: dds.site(site: ":"?) -> _Write (new) site file, set site and return it_ -> sited: ":"
  local handle = assert(io.open(_G.Muse.data.."site.txt", "w"), "dds site: can't write site.txt")
  local sited = site or place.site(); handle:write(sited.."\n"); handle:close()
  return sited
end

function dds.qualify(site)
  --:: dds.qualify(site: ":"?) -> _Create site file (default current site) if needed, set site, return role_ -> `qualified: ":"`
  local role, handle = core.getComputerLabel(), io.open(_G.Muse.data.."site.txt", "r") 
  local sited = not handle and dds.site(site) or (handle and handle:read()) -- if no site file, write one
  place.site(sited); return place.qualify(role) 
end
--[[
```
<a id="request"></a> 
Te main work of the library creating relationships between labeled roles and computer IDs starts here. The player sends a `request` for MUSE roles (as ComputerCraft labels) to all computers registered as `MQ protocol hosts and gets a count of them. It's useful to keep in mind where (player or turtle) the work is being done at each step of this process.
```Lua
--]]

function dds.playerID(id) if id then _G.Muse.playerID = id end; return _G.Muse.playerID end
--:: dds.playerID(id: #:?) -> _Isolate global_ -> #:

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
  local id, playerSite = rednet.receive("MQ"); dds.playerID(assert(id, "dds respond: no id")) -- set global on remote responder
  assert(id and playerSite, "dds respond: id and player site not received")
  local qualified = dds.qualify(tostring(playerSite))
  core.report(1, "MQT "..id.." "..qualified); -- DDS Turtle now sited
  rednet.send(id, qualified, "MQ") -- need to send `count` messages 
end
--[[
```
<a id="receive"></a>
The player waits to `receive` each of the responses and populates two tables, `IDs` and `labels`, that provide a mapping between names and numbers and back again. When it has the full `count` of responses, the work of `dds.hosts` is done. 
```Lua
--]]
local function receive(count) -- on player for each DDS host
  for _ = 1, count do
    local ddsID, received = rednet.receive("MQ") -- next, deal with rednet send to self behavior
    local ddsLabel = (ddsID == dds.playerID()) and "player" or received -- player sends garbage to self
    assert(ddsID and ddsLabel, " dds receive: need id and label")
    IDs[ddsLabel] = ddsID; roles[ddsID] = ddsLabel -- **the point of it all**
    core.report(1, "MQ "..ddsID.." "..ddsLabel) -- DDS Player
    rednet.send(ddsID, "DDS OK on "..core.getComputerLabel(), "MS") -- to .status
  end 
end
--[[
```
<a id="hosts"></a> 
The `dds.hosts` function is the one that kicks off the interactions above between a player and other DDS hosts to populate a mapping between roles and computer IDs. The interactions begin by a <a href="#request"> request </a> for a count of computers registered with the `MQ` protocol. This was set up during session <a href="../.start.html" target="_blank"> startup </a>. The MQ registered computers <a href="#respond"> respond </a> with a message allowing a mapping between the turtle's computer ID and its label (its MUSE role). This is done by the <a href="#receive"> receive </a> function. The `parallel.waitForAny` function is called with an anonymous closure to `receive` a `count` of these messages.
```Lua
--]]
function dds.hosts() 
  --:: dds.hosts() -> _Populates players IDs and labels using a MQ rednet protocol._ -> `nil`
  print("Waiting on MQ"); if not player then print("Need pocket computer for DDS") end
  if not player then parallel.waitForAny(respond) 
  else local count = request(); print(tostring(count).." DDS hosts (expected?)")  -- player
    parallel.waitForAny(function() receive(count) end) -- wait to get all MQ host responses
    --IDs[core.getComputerLabel("player")] = core.getComputerID(0) -- the player has a label: "player" TODO: drop??
  end; 
end
--[[
```
<a id="map"></a> 
The table of associations between labels (MUSE roles) and ComputerCraft computer IDs established for the session is isolated by exporting a function that returns an iterator for the elements of the table.
```Lua
--]]
---@diagnostic disable-next-line: redundant-return-value
function dds.map() return pairs(IDs) end --:: dds.map() -> Iterator from Muse roles to ComputerCraft IDs_ -> `():`, `{:}, `nil`

return {dds = dds}
