--:! {field: [":"]():} <- **Field Functions Library: Produce and Execute Field Plans** -> muse/docs/lib/field.md      
--:| field: _Fields are rectangular solids defined by a range (a `situation` pair with `fields` keyed properties)._ -> field, _field    
--:+ _Fields are made up of plots, each plot at least small enough to deal with turtle inventory limitations._  

--:# **Execution train runs from `field.make` to `field.plot` to `field.plan` to execute the plan**  

--:: field.make(commands: fieldCommands, faced: ^:) -> _Load field files; return their `field.plot` calls_ -> `report: ":" &:`  

--:> fieldCommands: _For CLI_ -> `[fieldOpName: ":", ranger: ":",  firstPlot: #:?, lastPlot: #:??]`    
--:+ _The second entry, `ranger` in `fieldCommands` is a string which may simply be a name for a `range`, (a kind of `place`)._    
--:+ _If so, the range name gets the range's features dictionary and the field file name to load (keyed as `features.fields`)._    
--:+ _It could also be a string specifying the name of a farm and a farm field name in that farm (separated by a colon)._    
--:+ _If so, the farm name specifies the farm's `range` and so the farm range's features dictionary._    
--:+ _The `fields` entry in that dictionary is itself a dictionary, keyed by the farm's field name to specify its range name._    
--:+ _With the proper range name in hand, either directly as above, or from the farm, the field file to load is specified._  

--:: field.plot(commands: field.plotSpan, fieldsOp: ():, fieldOpName: ":", plots: #:, offset: xyz?) -> _Plots_ -> `report: ":" &: &!`    
--:+ _Called by field files. Calls `fieldsOp` from field file (which calls `field.plan`)._  

--:> field.plotSpan: _`{}` spans all plots; if only first, default plots after first ->_ `[_:, _:, first: #:?, last: #:??]`  

--:: field.plan(planName: ":", fielding: fieldParameters, offset: xyz?) -> _Run plan, default offset {0,0,0}._ -> `report: ":" &: &!`    
--:+ _Loads and executes the prototype plan (which calls `field.paths`) for each (odd, even, or last) level of a plot._  

--:> fieldParameters: _`bounds` (and materials to fill and replace)_ -> `[bounds, fieldParameters.fills?, fieldParameters.removeables??]`  

--:> fieldParameters.fills: _Group or list of craft items for fill material_ -> `group|craft[]`  

--:> fieldParameters.removeables: _Material replaced by fill_ -> `group|craft[]`  

--:> craft: _Minecraft item `detail.name` without `minecraft:` prefix_ -> `":"`  

--:: field.extents(:bounds:, :strides:, faced: ":"?) -> _Plots placed_ -> `field.count, field.count , eP, eP, striding, ^:, ^:`    
--:+ Returns `nplots: #:, slots: #:, strides: eP, run: eP, striding: xyz, turn: ^:, back: ^:`    
--:+ _Extents for `stride` (shorter) and `run` (longer) virtual axes for each `opName` in the `strides` entries unless `faced`._  

--:> field.count: _dictionary keyed by 'opName` for number of elements in field for that operation_ -> `[fieldOp]: #:`  

--:> strides: _dictionary keyed by `opName` for the distance along the stride axis for a striding_ -> `[fieldOp]: #:`  

--:> striding: _dictionary keyed by `opName` of vectors incrementing game coordinate positions for `turn`_ -> `[fieldOp]: xyz`  

--:> eP: _pair of coordinates for extents_  -> `bounds`  

--:> fieldOp: _Operation name in the set for a particular kind of field_ -> ":"  

--:# **Path generator: flying ox plow paths through given three dimensional rectangular bounds.**    
--:+ _Ox plow paths minimize travel to plow a field. Flying oxen (aka turtles) do that in three dimensions._  

--:: field.paths(bounds: xyz[]) -> _Called by plan prototype file to generate plans for plot._ -> `paths, yDelta: #:, xzEdge: facing`  

--:> paths: __Flying ox traverse of three dimensional rectangular solid_ -> {start: ":"[], odd: ":"[], even: ":"[], last: ":"[]}`    
--:+ _Returns paths, vertical traverse (`yDelta: #:`), and orientation of longest horizontal edge for bounded block._  

--:# **Cut, fill, till, and traverse points defining rectangular volumes** using `field.plan` to optimize traversal.  

--:: field.cut(places: [nearPlace: ":", farPlace: ":"]) -> _Quarry out blocks from one place to the other._ -> `":" &:`  

--:- cut point point -> _Quarry out blocks bound by named points (defining a rectangular solid)._  

--:: field.fill(parameters: [nearPlace: ":", farPlace: ":", fill: ":", target: ":"?]) -> _Fill, Till, Replace._ -> `":" &:`  

--:< _Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:`   

--:- fill point point filling ?target -> _Layer fill bounds by points; optionally swaps out only target blocks._  

--:: field.till(parameters: [nearPlace: ":", farPlace: ":", seed: ":"]) -> _Till the seed from one place to the other._ -> `":" &:`  

--:< _Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `"minecraft:"`  

--:- till point point seed -> _Till the seed bounds by named points (defining a rectangular solid)._  

--:: field.fence(parameters: [ranger: ":", fencing: ":"?]) -> _Put fencing using `layer` plan._ -> `":"`  

--:- fence range [item] -> _Put item or available wooden fence from one point to another in range._  