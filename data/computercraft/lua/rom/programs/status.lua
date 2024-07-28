--[[
## Command to Control Status Reporting and Logging (Local)
```md
--:? rom/help/status.txt <- **Status Level and Status Logging Command Line Interface** -> muse/docs/programs/status.md  
```
```Lua
--]]
--:- status level [filename] -> _Set reporting hurdle and optionally save reporting in log file._
--:# _The status level controls reporting: the higher the level the more detailed the reports._
--:# _Log files are stored locally in a computer's `muse` directory._

local cores = require("core"); local core = cores.core ---@module "signs.core"
print(core.logging {...})