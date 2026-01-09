return {
  ["_place.erase:_"] = {
  ["line"] = "--::place.erase(name: \":\") -> _Removes named place from array of places._ -> `#:, order: #:`",
  ["kind"] = "face",
  ["sign"] = "place.erase(name: \":\")  ",
  ["out"] = " `#:, order: #:`",
  ["text"] = "Removes named place from array of places.",
}
,
  ["_place.count:_"] = {
  ["line"] = "--:: place.count() -> _Returns number of places._ -> `#:`",
  ["kind"] = "face",
  ["sign"] = "place.count()  ",
  ["out"] = " `#:`",
  ["text"] = "Returns number of places.",
}
,
  ["_place.track:_"] = {
  ["line"] = "  --:: place.track(name: \":\") -> _Returns trail_ -> `name: \":\"?, label: \":\"?, situations?`",
  ["kind"] = "face",
  ["sign"] = "place.track(name: \":\")  ",
  ["out"] = " `name: \":\"?, label: \":\"?, situations?`",
  ["text"] = "Returns trail",
}
,
  ["_place.xyzf:_"] = {
  ["line"] = "  --:: place.xyzf(name: \":\"?, index: #:?) -> _Looks up index in name [defaults to current situation]._ -> `xyzf?, order: #:?`",
  ["kind"] = "face",
  ["sign"] = "place.xyzf(name: \":\"?, index: #:?)  ",
  ["out"] = " `xyzf?, order: #:?`",
  ["text"] = "Looks up index in name [defaults to current situation].",
}
,
  ["_place.fix:_"] = {
  ["line"] = "--:: place.fix(:xyzf:, track: ^:?) -> _Sets situation position, can start tracking for trail._ -> `xyzf`  ",
  ["kind"] = "face",
  ["sign"] = "place.fix(:xyzf:, track: ^:?)  ",
  ["out"] = " `xyzf`  ",
  ["text"] = "Sets situation position, can start tracking for trail.",
}
,
  ["_place.add:_"] = {
  ["line"] = "--:: place.add(name: \":\", :situation:) -> _Add situation to situations of an existing place._ -> `serialized: \":\", prder: #:`",
  ["kind"] = "face",
  ["sign"] = "place.add(name: \":\", :situation:)  ",
  ["out"] = " `serialized: \":\", prder: #:`",
  ["text"] = "Add situation to situations of an existing place.",
}
,
  ["_place.reset:_"] = {
  ["line"] = "--:: place.reset() -> _Resets places to the empty table._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "place.reset()  ",
  ["out"] = " `nil`",
  ["text"] = "Resets places to the empty table.",
}
,
  ["_steps.along:_"] = {
  ["line"] = "--:: steps.along(name: \":\") -> _Iterator: first to next situation of place._ -> `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["kind"] = "face",
  ["sign"] = "steps.along(name: \":\")  ",
  ["out"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["text"] = "Iterator: first to next situation of place.",
}
,
  ["_moves.along:_"] = {
  ["line"] = "--:: moves.along(name: \":\") -> _Move from first to second situation of place._ -> `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["kind"] = "face",
  ["sign"] = "moves.along(name: \":\")  ",
  ["out"] = " `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["text"] = "Move from first to second situation of place.",
}
,
  ["_place.site:_"] = {
  ["line"] = "--:: place.site(value: \":\"?) -> _Set or return local `site` (isolates global)._ -> `\":\"`",
  ["kind"] = "face",
  ["sign"] = "place.site(value: \":\"?)  ",
  ["out"] = " `\":\"`",
  ["text"] = "Set or return local `site` (isolates global).",
}
,
  [" places"] = {
  ["type"] = "lib",
  ["name"] = " places",
  ["childs"] = {
}
,
}
,
  ["_place.match:_"] = {
  ["line"] = "  --:: place.match(name: \":\") -> _Lookup place qualified by site, return_ `nil` _if not found._ -> `order: #:?, place?`",
  ["kind"] = "face",
  ["sign"] = "place.match(name: \":\")  ",
  ["out"] = " `order: #:?, place?`",
  ["text"] = "Lookup place qualified by site, return_ `nil` _if not found.",
}
,
  ["moves"] = {
  ["type"] = "lib",
  ["name"] = "moves",
  ["childs"] = {
  ["to"] = {
  ["returns"] = " `code: \":\", remaining: #:, xyzf: \":\" &!recovery` <-\
",
  ["args"] = "target: \":\", first: \":\"",
  ["type"] = "function",
  ["name"] = "moves.to",
  ["description"] = "\
Move to target, first along direction.",
}
,
  ["along"] = {
  ["returns"] = " `code: \":\", remaining: #:, xyzf: \":\" &!recovery` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "moves.along",
  ["description"] = "\
Move from first to second situation of place. If the named place is the head of a trail, go from there to its tail. If it's a tail of a trail, go to its head.",
}
,
}
,
}
,
  ["places"] = {
  ["childs"] = {
  [":features"] = {
  ["type"] = "value",
  ["returns"] = " `[key: \":\"]: any`",
  ["name"] = "features",
  ["description"] = "\
Dictionary of string key, any value pairs",
}
,
  [":place"] = {
  ["type"] = "value",
  ["returns"] = " `[name: \":\", label: \":\", :situations:, :features:]`",
  ["name"] = "place",
  ["description"] = "\
A point, trail, or range",
}
,
  [":cardinals"] = {
  ["type"] = "value",
  ["returns"] = " (dx: #:, dz: #:): cardinal: \":\"",
  ["name"] = "cardinals",
  ["description"] = "\
Function to get one of the eight cardinal points of the compass",
}
,
}
,
  ["returns"] = " places, place, moves, steps",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "places",
  ["description"] = "\
Naming places at MUSE coordinates, moving there, stepping there for operations._ -> places, place, moves, steps place: **Name places (points, trails, ranges); serialize and load serializations for disk and network operations. moves: **Move turtles to named places or along named trails. steps: **Iterator to move block by block to named places or along named trails.",
}
,
  ["_steps.to:_"] = {
  ["line"] = "  --:: steps.to(target: \":\") -> _Step (iterator) to target place._ -> `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["kind"] = "face",
  ["sign"] = "steps.to(target: \":\")  ",
  ["out"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["text"] = "Step (iterator) to target place.",
}
,
  ["_place.near:_"] = {
  ["line"] = "--:: place.near(span: #:?, reference?: \":\"|position) -> __ -> (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"`",
  ["kind"] = "face",
  ["sign"] = "place.near(span: #:?, reference?: \":\"|position)  ",
  ["out"] = " (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"`",
  ["text"] = "",
}
,
  ["place"] = {
  ["type"] = "lib",
  ["name"] = "place",
  ["childs"] = {
  ["trail"] = {
  ["returns"] = " `headSerial: \":\", tailSerial: \":\"` <-\
",
  ["args"] = "headName: \":\", tailName: \":\", label: \":\"",
  ["type"] = "function",
  ["name"] = "place.trail",
  ["description"] = "\
Makes two places. Trail places share a label and represent trails from head to tail and tail to head; head set by_ `place.fix`.",
}
,
  ["reset"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "place.reset",
  ["description"] = "\
Resets places to the empty table.",
}
,
  ["near"] = {
  ["returns"] = " (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"` <-\
",
  ["args"] = "span: #:?, reference?: \":\"|position",
  ["type"] = "function",
  ["name"] = "place.near",
  ["description"] = "\
 If both span and name (or a position) are specified, return places within a span of blocks of the named place (or position). If only the span is specified, return places within a span of blocks of the current situation or player position. If neither is specified return each of the named places. In any case, iterator returns include serialized places.",
}
,
  ["xyzf"] = {
  ["returns"] = " `xyzf?, order: #:?` <-\
",
  ["args"] = "name: \":\"?, index: #:?",
  ["type"] = "function",
  ["name"] = "place.xyzf",
  ["description"] = "\
Looks up index in name [defaults to current situation].",
}
,
  ["fix"] = {
  ["returns"] = " `xyzf`   <-\
",
  ["args"] = ":xyzf:, track: ^:?",
  ["type"] = "function",
  ["name"] = "place.fix",
  ["description"] = "\
Sets situation position, can start tracking for trail.",
}
,
  ["nearby"] = {
  ["returns"] = " `[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:]` <-\
",
  ["args"] = ":xyzf:?, :cardinals:",
  ["type"] = "function",
  ["name"] = "place.nearby",
  ["description"] = "\
Sorted",
}
,
  ["track"] = {
  ["returns"] = " `name: \":\"?, label: \":\"?, situations?` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.track",
  ["description"] = "\
Returns trail",
}
,
  ["count"] = {
  ["returns"] = " `#:` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "place.count",
  ["description"] = "\
Returns number of places.",
}
,
  ["match"] = {
  ["returns"] = " `order: #:?, place?` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.match",
  ["description"] = "\
Lookup place qualified by site, return_ `nil` _if not found.",
}
,
  ["add"] = {
  ["returns"] = " `serialized: \":\", prder: #:` <-\
",
  ["args"] = "name: \":\", :situation:",
  ["type"] = "function",
  ["name"] = "place.add",
  ["description"] = "\
Add situation to situations of an existing place.",
}
,
  ["qualify"] = {
  ["returns"] = " `sitedName: \":\"` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.qualify",
  ["description"] = "\
Return already sited name, otherwise prepend site to name",
}
,
  ["site"] = {
  ["returns"] = " `\":\"` <-\
",
  ["args"] = "value: \":\"?",
  ["type"] = "function",
  ["name"] = "place.site",
  ["description"] = "\
Set or return local `site` (isolates global).",
}
,
  ["distance"] = {
  ["returns"] = " `distance: #:` <-\
",
  ["args"] = "a: xyzf, b: xyzf",
  ["type"] = "function",
  ["name"] = "place.distance",
  ["description"] = "\
Manhattan: abs(delta x) + abs(delta y) + abs(delta z).",
}
,
  ["name"] = {
  ["returns"] = " `\":\", #:` <-\
",
  ["args"] = "name: \":\", label: \":\", supplied: situation?, :features:??",
  ["type"] = "function",
  ["name"] = "place.name",
  ["description"] = "\
Make or update place. Include current situation or optionally supplied situation in places. Optionally update features with key = value. Return order of situation in global places and the serialized situation including its features.",
}
,
  ["erase"] = {
  ["returns"] = " `#:, order: #:` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.erase",
  ["description"] = "\
Removes named place from array of places. Return new length of places table and the (previous) order of the removed place.",
}
,
}
,
}
,
  ["_place.name:_"] = {
  ["line"] = "  --:: place.name(name: \":\", label: \":\", supplied: situation?, :features:??) -> _Make or update place._ -> `\":\", #:`",
  ["kind"] = "face",
  ["sign"] = "place.name(name: \":\", label: \":\", supplied: situation?, :features:??)  ",
  ["out"] = " `\":\", #:`",
  ["text"] = "Make or update place.",
}
,
  ["_place.trail:_"] = {
  ["line"] = "--:: place.trail(headName: \":\", tailName: \":\", label: \":\") -> _Makes two places._ -> `headSerial: \":\", tailSerial: \":\"`",
  ["kind"] = "face",
  ["sign"] = "place.trail(headName: \":\", tailName: \":\", label: \":\")  ",
  ["out"] = " `headSerial: \":\", tailSerial: \":\"`",
  ["text"] = "Makes two places.",
}
,
  ["_moves.to:_"] = {
  ["line"] = "--:: moves.to(target: \":\", first: \":\") -> _Move to target, first along direction._ -> `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["kind"] = "face",
  ["sign"] = "moves.to(target: \":\", first: \":\")  ",
  ["out"] = " `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["text"] = "Move to target, first along direction.",
}
,
  ["_place.qualify:_"] = {
  ["line"] = "--:: place.qualify(name: \":\") -> _Return already sited name, otherwise prepend site to name_ -> `sitedName: \":\"`",
  ["kind"] = "face",
  ["sign"] = "place.qualify(name: \":\")  ",
  ["out"] = " `sitedName: \":\"`",
  ["text"] = "Return already sited name, otherwise prepend site to name",
}
,
  ["_place.nearby:_"] = {
  ["line"] = "--:: place.nearby(:xyzf:?, :cardinals:) -> _Sorted_ -> `[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:]`",
  ["kind"] = "face",
  ["sign"] = "place.nearby(:xyzf:?, :cardinals:)  ",
  ["out"] = " `[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:]`",
  ["text"] = "Sorted",
}
,
  ["_place.distance:_"] = {
  ["line"] = "--:: place.distance(a: xyzf, b: xyzf) -> _Manhattan: abs(delta x) + abs(delta y) + abs(delta z)._ -> `distance: #:`",
  ["kind"] = "face",
  ["sign"] = "place.distance(a: xyzf, b: xyzf)  ",
  ["out"] = " `distance: #:`",
  ["text"] = "Manhattan: abs(delta x) + abs(delta y) + abs(delta z).",
}
,
  ["steps"] = {
  ["type"] = "lib",
  ["name"] = "steps",
  ["childs"] = {
  ["to"] = {
  ["returns"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery` <-\
",
  ["args"] = "target: \":\"",
  ["type"] = "function",
  ["name"] = "steps.to",
  ["description"] = "\
Step (iterator) to target place.",
}
,
  ["along"] = {
  ["returns"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "steps.along",
  ["description"] = "\
Iterator: first to next situation of place. If the named place is the head of a trail, step from there to its tail. If it's a tail of a trail, step to its head.",
}
,
}
,
}
,
}
