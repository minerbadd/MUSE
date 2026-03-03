--[[
## Command to Control Status Reporting and Logging (Local)
```md
--:? rom/help/log.txt <- **Status Level and Status Logging Command Line Interface** -> muse/docs/programs/log.md  
```
```Lua
--]]
--:- log level [filename] -> _Set reporting hurdle and optionally save reporting in log file._
--:# _The log level controls reporting: the higher the level the more detailed the reports._
--:# _Log files are stored locally in a computer's `muse` directory._

local cores = require("core"); local core = cores.core ---@module "signs.core"
print(core.logging {...})