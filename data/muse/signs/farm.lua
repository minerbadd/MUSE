---@meta

local  farm = {}

-- farmOpName:  `"quarry"|"layer"|"cover"|"finish"|"fence"|"harvest"|"path"|"test"`
---@alias farmOpName  "quarry"|"layer"|"cover"|"finish"|"fence"|"harvest"|"path"|"test" # Specifies operation on field


-- Remove, put. Returns a function used by `lib/worker` to inspect aimed direction, farm out any removeable, replace with found item. The direction of movement parameter in that function is used to reface turtle after replacement.
-- farm.replacer(putAim: direction, item: ":"[]|":", removables: ":"[]):  `(_:, :direction:): ":" &!`  <-

---@type fun(putAim: direction,  item: string[]|string,  removables: string[]): fun(any,  direction: direction):  string 
function farm.replacer() end

-- Logs down and sides, plants found seedlings.
-- farm.logs(seedlings: ":"[], :direction:):  `report: ":" &!` <-

---@type fun(seedlings: string[],  direction: direction):  report: string 
function farm.logs() end

-- Puts found item in aimed direction.
-- farm.put(putAim: direction, item: ":"[]|":"):   `report: ":" &!` <-

---@type fun(putAim: direction,  item: string[]|string):   report: string 
function farm.put() end

-- Tills and plants found planting.
-- farm.plant(planting: ":"):  `report: ":" &!`  <-

---@type fun(planting: string):  report: string 
function farm.plant() end
return { farm =  farm}
