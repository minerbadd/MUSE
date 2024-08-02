--[[
##Create Point At Player Position (Local)
```md
--:? rom/help/point.txt <- **Point Command Line Interface** -> muse/docs/programs/point.md  
```
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"

print(core.string(map.op({"point", ...}))) --:= point: 
