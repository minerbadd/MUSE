---@meta

local  launch, _launch = {}, {}

-- Command Line Interface.
-- launch.op(commands: ":"[]):  `report: ":"` &: <-

---@type fun( commands: string[]):   report: string 
function launch.op() end

-- Assemble parts.
-- _launch.equip(direction: facing):  ":" <-

---@type fun( direction: facing):   string 
function _launch.equip() end

-- Move to boot a GPS host and retrieve floppy.
-- _launch.actuate(commands: [command: ":", direction: facing]):  ":" <-

---@type fun( commands: [  string,   facing]):   string 
function _launch.actuate() end

-- Check before journey then launch.
-- _launch.launch(commands: [command: ":", location: ":", yD: #:?]):  ":" <-

---@type fun( commands: [  string,   string,   number?]):   string 
function _launch.launch() end
return { launch =  launch, _launch = _launch}
