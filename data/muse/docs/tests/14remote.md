--:? muse/docs/tests/14remote.txt <- **Run Regression Test for Muse** -> muse/docs/tests/14remote.md    

--:# **Remote Status Logging Control in lib/core**  

--:# **Remote turtle operations not subsumed by lib/task**  

--:- fuel -> _Returns energy available in turtle slots._  

--:- items -> _Returns items in turtle inventory._  

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