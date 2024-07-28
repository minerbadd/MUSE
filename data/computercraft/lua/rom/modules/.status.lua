--[[
## Reports and Records Status Message On `MS` Receive
```md
--:~ parallelWaitForAny(status) <- **MS Broadcast Handler Daemon Prints and Records Status** ->  muse/docs/daemons/.status.md  
```
```Lua
--]]
---@diagnostic disable-next-line: undefined-field
local rednet, parallel = _G.rednet, _G.parallel

local cores = require("core"); local core = cores.core ---@module "signs.core"
local ddss =  require("dds"); local dds = ddss.dds ---@module "signs.dds"

local function status()
  while true do local id, message = rednet.receive("MS"); 
    local taggedMessage = dds.role(id).."> "..message; print(taggedMessage)
    core.record(taggedMessage) 
  end
end

parallel.waitForAny(status)


