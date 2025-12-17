--:! [place: [":"]: (:), moves: [":"]: (:), steps: [":"]: (:) ] <- **Places Functions Libraries** -> muse/docs/lib/places.md      
--:| places: _Naming places at MUSE coordinates, moving there, stepping there for operations._ -> places, place, moves, steps    
--:+ place: **Name places (points, trails, ranges); serialize and load serializations for disk and network operations.**      
--:+ moves: **Move turtles to named places or along named trails.**     
--:+ steps: **Iterator to move block by block to named places or along named trails.**  

--:# **Type definitions that will be serialized for network tansport and disk storage**  

--:> place: _A point, trail, or range_ -> `{name: ":", label: ":", :situations:, :features:}`  

--:> features: _Dictionary of string key, any value pairs_ -> `[key: ":"]: any`  

--:# **Utilities for places (points, trails, and ranges)**  

--:: place.reset() -> _Resets places to the empty table._ -> `nil`  

--:: place.count() -> _Returns number of places._ -> `#:`  

--:: place.site(value: ":"?) -> _Set or return local `site` (isolates global)._ -> `":"`  

--:: place.qualify(name: ":") -> _Return already sited name, otherwise prepend site to name_ -> `sitedName: ":"`  

--:: place.distance(a: xyzf, b: xyzf) -> _Manhattan: abs(delta x) + abs(delta y) + abs(delta z)._ -> `distance: #:`  

--:: place.match(name: ":") -> _Lookup place qualified by site, return_ `nil` _if not found._ -> `index: #:?, place?`  

--:: place.xyzf(name: ":"?, number: #:?) -> _Looks up name [defaults to current situation]._ -> `xyzf?, index: #:?`  

--:: place.name(name: ":", label: ":", supplied: situation?, :features:??) -> _Make or update place._ -> `":", #:`    
--:+ _Include current situation or optionally supplied situation in places. Optionally update features with key = value._    
--:+ _Return index of situation in global places and the serialized situation including its features._  

--:: place.add(name: ":", :situation:) -> _Add situation to situations of an existing place._ -> `serialized: ":", index: #:`  

--::place.erase(name: ":") -> _Removes named place from array of places._ -> `#:, index: #:`    
--:+ _Return new length of places table and the (previous) index of the removed place._  

--:# **Answering "where?"**  

--:: place.near(span: #:?, reference?: ":"|position) -> __ -> (): `name: ":", label: ":", xyz, distance: #:, situations, serial: ":"`    
--:+ _If both span and name (or a position) are specified, return places within a span of blocks of the named place (or position)._    
--:+ _If only the span is specified, return places within a span of blocks of the current situation or player position._    
--:+ _If neither is specified return each of the named places. In any case, iterator returns include serialized places._  

--:: place.nearby(:xyzf:?, :cardinals:) -> _Sorted_ -> `:[distance: #:, name: ":", label: ":", cardinal: ":", :xyzf:]  

--:> cardinals: _Function to get one of the eight cardinal points of the compass_ -> (dx: #:, dz: #:): cardinal: ":"    
--:+ _Nearest places to specified xyzf coordinates or current position (as default)._     
--:+ _Returned table is sorted by distances and includes the name, label, and xyzf position of each place._    
--:+ _If a `cardinals` function is supplied, the eight point cardinal direction is also included._  

--:# **Support for trails (names and labels for sequences of situations)**  

--:: place.fix(:xyzf:, track: ^:?) -> _Sets situation position, can start tracking for trail._ -> `xyzf`    

--:: place.trail(headName: ":", tailName: ":", label: ":") -> _Makes two places._ -> `headSerial: ":", tailSerial: ":"`    
--:+ _Trail places share a label and represent trails from head to tail and tail to head; head set by_ `place.fix`.  

--:: place.track(name: ":") -> _Returns trail_ -> `name: ":"?, label: ":"?, situations`?  

--:# **Moving and stepping for known places: to points or along trails**  

--:: moves.along(name: ":") -> _Move from first to second situation of place._ -> `code: ":", remaining: #:, xyzf: ":" &! recovery`    
--:+ _If the named place is the head of a trail, go from there to its tail. If it's a tail of a trail, go to its head._  

--:: steps.along(name: ":") -> _Iterator: first to next situation of place._ -> `(): code: ":", remaining: #:, xyzf: ":" &! recovery`    
--:+ _If the named place is the head of a trail, step from there to its tail. If it's a tail of a trail, step to its head._  

--:: moves.to(target: ":", first: ":") -> _Move to target, first along direction._ -> `code: ":", remaining: #:, xyzf: ":" &! recovery`  

--:: steps.to(target: ":") -> _Step (iterator) to target place._ -> `(): code: ":", remaining: #:, xyzf: ":" &! recovery`  