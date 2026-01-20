--[[
## Network Remote Command Interface for RPC: lib/net
```md
--:! {net: [":"]: ():} <- **Net Remote Command Library** -> muse/docs/lib/net.md  
--:| net: _Command Line Library providing turtle operations used by remote library (effectively the UI for Muse)._ -> net
--:# _Remote commands for turtles need prefixing by `farmer`, `miner`, `logger`,`porter`,  or `rover` roles._
```
When this module is loaded it populates its exported table, the `net` library, as a dispatch table used by `remote.call`. Each entry in the table defines a _remote command_. Only the operations performed by these commands are available for remote execution. Together these create the remote CLI for MUSE. It also sets up hints as shell completions for ComputerCraft's CraftOS `shell.setCompletionFunction`. This is invoked at MUSE session start by <a href="../.start.html#complete" target="_blank"> `.start.lua` </a> running `core.completer`

As you'll see, it's all about that exported table.
```Lua
--]]
local net, as, path = {}, {}, _G.Muse.path; ---@module "signs.net"

--[[
```
<a id="roles"></a>
#Roles, Completions, and Dependencies
The `as` table accumulates `hints` for the `rover`, `porter`, `farmer`, `logger`, and `miner` _role commands_ as the library is loaded. Role commands begin a command line. The rest of the line is a _remote command_ followed by its arguments. The role commands direct the turtle with that role to perform the remote operation specified by that rest of that command line.  Follow the link to the implementation for the <a href="../../programs/farmer.html" target="_blank">`farmer`</a> role command. Those for <a href="../logger.html" target="_blank"> `logger`</a>, <a href="../miner.html" target="_blank"> `miner`</a>, <a href="../porter.html" target="_blank"> `porter`</a>, and <a href="../rover.html" target="_blank"> `rover`</a> are in the same pattern as (helpfully) consistent implementations. 
```Lua
--]]
net.hints = {}; local hints = net.hints
hints[path.."rover.lua"] = as; hints[path.."farmer.lua"] = as
hints[path.."logger.lua"] = as; hints[path.."miner.lua"] = as
hints[path.."porter.lua"] = as; 
--[[
```
<a id="dispatch"></a> 
The `net` table dispatches commands for each `remote.call` into server libraries. The `exec` and `port` libraries are used by the command computer. The `core` library is for debug.
```Lua
--]]
local cores = require("core"); local core = cores.core  ---@module "signs/core"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local gpss = require("gps"); local gps = gpss.gps ---@module "signs.gps"
local maps = require("map"); local map = maps.map ---@module "signs.map"
local mines = require("mine"); local mine = mines.mine ---@module "signs.mine"
local roams = require("roam"); local roam = roams.roam ---@module "signs.roam"
local tasks = require("task"); local task = tasks.task ---@module "signs.task"
local execs = require("exec"); local exec = execs.exec ---@module "signs.exec"
local ports = require("port"); local port = ports.port ---@module "signs.port"
local fields = require("field"); local field = fields.field ---@module "signs.field"
local farms = require("farm"); local farm = farms.farm ---@module "signs.farm"
--[[
```
<a id="op"></a> 
#Operation Dispatch
Some libraries export a dispatcher function that uses a string, its first argument, to pick one of its defined functions to operate on the rest of the arguments provided. The `op` function fits remote commands to this pattern. It returns a function that makes a protected call on a `dispatcher` function in a target library. The returned function included in the `net` table calls this `dispatcher` on a table it creates. The table packages up the `command`, the remote command, along with the arguments which are sent on the `remote.call`. 
```Lua
--]]
--:# **Dispatcher `op` catches net operations that raise exceptions so turtles report errors, ready for new commandsa.**
local function op(dispatcher, command) --TODO: use for all net operations
  return function(arguments)
    local ok, report = core.pass(pcall(dispatcher, {command, table.unpack(arguments or {})}))
    if not ok then core.status(1, "net", report, command, arguments) end
    return report
  end
end
--[[
```
<a id="hints"></a> 
Each of the _remote commands_ has its place in the `net` table. Completion hints are defined in the library with the functions they hint. How the hints are used varies:

- Some remote commands, for example `trail` and `fix`, are meaningful only within a MUSE role. For these, the only completions provided are those added to the `as` table, the completions table for each of the role commands.

- Other commands, such as `status`, are effective on their own as well as a remote command. These populate the `hints` table for that command as well as the `as` table for the remote command. 

- Some commands, such as `fuel`, have no need of completion hints so nothing is provided. The completion pattern, for example, `as["fuel"]` has no trailing space in the string.

Just as is done for hints, CLI summary <a href="../../docs/lib/net.html" table="_blank"> documentation</a> is copied (by `::-=` entries) from the libraries where the CLI is implemented. 

This then below defines the remote CLI: hints, docs, and all. It's dense, very repetitive, and easily changed as experience suggests the CLI needs to evolve. 
```Lua
--]]
--:# **Testing, Monitoring, and Control** (e.g., `farmer echo something something`)
net["status"] = core.logging; as["status "] = core.hints["status"]; hints[path.."status.lua"] = core.hints["status"] --:= status:
net["echo"] = core.echo; as["echo "] = core.hints["echo"]; hints[path.."echo.lua"] = core.hints["echo"] --:= echo:
net["quit"] = core.quit; as["quit "] = core.hints["quit"] --:= quit:

--:# **Remote Turtle and Task Operations** (for turtle API operations, e.g., `rover find`)
net["fuel"] = turtle.fuel; as["fuel"] = turtle.hints["fuel"] --:= fueling: fuel
net["items"] = turtle.items; as["items"] = turtle.hints["items"] --:= items:
net["find"] = op(task.op, "find"); as["find "] = task.hints["find"] --:= find:
--:= Directions:
net["suck"] = op(task.op, "suck"); as["suck "] = task.hints["suck"] --:= suck:
net["drop"] = op(task.op, "drop"); as["drop "] = task.hints["drop"]  --:= drop:
net["look"] = op(task.op, "look"); as["look "] =  task.hints["look"] --:= look:
net["compare"] = op(task.op, "compare"); as["compare "] = task.hints["compare"] --:= compare:
net["attack"] = op(task.op, "attack"); as["attack "] = task.hints["attack"] --:= attack:
net["dig"] = op(task.op, "dig"); as["dig "] = task.hints["dig"] --:= dig:
net["put"] = op(task.op, "put"); as["put "] = task.hints["put"] --:= put:
net["change"] = op(task.op, "change"); as["change "] = task.hints["change"] --:= change:

--:# **Remote Turtle Motion Commands** (e.g., `farmer come`)
net["to"] = op(roam.op, "to"); as["to "] = roam.hints["to"];  --:= to:
net["go"] = op(roam.op, "go"); as["go "] = roam.hints["go"];  --:= go: 
net["trace"] = op(roam.op, "trace");as["trace "] = roam.hints["trace"] --:= trace:
net["come"] = roam.come; as["come "] = roam.hints["come"]; hints[path.."come.lua"] = roam.hints["come"] --:= come:
net["tail"] = roam.tail; as["tail "] = roam.hints["tail"]; hints[path.."tail.lua"] = roam.hints["tail"] --:= tail:

--:= Places:
net["trail"] = op(map.op, "trail"); as["trail "] = map.hints["trail"] --:= trail:
net["point"] = op(map.op, "point"); as["point "] = map.hints["point"]; hints[path.."point.lua"] = map.hints["point"] --:= point: 
net["range"] = op(map.op, "range"); as["range "] = map.hints["range"]; hints[path.."range.lua"] = map.hints["range"] --:= range:
net["chart"] = op(map.op, "chart"); as["chart "] = map.hints["chart"]; hints[path.."chart.lua"] = map.hints["chart"] --:= chart:

--:= Navigation:
net["at"] = op(map.op, "at"); --:= at:
net["near"] = op(map.op, "near"); as["near "] = map.hints["near"]; hints[path.."near.lua"] = map.hints["near"] --:= near:
net["view"] = op(map.op, "view"); as["view "] = map.hints["view"]; hints[path.."view.lua"] = map.hints["view"] --:= view:
net["where"] = op(map.op, "where"); as["where "] = map.hints["where"]; hints[path.."where.lua"] = map.hints["where"]  --:= where:
net["fix"] = op(map.op, "fix"); as["fix "] = map.hints["fix"]; --:= fix:

net["headings"] = op(map.op, "headings") --:= headings:
as["headings "] = map.hints["headings"]; hints[path.."headings.lua"] = map.hints["headings"] 

--:# **Map File Operations** (e.g., `rover site ...`)
net["erase"] = op(map.op, "erase"); as["erase "] = map.hints["erase"]; hints[path.."erase.lua"] = map.hints["erase"] --:= erase:
net["sync"] = op(map.op, "sync"); as["sync"] = map.hints["sync"]; hints[path.."sync.lua"] = map.hints["sync"] --:= sync:
net["site"] = op(map.op, "site"); as["site "] = map.hints["site"]; hints[path.."site.lua"] = map.hints["site"] --:= site:
net["store"] = op(map.op, "store"); as["store "] = map.hints["store"]; hints[path.."store.lua"] = map.hints["store"] --:= site:
net["join"] = op(map.op, "join"); as["join "] = map.hints["join"]; hints[path.."join.lua"] = map.hints["join"] --:= join:

--:# **GPS Launch Command** (e.g., `rover launch gantry ....`)
net["launch"] = op(gps.op, "launch"); as["launch "] = gps.hints["launch "] --:= launch:
--<a id="mine"></a>
--:# **Remote Mining Operation Commands** (e.g. `miner shaft ....`)
net["shaft"] = op(mine.op, "shaft"); as["shaft "] = mine.hints["shaft"] --:= shaft:
net["bore"] = op(mine.op, "bore"); as["bore "] = mine.hints["bore"] --:= bore:
net["post"] = op(mine.op, "post"); as["post "] = mine.hints["post"] --:= post:
net["ores"] = op(mine.op, "ores"); as["ores "] = mine.hints["ores"] --:= ores:

--:# **Remote Volume Operations** (bound by point pairs, possibly in a `range`)
net["cut"] = field.cut; as["cut "] =  field.hints["cut"] --:= cut:
--:= Filling:
net["fill"] = field.fill; as["fill "] = field.hints["fill"] --:= fill:
--:= Seed:
net["till"] = field.till; as["till "] = field.hints["till"] --:= till:

net["fence"] = field.fence; as["fence "] = field.hints["fence"]  --:= fence:

--:# **Remote Farm Operations** (where a range feature value is a `fieldName` keyed by `field`, a string literal).
--:+ _A `fieldName` is a file name without its suffix, e.g. `cane` rather than `cane.lua`, in the `fields` directory._
-- <a id="farm">
net["farm"] = field.make; as["farm "] = farm.hints["farm"] --:= farm:
net["quarry"] = op(field.make, "quarry"); as["quarry "] = farm.hints["quarry"] --:= quarry:
net["layer"] = op(field.make, "layer"); as["layer "] = farm.hints["layer"]  --:= layer:
net["cover"] = op(field.make, "cover"); as["cover "] = farm.hints["cover"]  --:= cover:
net["finish"] = op(field.make, "finish"); as["finish "] = farm.hints["finish"]  --:= finish:
net["harvest"] = op(field.make, "harvest"); as["harvest "] = farm.hints["harvest"] --:= harvest:
net["path"] = op(field.make, "path"); as["path "] = farm.hints["path"] --:= path:


--:# **Command Computer Setup and Port Commands** (e.g., `locate gantry launch`)
net["locate"] = op(exec.op, "locate"); --:= locate:
as["locate "] = exec.hints["locate"]; hints[path.."locate.lua"] = exec.hints["locate"] 

net["activate"] = op(exec.op, "activate"); --:= activate:
as["activate "] = exec.hints["activate"] 

net["book"] = op(port.op, "book")  --:= book:
as["book "] = port.hints["book"]; hints[path.."book.lua"] = port.hints["book"] 

net["port"] = op(port.op, "port") --:= port:
as["port "] = port.hints["port"]; hints[path.."port.lua"] = port.hints["port"] 

return {net = net}