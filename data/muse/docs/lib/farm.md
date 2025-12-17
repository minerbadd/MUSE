--:! [farm: [":"](:)] <- **Turtle Work Functions Support Library** -> muse/docs/lib/farm.md      
--:| farm: _Planting through blockages and in several directions. Putting item and replacing blocks._-> farm  

--:> farmOpName: _Specifies operation on field_ -> `"quarry"|"layer"|"cover"|"finish"|"fence"|"harvest"|"path"|"test"`  

--:# **Remote Commands for `farmer` and `logger` farm operations (`fieldOpNames`) on plots of fields bounded by ranges**  

--:- quarry range firstPlot? lastPlot?? -> _Dig out the field to level it._  

--:- layer range firstPlot? lastPlot?? -> _Put foundation material in place for field._  

--:- cover range firstPlot? lastPlot?? -> _Replace field material (for tree farm grid)._  

--:- finish range firstPlot lastPlot?? -> _Complete field preparation for farming._  

--:- harvest range firstPlot lastPlot?? -> _Harvest (and replant if needed)._  

--:- path range firstPlot lastPlot?? -> _Test harvest path (safely)._  

--:# **Work Funcions for a `farm`**  

--:: farm.logs(seedlings: ":"[], :direction:) -> _Logs down and sides, plants found seedlings._ -> `report: ":" &!`  

--:: farm.plant(planting: ":") -> _Tills and plants found planting._ -> `report: ":" &!`   

--:: farm.put(putAim: direction, item: ":"[]|":") -> _Puts found item in aimed direction._ ->  `report: ":" &!`  

--:: farm.replacer(putAim: direction, item: ":"[]|":", removables: ":"[]) -> _Remove, put._ -> `(_:, :direction:): ":" &!`     
--:+ _Returns a function used by `lib/worker` to inspect aimed direction, farm out any removeable, replace with found item._    
--:+ _The direction of movement parameter in that function is used to reface turtle after replacement._  