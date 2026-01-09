--:! {planner: [":"]: ():} <- **Functions Library to Build a Plan** -> muse/docs/lib/planner.md    
--:| planner: _Given a_ `plan`, _create a table of operations to be performed by_ `worker.execute`. -> planner, plan  

--:> plan: _How to do work_ -> `{name: plan.name, path: plan.path, work: plan.work, fixtures: plan.fixtures, mark: plan.mark}`  

--:> plan.name: _for status and error reporting_  -> `":"`  

--:> plan.path: _table of space separated character sequence strings describing path_ -> `":"[]`  

--:> plan.work: _for execution at every_ `step` _iteration in plan movement direction_ -> `(:plan:, direction: ":"): ":"?`  

--:> plan.fixtures: _for placement as specified by path elements beginning with a digit_ -> `":"[]`  

--:> plan.mark: _for execution as specified by_ `plan.path` _markers_ -> `(:plan:, :marking:): markerName: ":", label: ":", report: ":"`  

--:> marking: _literals table of marker parts_ -> `[prefix: ":", base: ":", label: ":"]`  

--:> markings: _dictionary of markings keyed by a label_ -> `[label: ":"]: marking`  

--:# **Plan elements beginning with a letter indicate stepped movement in one of six directions: u, d, n, e, s, or w.**    
--:+ _Optionally, the letter may be followed by a number of blocks for the movement. The element ends with a space._    
--:+ _Elements beginning with a digit (indexing plan's fixtures table) are followed by a letter specifying direction._    
--:+ _Plan elements beginning with a colon indicate placement of a `mark`, a named and labelled `place`._    
--:+ The `plan.mark` function might replace each colon in a marker string prefix with, for example, a shaft name and level.     
--:+ _Characters between the last colon and a_ "|" _vertical bar character are the `base` argument for `plan.mark`._    
--:+ _Characters following the_ "|" _are the marker label for `plan.mark._  

--:: planner.load(planFileName: ":") -> _Instantiates what is returned from a plan file._ -> `plan &!`   

--:: planner.make(plan:plan) -> _Create path operations table for plan._ -> `pathElements, fuelOK: ^:, pathDistance: #:`  

--:> pathElements: _Used by `worker.execute` to run plan_ -> `(stepElement|putElement|markElement)[]`  

--:> stepElement: _Iterate steps function in direction for distance_ -> `[op: "step", :stepping:, direction: ":", distance: #:]`  

--:> putElement: _Put fixture in specified direction_ -> `[op: "put", direction: ":", fixture: ":"]`  

--:> markElement: _Current situation in named places_ -> `[op: "mark", :marking:]`  

--:# **Marker parsing utility function**  

--:: planner.mark(markerName: ":") -> _Parse marker name into parts._ -> `shaft: ":"?, level: ":"?, tag: ":"?)`  