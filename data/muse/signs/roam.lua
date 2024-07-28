---@meta

local  roam = {}

-- Move turtle:
-- roam.op(arguments: ":"[]):  `":" &:` <-
---@type fun(arguments: string[]):  string 
function roam.op() end

-- Server side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come.
-- roam.come(:xyz:):  `":" &:` <-
---@type fun(xyz: xyz):  string 
function roam.come() end

-- Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)
-- roam.tail(:xyz:):  `":" &:` <-
---@type fun(xyz: xyz):  string 
function roam.tail() end
return { roam =  roam}
