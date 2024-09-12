--[[
## Global Positioning System Launch: lib/gps.lua
```md
--:! {gps: []: (:)} <- **GPS Deployment Command Line Library** -> muse/docs/lib/gps.md 
--:| gps: _Assemble, launch, and startup GPS computers._ -> gps, _gps
```
The module introduction here is much like that for other MUSE modules but note the special handling for out-of-game testing.
```Lua
--]]
local _gps, gps = {}, {}; gps.hints = {} ---@module "signs.gps"-- for functions internal and exported from library 

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local moves = require("motion"); local move = moves.move ---@module "signs.motion"
local turtles = require("turtle"); local turtle = turtles.turtle ---@module "signs.turtle"
local places = require("places"); local place = places.place ---@module "signs.places

local peripheral = _G.peripheral

local installs = peripheral and "disk/install.lua" or _G.Muse.path.."tests/install.lua" --for out-game test
local startup = peripheral and "disk/startup.lua" or _G.Muse.path.."tests/startup.lua" --for out-game test

local computer, modem = "computercraft:computer_advanced", "computercraft:wireless_modem_advanced" -- ender
local drive, floppy  = "computercraft:disk_drive", "computercraft:disk"
--[[
```
<a id="boot"></a> 
Each short function below is intended to serve a clear, identifiable purpose. Further, it helps understanding to separate string constants out from code bodies. There's not much more to say, so without further comment.......
```Lua
--]]

-- common text of first boot: copies floppy to startup for reboot
local copyBoot = [[ 
fs.delete('startup.lua')
fs.copy('disk/install.lua', 'startup.lua'); 
os.sleep(5); 
os.reboot(); 
]]

function _gps.equip(direction) -- assembles computer, modem, drive, and floppy
  --:: `_gps.equip(commands: :[command: ":", direction: facing])` -> _Assemble parts._ -> ":"
  --:- equip direction -> _Assemble computer, modem, drive, and floppy for direction named GPS launch (for testing)._
  core.report(2, "Equipping host at ", move.ats(), direction)
  move.back(1) -- because positions are computer positions
  core.report(2, "Equiping host "..direction)
  assert(turtle.find({computer}), "gps: no computer") -- select computer
  turtle.puts["front"]() -- place computer in front of turtle
  move.back(1) -- move back to place modem
  assert(turtle.find({modem}), "gps: no modem") -- modem
  turtle.puts["front"]() -- place modem
  move.down(1); move.forward(1) -- move down below modem and forward to place drive below computer
  assert(turtle.find({drive}), "gps: no drive") -- select drive
  turtle.puts["front"]() -- place drive (facing drive)
  assert(turtle.find({floppy}), "gps: no floppy") -- select floppy
  turtle.drops["front"]()-- drop into drive
  return "Equipped "..direction.." GPS host"
end

local labels = {north = "gpsN", east = "gpsE", south = "gpsS", west = "gpsW", }

local function makeBoot(direction) -- creates first boot startup with direction label for gps host
  local contents = "os.setComputerLabel('"..labels[direction].."');\n "..copyBoot
  local file = io.open(startup, "w"); if not file then error() end
  file:write(contents); file:close()
end

local function install(position) -- persistent boot runs gps host
  local x, y, z = table.unpack(position);
  local open = "peripheral.find('modem', rednet.open); \n"
  local tab = "shell.switchTab(shell.openTab('gps','host', "..x..", "..y..", "..z..")); \n" 
  local file = io.open(installs,"w"); if not file then error() end
  file:write(open..tab); file:close()
end

function _gps.actuate(commands)
  --:# _Testing interface, useful before committing to deployment._
  --:- actuate direction -> _Move around to boot direction named GPS host and retrieve floppy (for testing)._ 
  --:: `_gps.actuate(commands: :[command: ":", direction: facing]) -> _Move to boot a GPS host and retrieve floppy._ -> ":"
  local _, direction = table.unpack(commands); makeBoot(direction);  -- prepares boot files
  move.left(1)-- turn left and then forward to left and in plane in front of drive
  move.up(1) -- up to left of computer still facing away from computer in plane in front of drive
  move.right(1) -- turn right toward computer and then forward into plane of computer
  move.right(0) --turn right to face computer on the side of the computer where there's no modem
  core.report(2, "Actuating " .. direction, move.ats())
  if peripheral then peripheral.call("front", "turnOn") end-- boot computer in game
  move.down(1) -- adjacent to drive
  core.report(2, "Retrieving floppy from ".. direction.." installation")
  turtle.sucks["front"]() -- retrieve floppy disk into a turtle slot (doesn't matter where)
  move.down(3) -- get away down from installation: clearance = 3
  core.report(2, "Actuated ".. direction.." installation at", move.ats())
  return "Actuated "..direction.." GPS host"
end

local function addVectors(displacements, xyzspot, orientation) -- add displacements to spot
  local xd, yd, zd = table.unpack(displacements); local xb, yb, zb = table.unpack(xyzspot)
  return {xd + xb, yd + yb, zd + zb, orientation}
end

local displacements = {north = {0, 0, -3}, south = {0, 0, 3}, east = {3, -3, 0}, west = {-3, -3, 0}, }

local function makePositions(xyzLocation, yDistance) -- positions for GPS computers
  core.report(2, "Deploy positions from", xyzLocation, yDistance)
  local xb, yb, zb = table.unpack(xyzLocation); local yGPS = math.min(253, yb + yDistance); 
  local xyzGPS = {xb, yGPS, zb} -- xyz for GPS = spot + y displacement
  local positions = {}; for direction, displacement in pairs(displacements) do
    positions[direction] = addVectors(displacement, xyzGPS, "south"); 
  end; return positions
end

local function count(target)    
  local total = 0; for i = 1, 16 do local detail = assert(turtle.item(i))
    local match = detail and detail.name == target
    total = match and total + detail.count or total
  end; return total
end

local function check() -- make sure all required is available
  local modems = assert(turtle.find({modem}), "gps: need ender modem") 
  local disks = assert(turtle.find({drive}), "gps: need drive") -- select drive
  assert(turtle.find({floppy}), "gps: need floppy") -- select floppy
  assert(count(computer) >= 4, "gps: need 4 computers")
  assert(modems.count >= 4, "gps: need 4 modems")
  assert(disks.count >= 4, "gps: need 4 disks")
  assert(turtle.find(turtle.category("fuel")), "gps: need fuel")
end

local order = {"north", "south", "east", "west"} -- for efficient movement

function _gps.launch(commands) -- use `locate` to give a `place` a `location`
  --:: `_gps.launch(commands: :[command: ":", location: ":", yD: #:?]) -> _Check before journey then launch._ -> ":"
  --:# _launch deployment needs 4 advanced computers, 4 disk drives, 4 ender modems, a floppy, and fuel._
  --:- launch place yD? -> _Deploy GPS launch yD or maximum y above place, report GPS at place._
  local _, location, yD = table.unpack(commands);  check() -- first, have everything?
  assert(location, "gps.launch: need to specify launch location")
  assert(place.match(location), "gps.launch: "..place.qualify(location).." not found")
  local xyzLocation = place.xyzf(location); yD = yD or 255; local positions = makePositions(xyzLocation, yD)
  
  for _, direction in ipairs(order) do local position = positions[direction]; 
    core.report(2, "GPS "..direction.." host to "..core.xyzf(position)) 
    move.to(position); _gps.equip(direction); install(position); _gps.actuate({"actuate", direction}) -- **do the work**
  end; core.report(2, "Returning to launch location"); move.to(xyzLocation)
  
  local xb, yb, zb = table.unpack(xyzLocation); local x, y, z = move.where(); 
  if not x then core.status(1, "gps", "GPS Locate Failed") end
  return "GPS "..x..", "..y..", "..z.." for "..xb..", "..yb..", "..zb
end gps.hints["launch "] = {["?location ??yDelta"] = {}}

local ops = {launch = _gps.launch, equip = _gps.equip, actuate = _gps.actuate, check = check} 

function gps.op(commands) 
  --:: gps.op(commands: {command: ":"[] }) -> _Command Line Interface._ -> `report: ":"` &:
  local ok, report = core.pass(pcall(ops[commands[1]], commands))
  if ok then return report else return "gps: "..report end -- report failure for error
end 

return {gps = gps}
