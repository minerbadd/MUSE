--[[
## Command to Join MQ with Role (Label) and Player's Site (on Player)
```md
--:? rom/help/join.txt <- **Join Command Line Interface** -> muse/docs/programs/join.md  
--:- join id role ?site -> _Join nameplate id'd turtle to network with specified role and site._
```Lua
--]]
local ddss = require("ddsa"); local dds = ddss.dds ---@module "signs.dds"
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

local role, id, siting = ...; --:- join  -> _Temporarily set mapping for next startup, id from turtle nameplate._
local qualified = dds.join(role, tonumber(id)) -- on player as, e.g., `join rover` 3 or `join farmer 4 baylands`
local message = remote.call(qualified, "join", {qualified, id, siting}) 
-- `lib/map` call makes turtle dance and sets its situation using gps
print(message)
print("Need to sync map?")

