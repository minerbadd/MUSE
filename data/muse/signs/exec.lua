---@meta

local  exec = {}

-- CLI for Command Computer commands
-- exec.op(commandLine: :[command: ":", ...]: ):  `":" &:` <-
---@type fun(commandLine: {[ string,  ...]: }):  string 
function exec.op() end
return { exec =  exec}
