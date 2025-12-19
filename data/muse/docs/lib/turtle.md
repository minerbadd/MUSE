--:! [turtle: [":"]: (:) ] <- **Turtle Operations Overlay Library** -> muse/docs/lib/turtle.md      
--:| turtle: _Replaces game definitions, unifies operations to all directions: north, east, south, west, up, down._ -> turtle    
--:+ _Provides low level item finding, naming and turtle inventory utilities; out-of-game simulated blocking._    

--:> direction: _Four compass points and verticals_ -> `"north"|"east"|"south"|"west"|"up"|"down"`  

--:# **Turtle operations north, east, south, west, up, down**  

--:# **Operation dictionaries keyed by direction, values are generally functions of no arguments calling which return a boolean.**  

--:> turtle.attacks: _Attack in direction and return attack success._ -> `[direction]: (): ^:, ":"?`  

--:> turtle.compares: _Check block in direction has the same ID as selected slot_ -> `[direction]: (): same: ^:`  

--:> turtle.detects: _Check block in direction is solid: not air, mob, liquid or floater._ -> `[direction]: (): ^:`  

--:> turtle.digs: _Try to dig block in direction and call_ suck(). -> `[direction]: (side: ":"?): ^:, ":"?`    
--:+ _Sucked items go to inventory. If a hoe is used to attempt to "dig" a dirt block, it will be tilled instead._    
--:+ _Tilling is also possible if the space in front of the turtle is empty but dirt exists below that point._  

--:> turtle.drops: _Drop count [or all] items in selected slot to inventory._ -> `[direction]: (count: #:?): ^:, ":"?`    
--:+ _Returned function drops and returns_ `false` _if there's inventory on the side specified by direction which is full._  

--:> turtle.inspects: _If true, get detail block information in direction._ -> `[direction]: (): `^:`, `detail?`  

--:> turtle.puts:  _Attempt placing block of the selected slot in direction._ -> `[direction]: (text: ":"?): ^:, ":"?`    
--:+ _Collects water or lava if the currently selected slot is an empty bucket. Text is used for placed sign._     
--:+ _Value of `turtle.puts[:direction:]` is a function of one optional argument calling which returns a boolean._  

--:> turtle.sucks: _Move count [or all] from direction to inventory._ -> `[direction]: (count: #:?): ^:, ":"?`    
--:+ _Move from ground or first non empty slot of adjacent inventory enabled block to selected or next turtle slot._    
--:+ _Value of `turtle.sucks[:direction:]` is function of one optional argument calling which returns a boolean._  

--:# **Function References**  

--:: turtle.find(targets: ":"[]) -> _Selects found slot._ -> `detail?`  

--:: turtle.select(slot: #:) -> _Attempts to select the specified slot._ -> `selected: ^:`  

--:: turtle.item(slot: #:?) ->  _Detail of specified or currently selected slot._ -> `nil | detail`  

--:# **Item name and turtle status utilities**  

--:: turtle.inventory() -> _Returns currrent turtle inventory as turtle detail table_. -> `detail[]`  

--:- items -> _Returns items in turtle inventory as string._  

--:: turtle.check(targets: ":"[], :detail:) -> _Tries to match each target against_ `detail.name`. -> ``matched: ^:`  

--:# _Categories provide names for sets of minecraft items._  

--:> ore: _Minecraft_ -> `"minecraft:coal_ore"|"minecraft:iron_ore"|"minecraft:lapis_ore"|"minecraft:gold_ore"|"minecraft:diamond_ore"|"minecraft:redstone_ore"|"minecraft:emerald_ore"|"minecraft:nether_quartz_ore"|"minecraft:prismarine"|minecraft:obsidian"`  

--:> ores: _Category_ -> `ore[]`  

--:> minecraft: _For Language Server_ -> ":"  

--:> group: _Materials_ -> `"fuel" | "ore"| "fill" | "dirt" | "stone" | "fence" | "test"`  

--:# **Fence material specified by short name (e.g. `oak`) along points specified by `range`**  

--:> fencings: _Wooden materials_ `-> "birch" | "acacia" | "bamboo" | "cherry" | "chrimson" | "dark oak" | "mangrove" | "oak"`  

--:: turtle.category(name: ":") -> _Names in category or fencings matching `name` or_ `{"minecraft:"..name}`. -> `":"[]`   

--:- fueling -> _Returns energy available in turtle slots._  

--:: turtle.fuel() -> _Total energy actually available in turtle slots plus turtle fuel level._ -> `fuelTotal: #:`  

--:: turtle.unblock(direction: ":", limit: #:?) -> _Retrys (default `_G.Muse.attempts`) dig to limit or bedrock._ -> `"done", nil|"undug" &!`     
--:+ _Returns "done, "undug" if dig attempt was for air, water, or lava. Raises error for bedrock or dig limit reached._  

--:: turtle.digTo(:xyzf:, limit: #:?) -> _Unblocking move._ -> `code: ":", remaining: #:, xyzf: ":" &: &!`     
--:+ _Try to move to position, dig to unblock if needed, catch (table) and raise error(string) for "lost" or "empty"._    
--:+ _Also catch and raise error (string) if attempt to dig to unblock failed for bedrock or other reason._    
--:+ _Normally return just what a successful move would: "done", 0 remaining, current position._  

--:: turtle.digAround(orientation: ":", name: ":", diggings: ":"[]) -> _Unblocking dig._ -> `"done" &: &!`    
--:+ _Dig (unblocking) in diggings directions, catch failure and raise error(string) re-orienting in original orientation._  