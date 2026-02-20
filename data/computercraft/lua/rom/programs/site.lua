--[[
## Command to Set or Get Local Site (Local)
```md
--:? rom/help/site.txt <- **Command Line Interface (on player) for** `site` -> muse/docs/programs/site.md  
```
```Lua
--]]
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"

print(core.string(map.op({"site", ...}))) --:= site:

