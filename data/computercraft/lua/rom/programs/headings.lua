--[[
## Report direction of movement, location, distance from named place, nearby places (Local)
```md
--:? rom/help/headings.txt <- **Headings Command Line Interface** -> muse/docs/programs/headings.md  
```
```Lua
--]]
local cores = require("core"); local core = cores.core ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.map"

print(core.string(map.op({"headings", ...}))) --:= headings:
