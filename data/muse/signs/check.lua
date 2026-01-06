---@meta

local  check = {}

-- Run ordered test (names) for regression.
-- check.regression(testOrder: ":"[]):  `nil` <-

---@type fun( testOrder: string[]):   nil 
function check.regression() end

-- Return `check` object(closure)
-- check.open(testName:":", text: ":"):  `{part:():, message:():, close:():}`  <-

---@type fun( testName:string,  text: string):  { part: function,  message: function,  close: function}
function check.open() end
return { check =  check}
