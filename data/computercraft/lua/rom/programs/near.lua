--[[
##Report Places Within Span Of Player (Local)
```md
--:? rom/help/near.txt <- **Near Command Line Interface** -> muse/docs/programs/near.md  
```
```Lua
--]]

local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"

print(core.string(map.op({"near", ...}))) --:= near:

