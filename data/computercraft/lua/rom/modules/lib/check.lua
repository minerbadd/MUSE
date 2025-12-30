--[[
#Setup Test Configuration for Doing the Tests with Regression Testing: lib/check
```md
--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check
```Lua
--]]

_G.Muse = _G.Muse or {}; _G.Muse.path = "rom/modules/"

local core = require("core").core ---@module "signs.core"
local check = {}; ---@module "signs.check"  

local here = _G.Muse.path.."tests/" -- arg[0]:match('.*[/\\]') -- path to executable calling this library
_G.Muse.data = here.."data/"  -- for test environment separate from game environment
_G.Muse.checks = here.."checks/" -- assumes tests directory structure so: `tests/checks`
_G.Muse.tests = "muse" -- regression suite (file in `tests/checks` holding names of tests with expected values)
_G.Muse.regression = false -- set true by running `tests/.regression`

--:# _Set Configuration Variables for tests: landed turtles, default site, tracking, delays, turtle `data` directory_
_G.Muse.landed = {farmer = true, logger = true, miner = true,} -- roles of turtles local to each site
_G.Muse.IDs, _G.Muse.roles, _G.Muse.defaultSite = {}, {}, "base" -- with `site` program
_G.Muse.tracking = {limit = 500, enabled = false}
_G.Muse.delays = {gps = 1, dds = 3, map = 5} -- for game setup before running dds
_G.Muse.slots = 16 -- in turtle inventory (just to avoid a magic number in libraries)
_G.Muse.attempts = 5 -- `lib/turtle` attempts to remove a blockage
_G.Muse.rates = {}; _G.Muse.rates.headings = 5; _G.Muse.rates.tail = 0.5
_G.Muse.permutations = {"y", "z", "x"} -- controlling axes order in permutations
-- {"y", "z", "x"} -> z x y, x z y, x y z, y x z, z y x, y z x
-- {"x", "y", "z"} -> y z x, z y x, z x y, x z y, y x z, x y z
--[[
```
<a id="tests"></a>
There's not much here. Just a way with `check.open` to create a `check` object with the context needed to save results by the `part` operation for each part of a given test. Those _expected_ results are compared with actuals during a regression validation. There's a cleanup operation to `close` the opened `check` object. Finally, `check.tests` is provides the file names of tests in a specified order for which there are _expected_ values for regression testing.

_(The code illustrates <a href="https://wiki.c2.com/?ClosuresAndObjectsAreEquivalent" target="_blank"> `poor man's objects`</a>. This link dumps you into a theory heavy digression. Go there when you're ready for that.)_

For MUSE, all this is enabled by files in a specified `checks` directory. Here's how that's structured. One file there, the `testSetName` in the `testSetTablePath` directory instantiates (when loaded) as a table keyed by names of test files. The keyed values are names of results files. These are found at the `testPartsResultsPath` (in the `testSetTablePath` directory) for the given test. The results files instantiate when loaded as tables of result strings keyed by part identifiers (as strings) in the test.
```Lua
--]]
local function save(theTable, path) -- utility
  local serialized = core.serialize(theTable)
  local handle = assert(io.open(path, "w"), "Can't open "..path.." in check.lua")
  handle:write(serialized); handle:close()
end

local function getTestSetTable(testSetTablePath, testSetName) -- returns testSetTable: , newTestSetTable: boolean
  -- `testSetTable`: `testName` keyed names of files with expected results for regressions in `testSetTablePath` directory
  local openedTestSetTable, failure = loadfile(testSetTablePath..testSetName)
  if openedTestSetTable then return openedTestSetTable(), false end -- testSetTable, newTestSetTable
  if _G.Muse.regression and not openedTestSetTable then error("No test set results in "..testSetTablePath..", "..failure) end
  if not _G.Muse.regression and not openedTestSetTable then return {}, true end -- testSetTable, newTestSetTable
end

local function getTestPartsResults(testSetTablePath, testSetTable, testName)
  -- `testPartsResults`:expected values (as strings) for regression keyed by `partID` of test (as string)
  local testPartsResultsPath = testSetTablePath..testSetTable[testName]
  local openedTestPartResults, failure = loadfile(testPartsResultsPath)
  if _G.Muse.regression and not openedTestPartResults then -- no expected results file for test!
    error("No results for "..testName.." in "..testPartsResultsPath..", "..failure) 
  end
  return not openedTestPartResults and {} or openedTestPartResults() -- testPartResults
end

local function open(testSetTablePath, testSetName, testName, text) -- `testSetTablePath` is e.g. <checks directory path>
  print(text); local testSetTable, newTestSetTable = getTestSetTable(testSetTablePath..testSetName)
  -- `testSetTable` keys are test names for which regression is valid in test set, values are names of files with test results
  return getTestPartsResults(testSetTablePath, testSetTable, testName), testSetTable, newTestSetTable -- testPartResults, ...
end

-- poor man's object.... encapsulates but no inheritance (didn't see the need to go there)
function check.open(theTestSetTablePath, theTestSetName, theTestName) -- create check object with context variables
  --:: check.open(theTestSetTablePath:":", theTestSetName:":", theTestName:":") -> _Return object(closure)_ -> `{part:():, close:():}`
  local testPartResults, testSetTable, newTestSetTable = open(theTestSetTablePath, theTestSetName, theTestName) 
  local this = { -- context (instance) variables, each check object is independent in itself
    testPartResults = testPartResults, testSetTable = testSetTable, newTestSetTable = newTestSetTable,
    testSetTablePath = theTestSetTablePath, testSetName = theTestSetName, testName = theTestName
  } -- following are the access functions for the `check` object

  local function part(testName, partID, note, ...) -- at each part of the test
    local partName = tostring(partID); local result, expected = core.string(...), this.testPartResults[partName]
    if (_G.Muse.regression and result ~= expected) then error(result.." ~= "..expected..", "..this.testName..":"..partName) end
    if not _G.Muse.regression then this.testPartResults[partName] = result; print(result); return end -- save for regression
  end

  local function close(text) -- at end of test
    if _G.Muse.regression then print(text); return end
    if this.newTestSetTable then save(this.testSetTable, this.testSetTablePath..this.testSetName) end
    save(this.testPartResults, this.testSetTablePath..this.testSetTable[this.testName])
    this = nil -- free up now for GC
  end

  local function message(text) if not _G.Muse.regression then print(text) end end

  return {part = part, close = close, message = message}
end -- check object created by `check.open`

function check.tests(testOrder, testSetTablePath, testSetName) 
  --:: check.tests(testOrder: ":"[], testSetTablePath:":", testSetName:":") -> _Return ordered test names for regression._ -> `":"[]`
  local tests = {}; for _, testName in ipairs(testOrder) do -- testSetTable: [testName: ":"]: expecteds: ":"[]
    local testSetTable = getTestSetTable(testSetTablePath, testSetName) -- expected results for tests in set
    if testSetTable[testName] then tests[#tests + 1] = testName end
  end; return tests
end

return {check = check}