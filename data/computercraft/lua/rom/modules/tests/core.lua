--:? muse/docs/tests/01core.txt <- **Run Regression Test for Muse** -> muse/docs/tests/00core.md  

-- **Tests for lib/core**.log

dofile(arg[0]:match('.*[/\\]').."preface.lua") -- set test environment using `preface` in execution path

local core = require("core").core -- 
local log = _G.Muse.log
local loggings = {level = core.state(log, "level")}
loggings.level(5)
print(loggings.level())
