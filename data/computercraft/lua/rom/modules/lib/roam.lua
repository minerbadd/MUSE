--[[
##Commands `go`, `to`, `trace`, `come` `tail` : lib/roam.lua
```md
--:! {roam: []: (:)} <- **Command Line Library for Turtle Movement** -> muse/docs/lib/roam.md  
--:| roam: _Server (turtle) side support for_ `come` _and_ `tail`, _chained motion commands, motion to or tracing._ -> roam
```Lua
--]]
local roam = {}; roam.hints = {} ---@module "signs.roam" -- for functions exported from library

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local places = require("places") local place, moves = places.place, places.moves ---@module "signs.places"
--[[
```
<a id="come"></a>
#Directed Movement: `come` to follow the player
After the usual library introduction, there's a table,  `pickMove`, of anonymous functions differing only in the order of x, y, and z coordinate movement. On each call to `picks` the order number gets incremented modulo the number of entries in the table so each `pickMove[picks()]` tries a different sequence of x, y, z to `move.to` the target position. There's a bit of defensive programming, `here`, before each try as a player repetitively commands the turtle to `come`.
```Lua
--]]
-- :# **How the turtle moves toward the player (allowing for repeats to deal with blockages)**
local function to(a, b, c) move.to({a, b, c, "north"}) end 

local pickMove = { -- t* turtle, tt* target; hy is ty or tty -- ToDO: make this into a little (declarative) language

  function (tx, hy, tz, ttx, tty, ttz) to(tx,hy,tz); to(ttx,hy,tz); to(ttx,tty,tz); to(ttx,tty,ttz) end, -- hy, ttx, tty, ttz
  function (tx, hy, tz, ttx, tty, ttz) to(tx,hy,tz); to(ttx,hy,tz); to(ttx,hy,ttz); to(ttx,tty,ttz) end, -- hy, ttx, ttz, tty
  function (tx, hy, tz, ttx, tty, ttz) to(tx,hy,tz); to(tx,tty,tz); to(ttx,tty,tz); to(ttx,tty,ttz) end, -- hy, tty, ttx, ttz
  function (tx, hy, tz, ttx, tty, ttz) to(tx,hy,tz); to(tx,tty,tz); to(tx,tty,ttz); to(ttx,tty,ttz) end, -- hy, tty, ttz, ttx
  function (tx, hy, tz, ttx, tty, ttz) to(tx,hy,tz); to(tx,hy,ttz); to(ttx,hy,ttz); to(ttx,tty,ttz) end, -- hy, ttz, ttx, tty
  function (tx, hy, tz, ttx, tty, ttz) to(tx,hy,tz); to(tx,hy,ttz); to(tx,tty,ttz); to(ttx,tty,ttz) end, -- hy, ttz, tty, ttx

  function (_, ty, tz, ttx, tty, ttz) to(ttx,ty,tz); to(ttx,tty,tz); to(ttx,tty,ttz) end, -- ttx, tty, ttz (not hy first)
  function (_, ty, tz, ttx, tty, ttz) to(ttx,ty,tz); to(ttx,ty,ttz); to(ttx,tty,ttz) end, -- ttx, ttz, tty (not hy first)
  function (tx, _, tz, ttx, tty, ttz) to(tx,tty,tz); to(ttx,tty,tz); to(ttx,tty,ttz) end, -- tty, ttx, ttz (not hy first)
  function (tx, _, tz, ttx, tty, ttz) to(tx,tty,tz); to(tx,tty,ttz); to(ttx,tty,ttz) end, -- tty, ttz, ttx (not hy first)
  function (tx, ty, _, ttx, tty, ttz) to(tx,ty,ttz); to(ttx,ty,ttz); to(ttx,tty,ttz) end, -- ttz, ttx, tty (not hy first)
  function (tx, ty, _, ttx, tty, ttz) to(tx,ty,ttz); to(tx,tty,ttz); to(ttx,tty,ttz) end, -- ttz, tty, ttx (not hy first)
}; 
_G.Muse.picks = _G.Muse.picks or {come = 0, try = 0}; roam.picks = _G.Muse.picks -- just another name for the global table

