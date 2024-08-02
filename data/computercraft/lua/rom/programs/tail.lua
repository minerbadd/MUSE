--[[
## Command to Tail `player` with `rover` (Local and Remote)
```md
--:? rom/help/tail.txt <- **Remote `rover` Tail Command Line Interface** -> muse/docs/programs/tail.md 
--:- tail rate? -> _Move `rover` every rate (default 5) seconds towards GPS player position._
```Lua
--]]
package.path = _G.Muse.package
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
local rates = ... -- optional as string; tonumber in remote.tail; default 0.5 seconds
remote.tail("rover", "tail", rates)
