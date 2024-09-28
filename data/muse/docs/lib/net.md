--:! {net: [] (:)} <- **Net Remote Command Library** -> muse/docs/lib/net.md      
--:| net: _Command Line Library providing turtle operations used by remote library (effectively the UI for Muse)._ -> net  

--:# _Remote commands for turtles need prefixing by `farmer`, `miner`, `logger`,`porter`,  or `rover` roles._  

--:# **Dispatcher `op` catches net operations that raise exceptions so turtles report errors, ready for new commandsa.**  

--:# **Testing, Monitoring, and Control** (e.g., `farmer echo something something`)  

--:- status level [filename] -> _Set reporting hurdle and optionally save reporting in log file._  

--:- echo arguments ... -> _For testing: just returns its arguments._  

--:- quit message -> _Set `quit` flag to message; next `core.status` throws `error` to abort operations._  

--:# **Remote Turtle and Task Operations** (for turtle API operations, e.g., `rover find`)  

--:- fueling -> _Returns energy available in turtle slots._  

--:- items -> _Returns items in turtle inventory as string._  

--:- find name...? -> _Report and select first slot found [or if no name, just report inventory]._  

--:< **Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`orward_**  

--:- suck direction quantity? -> _Suck quantity items [or all] into available slot._   

--:- drop item direction quantity? -> _Drop quantity of selected items [or all]._   

--:- look direction -> _Detect and inspect direction, return report._  

--:- compare item direction... -> _Named item matches block in any of specified directions?_  

--:- attack direction -> _Attempts attack in specified direction._   

--:- dig direction distance hoeing... -> _Direction and distance to (possibly blocked) move, hoeings directions to hoe._  

--:- put filling direction distance putting... -> _Direction, distance to move, placing filling in puttings directions._  

--:- change target filling direction distance putting... -> _Move distance in direction replacing target with filling._  

--:# **Remote Turtle Motion Commands** (e.g., `farmer come`)  

--:- to place | x y z face?-> _To named place or position and face. Retry for different first direction._   

--:- go _(first letter of) directions followed by optional counts, e.g. `r 10 u east 3 u 4 d n`._ -> _Chained movement._  

--:- trace trailname ->  _Move turtle along traced situations in named trail from one end of trail to the other._  

--:- come -> _rover turtle towards GPS player position._  

--:- tail rate? -> _Move `rover` every rate (default 5) seconds towards GPS player position._  

--:< **Places - Points, Locations, Trails, and Ranges of Maps**  

--:- trail name label -> _Include named point at head and (current situation) tail of a new trail, update map._   

--:- point name label trail? -> _Add named labeled point, can start trail, MU updated map. (Player situation needs GPS.)_   

--:- range name label point point key? value?? -> _Volume by named points, optional key and value for feature._   

--:- chart filename ... -> _Loads and runs named file in `charts` directory to create named point and associated ranges._  

--:< **Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?**  

--:- at -> _Report current (dead reckoning) turtle position and facing or player GPS position._   

--:- near place? span?? -> _Report points within span blocks (or all) of named place (or current player or turtle position)._  

--:- view place -> _Report place details including all situations and features._  

--:- where place? count?? -> _Report movement direction, distance to named place (or all) three (or count) closest places._   

--:- fix trail? -> _Set and report GPS turtle position for dead reckoning. Optionally begin named trailhead._  

--:- headings rate? place? count?? -> _Repeated movement report at specified rate (or every _G.Muse.rates.headings) seconds)._  

--:# **Map File Operations** (e.g., `rover site ...`)  

--:- erase name -> _Remove named place, broadcast Muse eXcise (MX)._  

--:- sync -> _Muse Update (MU) broadcast local map to (MQ) registered units._  

--:- site name? -> _Remote operation to report or change site (persistently) after, e.g., porting `rover`._  

--:- site name? -> _Remote operation to report or change site (persistently) after, e.g., porting `rover`._  

--:- join site role -> _Set site and join landed turtle to it with specified role._  

--:# **GPS Launch Command** (e.g., `rover launch gantry ....`)  

--:- launch place yD? -> _Deploy GPS launch yD or maximum y above place, report GPS at place._  

--:# **Remote Mining Operation Commands** (e.g. `miner shaft ....`)  

--:- shaft minehead levels shaftPlans -> _Dig down number of levels under named minehead place using specified plans._  

--:- bore marker borePlans  -> _Dig horizontally from marker using saved or specified bore and shaft plans._   

--:- post marker borePlans?  -> _Go to marker (and up 1 block) from current level with saved or specified plans._  

--:- ores marker borePlans?  -> _Excavate ores from side tunnel near marker, return up 1 from marker._  

--:# **Remote Volume Operations** (bound by point pairs, possibly in a `range`)  

--:- cut point point -> _Quarry out blocks bound by named points (defining a rectangular solid)._  

--:< _Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:`   

--:- fill point point filling ?target -> _Layer fill bounds by points; optionally swaps out only target blocks._  

--:< _Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `"minecraft:"`  

--:- till point point seed -> _Till the seed bounds by named points (defining a rectangular solid)._  

--:- fence range [item] -> _Put item or available wooden fence from one point to another in range._  

--:# **Remote Farm Operations** (where a range feature value is a `fieldName` keyed by `field`, a string literal).    
--:+ _A `fieldName` is a file name without its suffix, e.g. `cane` rather than `cane.lua`, in the `fields` directory._    
--:= farm:  

--:- quarry range firstPlot? lastPlot?? -> _Dig out the field to level it._  

--:- layer range firstPlot? lastPlot?? -> _Put foundation material in place for field._  

--:- cover range firstPlot? lastPlot?? -> _Replace field material (for tree farm grid)._  

--:- finish range firstPlot lastPlot?? -> _Complete field preparation for farming._  

--:- harvest range firstPlot lastPlot?? -> _Harvest (and replant if needed)._  

--:- path range firstPlot lastPlot?? -> _Test harvest path (safely)._  

--:# **Command Computer Setup and Port Commands** (e.g., `locate gantry launch`)  

--:- locate name label? -> _Create launch point having Minecraft coordinates above `porter`._  

--:- activate range -> _Add borders from west and north to east and south of range for Minecraft forceload._  

--:- book name label from to span? item??... ->  _Spanned range with (default) items as properties; return cost less bank._  

--:- port booking -> _As provided in booking, consume player inventory to teleport entities from one area to another._  