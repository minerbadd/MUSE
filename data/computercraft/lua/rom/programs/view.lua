--[[
## Command to View Map Entry Details (Local)
```md
--:? rom/help/view.txt <- **View Command Line Interface** -> muse/docs/programs/view.md  
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"

print(core.string(map.op({"view", ...}))) --:= view:
