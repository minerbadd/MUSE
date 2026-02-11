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

-- roles:  `role[]`
---@alias roles  role[] # Sparse array of Computercraft labels for MUSE roles indexed by Computercraft IDs


-- IDs:  `[role]: ID`
---@alias IDs { [role]: ID } # Dictionary of ComputerCraft computer IDs keyed by MUSE role


-- Write (new) site file, set site and return it
-- dds.site(site: ":"?):  sited: ":" <-

---@type fun( site: string?):   sited: string 
function dds.site() end

-- ID:  `#:`
---@alias ID  number # ComputerCraft computer ID


-- role:  `":"`
---@alias role  string # ComputerCraft label as MUSE role (may be qualified by_ `site` _for landed turtles)


-- Muse role (label) for a computer ID
-- dds.role(ID: #:):  `role: ":"` <-

---@type fun( ID: number):   role: string 
function dds.role() end

-- Create site file (default current site) if needed, set site, return role
-- dds.qualify(site: ":"?):  `qualified: ":"` <-

---@type fun( site: string?):   qualified: string 
function dds.qualify() end

-- Populates players IDs and labels using a MQ rednet protocol.
-- dds.hosts():  `nil` <-

---@type fun():  nil 
function dds.hosts() end

-- Qualify ID role association (label), id given by player. On player to join a turtle to network and give it a role (and then over network through_ `lib/map` _to turtle)
-- dds.join(role: ":", id: #:):  `name: ":"` <-

---@type fun( role: string,  id: number):   name: string 
function dds.join() end

-- Iterator from Muse roles to ComputerCraft IDs
-- dds.map():  `():`, `{:}, `nil` <-

---@type fun(): function,  table,  nil 
function dds.map() end
return { dds =  dds}
