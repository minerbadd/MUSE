--[[
## Command To Erase A Place From Map (Local)
```md
--:? rom/help/erase.txt <- **Erase Command Line Interface** -> muse/docs/programs/erase.md  
```
```Lua
--]]
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map

print(core.string(map.op({"erase", ...}))) --:= erase:


