--[[
##Create Range On Player Pocket Computer (Local)
```md
--:? rom/help/range.txt <- **Range Command Line Interface** -> muse/docs/programs/range.md  
```
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"


print(core.string(map.op({"range", ...}))) --:= range:
