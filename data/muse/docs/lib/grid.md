--:! {grid: []: (:)} <- **Grid Mining Functions Library** -> muse/docs/lib/grid.md      
--:| grid: _Work functions boring, navigating, and mining ore in a grid of tunnels._ -> grid  

--:> crossplan: _Bore and mine, minimal movement_ -> `{:bores:, ores: {name: ":", fixtures: ":"[], path: ":"[], work: plan.work} }`  

--:# **Navigation for grids:  use placed markers to find posts for turtles.**  

--:: grid.mark(:plan:, :marking:) -> _Make place name, report result._ -> `markerName: ":", label: ":", report: ":"`    
--:+ _Called by `worker.execute` to make marker name and use it to add map point for navigation in mine._    
--:+ _Puts plan name value in marker (keyed by `"shaft"` or `"bore"`) so marker is enough for navigating in shaft or bore._    
--:+ _Marker place name formed as `head:level:base` or `head:base` or `head` with place labelled as `"outer"|"inner"|"shaft"`._    
--:= mine.post:: grid.post  

--:# **Mining Ore: look around for ore and if found, mine adjacent ore as well**  

--:# **Definitions for finding and extracting ores**  

--:> grid.cut: _Directions to dig in vein_ -> `"up"|"down"|"north"|"south"`  

--:> grid.guide: _Instructions for cut_ -> `:[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`  

--:: grid.ores(:plan:, :direction:, guide: grid.guide, :ores:) -> _Extract ores._ -> `"done" &!`    
--:+ _Given the guide for a vein, mine ores in each of the guide's cuts for that vein._  