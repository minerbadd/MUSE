---@meta

local  worker = {}

-- Do plan. Attempt recovery for_ `blocked` _or_ `lost` _conditions; raise error for_ `empty` _or_ `bedrock` _or if recovery fails.
-- worker.execute(plan, pathOperations, fuelOK: ^:, pathDistance: #:):   `"done", report: ":" &: &!` <-

---@type fun(plan,  pathOperations,  fuelOK: boolean,  pathDistance: number):   "done",  report: string 
function worker.execute() end
return { worker =  worker}
