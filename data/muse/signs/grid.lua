---@meta

local  grid = {}

-- grid.guide:  `:[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias grid.guide [grid.cut, grid.cut[], grid.cut, grid.cut[]] # Instructions for cut


-- crossplan:  `{:bores:, ores: {name: ":", fixtures: ":"[], path: ":"[], work: plan.work} }`
---@alias crossplan {bores: bores,  ores: {name: string,  fixtures: string[],  path: string[],  work: plan.work}} # Bore and mine, minimal movement


-- grid.cut:  `"up"|"down"|"north"|"south"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias grid.cut  "up"|"down"|"north"|"south" # Directions to dig in vein


-- Extract ores. Given the guide for a vein, mine ores in each of the guide's cuts for that vein.
-- grid.ores(:plan:, :direction:, guide: grid.guide, :ores:):  `"done" &!` <-
---@type fun(plan: plan,  direction: direction,  guide: grid.guide,  ores: ores):  "done" 
function grid.ores() end

-- Make place name, report result. Called by `worker.execute` to make marker name and use it to add map point for navigation in mine. Puts plan name value in marker (keyed by `"shaft"` or `"bore"`) so marker is enough for navigating in shaft or bore. Marker place name formed as `head:level:base` or `head:base` or `head` with place labelled as `"outer"|"inner"|"shaft"`.
-- grid.mark(:plan:, :marking:):  `markerName: ":", label: ":", report: ":"` <-
---@type fun(plan: plan,  marking: marking):  markerName: string,  label: string,  report: string 
function grid.mark() end
return { grid =  grid}
