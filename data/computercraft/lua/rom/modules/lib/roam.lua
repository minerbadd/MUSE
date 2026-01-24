---@diagnostic disable: duplicate-set-field
--[[
##Commands `go`, `to`, `trace`, `come` `tail` : lib/roam
```md
--:! {roam: [":"]: ():} <- **Command Line Library for Turtle Movement** -> muse/docs/lib/roam.md  
--:| roam: _Server (turtle) side support for_ `come` _and_ `tail`, _as well as chained_ `go` _commands, motion_ `to` _or_ `trace`. -> roam
```Lua
--]]
local roams = require("signs.roam"); roams.roam = {}; local roam = roams.roam ---@module "signs.roam" 
roam.hints = {} ---@module "signs.roam" -- for functions exported from library

local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local places = require("places") local place, moves = places.place, places.moves ---@module "signs.places"

local axes = _G.Muse.permutations
--[[
```
<a id="come"></a>
#Directed Movement: `come` (and`tail`) to follow the player
After the usual library introduction, there are functions to attempt movement toward a target trying all the permutations in turn along the x, y, and z axes to deal with any blockages. Attempted movements return a message indicating eventual success or failure.
```Lua
--]]
-- :# **Movement along each axis in turn. The sequence is set by the permutation**.
-- :# {"y", "z", "x"} -> z x y, x z y, x y z, y x z, z y x, y z x

local function toAxes(change, currentAxes, targetAxes) 
  local targets = {}; 
  for i in ipairs(change) do targets[change[i]] =  targetAxes[change[i]] 
    for _, axis in ipairs(change) do -- set up to try `move.to`
      currentAxes[axis] = targets[axis] or currentAxes[axis] 
    end; -- if failure, get another permutation; otherwise, try the next axis of the permutation
    core.status(5, "roam axes", change, currentAxes, targetAxes) -- protected call: `move.to` throws errors
    local ok, _, recovery = core.pass(pcall(move.to, {currentAxes.x, currentAxes.y, currentAxes.z, "north"}))
    if not ok then local _, code = table.unpack(recovery)
      if code == "blocked" then turtle.blocking(); return end
    end
  end; return "done" -- success! (`move.to` worked for movement along each axis)
end

local function permuting(currentAxes, targetAxes) 
  local code; local x, y, z = move.get()  -- dead reckoning 
  for change in core.permute(axes) do code = toAxes(change, currentAxes, targetAxes); 
    if code == "done" then return "done" end -- successful movement; else try another permutation
  end -- tried all permutations but not at target; if any movement, try permutations from new position
  local mx, my, mz = move.get(); local distance = math.abs(x - mx) + math.abs(y - my) + math.abs(z - mz)
  core.status(3, "roam retry", distance, mx, my, mz)
  return distance == 0 and code or permuting({x = mx, y = my, z = mz}, targetAxes)
end

local function moveHere(tx, ty, tz, ttx, tty, ttz)
  return permuting({x = tx, y = ty, z = tz}, {x = ttx, y= tty, z = ttz}) -- currentAxes, targetAxes
end

local function fueling(tx, ty, tz, ttx, tty, ttz)
  local distance = math.abs(ttx-tx) + math.abs(tty-ty) + math.abs(ttz-tz) 
  local fuel = turtle.fuel(); local fueled = fuel - distance
  return fueled > 0, "fuel "..fueled.." for "..distance.." blocks to {"..ttx..","..tty..","..ttz.."}"
end

local function moving(tx, ty, tz, ttx, tty, ttz, op) -- `op` is `roam.come` or `to`
  local fuelOK, message = fueling(tx, ty, tz, ttx, tty, ttz); if not fuelOK then return "empty", message end
  local code, at = moveHere(tx, ty, tz, ttx, tty, ttz), move.ats()
  return code == "done" and "at "..at.." "..message or op..code.." at "..at -- failure report
end

--:: roam.come(:xyz:) -> _Server (turtle) side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come. -> `":" &:`
function roam.come(xyz) -- **needs GPS for {xyz} in game**, lib/remote RPC "come" dispatched by lib/net 
  local px, py, pz = table.unpack(xyz); local txyz = assert(place.xyzf(), "roam come: no turtle situation??")
  local tx, ty, tz = table.unpack(txyz); local dx, dz = px - tx, pz - tz -- x and z distance to turtle (t) from player's px, pz
  local ttx = px - 1 * (dx == 0 and 0 or math.abs(dx)/dx) -- turtle target 1 away from player along travel vector
  local ttz = pz - 1 * (dz == 0 and 0 or math.abs(dz)/dz) -- turtle target 1 away from player along travel vector
  local tty = py - 1; return moving(tx, ty, tz, ttx, tty, ttz, "rome.come ")
end 

roam.tail = roam.come; roam.hints["tail"] = {["?rate"] = {}} -- separate but equal, allow for future discriminate action 
--:: roam.tail(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)` -> `":" &:`
--[[
```
<a id="to"></a> 
#Coordinate Movement: `to` a `place` or a `position
The `to` function is used in order to move to a `position` (with `move.to`) or a `place` (with `moves.to`). Tries all permutations.

