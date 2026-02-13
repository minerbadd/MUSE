--[[
#Setup Test Configuration for Doing the Tests with Regression Testing: lib/check
```md
--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check
```Lua
--]]
local starts = require("_start"); local _ = starts -- loaded just to set configuration variables
local cores = require("core"); local core = cores.core ---@module "signs.core"
local remotes = require("remote"); local remote = remotes.remote ---@module "signs remote"
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

Test parts are executed as protected calls so errors can be used in regression testing. This requires part operations to be deferred by applying functions to arguments in `check.part` rather than in the tests themselves.  
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
  --:: check.open(testName:":", text: ":") -> _Return `check` object(closure)_ -> `{part:():, message:():, call: ():, close:():}` 
  print(text); local priors = not regression and {} or assert(expected(testName), "No prior results for "..testName)
  local partID = 0; local this = {priors = priors, testName = testName, regression = regression, partID = partID} 

  --:# Access functions for the `check` object, each check object is independent in itself
  local function part(note, fun, ...) -- at each part of the test
    --:# part(partID: ":", note: ":", fun: ():, ...: any): -> _Collect ... results for part, save or compare (for regression)_ -> `nil`
    partID = partID + 1; local partName, prior = tostring(partID), this.priors[partID]
    local ok, results = core.past(pcall(fun, ...)) -- **execute the test part deferred till now (with protection)**
    local text = core.string(table.unpack(results))
    local failure = ("ERROR "..this.testName..".lua part "..partName..": "..note.." failed: "..text)
    local report = ok and text or failure
    if (this.regression and report ~= prior) then error(report.." ~= "..prior or ''.. " in "..this.testName..": "..note) end
    if not this.regression then this.priors[partID] = report; print(note, report); return report, results end --> 
  end

  local function call(note, server, command, arguments)
    --:# call(note: ":", server: ":", command: ":", arguments: any[]): -> _Test remote calls without network_ -> `nil`
    -- testCall = prepareCall, -- (server: ":", command: ":", {arguments: ":"[]} -> serverID: #:, request: ":"
    local _, returns = part(note.." >", remote.testCall, server, command, arguments)
    local _, serverID, request = table.unpack(returns)
    -- testRequest = serverRequest, -- (clientID: ":", request: ":") -> result: ":"
    local _, results = part(note.." <", remote.testRequest, 0, request)
    local _, result = table.unpack(results)
    -- testResult = clientResult, -- (serverID: #:, result: ":", callback{}) -> `nil`
    part(note.." =", remote.testResult, serverID, result, function(result) return core.string(result) end)
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

  return {part = part, call = call, message = message, close = close}

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