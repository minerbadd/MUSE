---@meta

local  port = {}

-- Command Line Interface for teleport book and trip:
-- port.op(commands: ":"[]):  `":" &:` <-

---@type fun( commands: string[]):   string 
function port.op() end

-- port.order:  `port.item[]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias port.order  port.item[] # Order in which inventory items will be considered for booking


-- For Testing: mock player inventory
-- port.available(set: [port.item]: #:):  `[port.item]: #:` <-

---@type fun( set: { [port.item]: number }):  { [port.item]: number  }
function port.available() end

-- port.item:  `"iron"|"copper"|"gold"|"redstone"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias port.item  "iron" | "copper" | "gold" | "redstone" # Short inventory item name for booking


-- Testing Booking (string) names the `range` entry that will be used to specify a `port` operation and how to pay for it. Return needed inventory for booking and bankable if > 0
-- port.book(name: ":", label: ":", from: place, to: place, span: #:, ordering: port.order):  `booking: ":"` <-

---@type fun( name: string,  label: string,  from: place,  to: place,  span: number,  ordering: port.order):   booking: string 
function port.book() end

-- Testing Returns payment inventory used for `costToPay`, excess energy to bank, inventory energy used
-- port.inventory(costToPay: #:, orderedItems: port.order, playerInventory: [port.item]: #:):  `":"[], #:, #:` <-

---@type fun( costToPay: number,  orderedItems: port.order,  playerInventory: { [port.item]: number }):   string[],  number,  number 
function port.inventory() end
return { port =  port}
