---@meta

local  planner, plan, moves, steps = {}, {}, {}, {}

-- plan.fixtures:  `":"[]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias plan.fixtures  string[] # for placement as specified by path elements beginning with a digit


-- Parse marker name into parts.
-- planner.mark(markerName: ":"):  `shaft: ":"?, level: ":"?, tag: ":"?)` <-

---@type fun(markerName: string):  shaft: string?,  level: string?,  tag: string?) 
function planner.mark() end

-- markElement:  `[op: "mark", :marking:]`
---@alias markElement  [op: "mark", marking: marking] # Current situation in named places


-- putElement:  `:[op: "put", direction: ":", fixture: ":"]`
---@alias putElement  : [ "put",  string,  string] # Put fixture in specified direction


-- plan:  `{name: plan.name, path: plan.path, work: plan.work, fixtures: plan.fixtures, mark: plan.mark}`
---@alias plan {name: plan.name,  path: plan.path,  work: plan.work,  fixtures: plan.fixtures,  mark: plan.mark} # How to do work


-- plan.work:  `(:plan:, direction: ":"): ":"?`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias plan.work fun(plan: plan,  direction: string):  string? # for execution at every_ `step` _iteration in plan movement direction


-- plan.name:  `":"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias plan.name  string # for status and error reporting


-- Create path operations table for plan.
-- planner.make(plan:plan):  `pathElements, fuelOK: ^:, pathDistance: #:` <-

---@type fun(plan:plan):  pathElements,  fuelOK: boolean,  pathDistance: number 
function planner.make() end

-- Instantiates what is returned from a plan file.
-- planner.load(planFileName: ":"):  `plan &!`  <-

---@type fun(planFileName: string):  plan 
function planner.load() end

-- markings:  `[label: ":"]: marking`
---@alias markings { [ string]: marking } # dictionary of markings keyed by a label


-- pathElements:  `(stepElement|putElement|markElement)[]`
---@alias pathElements  (stepElement|putElement|markElement)[] # Used by `worker.execute` to run plan


-- stepElement:  `:[op: "step", :stepping:, direction: ":", distance: #:]`
---@alias stepElement  : [ "step",  stepping,  string,  number] # Iterate steps function in direction for distance


-- plan.path:  `":"[]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias plan.path  string[] # table of space separated character sequence strings describing path


-- marking:  `:[prefix: ":", base: ":", label: ":"]`
---@alias marking  : [ string,  string,  string] # literals table of marker parts


-- plan.mark:  `(:plan:, :marking:): markerName: ":", label: ":", report: ":"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias plan.mark fun(plan: plan,  marking: marking):  markerName: string,  label: string,  report: string # for execution as specified by_ `plan.path` _markers

return { planner =  planner, plan = plan, moves = moves, steps = steps}
