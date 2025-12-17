---@meta

local  check = {}

-- Return ordered test names for regression.
-- check.tests(testOrder:[], testSetTablePath:":", testSetName:":"):  `":"[]` <-
---@type fun(testOrder:[],  testSetTablePath:string,  testSetName:string):  string[]
function check.tests() end

-- Return object(closure)
-- check.open(theTestSetTablePath:":", theTestSetName:":", theTestName:":"):  `:[part:(:), close:(:)]:` <-
---@type fun(theTestSetTablePath:string,  theTestSetName:string,  theTestName:string):  :[part:function,  close:function]: 
function check.open() end
return { check =  check}
