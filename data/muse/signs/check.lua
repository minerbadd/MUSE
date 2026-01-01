---@meta

local  check = {}

-- Return object(closure)
-- check.open(testName:":", text: ":"):  `{part:():, close:():}`  <-

---@type fun( testName:string,  text: string):  { part: function,  close: function}
function check.open() end

-- Run ordered test names for regression.
-- check.all(testOrder: ":"[]):  `":"[]` <-

---@type fun( testOrder: string[]):   string[]
function check.all() end
return { check =  check}
