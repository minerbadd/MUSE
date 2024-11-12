--[[
## Mock Turtle and Command Computer Simulation for Out-of-Game Debug: `lib/mock.lua` 
```md
--:! { turtle: []: (:), commands: []: (:) } <- **Mock Functions Library** (for out-of-game test) -> muse/docs//lib/mock.md 
--:| mock: _Libraries to provide a limited simulation of turtle and command computer in-game operations._ -> mock
--:+ turtle: _Generally just returns success but allows for simulated blocking, fuel consumption, refueling._  
--:+ commands: _Mock returns from command computer and report success._
```
```Lua
--]]
local turtle, commands = {}, {} -- exported

local selected = 1; local refuelLevel = 100; local success = true; 
_G.Muse.fuel = _G.Muse.fuel or 80; 

local computer, modem = "computercraft:computer_advanced", "computercraft:wireless_modem_advanced"
local drive, floppy  = "computercraft:disk_drive", "computercraft:disk"

--:# _Mock turtle has coal, torches, fences, dirt, ladders, wheat seeds, reeds, sand, and saplings._
--:+ _As well as barrels, granite, potatoes, carrots, beetroot seeds, and kelp._
--:+ _And advanced computers, ender modems, disk drives and floppies in its slots._

turtle.slots = {
  {name = "minecraft:coal", count = 64}, 
  {name = "minecraft:torch", count = 8},
  {name = "minecraft:birch_fence", count = 8},
  {name = "minecraft:dirt", count = 64}, --4
  {name = "minecraft:ladder", count = 64},
  {name = "minecraft:wheat_seeds", count = 8}, 
  {name = "minecraft:reeds", count = 22}, 
  {name = "minecraft:sand", count = 33}, --8
  {name = "minecraft:birch_sapling", count = 11},
  {name = computer, count = 4}, 
  {name = modem, count = 4}, 
  {name = drive, count = 4}, --12
  {name = floppy, count = 1},
  {name = "minecraft:barrel", count = 33}, 
  {name = "minecraft:granite", count = 33}, 
  {name = "minecraft:potato", count = 6}, --16
  {name = "minecraft:carrot", count = 4},
  {name = "minecraft:beetroot_seeds", count = 4},
  {name = "minecraft:kelp", count = 4},
}

function turtle.select(i) selected = i; return turtle.slots[i]end
function turtle.getItemDetail(i) return turtle.slots[i or selected] end 

function turtle.refuel() _G.Muse.fuel = refuelLevel; return _G.Muse.fuel > 0 end
function turtle.getFuelLevel() return _G.Muse.fuel end

--:# _Inspection shows dirt for down direction, otherwise nothing._
function turtle.inspect() return false, "nothing here" end
function turtle.inspectUp() return  true, {name="minecraft:coal"} end
function turtle.inspectDown() return true, {name="minecraft:dirt"}  end

--:# turtle.block(blocked: ^:) -> _Sets blocked status to `blocked` for debug_ -> blocked: `^:`
function turtle.block(blocked) _G.Muse.blocked = blocked; return _G.Muse.blocked end -- for testing

--:# _Turns just report success, other motions decrement the simulated fuel and report success unless blocked._
--:+ _Only forward motion can be blocked in simulation._

function turtle.turnRight() return success end
function turtle.turnLeft() return success end
function turtle.back() _G.Muse.fuel = _G.Muse.fuel - 1; return success end
function turtle.up() _G.Muse.fuel = _G.Muse.fuel - 1; return success end
function turtle.down() _G.Muse.fuel = _G.Muse.fuel - 1; return success end
function turtle.forward() 
  if not _G.Muse.blocked then _G.Muse.fuel = _G.Muse.fuel - 1; return success end 
  return false
end

--:# _Primitive turtle operations are mocked: attack, dig, place, detect, compare, drop, and suck._
function turtle.attack() return true end
function turtle.attackUp() return true end
function turtle.attackDown() return true end

function turtle.dig() return true end
function turtle.digUp() return true end
function turtle.digDown() return true end

function turtle.place() return true end
function turtle.placeUp() return true end
function turtle.placeDown() return true end

function turtle.detect() return true end
function turtle.detectUp() return true end
function turtle.detectDown() return true end

function turtle.compare() return true end
function turtle.compareUp() return true end
function turtle.compareDown() return true end

function turtle.drop() return true end
function turtle.dropUp() return true end
function turtle.dropDown() return true end

function turtle.suck() return true end
function turtle.suckUp() return true end
function turtle.suckDown() return true end

--:# _A few command computer operations are mocked: `getBlockPosition`, `getBlockInfo`, and `exec`._
function commands.getBlockPosition(x, y, z) return x, y, z end
--:# commands.getBlockPosition(x: #:, y:, #:, z: #) -> _Mock position._ -> `x: #:, y:, #:, z: #`
function commands.getBlockInfo(_, _, _, resultTable) return resultTable end
--:# commands.getBlockInfo(_: _: , _: _: ,_: _: , resultTable: {:}) -> _Mock info._ -> `resultTable: {:}`
function commands.exec(_, result) return true, result end
--:# commands.exec(_: _:, result: any) -> _Mock exec command._ -> `result: any`

return {turtle = turtle, commands = commands}