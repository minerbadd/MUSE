
--[[
```
<a id="tests"></a>
#Doing the Tests
For regression tests
```Lua
--]]
package.path = _G.Muse.package

local core = require("core").core

local check = {}; local regression = _G.Muse.regression
local testSetTablePath, testSetName, testName = "", "", ""
local testPartResults, testSetTable, newTestSetTable = {}, {}, false

local function parameters(testSetTablePath, testSetName, testName) return testSetTablePath, testSetName, testName end
--local function parameters(...) return ... end

local function getTestSetTable(testSetTablePath, testSetName) -- returns testSetTable, newTestSetTable
  -- `testSetTable`: names of files in `testSetTablePath` directory keyed by `testName`
  local openedTestSetTable, failure = loadfile(testSetTablePath..testSetName)
  if openedTestSetTable then return openedTestSetTable(), false end -- testSetTable, newTestSetTable
  if regression and not openedTestSetTable then error("No test set results in "..testSetTablePath..", "..failure) end
  if not regression and not openedTestSetTable then return {}, true end -- testSetTable, newTestSetTable
end

local function getTestPartsResults(testSetTablePath, testSetTable, testName)
  -- `testPartsResults`:string values keyed by `partID` as string)
  local testPartsResultsPath = testSetTablePath..testSetTable[testName]
  local openedTestPartResults, failure = loadfile(testPartsResultsPath)
  if regression and not openedTestPartResults then 
    error("No results for "..testName.." in "..testPartsResultsPath..", "..failure) 
  end
  return openedTestPartResults() or {} -- testPartResults
end

local function open(testSetTablePath, testSetName, testName) -- `testSetTablePath` is e.g. <checks directory path>
  testSetTablePath, testSetName, testName = parameters(testSetTablePath, testSetName, testName)
  local testSetTable, newTestSetTable = getTestSetTable(testSetTablePath..testSetName)
  -- `testSetTable` keys are test names for which regression is valid in test set, values are names of files with test results
  return getTestPartsResults(testSetTablePath, testSetTable, testName), testSetTable, newTestSetTable -- testPartResults
end

function check.open(testSetTablePath, testSetName, testName) 
  testPartResults, testSetTable, newTestSetTable = open(testSetTablePath, testSetName, testName) 
end

function check.part(testName, partID, ...) -- at each part of the test
  local part = tostring(partID); local result, expected = core.string(...), testPartResults[part]
  if (regression and result ~= expected) then error(result.." ~= "..expected..", "..testName..":"..part) end
  if not regression then testPartResults[part] = result; print(result); return end
end

local function save(theTable, path)
  local serialized = core.serialize(theTable)
  local handle = assert(io.open(path, "w"), "Can't open "..path.." in check.lua")
  handle:write(serialized); handle:close()
end

function check.close(message) -- at end of test
  if regression then print(message); return end
  if newTestSetTable then save(testSetTable, testSetTablePath..testSetName) end
  save(testPartResults, testSetTablePath..testSetTable[testName])
end

function check.tests(testSetTablePath, testSetName) -- iterator of `testName` keys of `testSetTablePath` sorted by `testName`
  local testSetTable = getTestSetTable(testSetTablePath, testSetName)
  local tests, i = {}, 1; for testName in pairs(testSetTable) do tests[i] = testName; i = i + 1 end; table.sort(tests);
    local j, n = 0, #tests; return function () j = j + 1; if j <= n then return tests[j] end end  -- return iterator
  end

  return {check = check}