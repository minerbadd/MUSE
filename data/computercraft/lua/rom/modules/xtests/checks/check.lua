
--[[
```
<a id="tests"></a>
#Doing the Tests
For regression tests
```Lua
--]]

function check.regression(checkfile)
-- load checks file
-- sort test table in checks file
-- load and run each test in turn (core.test)
-- report testname to start, "ok" if correct
-- catch any thown errors and raise regression failed exception
end

function check.test(testsDirectory, checkFileName, testFileName)
  -- load test from tests 

  -- 
end

function check.checkSet(checkResults, testName, testResult)
  -- lookup checkResult for testName
  
end

function check.checkGet(checkResults, testName, testResult)
  -- lookup checkResult for testName
  
end
