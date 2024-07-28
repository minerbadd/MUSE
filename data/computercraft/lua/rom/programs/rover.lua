--[[
## Send Command to `rover`(Remote)
```md
--:? rom/help/rover.txt <- **Remote Command Line Interface for `rover`** -> muse/docs/programs/rover.md  
--:- rover command argument... -> _See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface._
```
```Lua
--]]
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

local command, arguments = ..., {select(2, ...)} -- -- first, {rest}
--[[
```
There's <a href="https://riptutorial.com/lua/topic/4475/variadic-arguments" target="_blank"> a tutorial </a> on Lua's ... operator and its `select` function.
```Lua
-]]
local ops = {come = remote.come, tail = remote.tail, map = remote.map}
local op = ops[command] or remote.call; op("rover", command, arguments)
