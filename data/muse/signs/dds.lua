---@meta

local  dds = {}

-- ID for a Muse role
-- dds.roleID(role: ":"):  `ID: #:`  <-
---@type fun(role: string):  ID: number  
function dds.roleID() end

-- roles:  `[ID]: ":"`
---@alias roles {[ID]: string} # Dictionary of Computercraft labels for MUSE roles keyed by Computercraft (string) IDs


-- IDs:  `[role]: ID`
---@alias IDs {[role]: ID} # Dictionary of ComputerCraft computer IDs keyed by MUSE role


-- ID:  `#:`
---@alias ID  number # ComputerCraft computer ID


-- role:  `":"`
---@alias role  string # ComputerCraft label as MUSE role


-- Label for a Muse role
-- dds.role(ID: ":"):  `role: ":"` <-
---@type fun(ID: string):  role: string 
function dds.role() end

-- Populates players IDs and labels using a MQ rednet protocol.
-- dds.hosts():  `IDs, roles` <-
---@type fun():  IDs,  roles 
function dds.hosts() end

-- Fix ID role association for next startup, id given by player.
-- dds.join(role: ":", id: #:?):  `sitedLabel: ":"` <-
---@type fun(role: string,  id: number?):  sitedLabel: string 
function dds.join() end

-- Returns associations from Muse roles to ComputerCraft IDs
-- dds.map():  `IDs` <-
---@type fun():  IDs 
function dds.map() end
return { dds =  dds}
