--[[
## Command to Set or Get Local Site (Local)
```md
--:? rom/help/site.txt <- **Command Line Interface for** `site` -> muse/docs/programs/site.md  
```
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"

print(core.string(map.op({"site", ...}))) --:= site:

