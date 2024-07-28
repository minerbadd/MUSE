---@meta

local  gps, _gps = {}, {}

-- Command Line Interface.
-- gps.op(commands: {command: ":"[] }):  `report: ":"` &: <-
---@type fun(commands: {command: string[]}):  report: string 
function gps.op() end

-- Assemble parts.
-- _gps.equip(commands: :[command: ":", direction: facing]):  ":" <-
---@type fun(commands: [string, facing]):  string 
function _gps.equip() end

-- Move to boot a GPS host and retrieve floppy.
-- _gps.actuate(commands: :[command: ":", direction: facing]):  ":" <-
---@type fun(commands: [string, facing]):  string 
function _gps.actuate() end

-- Check before journey then launch.
-- _gps.launch(commands: :[command: ":", location: ":", yD: #:?]):  ":" <-
---@type fun(commands: [string, string, number?]):  string 
function _gps.launch() end
return { gps =  gps, _gps = _gps}
