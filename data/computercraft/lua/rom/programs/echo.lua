--[[
## Command To Check`If Anything Is Working (Local)
```md
---:? rom/help/echo.txt <- **Echo Command Line Interface** -> muse/docs/programs/echo.md  
```
```Lua
--]]
package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
print(core.echo(...)) --:= echo:

--[[
##
```md

```
```Lua
--]]
