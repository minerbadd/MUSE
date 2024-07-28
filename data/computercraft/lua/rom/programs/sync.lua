--[[
## Command to Sync Distributed Maps (Local and `MU` Remote)
```md
--:? rom/help/sync.txt <- **Sync Command Line Interface** -> muse/docs/programs/sync.md  
```Lua
--]]
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"


print(core.string(map.op({"sync", ...}))) --:= sync:
