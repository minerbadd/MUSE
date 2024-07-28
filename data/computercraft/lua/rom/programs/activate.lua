--[[
## Activate Within Borders Using /forceload (with Porter)
```md
--:? rom/help/activate.txt <- Command Computer /forceload Activation of Bounds -> muse/docs/programs/activate.md  
```Lua
--]]

local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

remote.call("porter", "activate", {...}) --:= activate:
