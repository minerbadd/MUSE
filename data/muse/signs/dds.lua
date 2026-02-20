---@meta

local  dds = {}

-- ID for a Muse role (qualified if need be)
-- dds.roleID(role: ":"):  `ID: #:`  <-

---@type fun( role: string):   ID: number  
function dds.roleID() end

-- Isolate global
-- dds.playerID(id: #:?):  #: <-

---@type fun( id: number?):   number 
function dds.playerID() end

-- Write (new) site file, set new qualified IDs[role, set site and return it
-- dds.set(site: ":"?):  `role: ":"` <-

---@type fun( site: string?):   role: string 
function dds.set() end

-- roles:  `role[]`
---@alias roles  role[] # Sparse array of Computercraft labels for MUSE roles indexed by Computercraft IDs


-- IDs:  `[role]: ID`
---@alias IDs { [role]: ID } # Dictionary of ComputerCraft computer IDs keyed by MUSE role


-- ID:  `#:`
---@alias ID  number # ComputerCraft computer ID


-- role:  `":"`
---@alias role  string # ComputerCraft label as MUSE role (may be qualified by_ `site` _for landed turtles)


-- Muse role (label) for a computer ID
-- dds.role(id: #:):  `role: ":"` <-

---@type fun( id: number):   role: string 
function dds.role() end

-- Set site, return (qualified) role; only create site file (default current) if needed
-- dds.site(site: ":"):  `role: ":"` <-

---@type fun( site: string):   role: string 
function dds.site() end

-- Populates players IDs and labels using a MQ rednet protocol.
-- dds.hosts():  `nil` <-

---@type fun():  nil 
function dds.hosts() end

-- Sets (non-persistent) qualified ID role (label), id given by player. On player to join a turtle to network and give it a role (and then over network through_ `lib/map` _to turtle) Each site can have its own landed turtles with their own qualfied roles.
-- dds.join(role: ":", id: #:):  `role: ":"` <-

---@type fun( role: string,  id: number):   role: string 
function dds.join() end

-- Iterator from Muse roles to ComputerCraft IDs
-- dds.map():  `():`, `{:}, `nil` <-

---@type fun(): function,  table,  nil 
function dds.map() end
return { dds =  dds}
