--[[
## Send Command to `porter`(Remote)
```md
--:? rom/help/porter.txt <- **Remote Operations for Muse porter** -> muse/docs/programs/porter.md  
--:- porter command argument... -> _See <a href="../lib/net.html" target="_blank">/lib/net</a> for the remote command line interface._
```
There's <a href="https://riptutorial.com/lua/topic/4475/variadic-arguments" target="_blank"> a tutorial </a> on Lua's ... operator and its `select` function.
```Lua
--]]
package.path = _G.Muse.package
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

local command, arguments = ..., {select(2, ...)} -- first, {rest}
remote.call("porter", command, arguments)
