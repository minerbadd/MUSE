--[[
##Test: `tests/dds` for the turtle operation command library 
```md
--:? muse/docs/tests/dds.txt <- **Test `lib/task`** -> muse/docs/tests/dds.md 
--:# Test attack, change, find, look, drop, suck, dig, put, and compare commands

```Lua
--]]
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local places = require("places"); local place = places.place ---@module "signs.place"
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.dds"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

local test = check.open(testName, text, regression) --:# Create the test object for this test

--:# **Set** `place.site` **and lookup roles**
test.part("set site", place.site, "testing 1")
test.part("check site", place.qualify, "tester")
test.part("check site", place.qualify, "testing 1.tester")
test.part("player", dds.role, 0)
test.part("porter", dds.role, 1)
test.part("rover", dds.role, 5)
test.part("miner", dds.role, 6)
test.part("unknown", dds.role, 2)

--:# **Join and lookup qualified roles for IDs**
test.part("join player", dds.join, 10, "player")
test.part("new player id", dds.ID, "player")
test.part("rejoin player", dds.join, 0, "player")
test.part("join miner", dds.join, 16, "miner")
test.part("new miner id", dds.ID, "miner")
test.part("rejoin miner", dds.join, 6, "miner")
for role, id in dds.map() do test.part("map", core.echo, role, id) end
  
--:# **Check site file writes and clean up**
core.setComputerLabel("miner")
do local ok, message = os.remove(_G.Muse.data.."site.txt"); assert(ok, message) end
test.part("qualify write", dds.qualify, "testing 2")
test.part("sited miner", dds.ID, "miner")
test.part("sited logger?", dds.ID, "logger")
test.part("resite", dds.site, "testing 3")
test.part("resited miner", dds.ID, "miner")
test.part("qualify miner", dds.qualify, "miner")
test.part("qualify player", dds.qualify, "player")
for role, id in dds.map() do test.part("map", core.echo, role, id) end
do local ok, message = os.remove(_G.Muse.data.."site.txt"); assert(ok, message) end


