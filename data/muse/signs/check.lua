---@meta

local  check = {}

-- Return iterator.
-- check.tests(testSetTablePath:":", testSetName:":"):  `(:)` <-
---@type fun(testSetTablePath:string,  testSetName:string):  function 
function check.tests() end

-- Return object(closure).
-- check.open(theTestSetTablePath:":", theTestSetName:":", theTestName:":"):  `:[part:(:), close:(:)]` <-
---@type fun(theTestSetTablePath:string,  theTestSetName:string,  theTestName:string):  :[part:function,  close:function] 
function check.open() end
return { check =  check}
