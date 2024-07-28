--[[
## Create Booking: From Place Spanning Area To Place, Offering Items For Porting (Porter)
```md
--:? rom/help/book.txt <- **Muse Teleport with Command Computer to Named Place** -> muse/docs/programs/book.md  
```Lua
--]]

local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
remote.call("porter", "book", {...}) --:= book:
