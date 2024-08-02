--[[
## Commands `roamer` to come to `player` (Local and Remote)
```md
--:? rom/help/come.txt <- **Remote Come Command Line Interface** for `roamer` -> muse/docs/programs/come.md  
--:- come -> _rover turtle towards GPS player position._
```
```Lua
--]]
package.path = _G.Muse.package
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"
remote.come("rover")
