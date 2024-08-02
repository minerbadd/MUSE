--[[
## Align MUSE Coordinates with Minecraft's for GPS Launch (Porter)
```md
--:? rom/help/locate.txt <- **Dead reckoning `point` for turtle on `porter` as Minecraft coordinates** -> muse/docs/programs/locate.md  
```Lua
--]]
package.path = _G.Muse.package
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
remote.call("porter", "locate", {...}) --:= locate:
