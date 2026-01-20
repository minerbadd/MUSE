---@meta

local  turtle = {}

-- group:  `"fuel" | "ore"| "fill" | "dirt" | "stone" | "fence" | "test"`
---@alias group  "fuel"  |  "ore" |  "fill"  |  "dirt"  |  "stone"  |  "fence"  |  "test" # Materials


-- turtle.drops:  `[direction]: (count: #:?): ^:, ":"?`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.drops fun( count: number?):   boolean,  string? # Drop count [or all] items in selected slot to inventory.


-- Names in category or fencings matching `name` or_ `{"minecraft:"..name}`.
-- turtle.category(name: ":"):  `":"[]`  <-

---@type fun( name: string):   string[]
function turtle.category() end

-- turtle.attacks:  `[direction]: (): ^:, ":"?`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.attacks { [direction]:fun():  boolean,  string? } # Attack in direction and return attack success.


-- minecraft:  ":"
---@alias minecraft  string # For Language Server


-- turtle.compares:  `[direction]: (): same: ^:`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.compares { [direction]:fun():  same: boolean } # Check block in direction has the same ID as selected slot


-- Retrys (default `_G.Muse.attempts`) dig to limit or bedrock.
-- turtle.unblock(direction: ":", limit: #:?):  `"done", nil|"undug" &!`  <-

---@type fun( direction: string,  limit: number?):   "done",  nil | "undug" 
function turtle.unblock() end

-- turtle.sucks:  `[direction]: (count: #:?): ^:, ":"?`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.sucks fun( count: number?):   boolean,  string? # Move count [or all] from direction to inventory.


-- direction:  `"north"|"east"|"south"|"west"|"up"|"down"`
---@alias direction  "north" | "east" | "south" | "west" | "up" | "down" # Four compass points (cardinals) and verticals


-- Tries to match each target against_ `detail.name`.
-- turtle.check(targets: ":"[], :detail:):  `matched: ":"?` <-

---@type fun( targets: string[],  detail: detail):   matched: string? 
function turtle.check() end

-- turtle.detects:  `[direction]: (): ^:`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.detects { [direction]:fun():  boolean } # Check block in direction is solid: not air, mob, liquid or floater.


-- fencings:  "birch" | "acacia" | "bamboo" | "cherry" | "chrimson" | "dark oak" | "mangrove" | "oak"`
---@alias fencings  "birch"  |  "acacia"  |  "bamboo"  |  "cherry"  |  "chrimson"  |  "dark oak"  |  "mangrove"  |  "oak" # Wooden materials


-- ore:  `"minecraft:coal_ore"|"minecraft:iron_ore"|"minecraft:lapis_ore"|"minecraft:gold_ore"|"minecraft:diamond_ore"|"minecraft:redstone_ore"|"minecraft:emerald_ore"|"minecraft:nether_quartz_ore"|"minecraft:prismarine"|minecraft:obsidian"`
---@alias ore  "minecraft:coal_ore" | "minecraft:iron_ore" | "minecraft:lapis_ore" | "minecraft:gold_ore" | "minecraft:diamond_ore" | "minecraft:redstone_ore" | "minecraft:emerald_ore" | "minecraft:nether_quartz_ore" | "minecraft:prismarine" | minecraft:obsidian" # Minecraft


-- turtle.digs:  `[direction]: (side: ":"?): ^:, ":"?`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.digs fun( side: string?):   boolean,  string? # Try to dig block in direction and implicitly call_ suck().


-- Unblocking dig. Dig (unblocking) in diggings directions, catch failure and raise error(string) re-orienting in original orientation.
-- turtle.digAround(orientation: ":", diggings: ":"[], name: ":"?):  `"done" &: &!` <-

---@type fun( orientation: string,  diggings: string[],  name: string?):   "done" 
function turtle.digAround() end

-- turtle.puts:  `[direction]: (text: ":"?): ^:, ":"?`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.puts fun( text: string?):   boolean,  string? # Attempt placing block of the selected slot in direction.


-- ores:  `ore[]`
---@alias ores  ore[] # Category


-- Unblocking move. Try to move to position, dig to unblock if needed, catch (table) and raise error(string) for "lost" or "empty". Also catch and raise error (string) if attempt to dig to unblock failed for bedrock or other reason. Normally return just what a successful move would: "done", 0 remaining, current position.
-- turtle.digTo(:xyzf:, limit: #:?):  `done: ":" &: &!`  <-

---@type fun( xyzf: xyzf,  limit: number?):   done: string 
function turtle.digTo() end

-- Total energy actually available in turtle slots plus turtle fuel level. Returns "done, "undug" if dig attempt was for air, water, or lava. Raises error for bedrock or dig limit reached.
-- turtle.fuel():  `fuelTotal: #:` <-

---@type fun():  fuelTotal: number 
function turtle.fuel() end

-- turtle.inspects:  `[direction]: (): `^:, detail?`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias turtle.inspects { [direction]:fun():  boolean,  detail? } # If true, get detail block information in direction.


-- Selects found slot.
-- turtle.find(targets: ":"[]):  `detail?`, #:?, ^:? <-

---@type fun( targets: string[]):   detail?,  number?,  boolean? 
function turtle.find() end

-- Returns currrent turtle inventory as turtle detail table_.
-- turtle.inventory():  `detail[]` <-

---@type fun():  detail[]
function turtle.inventory() end
return { turtle =  turtle}
