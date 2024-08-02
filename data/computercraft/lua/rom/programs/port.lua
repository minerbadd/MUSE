--[[
##Use Booking *Created With `book` Command to Do Teleport Operation, Paying With Player Inventory (Porter)
```md
--:? rom/help/port.txt <- **Muse Teleport with Command Computer to Named Place** -> muse/docs/programs/port.md  
```Lua
--]]
package.path = _G.Muse.package
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
remote.call("porter", "port", {...}) --:= port: 

