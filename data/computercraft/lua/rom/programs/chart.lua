--[[
## Command To Create Chart, Running Chart File (Local)
```md
--:? rom/help/chart.txt <- **Chart Command Line Interface** -> muse/docs/programs/chart.md  
```
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"

print(core.string(map.op({"chart", ...}))) --:= chart:


