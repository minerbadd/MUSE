--[[
##Test: `tests/remote` for the remote operation command library with lib/net 
```md
--:? muse/docs/tests/remote.txt <- **Test `lib/remote`** -> muse/docs/tests/remote.md 
--:# Test remote commands for lib/task and lib/roam to test local operations of lib/remote

```Lua
--]]
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move = motion.move ---@module "signs.motion"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

local test = check.open(testName, text, regression) --:# Create the test object for this test

--:# **Remote Status Logging Control in lib/core**
test.remote("echo", "echo", {"echo 1", "echo 2", "echo 3"})
test.remote("log report 1", "log")
test.remote("log level", "log", {3})
test.remote("log report 2", "log")
test.remote("log level", "log", {3, test.log})
test.remote("log report 3", "log")

--:# **Remote turtle operations not subsumed by lib/task**
test.remote("fuel", "fuel")
test.remote("items", "items")

--:# **Remote Low Level Turtle Operations in lib/turtle and lib/task** (for turtle API operations, e.g., `rover find`)
test.remote("nonesuch fails", "nonesuch", {"apples"})
--:# find name...? -> Report and select first slot found [or if no name, just report inventory].
test.remote("find all", "find")
test.remote("find fuel and ores", "find", {"fuel", "ores"})
test.remote("find unobtanium fails", "find", {"unobtanium"})
--:# attack direction -> Attempts attack in specified direction.
test.remote("attack", "attack", {"east"})
--:# look direction -> Detect and inspect direction, return report.
test.remote("look down", "look", {"down"}); 
test.remote("look around fail", {"around"}, "expected fail")
--:# drop item direction quantity? -> Drop quantity of selected items [or all].
test.remote("drop", "drop", {"fuel", "up", "6"})
--:# suck direction quantity? -> Suck quantity items [or all] into available slot.
test.remote("suck", "suck", {"up", "2"})
--:# compare item direction+ -> _Named item matches block in any of specified directions?_
test.remote("compare", "compare", {"minecraft:dirt", "up", "down"})
--:# dig direction distance hoeings...? -> Direction and distance to (possibly blocked) move, hoeings directions to hoe.
test.remote("dig", "dig", {"down", "5", "east", "south"})
--:# put filling direction distance puttings+ -> Direction, distance to move, placing filling in puttings directions.
test.remote("put", "put", {"dirt", "east", "3", "up", "down"})
--:# change target filling direction distance puttings+ -> Move distance in direction replacing target with filling.
test.remote("change", "change", {"dirt", "stone", "down", "4", "north", "down"})
--[[

--:# **Remote Turtle Motion Commands** (e.g., `farmer come`)
net["to"] = op(roam.op, "to"); as["to "] = roam.hints["to"];  --:= to:
net["go"] = op(roam.op, "go"); as["go "] = roam.hints["go"];  --:= go: 
net["trace"] = op(roam.op, "trace");as["trace "] = roam.hints["trace"] --:= trace:
net["come"] = roam.come; as["come "] = roam.hints["come"]; hints[path.."come.lua"] = roam.hints["come"] --:= come:
net["tail"] = roam.tail; as["tail "] = roam.hints["tail"]; hints[path.."tail.lua"] = roam.hints["tail"] --:= tail:
--]]

test(99, "rover", "quit", "quitting")
core.report(1, "Should be quitting")
test(999, "miner", "echo", {"echo 1", "echo 2", "echo 3"})
