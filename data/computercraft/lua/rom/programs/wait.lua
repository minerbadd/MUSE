--[[
## Command Establish Wait for Rednet (Local on Turtle)
```md
--:? rom/help/wait.txt <- **Rednet Message Wait Command Line Interface** -> muse/docs/programs/wait.md  
--:- wait -> _Locally on turtle, wait for rednet message. Useful as recovery for uncaught turtle error._  
```Lua
--]]
local remotes = require("remote"); local remote = remotes.remote ---@module "signs.remote"

print("Waiting for rednet"); remote.wait()