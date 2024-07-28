--[[
## Exec: Command Computer Operations CLL: ComputerCraft Position and Chunk Activation
```md
--:! {exec: []: (:)} <- **Command Computer Command Line Library** -> muse/docs/lib/exec.md
--:| exec: _CLL to align MUSE location with Minecraft coordinates and activate a range as a Minecraft chunk._ -> exec
```
The `exec` library provides CLL support for selected commands as alternatives to directly using Minecraft 'cheats'. A number of the commands make it easier to setup a Muse environment. They count on a command computer enabled for use outside Minecraft's creative mode.
```
The library preface is as expected. The only new thing is mocking some command computer operations so development and debug can be done outside the game environment.
```Lua
--]]
local exec = {}; exec.hints = exec.hints or {} ---@module "signs.exec"-- for functions exported from library
local cores = require("core"); local core = cores.core ---@module "signs.core"
local places = require("places"); local place = places.place ---@module "signs.places"
local maps = require("map"); local map = maps.map ---@module "signs.map"

---@diagnostic disable-next-line: undefined-field
local commands = _G.rednet and _G.commands or require("mock").commands -- for out-game testing
--[[
```
### CLI support for `locate` command to align a turtle's dead reckoning with Minecraft coordinates for launch.
```Lua
--]]
--:# **Before GPS launch, set Muse dead reckoning coordinates for turtle sitting on `porter` to be its Minecraft coordinates**
--:+ The turtle will generally be `rover` for launch. Named point will be launch base. Only runs on command computer in-game.

local function locate(name, label, tx, ty, tz, blockAboveTest) -- `t*` (x, y, z as numbers) and `blockAboveTest` are test inputs
  --:- locate name label? -> _Create launch point having Minecraft coordinates above `porter`._
  --:+ blockAboveTest: _For testing_ -> `{nbt: {Label: ":"}, state: {facing: ":"}}`
  assert(commands, "exec.locate: not a command computer") -- mocked out-of-game
  assert(name, "exec.locate: needs name for new point")
  local x, y, z = commands.getBlockPosition(tx, ty, tz)   -- `getBlockPosition` and `getBlockInfo` mocked for test
  local blockAbove = commands.getBlockInfo(x, y + 1, z, blockAboveTest)
  if not blockAbove then return "Nothing above" end       -- Aligned for dead reckoning but no `launch` turtle
  local state = assert(blockAbove.state, "exec.locate: no state above")
  local facing = assert(state.facing, "exec.locate: no face above")
  map.set(name, label or "locate", x, y + 1, z, facing)
  local nbt = assert(blockAbove.nbt, "exec.locate: no nbt above")
  local museRole = assert(nbt.Label, "exec.locate: no role above")
  return museRole .. " at " .. place.qualify(name) .. " facing " .. facing
end; exec.hints["locate"] = { ["?name ??label"] = {} }
--[[
```
### CLI support for `activate` command: `/forceload add` area specified by a `range`
```Lua
--]]
local function activate(range)
  --:- activate range -> _Add borders from west and north to east and south of range for Minecraft forceload._
  assert(commands, "exec.activate: not a command computer")
  local borders = map.borders(assert(range, "exec.activate: need range for borders"))
  local fx, fz, tx, tz = borders.west, borders.north, borders.east, borders.south
  local stringBorders = tostring(fx) .. " " .. tostring(fz) .. " " .. tostring(tx) .. " " .. tostring(tz)
  local OK, message = commands.exec("forceload add " .. stringBorders); assert(OK, message)
  return "Activated chunk " .. stringBorders
end
exec.hints["activate"] = { ["?range"] = {} }
--[[
```
###Dispatch operations and catch errors for remote operation
```Lua
--]]
--:# Dispatch for `exec` commands: `locate`, `activate`
local ops = { locate = locate, activate = activate, }

function exec.op(commandLine)                                            --:: exec.op(commandLine: :[command: ":", ...]) -> _CLI for Command Computer commands_ -> `":" &:`
  local ok, report = core.pass(pcall(ops[commandLine[1]], table.unpack(commandLine, 2)))
  if ok then return report else return "exec: " .. core.string(report) end -- report failure for error
end

return { exec = exec }
