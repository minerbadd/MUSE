---@meta

local  check = {}

-- Run ordered test names for regression.
-- check.regression(testOrder: ":"[]):  `":"[]` <-

---@type fun( testOrder: string[]):   string[]
function check.regression() end

-- Return object(closure)
-- check.open(testName:":", text: ":"):  `{part:():, message:(): , close:():}`  <-

---@type fun( testName:string,  text: string):  { part: function,  message: function,  close: function}
function check.open() end
return { check =  check}
