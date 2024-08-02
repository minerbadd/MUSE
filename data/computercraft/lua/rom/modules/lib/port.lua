--[[
## Book and Port Booking From Place (Spanning Area) To Place Offering Inventory
```md
--:! {port: []: (:)} <- **Transport Operations Command Line Library** -> muse/docs/lib/port.md  
--:| port: _CLL for `book` and `port` commands assessing and clearing player inventory for specified teleport._ -> port
```
```Lua
--]]
local port = {}; port.hints = {} ---@module "signs.port" -- for functions exported from library

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local places = require("places"); local place = places.place ---@module "signs.places"
local maps = require("map"); local map = maps.map ---@module "signs.map"

local mock = require("mock").commands ---@module "signs.mock"
---@diagnostic disable-next-line: undefined-field
local commands = _G.rednet and _G.commands or mock

--:# Partially consumed inventory items add to the energy `bank` used to decrease a future porting cost in a session.
local function bank(value) if value then _G.Muse.portBank = value end return _G.Muse.portBank or 0 end-- maintained over session

--:# Default player inventory items are considered for `book` and `port` (porting) operations.
local itemValues = {iron = 10, copper = 30, gold = 90, redstone = 270,} -- relative energies
local orderDefault = {"redstone", "gold", "copper", "iron",}

local itemNames = { --:> port.item: _Short inventory item name for booking_ -> `"iron"|"copper"|"gold"|"redstone"`
  iron = "minecraft:iron_ingot", copper = "minecraft:copper_ingot	", 
  gold = "minecraft:gold_ingot", redstone = "minecraft:redstone"}

local height = 3 --:# Rather arbitrarly, height for porting includes a player standing on a turtle

--:# **Support and test functions for `book` and `port` operations.**
--:+ _Assess player inventory considered for energy available to do work._

local function energy(inventory)
  local sum = 0; for item, count in pairs(inventory) do sum = sum + count * (itemValues[item] or 0) end
  return sum
end

function port.inventory(costToPay, orderedItems, playerInventory) -- how to pay cost of porting 
  --:: port.inventory(costToPay: #:, orderedItems: port.order, playerInventory: [port.item]: #:) -> _Testing_ -> `":"[], #:, #:`
  --:+ _Returns payment inventory used for `costToPay`, excess energy to bank, inventory energy used_
  --:> port.order: _Order in which inventory items will be considered for booking_ -> `port.item[]`
  local paymentInventory, costUnpaid = {}, costToPay; -- start with no items from `playerInventory` in payment
  for _, item in ipairs(orderedItems) do local itemCount = playerInventory[item] or 0
    local eachValue = itemValues[item] or 0
    local inventoryItemValue = itemCount * (itemValues[item] or 0)

    if costUnpaid <= inventoryItemValue then -- **costToPay met with payment inventory, excess to bank, inventory energy used** 
      paymentInventory[item] = math.ceil(costUnpaid/eachValue) -- count
      return paymentInventory, energy(paymentInventory) - costToPay, energy(playerInventory) 
    end;
    -- cost unmet by item: add all of item to payment, reduce unpaid cost, try next item
    paymentInventory[item] = itemCount; costUnpaid = costUnpaid - inventoryItemValue

  end; 
  return paymentInventory, -costUnpaid, energy(playerInventory) -- inventory all used, unmet cost
end

local function getInventory(items) -- find player's available inventory quantities for named items in-game (untestable)
  local inventory = {}; for _, item in ipairs(items) do -- `clear` of zero items gets count if command succeeds
    local considered = itemNames[item] or item
    local success, count = commands.exec("clear @p "..considered.." 0")
    assert(success, "port.getInventory: failed for "..considered)
    inventory[item] = count -- build up view of inventory
  end; return inventory 
end 

function port.available(set)  -- for testing
  --:: port.available(set: [port.item]: #:) -> _For Testing: mock player inventory_ -> `[port.item]: #:`
  
  local inventoryTest = set or _G.Muse.inventoryTest; _G.Muse.inventoryTest = inventoryTest; return inventoryTest
end

local function portingCost(xyzfFrom, xyzfTo, span, orderedItems, testInventory) -- get energy needed for porting 
  span = span or 0; local distance = place.distance(xyzfFrom, xyzfTo)
  local volume = height * (((2 * span) + 1) ^ 2) -- span drives area (by square)
  local work = volume * distance; local cost = work - bank() -- reduce cost by bank 
  local playerInventory = testInventory or (next(port.available()) and port.available() or getInventory(orderedItems));
  local inventoryCost, bankable = port.inventory(cost, orderedItems, playerInventory)
  return inventoryCost, bankable, cost -- bankable < 0 => insufficient inventory
end

function port.book(name, label, from, to, span, ordering) -- testable
  --:: port.book(name: ":", label: ":", from: place, to: place, span: #:, ordering: port.order) -> _Testing_ -> `booking: ":"`
  --:+ _Booking (string) names the `range` entry that will be used to specify a `port` operation and how to pay for it._
  --:+ _Return needed inventory for booking and bankable if > 0_
  local xyzfFrom = assert(place.xyzf(from), "port.book: "..place.qualify(from).." unknown place"); 
  local xyzfTo = assert(place.xyzf(to), "port.book: "..place.qualify(to).." unknown place")
---@diagnostic disable-next-line: assign-type-mismatch -- key: `booking`, value: any
  map.op {"range", name, label, from, to, "booking", {span, ordering or orderDefault}}
  local inventoryCost, bankable, cost = portingCost(xyzfFrom, xyzfTo, span, ordering)
  local bookString = tostring(cost).. "J, bankable (or unmet) "..tostring(bankable).."J using "..core.string(inventoryCost)
  return bookString  
end

--:# **Booking from place spanning area to place, offering items for port operation**
local function book(name, label, from, to, span, ...) -- in-game only
  --:- book name label from to span? item??... ->  _Spanned range with (default) items as properties; return cost less bank._
  assert(commands, "port.book: not a command computer")
  local items = select("#", ...); local ordering = items > 0 and {...} or orderDefault
  --:# Save booking as a `range` with `span` and offered or default ordering of items as `range` properties
  return port.book(name, label, from, to, span, ordering)
end port.hints["book"] = {["?name ?label ?from ?to ??span=0 ???item..."] = {} }

local function portingCommand(xyzFrom, xyzTo, span)
  -- # **With inventoryCost, bankable, and the xyzf from and to, create the string for the porting command.**
  local fx, fy, fz = table.unpack(xyzFrom); local tx, ty, tz = table.unpack(xyzTo)
  local bfx, bfz = tostring(fx - span), tostring(fz - span); local dx, dz = tostring(span * 2), tostring(span * 2); 
  local btx, btz = tostring(tx - span), tostring(tz - span); local bty = tostring(ty)
  local fromString = "@e[x="..bfx..",dx="..dx..",y="..tostring(fy)..",dy="..tostring(height)..",z="..bfz..",dz="..dz.."]"
  return fromString.." "..btx.." "..bty.." "..btz
end

local function ports(booking, testInventory) --:# **Port operation consuming player inventory offered in booking.**
  --:- port booking -> _As provided in booking, consume player inventory to teleport entities from one area to another._
  assert(commands, "port.ports: not a command computer"); assert(booking, "port.ports: need booking for porting")
  local _, features, from, to = map.borders(booking) -- ignore cardinal direction borders
  local xyzFrom, xyzTo = {from.x, from.y, from.z}, {to.x, to.y, to.z}
  local bookingFeatures = assert(features.booking, "port.ports: no booking features in "..booking)
  local span, orderedItems = table.unpack(bookingFeatures) -- might be default
  assert(span and orderedItems, "port.ports: missing span or items in "..booking)
  local inventoryCost, bankable, cost = portingCost(xyzFrom, xyzTo, span, orderedItems, testInventory)
  if bankable < 0 then return "Need "..cost.." but only have "..cost + bankable end

  local porting = portingCommand(xyzFrom, xyzTo, span)
  local bookString = tostring(cost).. "J, bankable (or Unmet) "..tostring(bankable).."J using "..core.string(inventoryCost)
  if testInventory then return bookString.."\n".. porting end

  --:# **If this is in-game, do the port and if successful, pay for it by clearing counts of selected items**
  local portOK, portMessage = commands.exec("teleport "..porting); assert(portOK, portMessage) -- did it
  for item, count in pairs(inventoryCost) do -- pay for it
    local clearOK, clearMessage = commands.exec("clear "..item.." "..tostring(count)); assert(clearOK, clearMessage); 
  end; bank(bankable); return "Ported "..booking..", banked "..bank().."J"
end port.hints["port"] = {["?booking"] = {} }

local ops = {book = book, port = ports, }

function port.op(commands) --:: port.op(commands: ":"[]) -> _Command Line Interface for teleport book and trip:_ -> `":" &:`
  local ok, report = core.pass(pcall(ops[commands[1]], table.unpack(commands, 2)))
  if ok then return report else return "port: "..core.string(report) end -- report failure for error
end

return {port = port}