--:! {grid: [":"]: ():} <- **Grid Mining Functions Library** -> muse/docs/lib/grid.md      
--:| grid: _Work functions boring, navigating, and mining ore in a grid of tunnels._ -> grid  

--:# **Navigation for grids:  use placed markers to find posts for turtles.**    
--:= mine.post:: grid.post  

--:# **Mining Ore: look around for ore and if found, mine adjacent ore as well**  

--:# **Definitions for finding and extracting ores**  

--:> grid.cut: _Directions to dig in vein_ -> `"up"|"down"|"north"|"south"`  

--:> grid.guide: _Instructions for cut_ -> `[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`  

--:: grid.ores(plan: crossplan, :direction:, guide: grid.guide, :ores:) -> _Extract ores._ -> `"done" &!`    
--:+ _Given the guide for a vein, mine ores in each of the guide's cuts for that vein._  

--:> crossplan: _Bore and mine, minimal movement_ -> `{:bores:, ores: {name: ":", fixtures: ":"[], path: ":"[], work: plan.work} }`  