---@meta

local  grid = {}

-- grid.guide:  `[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias grid.guide  [ look: grid.cut,  dig: grid.cut[],  lookMore: grid.cut,  digMore: grid.cut[] # Instructions for cut


-- grid.cut:  `"up"|"down"|"north"|"south"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias grid.cut  "up"|"down"|"north"|"south" # Directions to dig in vein


-- crossplan:  `{:bores:, ores: {name: ":", fixtures: ":"[], path: ":"[], work: plan.work} }`
---@alias crossplan  {bores: bores,  ores: {name: string,  fixtures: string[] # Bore and mine, minimal movement


-- Extract ores. Given the guide for a vein, mine ores in each of the guide's cuts for that vein.
-- grid.ores(:plan:, :direction:, guide: grid.guide, :ores:):  `"done" &!` <-
---@type fun(plan: plan,  direction: direction,  guide: grid.guide,  ores: ores):  "done" 
function grid.ores() end
return { grid =  grid}
