--[[
##Test: `tests/task` for the turtle operation command library 
```md
--:? muse/docs/tests/task.txt <- **Test `lib/task`** -> muse/docs/tests/task.md 
--:# Test attack, change, find, look, drop, suck, dig, put, and compare commands

```Lua
--]]
local check = require("check").check --:# Set configuration globals for tests by loading `lib/check`

local cores = require("core"); local core = cores.core ---@module "signs.core" 
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local places = require("places"); local place = places.place ---@module "signs.place"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle" -- just for blocking
local tasks = require("task"); local task = tasks.task ---@module "signs.roam"

local regression = ... --:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`
core.log.level(regression and 0 or 3) --:# Set log level default. Set lower to report less, higher to report more

local testName = arg[0]:match("(%w-)%.%w-$") --:# Bind `testName` as the last word (without extension) in the execution path
local text = "Beginning "..testName..".lua test at "..move.ats()

turtle.blocking(false); place.site("TT")

local test = check.open(testName, text, regression) --:# Create the test object for this test

--:# Test simple operations: look, attack, find, drop, suck, compare
test.part("look east", task.op, {"look", "east"})
test.part("look up", task.op, {"look", "up"})
test.part("attack", task.op, {"attack", "east"})
test.part("find coal", task.op, {"find", "coal"})
test.part("find fuel", task.op, {"find", "fuel"})
test.part("find all", task.op, {"find", })
test.part("drop east 1", task.op, {"drop", "coal", "east", "1"})
test.part("drop east", task.op, {"drop", "coal", "east"})
test.part("suck", task.op, {"suck", "east"})
test.part("compare up", task.op, {"compare", "coal", "up", "east"})
test.part("compare down", task.op, {"compare", "ores", "down"})

--:# Test dig, put, change with directions and distance
test.part("dig up", task.op, {"dig", "up", "6", "up"})
test.part("dig e 10 e d", task.op, {"dig", "e", "10", "e", "d"})
test.part("put dirt w 10 e d", task.op, {"put", "dirt", "w", "10", "e", "d"})
test.part("change sand dirt w 10 e d", task.op, {"change", "sand", "dirt", "w", "10", "e", "d"})
test.part("put dirt here d", task.op, {"put", "dirt", "here", "d", "e"})

--:# Test dig, put, and change `along`
place.fix({10, 120, 230}, true); move.to({15, 125, 235}); move.to({20, 130, 240})
place.trail("start", "end", "test"); move.to {5, 115, 225}
test.part("dig along start", task.op, {"dig", "along", "start"})
test.part("put dirt along end", task.op, {"put", "dirt", "along", "end"}) 
test.part("change sand dirt along start", task.op, {"change", "sand", "dirt", "along", "start"})

--:# Close test object, report completion if we got here without errors
test.close("Test "..testName.." complete") 