local function comes() 
  roam.picks.come = _G.Muse.sequenced and ((roam.picks.come + 1) % #pickMove) or math.random(#pickMove)
  core.status(3, "roam pickCome", roam.picks.come); return roam.picks.come 
end 

local function trys() 
  roam.picks.try = _G.Muse.sequenced and ((roam.picks.try + 1)) % #pickMove or math.random(#pickMove)
  core.status(3, "roam pick try", roam.picks.try)
  return roam.picks.try 
end 

local function here() -- are we actually here? (defensive programming, checking dead reckoning against GPS)
  local gx, gy, gz, _, ok = move.where(); if not ok then return end -- can't check without GPS
  local ax, ay, az = table.unpack(move.at()); if not (gx == ax and gy == ay and gz == az) then error("roam.here: Lost!") end
  return core.ats()
end

local function moveHere(picker, tx, ty, tz, ttx, tty, ttz) --t* turtle, tt* target
  pickMove[picker](tx, ty, tz, ttx, tty, ttz) -- sequentially to deal with blockages
end

local function fueled(tx, ty, tz, ttx, tty, ttz)
  local hy = math.max(ty, tty) -- go high first
  local distance = math.abs(ttx-tx) + math.abs(tty-ty) + math.abs(ttz-tz) 
  local fuel = turtle.fuel(); local fuelOK = fuel > distance
  if fuelOK then return hy end
  return "roam: Insufficient fuel ("..fuel..") for "..distance.." blocks to {"..ttx..","..tty..","..ttz.."}" 
end


function roam.come(xyz) -- **needs GPS for {xyz}**, lib/remote RPC "come" dispatched by lib/net 
  --:: roam.come(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come. -> `":" &:`
  turtle.block(turtle.blocking())-- try motion and block if blocking has been enabled for testing
  local px, py, pz = table.unpack(xyz); local txyz = assert(place.xyzf(), "roam come: no place for a turtle")
  local tx, ty, tz = table.unpack(txyz); local dx, dz = px - tx, pz - tz -- x and z distance to turtle from player's px, pz
  local ttx = px - 1 * (dx == 0 and 0 or math.abs(dx)/dx) -- turtle target 1 away from player along travel vector
  local ttz = pz - 1 * (dz == 0 and 0 or math.abs(dz)/dz) -- turtle target 1 away from player along travel vector
  local tty = py - 1; local hy = fueled(tx, ty, tz, ttx, tty, ttz)
  local moveOK, report = core.pass(pcall(moveHere, comes, tx, hy, tz, ttx, tty, ttz)) 
  if moveOK then return "At "..core.xyzf({ttx, tty, ttz}) end
  return report -- failure report
end 

roam.tail = roam.come; roam.hints["tail"] = {["?rate"] = {}} -- separate but equal, allow for future discriminate action 
--:: roam.tail(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)` -> `":" &:`
--[[
```
<a id="to"></a> 
#Coordinate Movement: `to` a `place` or a `position
Modulo arithmetic incrementing a global variable bound to `roam.picks.try` is used to pick a different coordinate to try on each `to` command. The `tryTo` function is used in order to move to a `position` (with `move.to`) or a `place` (with `moves.to`). 
```Lua
--]]
local function tryTo(arguments) -- repeated calls try each direction in turn
  --:- to place | x y z face?-> _To named place or position and face. Retry for different first direction._ 
  local _, x, y, z, facing = table.unpack(arguments); local tx, ty, tz = move.at() -- from
  local to = tonumber(x) and {tonumber(x), tonumber(y), tonumber(z), facing or "south"} or place.xyzf(x) -- x is named place
  local ttx, tty, ttz = table.unpack(to); local hy = fueled(tx, ty, tz, ttx, tty, ttz)
  local moveOK, code, index, xyzfacing =  core.pass(pcall(moveHere, trys, tx, hy, tz, ttx, tty, ttz))
  if not moveOK then error("roam.tryTo: Could not roam to ".. to.." because "..code.." at "..move.ats()) end
  return code, index, xyzfacing
end; roam.hints["to"] = {["?name | ?x y z ??face"] = {}} 
--[[
```
<a id="trace"></a>
#Tracing A Trail
```Lua
--]]
local function trace(arguments) 
  --:- trace trailname ->  _Move turtle along traced situations in named trail from one end of trail to the other._
  local _, trailname = table.unpack(arguments) -- first argument is command
  local moveOK, code, index, xyzfacing = core.pass(pcall(moves.along, trailname))
  if moveOK then return code, index, xyzfacing end
  error("roam.trace: "..trailname.." failed because "..code.." with "..index.." remaining at "..xyzfacing) 
end roam.hints["trace"] = {["?trail"] = {}} 
--[[
```
<a id="go"></a>
#Chained Movement: the `go` command
The `go` command is implemented with a relatively thin envelope around the primitive operations. Mostly the envelope deals with parsing, dispatch, and errors. This is a common pattern allowing easier modification of the user interface (UI) as needed . The hard work, that done by the underlying libraries, is unaffected when the UI needs to be modified.

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
  local commandOK, code, remaining, xyzfacing[local commands = chain(2, line, {}); -- line[1] is  "go"
  for _, command in ipairs(commands) do commandOK, code, remaining, xyzfacing = core.pass(pcall(doChain, command))
    if not commandOK then 
      error("roam.go: Failed "..core.string(command).." in "..core.string(line).." because "..code.." at "..move.ats()) 
    end
  end; return code, remaining, xyzfacing
end; roam.hints["go"] = {["?chain"] = {}}
--[[
```
<a id="op"></a> 
#Dispatch and Done
Just a simple dispatch, some error handling, and our work here is done. Look at what goes before to see how.
```Lua
--]]
local function doCommand(op, arguments) here(); return op(arguments) end 

local ops = {go = go, to = tryTo, trace = trace, } 

function roam.op(arguments) --:: roam.op(arguments: ":"[]) -> _Move turtle:_ -> `":" &:`
  local from = here(); turtle.block(turtle.blocking()) -- check dead reckoning, try motion and block if enabled for testing
  local roamOK, code, _, xyzfacing = core.pass(pcall(doCommand, ops[arguments[1]], arguments))
  if not roamOK then return "Roam error command: "..arguments[1].." in "..core.string(arguments).." because "..code end
  return from.." to "..xyzfacing 
end

return {roam = roam}
--[[
```
Return to <a href="../../Mining MUSE.html#task"> Mining MUSE</a> to continue the exploration.
--]]
