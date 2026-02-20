--[[
## Command to Join MQ with Role (Label) and Player's Site (on Player) and on Turtle
```md
--:? rom/help/join.txt <- **Join Command Line Interface** -> muse/docs/programs/join.md  
--:- join role id ?site -> _Join nameplate id'd turtle to network with specified role and site._
```Lua
--]]
local ddss = require("ddsa"); local dds = ddss.dds ---@module "signs.dds"
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

local role, id, siting = ...; --:- join  -> _Set network mapping with id from turtle nameplate, update turtle_
local qrole = dds.join(role, tonumber(id)) -- on player as, e.g., `join rover` 3 or `join farmer 4 baylands`
local message = remote.call(qrole, "join", {qrole, id, siting}) -- `dds.join` connected turtle to network
--:# `lib/map` **call over network persists site on turtle then makes turtle dance and sets its situation using gps**
print(message)
print("Need to sync map?")

