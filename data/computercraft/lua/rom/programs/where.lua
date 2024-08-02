--[[
## Command to Report Player Whereabouts and Movement Direction (Local)
```md
--:? rom/help/where.txt <- **Where Am I Command Line Interface** -> muse/docs/programs/where.md  
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"


print(core.string(map.op({"where", ...}))) --:= where:
