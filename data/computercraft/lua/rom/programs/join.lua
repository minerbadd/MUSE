--[[
## Command to Join MQ with Role (Label) and Player's Site (on Player)
```md
--:? rom/help/join.txt <- **Join Command Line Interface** -> muse/docs/programs/join.md  
```Lua
--]]
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.dds"
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
local places = require("places"); local place = places.place ---@module "signs.places"

local role, id = ...; --:- join role id -> _Temporarily set mapping for next startup, id from turtle nameplate._
print (dds.join(role, tonumber(id)).." joining") -- on player
print(remote.call(role, "join", {place.site(), role}).." joined")
print("Need to sync map?")

