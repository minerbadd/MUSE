--[[
## Send Command to `rover`(Remote)
```md
--:? rom/help/rover.txt <- **Remote Command Line Interface for `rover`** -> muse/docs/programs/rover.md  
--:- rover command argument... -> _See <a href="../lib/net.html" target="_blank">/lib/net</a> for the remote command line interface._
```
```Lua
--]]
package.path = _G.Muse.package
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

local command, arguments = ..., {select(2, ...)} -- -- first, {rest}
--[[
```
There's <a href="https://riptutorial.com/lua/topic/4475/variadic-arguments" target="_blank"> a tutorial </a> on Lua's ... operator and its `select` function.
```Lua
-]]
local ops = {come = remote.come, tail = remote.tail, map = remote.map}
local op = ops[command] or remote.call; op("rover", command, arguments)
