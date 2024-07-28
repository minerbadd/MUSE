--[[
##Updates Place Memory and Storage on `MU` Receive 
```md
--:~ parallelWaitForAny(update) <- **MU Broadcast Handler Daemon to Update `place` Entries** -> muse/docs/daemons/.update.md  
```
```Lua
--]]
---@diagnostic disable-next-line: undefined-field
local rednet, parallel = _G.rednet, _G.parallel

local cores = require("core"); local core = cores.core ---@module "signs.core"
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.core"
local maps = require("map"); local map = maps.map ---@module "signs.core"

local function update()
  while true do local id, message = rednet.receive("MU"); 
    core.report(3, ".update", "MU from "..dds.role(id))
    map.place(message); map.update(message); 
    -- update pocket/turtle local map and persistent map
  end
end

parallel.waitForAny(update)