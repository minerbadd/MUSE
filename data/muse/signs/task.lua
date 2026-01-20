---@meta

local  task, _task = {}, {}

-- _task.puts:  `[direction: ":", distance: #:, puttings: ":"[] ]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias _task.puts [  string,   number,   string[]] # Common arguments


-- Execute tasks for low level turtle operations:
-- task.op(commands: [ op: ":", arguments: ":"[] ] ):  `":" &:` <-

---@type fun( commands: [   string,   string[]]):   string 
function task.op() end

-- Tasks
-- _task.doTask(arguments: _task.puts, op: ():, clear: ^:, fill?: ":", targets?: ":"[]):  ":" &!` <-

---@type fun( arguments: _task.puts,  op: function,  clear: boolean,  fill?: string,  targets?: string[]):   string 
function _task.doTask() end
return { task =  task, _task = _task}