There's also some mysterious stuff around `roam.hints`. The stuff populates a table used by <a href="core.html#UI" target = "_blank">`core.completion` to provide shell completions in ComputerCraft's CraftOS in the format that it expects.
```Lua
--]]
local function to(arguments) 
  --:- to place | x y z face?-> _To named place or position and face. Retry permutation for different first direction._ 
  local _, x, y, z, facing = table.unpack(arguments); local tx, ty, tz = table.unpack(move.at()) -- from
  local toPlace = tonumber(x) and {tonumber(x), tonumber(y), tonumber(z), facing or "south"} or place.xyzf(x) -- x is named place
---@diagnostic disable-next-line: param-type-mismatch
  local ttx, tty, ttz = table.unpack(toPlace); return moving(tx, ty, tz, ttx, tty, ttz, "rome.to ") -- **do it!**
end; roam.hints["to"] = {["?name | ?x y z "] = {["??face"] = {}}}
--[[
```
<a id="trace"></a>
#Tracing A Trail
```Lua
--]]
local function trace(arguments) 
  --:- trace trailname ->  _Move turtle along traced situations in named trail from one end of trail to the other._
  local _, trailname = table.unpack(arguments) -- first argument is command
  local moveOK, code, index = core.pass(pcall(moves.along, trailname))
  if moveOK then return "trace "..index.." to "..move.ats() end -- no permutation retry on failure
  return "roam.trace: "..trailname.." failed because "..code.." with "..index.." remaining at "..move.ats() 
end roam.hints["trace"] = {["?trail"] = {}} 
--[[
```
<a id="go"></a>
#Chained Movement: the `go` command
The `go` command is implemented with a relatively thin envelope around the primitive (no permutations retry) operations. Mostly the envelope deals with parsing, dispatch, and errors. This is a common pattern allowing easier modification of the user interface (UI) as needed . The hard work, that done by the underlying libraries, is unaffected when the UI needs to be modified. 

The command is provided with a tiny language to chain together where to `go`.
```Lua
--]]
-- **Chained commands**
local movements = {
  n = function(count) return move.north(tonumber(count)) end, 
  e = function(count) return move.east(tonumber(count)) end,
  s = function(count) return move.south(tonumber(count)) end,
  w = function(count) return move.west(tonumber(count)) end,
  r = function(count) return move.right(tonumber(count)) end,
  l = function(count) return move.left(tonumber(count)) end,
  f = function(count) return move.forward(tonumber(count)) end,
  b = function(count) return move.back(tonumber(count)) end,
  u = function(count) return move.up(tonumber(count)) end,
  d = function(count) return move.down(tonumber(count)) end,
} 

local function doChain(command) -- attempt to do one command table entry from chain 
  local letter = command[1]; local movement = movements[letter]-- command letter for dispatch
  if not movement then error("roam.doChain: Invalid operation: "..core.string(command)) end
  return movement(table.unpack(command, 2)) -- return the result of the command 
end

local function chain(i, line, commands) -- make command table { { ":", [#:] }... }  for `doChain`
  if i > #line then return commands end -- `line` is table of letters followed by its corresponding number if any 
  local letter, count = string.sub(line[i], 1, 1), tonumber(line[i + 1]) -- letter number pattern?
  if type(count) == "number" then table.insert(commands, {letter, count}); return chain(i + 2, line, commands) end -- yep
  table.insert(commands, {letter}); return chain(i + 1, line, commands) -- nope, this one's just letter; try next 
end

local function go(line) -- returns the result from last chain command attempted
  --:# Movements are `r[ight], l[eft], f[orward], b[ack], u[p], d[own], n[orth], e[ast], s[outh], w[est]`.
  --:- go _(first letter of) directions followed by optional counts, e.g. `r 10 u east 3 u 4 d n`._ -> _Chained movement._
  local commandOK, code; local commands = chain(2, line, {}); -- line[1] is  "go"
  for _, command in ipairs(commands) do commandOK, code  = core.pass(pcall(doChain, command))
    if not commandOK then 
      error("roam.go: Failed "..core.string(command).." in "..core.string(line).." because "..code.." at "..move.ats()) 
    end
  end; return "roamed to "..move.ats()
end; roam.hints["go"] = {["?chain n e s w u p r l f b"] = {}}
--[[
```
<a id="op"></a> 
#Dispatch and Done
Just a simple dispatch, some error handling, and our work here is done. Look at what goes before to see how.
```Lua
--]]
local ops = {go = go, to = to, trace = trace, } 

local function here() -- are we actually here? (defensive programming, checking dead reckoning against GPS)
  local gx, gy, gz, _, ok = move.where(); if not ok then return end -- can't check without GPS
  local ax, ay, az = table.unpack(move.at()); if not (gx == ax and gy == ay and gz == az) then error("roam.here: Lost!") end
  return core.ats()
end

function roam.op(arguments) --:: roam.op(arguments: ":"[]) -> _Move turtle:_ -> `":" &:`
  local from = here() -- as a defensive move, check dead reckoning
  local roamOK, message = core.pass(pcall(ops[arguments[1]], arguments))
  return roamOK and message.." from "..from or "roam failed "..arguments[1].." in "..core.string(arguments).." because "..message
end

return {roam = roam}
--[[
```
Look at <a href="../tests/roam.html" target = "_blank"> `tests/roam` </a> and <a href="check.html" target = "_blank"> `lib/check`</a>` to see how testing works for this module. Return to <a href="../../MiningMUSE.html#task"> MiningMUSE</a> to continue the exploration.
--]]
