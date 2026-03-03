--:? muse/docs/tests/remote.txt <- **Test `lib/remote`** -> muse/docs/tests/remote.md   

--:# Test remote commands for lib/task and lib/roam to test local operations of lib/remote  

--:# Set configuration globals for tests by loading `lib/check`  

--:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`  

--:# Set log level default. Set lower to report less, higher to report more  

--:# Bind `testName` as the last word (without extension) in the execution path  

--:# Create the test object for this test  

--:# **Remote Turtle and Task Operations** (for turtle API operations, e.g., `rover find`)  

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

--:- to place | x y z face?-> _To named place or position and face. Retry permutation for different first direction._   

--:- go _(first letter of) directions followed by optional counts, e.g. `r 10 u east 3 u 4 d n`._ -> _Chained movement._  

--:- trace trailname ->  _Move turtle along traced situations in named trail from one end of trail to the other._  

--:- come -> _rover turtle towards GPS player position._  

--:- tail rate? -> _Move `rover` every rate (default 5) seconds towards GPS player position._  

--:# **Remote Status Logging Control in lib/core**  

--:# **Remote turtle operations not subsumed by lib/task**  

--:# **Remote Low Level Turtle Operations in lib/task**  

--:- find name...? -> Report and select first slot found [or if no name, just report inventory].  

--:- attack direction -> Attempts attack in specified direction.  

--:- look direction -> Detect and inspect direction, return report.  

--:- drop item direction quantity? -> Drop quantity of selected items [or all].  

--:- suck direction quantity? -> Suck quantity items [or all] into available slot.  

--:- compare item direction+ -> _Named item matches block in any of specified directions?_  

--:- dig direction distance hoeings...? -> Direction and distance to (possibly blocked) move, hoeings directions to hoe.  

--:- put filling direction distance puttings+ -> Direction, distance to move, placing filling in puttings directions.  

--:- change target filling direction distance puttings+ -> Move distance in direction replacing target with filling.  

--:# **Remote Turtle Motion Commands** (e.g., `farmer go`)  

--:# **Remote Map Operations for Turtles and Player.**  

--:# Map File Operations  

--:- sync -> Muse Update (MU) broadcast local map to units at current site.  

--:- erase name -> Remove named place and broadcast Muse eXcise (MX) to units at current site.  

--:- site [name] -> _Remote operation to report or change site after, e.g., porting `rover`._test(23, "logger", "site")  

--:# Places - Points, Trails, and Ranges of Maps  

--:- point name label -> Add named and labeled point, broadcast updated map with (MU) Muse Update. (Player needs GPS.)  

--:- trail name -> Include named point at head and (current situation) tail of a new trail, update map.  

--:- range name label point point key value -> Define volume by named points, specify key and value of range property.  

--:- chart chartfilename ... -> _Loads and runs named chart file in `charts` directory to create named point and associated ranges._  

--:# Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?  

--:- at -> Report current (dead reckoning) turtle position and facing or player GPS position.  

--:- where [place] [count = 3] -> Report movement direction, distance to named place, and to count closest places.  

--:- near [place] [span] -> Report points within span blocks (or all) of named place (or current player or turtle position).  

--:- view place -> Report place details including all situations and properties.  

--:# **Command Computer Position and Port Commands** (e.g., `porter locate gantry launch``)  

--:- kit "base"|"site" -> _Kit up player for specifed `set` of items._  

--:- locate name label -> _Create point having Minecraft coordinates above `porter` Command Computer_  

--:- activate range -> _Add bounds from west and north to east and south of range for forceload._  

--:- book name label from to [span [item ...] ] -> _Spanned range with (default) items as properties; return cost less bank._  

--:- port booking -> _As laid out in booking, consume player inventory to teleport entities from one area to another._  

--:# **GPS Positioning**  

--:# **Mining Operations**  

--:# **Field Operations** (Simple Ones First)  