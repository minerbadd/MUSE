--[[
##Erases Local Place Name Entry On `MX` Receive
```md
--:~ parallelWaitForAny() <- **MX Broadcast Handler Daemon to Clear Named Place** -> muse/docs/daemons/.erase.md  
--:+ _Receives `name` of a place and calls `map.op{"erase", name: ":"}` on receiving turtle._  
```
```Lua
--]]

---@diagnostic disable-next-line: undefined-field
local rednet, parallel = _G.rednet, _G.parallel

local cores = require("core"); local core = cores.core ---@module "signs.core"
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.dds"
local maps = require("map"); local map = maps.map ---@module "signs.map"

local function erase()
  while true do local id, name = rednet.receive("MX"); 
    core.status(3, ".erase", "MX", name, " from ", dds.role(id))
    map.erase(name); -- erase pocket/turtle/command local storage for place name
  end
end

parallel.waitForAny(erase)