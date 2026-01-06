--[[
#Setup Test Configuration for Doing the Tests with Regression Testing: lib/check
```md
--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check
```Lua
--]]
local starts = require("_start"); local _ = starts -- loaded just to set configuration variables
local cores = require("core"); local core = cores.core ---@module "signs.core"
local lfs = require("lfs"); local check = {}; ---@module "signs.check"  

local tests = arg[0]:match('.*[/\\]') --:# Get path to calling executable
local checks = tests.."checks/" --:# Assumes tests directory structure as `tests/checks`
_G.Muse.data = tests.."data/" -- separate from game when testing

--[[
```
<a id="tests"></a>
There's an example here, `check.open`, of what's called _a poor man's object_. The function creates what can be thought of as a `check` object with the context needed to save (and compare) results by the `part` "method" for each part of a given test. Those _expected_ results are compared with actuals during a regression validation. There's a cleanup operation to `close` the opened `check` object. 

_(The code illustrates <a href="https://wiki.c2.com/?ClosuresAndObjectsAreEquivalent" target="_blank"> `poor man's objects`</a>. This link dumps you into a theory heavy digression. Go there when you're ready for that.)_

For MUSE, all this is enabled by files in a specified `checks` directory. The expected results from the previous run of a test are found in the file in that directory for the given test. The results files instantiate when loaded as tables of result strings keyed by part identifiers (as strings) in the test.
```Lua
--]]

local function directories()
  assert(lfs.chdir(tests), "No tests directory here: "..tests) 
  if lfs.chdir(checks) then return end -- or make a checks directory if needed
  assert(lfs.mkdir("checks"), "Can't make tests/check/ in "..tests)
end

local function expected(testName) --:# Find results (if any) from a previous test.
  directories(); local resultsFileName = checks..testName..".lua"
  local resultsFunction = io.open(resultsFileName, "r") and loadfile(resultsFileName)
  local priors = resultsFunction and resultsFunction()
  return priors -- if any
end

--:# The poor man's object.... encapsulates but provides no inheritance facilities (didn't see the need to go there)
function check.open(testName, text, regression) -- create check object with context variables
  --:: check.open(testName:":", text: ":") -> _Return `check` object(closure)_ -> `{part:():, message:():, close:():}` 
  print(text); local priors = not regression and {} or assert(expected(testName), "No prior results for "..testName)
  local this = {priors = priors, testName = testName, regression = regression} -- instance variables

  --:# Access functions for the `check` object, each check object is independent in itself
  local function part(partID, note, ...) -- at each part of the test
    --:# part(partID: ":", note: ":", ...: ":"): -> _Collect ... results for part, save or compare (for regression)_ -> `nil`
    if not this.regression then print(note) end -- verbose if not regression
    local partName = tostring(partID); local prior = this.priors['["'..partName..'"]']
    local ok, report = core.pass(pcall(core.string, ...))
    local result = not ok and ("ERROR "..this.testName..".lua part "..partID..": "..note.." failed: "..report) or report  
    if (this.regression and result ~= prior) then error(result.." ~= "..prior or ''.. " in "..this.testName..":"..partName) end
    if not this.regression then this.priors['["'..partName..'"]'] = result; print(partName, result); return end --> regression
  end

  local function message(...) if not this.regression then print(...) end end
  --:# message(..: ":"): -> _Print ... if not regression_ -> `nil`

  local function close(text) -- at end of test
    --:# close(text: ":"): -> _Print text if regression, otherwise save results in_ `checks` _directory for test_ -> `nil`
    if this.regression then print(text); this = nil; return end
    directories(); local serialized, path = core.serialize(this.priors), checks..testName..".lua"
    local handle = assert(io.open(path, "w"), "Can't open "..path.." in tests/check")
    handle:write(serialized); handle:close(); this = nil -- for gc
    print(text, checks..testName..".lua")
  end

  return {part = part, message = message, close = close}

end -- check object created by `check.open`

--:# Run each test in this test directory that has expected results 
function check.regression(testOrder) --:: check.regression(testOrder: ":"[]) -> _Run ordered test (names) for regression._ -> `nil`
  local regression = true -- not the one in the `check` object
  for _, testName in ipairs(testOrder) do --:# Order to run tests comes from `tests/.regression`.
    if expected(testName) then -- TODO: maybe catch any thown errors and raise regression failed exception
      local test = assert(loadfile(tests..testName..".lua"), "Failed to load "..testName..".lua")
      test(regression) --:# Load test with `regression` parameter `true`. Apply `check.open` in test with this parameter.
    end 
  end 
end 

return {check = check}