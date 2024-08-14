--[[
## Send Command to `miner`(Remote)
```md
--:? rom/help/miner.txt <- **Remote Operations for Muse Miner** -> muse/docs/programs/miner.md  
--:- miner command argument... -> _See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface._
```
There's <a href="https://riptutorial.com/lua/topic/4475/variadic-arguments" target="_blank"> a tutorial </a> on Lua's ... operator and its `select` function.
```Lua
--]]
package.path = _G.Muse.package
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

local command, arguments = ..., {select(2, ...)}
local ops = {come = remote.come, tail = remote.tail}

local op = ops[command] or remote.call; op("miner", command, arguments)

