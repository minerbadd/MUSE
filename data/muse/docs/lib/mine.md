--:! [mine: [":"]: (:)] <- **Mine Command Line Library** -> muse/docs/lib/mine.md      
--:| mine: _CLL operates plan to manage mines: shaft, bore, move to posts (between and within levels), and get ores._ -> mine, _mine  

--:# **Interface for mining plans: digging and navigating shafts and bores, extracting ore**  

--:# **Plan elements for digging shafts going down, furnishing them going back up, and moving between levels.**   

--:> shafts: _Dig_ -> `{shafts.name: ":", shafts.down: downs, shafts.back: levels, shafts.lower: levels, shafts.higher: levels}`  

--:> shafts.name: _Included in error and status reports_ -> `":"`  

--:> shafts.down: _Plan for digging shaft one level through even and odd levels_ -> `downs`  

--:> shafts.back: _Plan for returning to minehead, placing fixtures and safety shelves for player_ -> `levels`  

--:> shafts.lower: _Plan for navigating from one (even or odd) level to the next lower_ -> `levels`  

--:> shafts.higher: _Plan for navigating from one (even or odd) level to the next higher_ -> `levels`  

--:# **Plan definitions for digging shafts down from even to odd and from odd to even levels**  

--:> downs: _Mark, dig, ladder, and fill one level (for landing platforms)_  -> `{downs.even: plan, downs.odd: plan, downs.last: plan }`  

--:> downs.even: _Mark, dig, ladder, and fill an even level (for landing platforms) -> `plan`  

--:> downs.odd: _Mark, dig, ladder, and fill an odd level (for landing platforms)_ -> `plan`  

--:> downs.last: _Mark last level dug_ -> `plan`  

--:# **Plan definitions for just moving between odd and even levels**  

--:> levels: _Traverse (and fill shelves for  player safety in back plan) shaft_  -> `{levels.even: plan, levels.odd: plan}`  

--:> levels.even: _Plan for navigating from one even level to the next -> `plan`  

--:> levels.odd: _Plan for navigating from one even level to the next_ -> `plan`  

--:# **Plan elements for boring and furnishing horizontal access tunnels at odd and even levels for mining**  

--:> bores: _Horizontals_ -> `{bores.name: ":", bores.post: mine.post, bores.even: plan, bores.odd: plan, bores.fix: plan }`  

--:> bores.name: _Included in error and status reports_ -> `":"`  

--:> bores.even: _Plan for boring tunnels at even levels_ -> `plan`  

--:> bores.odd: _Plan for boring tunnels at odd levels_ -> `plan`  

--:> bores.fix: _Plan for fixtures: shaft area ladders and placing barrel_ -> `plan`  

--:# **Interface definition for implemented bore navigation functions in mines**  

--:> mine.post: _Navigate shaft and bores to go to marker._ -> (markerName: ":", :bores:):  `marking[]`  

--:: mine.mark(:plan:, :marking:) -> _Make place name, report result._ -> `markerName: ":", label: ":", report: ":"`    
--:+ _Called by `worker.execute` to make marker name and use it to add map point for navigation in mine._    
--:+ _Puts plan name value in marker (keyed by `"shaft"` or `"bore"`) so marker is enough for navigating in shaft or bore._    
--:+ _Marker place name formed as `head:level:base` or `head:base` or `head` with place labelled as `"outer"|"inner"|"shaft"`._  

--:# **Go to minehead, dig shaft and return to minehead if no errors.**    
--:+ _Start dig down from minehead, finish by placing marker one level below target level, error raised for failure._    
--:+ _Add "shaft" and shaft plans name as key and value to shaft plans for inclusion in marker._    
--:+ _Execute shaft plans back to return to minehead from one below target level_    
--:+ _Add "shaft" and shaft plans name as key and value to shaft plans for inclusion in marker_  

--:# **Do the `shaft` operation for the command line interface.**  

--:- shaft minehead levels shaftPlans -> _Dig down number of levels under named minehead place using specified plans._  

--:# **Do the `post` operation for the command line interface**.  

--:- post marker borePlans?  -> _Go to marker (and up 1 block) from current level with saved or specified plans._  

--:# **Bore horizontal tunnels and mine tunnels branching off the main tunnel for ore**    
--:+ _Use shaft plans and bore plans to navigate to marker, bore horizontal tunnels using bore plans._    
--:+ _Add "bore" and bore plans name as key and value to bore plans for inclusion in marker._    
--:+ _Bores plans at even or odd level, potentially leaves place marks and torches._  

--:- bore marker borePlans  -> _Dig horizontally from marker using saved or specified bore and shaft plans._     
--:+ _Use shaft plans and instantiated bore plans to go to marker and execute mining operations_  

--:- ores marker borePlans?  -> _Excavate ores from side tunnel near marker, return up 1 from marker._  

--:: mine.op(arguments: [op: ":", placeName: ":", borePlansFileOrLevels: ":"|#:, shaftPlansFile: ":"]) -> _Dig._ -> `^:, ":", #: &:`    
--:+ _Dig shaft; go to post at level; bore, mark, and torch; get ores. Markers hold saved plans._  