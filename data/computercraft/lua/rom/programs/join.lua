--[[
## Command to Join MQ with Role (Label) and Player's Site (on Player)
```md
--:? rom/help/join.txt <- **Join Command Line Interface** -> muse/docs/programs/join.md  
--:- join id role ?site -> _Join nameplate id'd turtle to network with specified role and site._
```Lua
--]]
local maps = require("map"); local map = maps.map ---@module "signs.map"
local ddss = require("ddsa"); local dds = ddss.dds ---@module "signs.dds"
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"


local role, id, site = ...; --:- join  -> _Temporarily set mapping for next startup, id from turtle nameplate._
local name = dds.join(role, tonumber(id), site) -- on player as, e.g., `join rover` 3 or `join farmer 4 baylands`
remote.call(name, "fix", {}) -- `lib/map` makes turtle dance and sets its situation using gps
print("Need to sync map?")

