--[[
#Setup Test Configuration for Doing the Tests with Regression Testing: lib/check
```md
--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check
```Lua
--]]

_G.Muse = _G.Muse or {}; _G.Muse.path = "rom/modules/"

local lfs = require("lfs"); local core = require("core").core ---@module "signs.core"
local check = {}; ---@module "signs.check"  

local tests = arg[0]:match('.*[/\\]') -- path to executable calling this library
local checks = tests.."checks/" -- assumes tests directory structure as `tests/checks`

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
_G.Muse.data = tests.."data/"  -- for test environment separate from game environment
--[[
```
<a id="tests"></a>
There's not much here. Just a way with `check.open` to create a `check` object with the context needed to save results by the `part` operation for each part of a given test. Those _expected_ results are compared with actuals during a regression validation. There's a cleanup operation to `close` the opened `check` object. Finally, `check.tests` is provides the file names of tests in a specified order for which there are _expected_ values for regression testing.

_(The code illustrates <a href="https://wiki.c2.com/?ClosuresAndObjectsAreEquivalent" target="_blank"> `poor man's objects`</a>. This link dumps you into a theory heavy digression. Go there when you're ready for that.)_

For MUSE, all this is enabled by files in a specified `checks` directory. The expected results from the previous run of a test are found in the file in that directory for the given test. The results files instantiate when loaded as tables of result strings keyed by part identifiers (as strings) in the test.
```Lua
--]]

local function expected(testName)
  assert(lfs.chdir(tests), "No tests directory here: "..tests) -- make a checks directory if needed
  assert((io.open(checks, "r") or lfs.mkdir("checks")), "Can't make tests/check/ in "..tests)
  local resultsFileName = checks..testName..".lua"
  local resultsFunction = io.open(resultsFileName, "r") and loadfile(resultsFileName)
  local priors = resultsFunction and resultsFunction()
  return priors
end

-- poor man's object.... encapsulates but no inheritance (didn't see the need to go there)
function check.open(testName, text, regression) -- create check object with context variables
  --:: check.open(testName:":", text: ":") -> _Return object(closure)_ -> `{part:():, close:():}` 
  print(text); local priors = not regression and {} or assert(expected(testName), "No prior results for "..testName)
  local this = {priors = priors, testName = testName, regression = regression} -- instance variables

  -- access functions for the `check` object, each check object is independent in itself
  local function part(partID, note, ...) -- at each part of the test
    if not this.regression then print(note) end
    local partName = tostring(partID); local result, prior = core.string(...), this.priors[partName]
    if (this.regression and result ~= prior) then error(result.." ~= "..prior or ''.. " in "..this.testName..":"..partName) end
    if not this.regression then this.priors[partName] = result; print(result); return end -- save for regression
  end

  local function message(...) if not this.regression then print(...) end end

  local function close(text) -- at end of test
    if this.regression then print(text); this = nil; return end
    local serialized, path = core.serialize(this.priors), checks..testName..".lua"
    local handle = assert(io.open(path, "w"), "Can't open "..path.." in check.lua")
    handle:write(serialized); handle:close(); this = nil -- for gc
  end

  return {part = part, close = close, message = message}

end -- check object created by `check.open`

--:# Run each test in this test directory that has expected results 
function check.regression(testOrder) --:: check.all(testOrder: ":"[]) -> _Run ordered test names for regression._ -> `":"[]`
  local regression = true
  for _, testName in ipairs(testOrder) do 
    if expected(testName) then 
      local test = assert(loadfile(tests..testName..".lua"), "Failed to load "..testName..".lua")
      test(regression) -- TODO: maybe catch any thown errors and raise regression failed exception
    end 
  end 
end 

return {check = check}