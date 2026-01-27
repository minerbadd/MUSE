return {
  ["_planner.load:_"] = {
  ["line"] = "  --:: planner.load(planFileName: \":\") -> _Instantiates what is returned from a plan file._ -> `plan &!` ",
  ["kind"] = "face",
  ["sign"] = "planner.load(planFileName: \":\")  ",
  ["out"] = " `plan &!` ",
  ["text"] = "Instantiates what is returned from a plan file.",
}
,
  ["_join_"] = {
  ["line"] = "local role, id = ...; --:- join role id -> _Temporarily set mapping for next startup, id from turtle nameplate._",
  ["sign"] = "join role id  ",
  ["kind"] = "cli",
  ["text"] = "Temporarily set mapping for next startup, id from turtle nameplate.",
}
,
  ["gps"] = {
  ["childs"] = {
  ["op"] = {
  ["returns"] = " `report: \":\"` &: <-\
",
  ["args"] = "commands: \":\"[]",
  ["type"] = "function",
  ["name"] = "gps.op",
  ["description"] = "\
Command Line Interface.",
}
,
}
,
  ["returns"] = " gps, _gps",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "gps",
  ["description"] = "\
Assemble, launch, and startup GPS computers._ -> gps, _gps",
}
,
  ["_map.point:_"] = {
  ["line"] = "  --:: map.point(name: \":\", label: \":\", :xyzf:) -> _Create, send point update._ -> `nil & !`",
  ["kind"] = "face",
  ["sign"] = "map.point(name: \":\", label: \":\", :xyzf:)  ",
  ["out"] = " `nil & !`",
  ["text"] = "Create, send point update.",
}
,
  ["_task"] = {
  ["type"] = "lib",
  ["name"] = "_task",
  ["childs"] = {
  ["doTask"] = {
  ["returns"] = " \":\" &!` <-\
",
  ["args"] = "arguments: _task.puts, op: ():, clear: ^:, fill?: \":\", targets?: \":\"[]",
  ["type"] = "function",
  ["name"] = "_task.doTask",
  ["description"] = "\
Tasks",
}
,
}
,
}
,
  ["__mine.down:_"] = {
  ["line"] = "  --:: `_mine.down(mineheadName: \":\", targetLevel: #:, shaftPlansDown: downs, shaftPlansName: \":\")` -> _Dig shaft_ -> `\"done\" &!`",
  ["out"] = " `\"done\" &!`",
  ["sign"] = "`_mine.down(mineheadName: \":\", targetLevel: #:, shaftPlansDown: downs, shaftPlansName: \":\")`  ",
  ["kind"] = "face",
  ["text"] = "Dig shaft",
}
,
  ["_port_"] = {
  ["line"] = "--:- port booking -> _As laid out in booking, consume player inventory to teleport entities from one area to another._",
  ["sign"] = "port booking  ",
  ["text"] = "As laid out in booking, consume player inventory to teleport entities from one area to another.",
  ["kind"] = "cli",
}
,
  ["_core.clone:_"] = {
  ["line"] = "  --:: core.clone(source: {:}|any) -> _Deep copy source table or return source if not table._ -> `{:}|any`",
  ["out"] = " `{:}|any`",
  ["sign"] = "core.clone(source: {:}|any)  ",
  ["kind"] = "face",
  ["text"] = "Deep copy source table or return source if not table.",
}
,
  [" gps"] = {
  ["type"] = "lib",
  ["name"] = " gps",
  ["childs"] = {
}
,
}
,
  ["_core.sleep:_"] = {
  ["line"] = "--:: core.sleep(#:?) -> _Mocks sleep as null operation out of game._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "core.sleep(#:?)  ",
  ["kind"] = "face",
  ["text"] = "Mocks sleep as null operation out of game.",
}
,
  ["_core.string:_"] = {
  ["line"] = "function core.string(...) --:: core.string(...: any) -> _Makes string from any inputs, simplifies single entry tables._ -> `\":\"`",
  ["out"] = " `\":\"`",
  ["sign"] = "core.string(...: any)  ",
  ["kind"] = "face",
  ["text"] = "Makes string from any inputs, simplifies single entry tables.",
}
,
  ["_dds.map:_"] = {
  ["line"] = "function dds.map() return pairs(IDs) end --:: dds.map() -> _Returns associations from Muse roles to ComputerCraft IDs_ -> `IDs`",
  ["kind"] = "face",
  ["sign"] = "dds.map()  ",
  ["out"] = " `IDs`",
  ["text"] = "Returns associations from Muse roles to ComputerCraft IDs",
}
,
  [" port"] = {
  ["type"] = "lib",
  ["name"] = " port",
  ["childs"] = {
}
,
}
,
  ["_till_"] = {
  ["line"] = "--:- till point point seed -> _Till the seed bounds by named points (defining a rectangular solid)._",
  ["sign"] = "till point point seed  ",
  ["text"] = "Till the seed bounds by named points (defining a rectangular solid).",
  ["kind"] = "cli",
}
,
  ["roam"] = {
  ["childs"] = {
  ["op"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "arguments: \":\"[]",
  ["type"] = "function",
  ["name"] = "roam.op",
  ["description"] = "\
Move turtle:",
}
,
  ["come"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = ":xyz:",
  ["type"] = "function",
  ["name"] = "roam.come",
  ["description"] = "\
Server (turtle) side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come.",
}
,
  ["tail"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = ":xyz:",
  ["type"] = "function",
  ["name"] = "roam.tail",
  ["description"] = "\
Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)",
}
,
}
,
  ["returns"] = " roam",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "roam",
  ["description"] = "\
Server (turtle) side_ `come` _and_ `tail`, _chained_ `go` _commands, motion_ `to` _and_ `trace`. -> roam",
}
,
  ["map"] = {
  ["childs"] = {
  ["erase"] = {
  ["returns"] = " `remaining: #:` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "map.erase",
  ["description"] = "\
Remove named place, overwrite local map file",
}
,
  ["locations"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "template: {name: \":\", offset: xyz}, base: \":\", label: \":\", top: #:",
  ["type"] = "function",
  ["name"] = "map.locations",
  ["description"] = "\
Add points offset from base. Add labelled points using template names and offsets from named base point or top for y-axis.",
}
,
  ["write"] = {
  ["returns"] = " `nil &!` <-\
",
  ["args"] = "thisMap: \":\"?",
  ["type"] = "function",
  ["name"] = "map.write",
  ["description"] = "\
Delete old, write new locally. Default current.",
}
,
  ["set"] = {
  ["returns"] = " \":\" <-\
",
  ["args"] = "name: \":\", label: \":\", x: #:, y: #:, z: #:, f: \":\"",
  ["type"] = "function",
  ["name"] = "map.set",
  ["description"] = "\
Set turtle at created point",
}
,
  ["read"] = {
  ["returns"] = " `serial: \":\", index: #: &!` <-\
",
  ["args"] = "thisMap: \":\"",
  ["type"] = "function",
  ["name"] = "map.read",
  ["description"] = "\
Reinstantiate places from map file.",
}
,
  ["point"] = {
  ["returns"] = " `nil & !` <-\
",
  ["args"] = "name: \":\", label: \":\", :xyzf:",
  ["type"] = "function",
  ["name"] = "map.point",
  ["description"] = "\
Create, send point update.",
}
,
  ["put"] = {
  ["returns"] = "  `key: \":\"?, value: any|true|nil &!` <-\
",
  ["args"] = "name: \":\", key: \":\", value: any?",
  ["type"] = "function",
  ["name"] = "map.put",
  ["description"] = "\
Set named place feature, send MU.",
}
,
  ["op"] = {
  ["returns"] = " `report: \":\" &:` <-\
",
  ["args"] = "commands: \":\"[]",
  ["type"] = "function",
  ["name"] = "map.op",
  ["description"] = "\
Command Line Interface",
}
,
  ["place"] = {
  ["returns"] = " `serial: \":\", index: #: &!` <-\
",
  ["args"] = "placeString: \":\"",
  ["type"] = "function",
  ["name"] = "map.place",
  ["description"] = "\
Instantiate string as named place, include in named places.",
}
,
  ["testFacing"] = {
  ["returns"] = " `facing: \":\" & !` <-\
",
  ["args"] = "dx: #:, dz: #:",
  ["type"] = "function",
  ["name"] = "map.testFacing",
  ["description"] = "\
Find orientation using position changes for non-zero movement.",
}
,
  [":borders"] = {
  ["type"] = "value",
  ["returns"] = " {east: #:, west: #:, north: #:, south: #:, top: #:, bottom: #:}",
  ["name"] = "borders",
  ["description"] = "\
Range boundarires",
}
,
  ["puts"] = {
  ["returns"] = " `key: \":\", value: \":\"|true &!` <-\
",
  ["args"] = "name: \":\", key: \":\", value: \":\"?",
  ["type"] = "function",
  ["name"] = "map.puts",
  ["description"] = "\
Set string feature value, send MU.",
}
,
  ["borders"] = {
  ["returns"] = " `borders, features, position, position &!` <-\
",
  ["args"] = "range: place",
  ["type"] = "function",
  ["name"] = "map.borders",
  ["description"] = "\
Get range elements",
}
,
  ["gets"] = {
  ["returns"] = " `\":\"?` <-\
",
  ["args"] = "name: \":\", key: \":\"",
  ["type"] = "function",
  ["name"] = "map.gets",
  ["description"] = "\
Less generic retrieval interface: gets string feature value.",
}
,
  ["update"] = {
  ["returns"] = " `nil &!` <-\
",
  ["args"] = "serial: \":\"",
  ["type"] = "function",
  ["name"] = "map.update",
  ["description"] = "\
Append received instantiated MU to local map file_.",
}
,
  ["get"] = {
  ["returns"] = " `value: any? &!` <-\
",
  ["args"] = "name: \":\", key: \":\"",
  ["type"] = "function",
  ["name"] = "map.get",
  ["description"] = "\
Get named place local feature value for key.",
}
,
}
,
  ["returns"] = " map",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "map",
  ["description"] = "\
Orientation and position reporting, broadcast and persistence of places_ -> map",
}
,
  ["_move.north:_"] = {
  ["line"] = "--:: move.north(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.north(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_finish_"] = {
  ["line"] = "--:- finish range firstPlot lastPlot?? -> _Complete field preparation for farming._",
  ["sign"] = "finish range firstPlot lastPlot??  ",
  ["kind"] = "cli",
  ["text"] = "Complete field preparation for farming.",
}
,
  ["_change_"] = {
  ["line"] = "--:- change target filling direction distance puttings+ -> Move distance in direction replacing target with filling.",
  ["sign"] = "change target filling direction distance puttings+  ",
  ["text"] = "Move distance in direction replacing target with filling.",
  ["kind"] = "cli",
}
,
  ["_headings_"] = {
  ["line"] = "  --:- headings rate? place? count?? -> _Repeated movement report at specified rate (or every _G.Muse.rates.headings) seconds)._",
  ["sign"] = "headings rate? place? count??  ",
  ["kind"] = "cli",
  ["text"] = "Repeated movement report at specified rate (or every _G.Muse.rates.headings) seconds).",
}
,
  ["_point_"] = {
  ["line"] = "--:- point name label -> Add named and labeled point, broadcast updated map with (MU) Muse Update. (Player needs GPS.)",
  ["sign"] = "point name label  ",
  ["text"] = "Add named and labeled point, broadcast updated map with (MU) Muse Update. (Player needs GPS.)",
  ["kind"] = "cli",
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
  ["_core.permute:_"] = {
  ["line"] = "--:: core.permute(array: any[]) -> _Iterator for (factorial) permutations of array_ -> `():`",
  ["out"] = " `():`",
  ["sign"] = "core.permute(array: any[])  ",
  ["kind"] = "face",
  ["text"] = "Iterator for (factorial) permutations of array",
}
,
  ["__field.runElements:_"] = {
  ["line"] = "  --:: `_field.runElements(bounds: [xyzStart: xyz, xyzFinish: xyz])` -> _Fly ox._ -> `runs:_field.runs, yDelta: #:, xzDelta: #:, xzEdge: facing`",
  ["out"] = " `runs:_field.runs, yDelta: #:, xzDelta: #:, xzEdge: facing`",
  ["sign"] = "`_field.runElements(bounds: [xyzStart: xyz, xyzFinish: xyz])`  ",
  ["kind"] = "face",
  ["text"] = "Fly ox.",
}
,
  ["_move.east:_"] = {
  ["line"] = "--:: move.east(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.east(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["__field.cut:_"] = {
  ["line"] = "  --:: `_field.cut(places: [nearPlace: \":\", farPlace: \":\"])` -> _Use plan.quarry to cut._ -> `report: \":\" &:`",
  ["out"] = " `report: \":\" &:`",
  ["sign"] = "`_field.cut(places: [nearPlace: \":\", farPlace: \":\"])`  ",
  ["kind"] = "face",
  ["text"] = "Use plan.quarry to cut.",
}
,
  ["_move.where:_"] = {
  ["line"] = "--:: move.where(tx: #:?, ty: #:?, tz: #:?, tf: \":\"?) -> _Returns GPS results if available._ -> `x: #:, y: #:, z: #:, facing: \":\", ok: #:|^:`",
  ["out"] = " `x: #:, y: #:, z: #:, facing: \":\", ok: #:|^:`",
  ["sign"] = "move.where(tx: #:?, ty: #:?, tz: #:?, tf: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Returns GPS results if available.",
}
,
  ["_book_"] = {
  ["line"] = "--:- book name label from to [span [item ...] ] -> _Spanned range with (default) items as properties; return cost less bank._",
  ["sign"] = "book name label from to [span [item ...] ]  ",
  ["text"] = "Spanned range with (default) items as properties; return cost less bank.",
  ["kind"] = "cli",
}
,
  ["_core.report:_"] = {
  ["line"] = "  --:: core.report(level: #:, ...: any) -> _If level less than `status` threshold, report `rest` as string._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "core.report(level: #:, ...: any)  ",
  ["kind"] = "face",
  ["text"] = "If level less than `status` threshold, report `rest` as string.",
}
,
  ["_quit_"] = {
  ["line"] = "--:- quit message -> Set quit flag to message; next core.status throws error to abort operations.  ",
  ["sign"] = "quit message  ",
  ["text"] = "Set quit flag to message; next core.status throws error to abort operations.",
  ["kind"] = "cli",
}
,
  ["_move.situations:_"] = {
  ["line"] = "--:: move.situations() -> _Deep copy `_G.Muse.situations`._ ->  situations",
  ["out"] = "  situations",
  ["sign"] = "move.situations()  ",
  ["kind"] = "face",
  ["text"] = "Deep copy `_G.Muse.situations`.",
}
,
  ["_field.extents:_"] = {
  ["line"] = "--:: field.extents(:bounds:, :strides:, faced: \":\"?) -> _Plots placed_ -> `field.count, field.count , eP, eP, striding, ^:, ^:`",
  ["out"] = " `field.count, field.count , eP, eP, striding, ^:, ^:`",
  ["sign"] = "field.extents(:bounds:, :strides:, faced: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Plots placed",
}
,
  ["_place.site:_"] = {
  ["line"] = "--:: place.site(value: \":\"?) -> _Set or return local `site` (isolates global)._ -> `\":\"`",
  ["out"] = " `\":\"`",
  ["sign"] = "place.site(value: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Set or return local `site` (isolates global).",
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
  ["_chart_"] = {
  ["line"] = "--:- chart chartfilename ... -> _Loads and runs named chart file in `charts` directory to create named point and associated ranges._",
  ["sign"] = "chart chartfilename ...  ",
  ["text"] = "Loads and runs named chart file in `charts` directory to create named point and associated ranges.",
  ["kind"] = "cli",
}
,
  ["mine"] = {
  ["childs"] = {
  [":downs.even"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "downs.even",
  ["description"] = "\
Mark, dig, ladder, and fill an even level (for landing platforms)",
}
,
  [":downs.last"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "downs.last",
  ["description"] = "\
Mark last level dug",
}
,
  [":shafts.back"] = {
  ["type"] = "value",
  ["returns"] = " `levels`",
  ["name"] = "shafts.back",
  ["description"] = "\
Plan for returning to minehead, placing fixtures and safety shelves for player",
}
,
  [":shafts"] = {
  ["type"] = "value",
  ["returns"] = " `{shafts.name: \":\", shafts.down: downs, shafts.back: levels, shafts.lower: levels, shafts.higher: levels}`",
  ["name"] = "shafts",
  ["description"] = "\
Dig",
}
,
  [":shafts.higher"] = {
  ["type"] = "value",
  ["returns"] = " `levels`",
  ["name"] = "shafts.higher",
  ["description"] = "\
Plan for navigating from one (even or odd) level to the next higher",
}
,
  [":bores.odd"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "bores.odd",
  ["description"] = "\
Plan for boring tunnels at odd levels",
}
,
  [":bores.fix"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "bores.fix",
  ["description"] = "\
Plan for fixtures: shaft area ladders and placing barrel",
}
,
  [":levels.odd"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "levels.odd",
  ["description"] = "\
Plan for navigating from one even level to the next",
}
,
  [":levels"] = {
  ["type"] = "value",
  ["returns"] = " `{levels.even: plan, levels.odd: plan}`",
  ["name"] = "levels",
  ["description"] = "\
Traverse (and fill shelves for  player safety in back plan) shaft",
}
,
  [":bores.name"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"`",
  ["name"] = "bores.name",
  ["description"] = "\
Included in error and status reports",
}
,
  [":shafts.lower"] = {
  ["type"] = "value",
  ["returns"] = " `levels`",
  ["name"] = "shafts.lower",
  ["description"] = "\
Plan for navigating from one (even or odd) level to the next lower",
}
,
  [":levels.even"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "levels.even",
  ["description"] = "\
Plan for navigating from one even level to the next",
}
,
  [":downs.odd"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "downs.odd",
  ["description"] = "\
Mark, dig, ladder, and fill an odd level (for landing platforms)",
}
,
  ["op"] = {
  ["returns"] = " `^:, \":\", #: &:` <-\
",
  ["args"] = "arguments: [op: \":\", placeName: \":\", borePlansFileOrLevels: \":\"|#:, shaftPlansFile: \":\"]",
  ["type"] = "function",
  ["name"] = "mine.op",
  ["description"] = "\
Dig. Dig shaft; go to post at level; bore, mark, and torch; get ores. Markers hold saved plans.",
}
,
  [":bores"] = {
  ["type"] = "value",
  ["returns"] = " `{bores.name: \":\", bores.post: mine.post, bores.even: plan, bores.odd: plan, bores.fix: plan }`",
  ["name"] = "bores",
  ["description"] = "\
Horizontals",
}
,
  [":downs"] = {
  ["type"] = "value",
  ["returns"] = " `{downs.even: plan, downs.odd: plan, downs.last: plan }`",
  ["name"] = "downs",
  ["description"] = "\
Mark, dig, ladder, and fill one level (for landing platforms)",
}
,
  [":shafts.name"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"`",
  ["name"] = "shafts.name",
  ["description"] = "\
Included in error and status reports",
}
,
  [":shafts.down"] = {
  ["type"] = "value",
  ["returns"] = " `downs`",
  ["name"] = "shafts.down",
  ["description"] = "\
Plan for digging shaft one level through even and odd levels",
}
,
  [":mine.post"] = {
  ["type"] = "value",
  ["returns"] = " (markerName: \":\", :bores:):  `marking[]`",
  ["name"] = "mine.post",
  ["description"] = "\
Navigate shaft and bores to go to marker.",
}
,
  [":bores.even"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "bores.even",
  ["description"] = "\
Plan for boring tunnels at even levels",
}
,
  ["mark"] = {
  ["returns"] = " `markerName: \":\", label: \":\", report: \":\"` <-\
",
  ["args"] = ":plan:, :marking:",
  ["type"] = "function",
  ["name"] = "mine.mark",
  ["description"] = "\
Make place name, report result. Called by `worker.execute` to make marker name and use it to add map point for navigation in mine. Puts plan name value in marker (keyed by `\"shaft\"` or `\"bore\"`) so marker is enough for navigating in shaft or bore. Marker place name formed as `head:level:base` or `head:base` or `head` with place labelled as `\"outer\"|\"inner\"|\"shaft\"`.",
}
,
}
,
  ["returns"] = " mine, _mine",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "mine",
  ["description"] = "\
CLL operates plan to manage mines: shaft, bore, move to posts (between and within levels), and get ores._ -> mine, _mine",
}
,
  ["_go_"] = {
  ["line"] = "  --:- go _(first letter of) directions followed by optional counts, e.g. `r 10 u east 3 u 4 d n`._ -> _Chained movement._",
  ["sign"] = "go _(first letter of) directions followed by optional counts, e.g. `r 10 u east 3 u 4 d n`._  ",
  ["text"] = "Chained movement.",
  ["kind"] = "cli",
}
,
  ["_farm.replacer:_"] = {
  ["line"] = "  --:: farm.replacer(putAim: direction, item: \":\"[]|\":\", removables: \":\"[]) -> _Remove, put._ -> `(_:, :direction:): \":\" &!` ",
  ["kind"] = "face",
  ["sign"] = "farm.replacer(putAim: direction, item: \":\"[]|\":\", removables: \":\"[])  ",
  ["out"] = " `(_:, :direction:): \":\" &!` ",
  ["text"] = "Remove, put.",
}
,
  ["_attack_"] = {
  ["line"] = "--:- attack direction -> Attempts attack in specified direction.",
  ["sign"] = "attack direction  ",
  ["text"] = "Attempts attack in specified direction.",
  ["kind"] = "cli",
}
,
  ["_place.fix:_"] = {
  ["line"] = "--:: place.fix(:xyzf:, track: ^:?) -> _Sets situation position, can start tracking for trail._ -> `xyzf` ",
  ["out"] = " `xyzf` ",
  ["sign"] = "place.fix(:xyzf:, track: ^:?)  ",
  ["kind"] = "face",
  ["text"] = "Sets situation position, can start tracking for trail.",
}
,
  ["_roam.op:_"] = {
  ["line"] = "function roam.op(arguments) --:: roam.op(arguments: \":\"[]) -> _Move turtle:_ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "roam.op(arguments: \":\"[])  ",
  ["kind"] = "face",
  ["text"] = "Move turtle:",
}
,
  ["_view_"] = {
  ["line"] = "--:- view place -> Report place details including all situations and properties.",
  ["sign"] = "view place  ",
  ["text"] = "Report place details including all situations and properties.",
  ["kind"] = "cli",
}
,
  ["_core.completer:_"] = {
  ["line"] = "function core.completer(completions) --:: core.completer(completions: {:}) -> _Register command completions for shell_ -> `():`",
  ["out"] = " `():`",
  ["sign"] = "core.completer(completions: {:})  ",
  ["kind"] = "face",
  ["text"] = "Register command completions for shell",
}
,
  ["__mine.shaftOp:_"] = {
  ["line"] = "  --:: `_mine.shaftOp(mineheadName: \":\", levels: #:, shaftPlans: shafts)` -> _Dig shaft through levels._ -> `\":\", \":\", #:` &!",
  ["out"] = " `\":\", \":\", #:` &!",
  ["sign"] = "`_mine.shaftOp(mineheadName: \":\", levels: #:, shaftPlans: shafts)`  ",
  ["kind"] = "face",
  ["text"] = "Dig shaft through levels.",
}
,
  ["_kit_"] = {
  ["line"] = "--:- kit \"base\"|\"site\" -> _Kit up player for specifed `set` of items._",
  ["sign"] = "kit \"base\"|\"site\"  ",
  ["text"] = "Kit up player for specifed `set` of items.",
  ["kind"] = "cli",
}
,
  ["_move.up:_"] = {
  ["line"] = "--:: move.up(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.up(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["exec"] = {
  ["childs"] = {
  ["op"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "commandLine: [command: \":\", ...] ",
  ["type"] = "function",
  ["name"] = "exec.op",
  ["description"] = "\
CLI for Command Computer commands",
}
,
}
,
  ["returns"] = " exec",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "exec",
  ["description"] = "\
CLL to align MUSE location with Minecraft coordinates and activate a range as a Minecraft chunk._ -> exec",
}
,
  ["_core.round:_"] = {
  ["line"] = "--:: core.round(n: #:) -> _Next integer down if below half fraction_ -> `#:`",
  ["out"] = " `#:`",
  ["sign"] = "core.round(n: #:)  ",
  ["kind"] = "face",
  ["text"] = "Next integer down if below half fraction",
}
,
  ["_core.state:_"] = {
  ["line"] = "  --:: core.state(table: {:}?, key: \":\"?) -> _Returns closure over closure variable_ -> `closing`",
  ["out"] = " `closing`",
  ["sign"] = "core.state(table: {:}?, key: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Returns closure over closure variable",
}
,
  ["_trail_"] = {
  ["line"] = "--:- trail name -> Include named point at head and (current situation) tail of a new trail, update map.",
  ["sign"] = "trail name  ",
  ["text"] = "Include named point at head and (current situation) tail of a new trail, update map.",
  ["kind"] = "cli",
}
,
  ["_dds.role:_"] = {
  ["line"] = "function dds.role(ID) return roles[ID] end --:: dds.role(ID: #:) ->  _Label for a Muse role_ -> `role: \":\"`",
  ["kind"] = "face",
  ["sign"] = "dds.role(ID: #:)  ",
  ["out"] = " `role: \":\"`",
  ["text"] = "Label for a Muse role",
}
,
  ["_post_"] = {
  ["line"] = "  --:- post marker borePlans?  -> _Go to marker (and up 1 block) from current level with saved or specified plans._",
  ["sign"] = "post marker borePlans?   ",
  ["text"] = "Go to marker (and up 1 block) from current level with saved or specified plans.",
  ["kind"] = "cli",
}
,
  ["_activate_"] = {
  ["line"] = "--:- activate range -> _Add bounds from west and north to east and south of range for forceload._",
  ["sign"] = "activate range  ",
  ["text"] = "Add bounds from west and north to east and south of range for forceload.",
  ["kind"] = "cli",
}
,
  ["_turtle.fuel:_"] = {
  ["line"] = "  --:: turtle.fuel() -> _Total energy actually available in turtle slots plus turtle fuel level._ -> `fuelTotal: #:`",
  ["out"] = " `fuelTotal: #:`",
  ["sign"] = "turtle.fuel()  ",
  ["kind"] = "face",
  ["text"] = "Total energy actually available in turtle slots plus turtle fuel level.",
}
,
  ["_step.left:_"] = {
  ["line"] = "--:: step.left(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.left(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_field.fill:_"] = {
  ["line"] = "--:: field.fill(parameters: [nearPlace: \":\", farPlace: \":\", fill: \":\", target: \":\"?]) -> _Fill, Till, Replace._ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "field.fill(parameters: [nearPlace: \":\", farPlace: \":\", fill: \":\", target: \":\"?])  ",
  ["kind"] = "face",
  ["text"] = "Fill, Till, Replace.",
}
,
  ["remote"] = {
  ["childs"] = {
  ["returns"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "results: any[]",
  ["type"] = "function",
  ["name"] = "remote.returns",
  ["description"] = "\
Default client side handling of server response: just print results as string.",
}
,
  ["come"] = {
  ["returns"] = " `report: \":\"` <-\
",
  ["args"] = "turtle: \":\"",
  ["type"] = "function",
  ["name"] = "remote.come",
  ["description"] = "\
Towards GPS player position.",
}
,
  ["wait"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "remote.wait",
  ["description"] = "\
Setup turtle to repeatedly wait for MC network requests, send MR results.",
}
,
  ["tail"] = {
  ["returns"] = " `nil`  <-\
",
  ["args"] = "turtle: \":\", __ : \"tail\", rates: \":\"?",
  ["type"] = "function",
  ["name"] = "remote.tail",
  ["description"] = "\
Repeatedly towards player position, default rate _G.Muse.rates.tail seconds",
}
,
  ["call"] = {
  ["returns"] = " `any &: &!` <-\
",
  ["args"] = "server: \":\", command: \":\", arguments: any[], callback: ():?",
  ["type"] = "function",
  ["name"] = "remote.call",
  ["description"] = "\
RPC: Form serialized request table from command string and arguments. Get server ID from server name. Send request to server, wait for result, return call (default `remote.return`) callback function to result.",
}
,
}
,
  ["returns"] = " remote, _remote",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "remote",
  ["description"] = "\
Client and server side support for RPCs and client (player) side support for_ `come` _and_ `tail`. -> remote, _remote Test functions are provided for out-of-game, no network operation.",
}
,
  ["_move.tracking:_"] = {
  ["line"] = "  --:: move.tracking(enabled: ^:) -> _Set tracking condition and situations, return situations count_ -> `copy: situation, count: #:`",
  ["out"] = " `copy: situation, count: #:`",
  ["sign"] = "move.tracking(enabled: ^:)  ",
  ["kind"] = "face",
  ["text"] = "Set tracking condition and situations, return situations count",
}
,
  ["_fix_"] = {
  ["line"] = "  --:- fix trail? -> _Set and report GPS turtle position for dead reckoning. Optionally begin named trailhead._",
  ["sign"] = "fix trail?  ",
  ["kind"] = "cli",
  ["text"] = "Set and report GPS turtle position for dead reckoning. Optionally begin named trailhead.",
}
,
  ["_step.steps:_"] = {
  ["line"] = "--:: step.steps(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.steps(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_turtle.find:_"] = {
  ["line"] = "  --:: turtle.find -- `move.findItems` gets mocked turtle if not in-game(targets: \":\"[]) -> _Selects found slot._ -> `detail?`, #:?, ^:?",
  ["kind"] = "face",
  ["sign"] = "turtle.find -- `move.findItems` gets mocked turtle if not in-game(targets: \":\"[])  ",
  ["out"] = " `detail?`, #:?, ^:?",
  ["text"] = "Selects found slot.",
}
,
  ["_steps.along:_"] = {
  ["line"] = "--:: steps.along(name: \":\") -> _Iterator: first to next situation of place._ -> `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["out"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["sign"] = "steps.along(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Iterator: first to next situation of place.",
}
,
  ["_move.findItems:_"] = {
  ["line"] = "  --:: move.findItems(targets: \":\"[]) -> _Selects found slot._ -> `detail?`, #:?, ^:?",
  ["out"] = " `detail?`, #:?, ^:?",
  ["sign"] = "move.findItems(targets: \":\"[])  ",
  ["kind"] = "face",
  ["text"] = "Selects found slot.",
}
,
  ["__mine.toPost:_"] = {
  ["line"] = "  --:: `_mine.toPost(markerName: \":\", borePlans: bores, shaftPlans: shafts)` -> _Navigate to post_ -> `\"done\", \":\", #: &!`",
  ["out"] = " `\"done\", \":\", #: &!`",
  ["sign"] = "`_mine.toPost(markerName: \":\", borePlans: bores, shaftPlans: shafts)`  ",
  ["kind"] = "face",
  ["text"] = "Navigate to post",
}
,
  ["_quarry_"] = {
  ["line"] = "--:- quarry range firstPlot? lastPlot?? -> _Dig out the field to level it._",
  ["sign"] = "quarry range firstPlot? lastPlot??  ",
  ["kind"] = "cli",
  ["text"] = "Dig out the field to level it.",
}
,
  ["motion"] = {
  ["childs"] = {
  [":facing"] = {
  ["type"] = "value",
  ["returns"] = " `\"north\"|\"east\"|\"south\"|\"west\"` ",
  ["name"] = "facing",
  ["description"] = "\
For movement in four NESW cardinal directions",
}
,
  [":stepping"] = {
  ["type"] = "value",
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["name"] = "stepping",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  [":detail.damage"] = {
  ["type"] = "value",
  ["returns"] = " `#:`",
  ["name"] = "detail.damage",
  ["description"] = "\
Distinguishing value",
}
,
  [":situation"] = {
  ["type"] = "value",
  ["returns"] = " `{:position:, :facing:, fuel: situation.fuel, level: situation.level}`",
  ["name"] = "situation",
  ["description"] = "\
Dead reckoning",
}
,
  [":detail"] = {
  ["type"] = "value",
  ["returns"] = " `{name: detail.name, count: detail.count, damage: detail.damage}`",
  ["name"] = "detail",
  ["description"] = "\
Defined by Computercraft",
}
,
  [":position"] = {
  ["type"] = "value",
  ["returns"] = " `{x: #:, y: #:, z: #:}`",
  ["name"] = "position",
  ["description"] = "\
Computercraft co-ordinates (+x east, +y up, +z south)",
}
,
  [":situation.fuel"] = {
  ["type"] = "value",
  ["returns"] = " `#:`",
  ["name"] = "situation.fuel",
  ["description"] = "\
Simulated fuel level checked against reported fuel to validate dead reckoning",
}
,
  [":detail.count"] = {
  ["type"] = "value",
  ["returns"] = " `#:`",
  ["name"] = "detail.count",
  ["description"] = "\
Available in inventory",
}
,
  [":recovery"] = {
  ["type"] = "value",
  ["returns"] = " `[call: \":\", cause: \":\", remaining: #:, :xyzf:, :direction:, operation: \":\"]`",
  ["name"] = "recovery",
  ["description"] = "\
For some errors",
}
,
  [":detail.name"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"`",
  ["name"] = "detail.name",
  ["description"] = "\
Prepended by the mod name `\"minecraft:\"`.",
}
,
  [":situations"] = {
  ["type"] = "value",
  ["returns"] = " `situation[]`",
  ["name"] = "situations",
  ["description"] = "\
Tracking history",
}
,
  [":situation.level"] = {
  ["type"] = "value",
  ["returns"] = " `\"same\"|\"rise\"|\"fall\"`",
  ["name"] = "situation.level",
  ["description"] = "\
For tracking",
}
,
}
,
  ["returns"] = " motion, move, step",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "motion",
  ["description"] = "\
Libraries to move turtles and move turtles by steps allowing operations at each step._ -> motion, move, step move: _Position setting, tracking, and reporting by dead reckoning checked by fuel consumption. step: _Iterators (closures) for moving block by block, potentially doing operations at each block.",
}
,
  ["__remote.prepareCall:_"] = {
  ["line"] = "--:: `_remote.prepareCall(server: \":\", command: \":\", arguments: any[])` -> _Serialize server request._ -> `serverID: #:, request: \":\" &: &!`",
  ["kind"] = "face",
  ["sign"] = "`_remote.prepareCall(server: \":\", command: \":\", arguments: any[])`  ",
  ["out"] = " `serverID: #:, request: \":\" &: &!`",
  ["text"] = "Serialize server request.",
}
,
  ["_gps"] = {
  ["type"] = "lib",
  ["name"] = "_gps",
  ["childs"] = {
  ["equip"] = {
  ["returns"] = " \":\" <-\
",
  ["args"] = "direction: facing",
  ["type"] = "function",
  ["name"] = "_gps.equip",
  ["description"] = "\
Assemble parts.",
}
,
  ["actuate"] = {
  ["returns"] = " \":\" <-\
",
  ["args"] = "commands: [command: \":\", direction: facing]",
  ["type"] = "function",
  ["name"] = "_gps.actuate",
  ["description"] = "\
Move to boot a GPS host and retrieve floppy.",
}
,
  ["launch"] = {
  ["returns"] = " \":\" <-\
",
  ["args"] = "commands: [command: \":\", location: \":\", yD: #:?]",
  ["type"] = "function",
  ["name"] = "_gps.launch",
  ["description"] = "\
Check before journey then launch.",
}
,
}
,
}
,
  ["_fuel_"] = {
  ["line"] = "test(3, \"miner\", \"fuel\") --:- fuel -> _Returns energy available in turtle slots._",
  ["sign"] = "fuel  ",
  ["text"] = "Returns energy available in turtle slots.",
  ["kind"] = "cli",
}
,
  ["_map.place:_"] = {
  ["line"] = "  --:: map.place(placeString: \":\") -> _Instantiate string as named place, include in named places._ -> `serial: \":\", index: #: &!`",
  ["kind"] = "face",
  ["sign"] = "map.place(placeString: \":\")  ",
  ["out"] = " `serial: \":\", index: #: &!`",
  ["text"] = "Instantiate string as named place, include in named places.",
}
,
  ["_harvest_"] = {
  ["line"] = "--:- harvest range firstPlot lastPlot?? -> _Harvest (and replant if needed)._",
  ["sign"] = "harvest range firstPlot lastPlot??  ",
  ["kind"] = "cli",
  ["text"] = "Harvest (and replant if needed).",
}
,
  ["__gps.equip:_"] = {
  ["line"] = "  --:: `_gps.equip(direction: facing)` -> _Assemble parts._ -> \":\"",
  ["kind"] = "face",
  ["sign"] = "`_gps.equip(direction: facing)`  ",
  ["out"] = " \":\"",
  ["text"] = "Assemble parts.",
}
,
  ["_find_"] = {
  ["line"] = "--:- find name...? -> Report and select first slot found [or if no name, just report inventory].",
  ["sign"] = "find name...?  ",
  ["text"] = "Report and select first slot found [or if no name, just report inventory].",
  ["kind"] = "cli",
}
,
  ["_site_"] = {
  ["line"] = "--:- site [name] -> _Remote operation to report or change site after, e.g., porting `rover`._test(23, \"logger\", \"site\")",
  ["sign"] = "site [name]  ",
  ["text"] = "Remote operation to report or change site after, e.g., porting `rover`._test(23, \"logger\", \"site\")",
  ["kind"] = "cli",
}
,
  ["_field.cut:_"] = {
  ["line"] = "--:: field.cut(places: [nearPlace: \":\", farPlace: \":\"]) -> _Quarry out blocks from one place to the other._ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "field.cut(places: [nearPlace: \":\", farPlace: \":\"])  ",
  ["kind"] = "face",
  ["text"] = "Quarry out blocks from one place to the other.",
}
,
  ["_remote.come:_"] = {
  ["line"] = "  --:: remote.come(turtle: \":\") -> _Towards GPS player position._ -> `report: \":\"`",
  ["kind"] = "face",
  ["sign"] = "remote.come(turtle: \":\")  ",
  ["out"] = " `report: \":\"`",
  ["text"] = "Towards GPS player position.",
}
,
  ["_map.read:_"] = {
  ["line"] = "  --:: map.read(thisMap: \":\") -> _Reinstantiate places from map file._ -> `serial: \":\", index: #: &!`",
  ["kind"] = "face",
  ["sign"] = "map.read(thisMap: \":\")  ",
  ["out"] = " `serial: \":\", index: #: &!`",
  ["text"] = "Reinstantiate places from map file.",
}
,
  ["move"] = {
  ["type"] = "lib",
  ["name"] = "move",
  ["childs"] = {
  ["right"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.right",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["to"] = {
  ["returns"] = " `\"done\", #:, xyzf: \":\" &!recovery`  <-\
",
  ["args"] = "xyzf: xyzf, first: \":\"?",
  ["type"] = "function",
  ["name"] = "move.to",
  ["description"] = "\
Current situation to x, z, y, and optionally face. Optional argument_ `first` _is \"x\", \"y\", or \"z\" to select first move in that direction to deal with blockages.",
}
,
  ["situations"] = {
  ["returns"] = "  situations <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "move.situations",
  ["description"] = "\
Deep copy `_G.Muse.situations`.",
}
,
  ["east"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.east",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["down"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.down",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["findItems"] = {
  ["returns"] = " `detail?`, #:?, ^:? <-\
",
  ["args"] = "targets: \":\"[]",
  ["type"] = "function",
  ["name"] = "move.findItems",
  ["description"] = "\
Selects found slot.",
}
,
  ["left"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.left",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["back"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.back",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["forward"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.forward",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["north"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.north",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["at"] = {
  ["returns"] = " `xyzf` <-\
",
  ["args"] = "theSituation:situation?",
  ["type"] = "function",
  ["name"] = "move.at",
  ["description"] = "\
(Current) situation xyzf.",
}
,
  ["set"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "x: #:, y: #:, z: #:, f: facing?, fuels: #:??, level: \":\"???",
  ["type"] = "function",
  ["name"] = "move.set",
  ["description"] = "\
Set position, optionally rest of situation.",
}
,
  ["up"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.up",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["west"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.west",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["where"] = {
  ["returns"] = " `x: #:, y: #:, z: #:, facing: \":\", ok: #:|^:` <-\
",
  ["args"] = "tx: #:?, ty: #:?, tz: #:?, tf: \":\"?",
  ["type"] = "function",
  ["name"] = "move.where",
  ["description"] = "\
Returns GPS results if available. If no GPS, returns the optional (testing) parameters or, if not supplied, current dead reckoning position in situation.",
}
,
  ["tracking"] = {
  ["returns"] = " `copy: situation, count: #:` <-\
",
  ["args"] = "enabled: ^:",
  ["type"] = "function",
  ["name"] = "move.tracking",
  ["description"] = "\
Set tracking condition and situations, return situations count",
}
,
  ["situation"] = {
  ["returns"] = " situation <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "move.situation",
  ["description"] = "\
Clone current situation",
}
,
  ["moves"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.moves",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["south"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.south",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["ats"] = {
  ["returns"] = " `xyzf: \":\"` <-\
",
  ["args"] = "theSituation:situation?",
  ["type"] = "function",
  ["name"] = "move.ats",
  ["description"] = "\
(Current) situation position and facing string (`\"\"` in game if not turtle).",
}
,
  ["get"] = {
  ["returns"] = " `x: #:?, y: #:?, z: #:?, facing: \":\", fuel: #:, level: \":\" <-\
",
  ["args"] = ":situation:?",
  ["type"] = "function",
  ["name"] = "move.get",
  ["description"] = "\
Default current situation.",
}
,
}
,
}
,
  ["__field.makeBounds:_"] = {
  ["line"] = "  --:: `_field.makeBounds(nearPlace: \":\", farPlace: \":\")` -> _Get coordinate pair for named places._ -> `xyz, xyz, #:, #:`",
  ["out"] = " `xyz, xyz, #:, #:`",
  ["sign"] = "`_field.makeBounds(nearPlace: \":\", farPlace: \":\")`  ",
  ["kind"] = "face",
  ["text"] = "Get coordinate pair for named places.",
}
,
  ["_core.compose:_"] = {
  ["line"] = "  --:: core.compose(...: ():): -> _Produce function equivqlent to sucessive application of argument functions_ -> ():",
  ["out"] = " ():",
  ["sign"] = "core.compose(...: ():):  ",
  ["kind"] = "face",
  ["text"] = "Produce function equivqlent to sucessive application of argument functions",
}
,
  ["_Places_"] = {
  ["line"] = "--:< **Places - Points, Locations, Trails, and Ranges of Maps**",
  ["sign"] = "**Places - Points, Locations, Trails, and Ranges of Maps** ",
  ["kind"] = "word",
  ["text"] = "Places - Points, Locations, Trails, and Ranges of Maps",
}
,
  ["_step.up:_"] = {
  ["line"] = "--:: step.up(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.up(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_port.book:_"] = {
  ["line"] = "  --:: port.book(name: \":\", label: \":\", from: place, to: place, span: #:, ordering: port.order) -> _Testing_ -> `booking: \":\"`",
  ["out"] = " `booking: \":\"`",
  ["sign"] = "port.book(name: \":\", label: \":\", from: place, to: place, span: #:, ordering: port.order)  ",
  ["kind"] = "face",
  ["text"] = "Testing",
}
,
  [" mock"] = {
  ["type"] = "lib",
  ["name"] = " mock",
  ["childs"] = {
}
,
}
,
  [" turtle"] = {
  ["type"] = "lib",
  ["name"] = " turtle",
  ["childs"] = {
}
,
}
,
  ["_gps.op:_"] = {
  ["line"] = "  --:: gps.op(commands: \":\"[]) -> _Command Line Interface._ -> `report: \":\"` &:",
  ["kind"] = "face",
  ["sign"] = "gps.op(commands: \":\"[])  ",
  ["out"] = " `report: \":\"` &:",
  ["text"] = "Command Line Interface.",
}
,
  ["_remote.returns:_"] = {
  ["line"] = "--:: remote.returns(results: any[]) -> _Default client side handling of server response: just print results as string._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "remote.returns(results: any[])  ",
  ["out"] = " `nil`",
  ["text"] = "Default client side handling of server response: just print results as string.",
}
,
  [" core"] = {
  ["type"] = "lib",
  ["name"] = " core",
  ["childs"] = {
}
,
}
,
  ["_port.op:_"] = {
  ["line"] = "function port.op(commands) --:: port.op(commands: \":\"[]) -> _Command Line Interface for teleport book and trip:_ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "port.op(commands: \":\"[])  ",
  ["kind"] = "face",
  ["text"] = "Command Line Interface for teleport book and trip:",
}
,
  ["_turtle.check:_"] = {
  ["line"] = "  --:: turtle.check(targets: \":\"[], :detail:) -> _Tries to match each target against_ `detail.name`. -> `matched: \":\"?`",
  ["out"] = " `matched: \":\"?`",
  ["sign"] = "turtle.check(targets: \":\"[], :detail:)  ",
  ["kind"] = "face",
  ["text"] = "Tries to match each target against_ `detail.name`.",
}
,
  ["_items_"] = {
  ["line"] = "test(4, \"miner\", \"items\") --:- items -> _Returns items in turtle inventory._",
  ["sign"] = "items  ",
  ["text"] = "Returns items in turtle inventory.",
  ["kind"] = "cli",
}
,
  ["_rover_"] = {
  ["line"] = "--:- rover command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "rover command argument...  ",
  ["kind"] = "cli",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
}
,
  ["_put_"] = {
  ["line"] = "--:- put filling direction distance puttings+ -> Direction, distance to move, placing filling in puttings directions.",
  ["sign"] = "put filling direction distance puttings+  ",
  ["text"] = "Direction, distance to move, placing filling in puttings directions.",
  ["kind"] = "cli",
}
,
  ["farm"] = {
  ["childs"] = {
  [":farmOpName"] = {
  ["type"] = "value",
  ["returns"] = " `\"quarry\"|\"layer\"|\"cover\"|\"finish\"|\"fence\"|\"harvest\"|\"path\"|\"test\"`",
  ["name"] = "farmOpName",
  ["description"] = "\
Specifies operation on field",
}
,
  ["replacer"] = {
  ["returns"] = " `(_:, :direction:): \":\" &!`  <-\
",
  ["args"] = "putAim: direction, item: \":\"[]|\":\", removables: \":\"[]",
  ["type"] = "function",
  ["name"] = "farm.replacer",
  ["description"] = "\
Remove, put. Returns a function used by `lib/worker` to inspect aimed direction, farm out any removeable, replace with found item. The direction of movement parameter in that function is used to reface turtle after replacement.",
}
,
  ["logs"] = {
  ["returns"] = " `report: \":\" &!` <-\
",
  ["args"] = "seedlings: \":\"[], :direction:",
  ["type"] = "function",
  ["name"] = "farm.logs",
  ["description"] = "\
Logs down and sides, plants found seedlings.",
}
,
  ["put"] = {
  ["returns"] = "  `report: \":\" &!` <-\
",
  ["args"] = "putAim: direction, item: \":\"[]|\":\"",
  ["type"] = "function",
  ["name"] = "farm.put",
  ["description"] = "\
Puts found item in aimed direction.",
}
,
  ["plant"] = {
  ["returns"] = " `report: \":\" &!`  <-\
",
  ["args"] = "planting: \":\"",
  ["type"] = "function",
  ["name"] = "farm.plant",
  ["description"] = "\
Tills and plants found planting.",
}
,
}
,
  ["returns"] = " farm",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "farm",
  ["description"] = "\
Planting through blockages and in several directions. Putting item and replacing blocks._-> farm",
}
,
  ["_place.near:_"] = {
  ["line"] = "--:: place.near(span: #:?, reference?:\":\"|[x:#:,y:#:,z:#:]) ->  -> (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"`",
  ["out"] = " (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"`",
  ["sign"] = "place.near(span: #:?, reference?:\":\"|[x:#:,y:#:,z:#:])  ",
  ["kind"] = "face",
  ["text"] = "",
}
,
  ["_move.south:_"] = {
  ["line"] = "--:: move.south(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.south(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_fill_"] = {
  ["line"] = "--:- fill point point filling ?target -> _Layer fill bounds by points; optionally swaps out only target blocks._",
  ["sign"] = "fill point point filling ?target  ",
  ["text"] = "Layer fill bounds by points; optionally swaps out only target blocks.",
  ["kind"] = "cli",
}
,
  [" field"] = {
  ["type"] = "lib",
  ["name"] = " field",
  ["childs"] = {
}
,
}
,
  ["_erase_"] = {
  ["line"] = "--:- erase name -> Remove named place and broadcast Muse eXcise (MX) to units at current site.",
  ["sign"] = "erase name  ",
  ["text"] = "Remove named place and broadcast Muse eXcise (MX) to units at current site.",
  ["kind"] = "cli",
}
,
  ["_map.gets:_"] = {
  ["line"] = "map.gets = map.get --:: map.gets(name: \":\", key: \":\") -> _Less generic retrieval interface: gets string feature value._ -> `\":\"?`",
  ["kind"] = "face",
  ["sign"] = "map.gets(name: \":\", key: \":\")  ",
  ["out"] = " `\":\"?`",
  ["text"] = "Less generic retrieval interface: gets string feature value.",
}
,
  ["_core.xyzf:_"] = {
  ["line"] = "function core.xyzf(xyzf) --:: core.xyzf(:xyzf:) -> _Returns specially formatted string for `xyzf`._ -> `\":\"`",
  ["out"] = " `\":\"`",
  ["sign"] = "core.xyzf(:xyzf:)  ",
  ["kind"] = "face",
  ["text"] = "Returns specially formatted string for `xyzf`.",
}
,
  ["_move.right:_"] = {
  ["line"] = "--:: move.right(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.right(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["port"] = {
  ["childs"] = {
  ["op"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "commands: \":\"[]",
  ["type"] = "function",
  ["name"] = "port.op",
  ["description"] = "\
Command Line Interface for teleport book and trip:",
}
,
  [":port.order"] = {
  ["type"] = "value",
  ["returns"] = " `port.item[]`",
  ["name"] = "port.order",
  ["description"] = "\
Order in which inventory items will be considered for booking",
}
,
  ["available"] = {
  ["returns"] = " `[port.item]: #:` <-\
",
  ["args"] = "set: [port.item]: #:",
  ["type"] = "function",
  ["name"] = "port.available",
  ["description"] = "\
For Testing: mock player inventory",
}
,
  [":port.item"] = {
  ["type"] = "value",
  ["returns"] = " `\"iron\"|\"copper\"|\"gold\"|\"redstone\"`",
  ["name"] = "port.item",
  ["description"] = "\
Short inventory item name for booking",
}
,
  ["book"] = {
  ["returns"] = " `booking: \":\"` <-\
",
  ["args"] = "name: \":\", label: \":\", from: place, to: place, span: #:, ordering: port.order",
  ["type"] = "function",
  ["name"] = "port.book",
  ["description"] = "\
Testing Booking (string) names the `range` entry that will be used to specify a `port` operation and how to pay for it. Return needed inventory for booking and bankable if > 0",
}
,
  ["inventory"] = {
  ["returns"] = " `\":\"[], #:, #:` <-\
",
  ["args"] = "costToPay: #:, orderedItems: port.order, playerInventory: [port.item]: #:",
  ["type"] = "function",
  ["name"] = "port.inventory",
  ["description"] = "\
Testing Returns payment inventory used for `costToPay`, excess energy to bank, inventory energy used",
}
,
}
,
  ["returns"] = " port",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "port",
  ["description"] = "\
CLL for `book` and `port` commands assessing and clearing player inventory for specified teleport._ -> port",
}
,
  ["__mine.bore:_"] = {
  ["line"] = "  --:: `_mine.bore(markerName: \":\", borePlans: bores, shaftPlans:shafts)` -> _Go to marker and bore_ -> `\"done\", \":\", #: &: &!`",
  ["out"] = " `\"done\", \":\", #: &: &!`",
  ["sign"] = "`_mine.bore(markerName: \":\", borePlans: bores, shaftPlans:shafts)`  ",
  ["kind"] = "face",
  ["text"] = "Go to marker and bore",
}
,
  ["_move.west:_"] = {
  ["line"] = "--:: move.west(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.west(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_turtle.inventory:_"] = {
  ["line"] = "  --:: turtle.inventory() -> _Returns currrent turtle inventory as turtle detail table_. -> `detail[]`",
  ["out"] = " `detail[]`",
  ["sign"] = "turtle.inventory()  ",
  ["kind"] = "face",
  ["text"] = "Returns currrent turtle inventory as turtle detail table_.",
}
,
  ["_dds.roleID:_"] = {
  ["line"] = "function dds.roleID(role) return IDs[role] end --:: dds.roleID(role: \":\") -> _ID for a Muse role_ -> `ID: #:` ",
  ["kind"] = "face",
  ["sign"] = "dds.roleID(role: \":\")  ",
  ["out"] = " `ID: #:` ",
  ["text"] = "ID for a Muse role",
}
,
  ["_map.testFacing:_"] = {
  ["line"] = "--:: map.testFacing(dx: #:, dz: #:) -> _Find orientation using position changes for non-zero movement._ -> `facing: \":\" & !`",
  ["kind"] = "face",
  ["sign"] = "map.testFacing(dx: #:, dz: #:)  ",
  ["out"] = " `facing: \":\" & !`",
  ["text"] = "Find orientation using position changes for non-zero movement.",
}
,
  ["_move.back:_"] = {
  ["line"] = "--:: move.back(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.back(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_step.east:_"] = {
  ["line"] = "--:: step.east(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.east(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_move.forward:_"] = {
  ["line"] = "--:: move.forward(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.forward(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_place.trail:_"] = {
  ["line"] = "--:: place.trail(headName: \":\", tailName: \":\", label: \":\") -> _Makes two places._ -> `headSerial: \":\", tailSerial: \":\", count: #:`",
  ["out"] = " `headSerial: \":\", tailSerial: \":\", count: #:`",
  ["sign"] = "place.trail(headName: \":\", tailName: \":\", label: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Makes two places.",
}
,
  ["_farm.put:_"] = {
  ["line"] = "--:: farm.put(putAim: direction, item: \":\"[]|\":\") -> _Puts found item in aimed direction._ ->  `report: \":\" &!`",
  ["kind"] = "face",
  ["sign"] = "farm.put(putAim: direction, item: \":\"[]|\":\")  ",
  ["out"] = "  `report: \":\" &!`",
  ["text"] = "Puts found item in aimed direction.",
}
,
  ["_place.qualify:_"] = {
  ["line"] = "--:: place.qualify(name: \":\") -> _Return already sited name, otherwise prepend site to name_ -> `sitedName: \":\"`",
  ["out"] = " `sitedName: \":\"`",
  ["sign"] = "place.qualify(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Return already sited name, otherwise prepend site to name",
}
,
  ["_echo_"] = {
  ["line"] = "--:- echo arguments ... -> For testing: just returns its arguments.  ",
  ["sign"] = "echo arguments ...  ",
  ["text"] = "For testing: just returns its arguments.",
  ["kind"] = "cli",
}
,
  ["__task.doTask:_"] = {
  ["line"] = "  --:: `_task.doTask(arguments: _task.puts, op: ():, clear: ^:, fill?: \":\", targets?: \":\"[])`-> _Tasks_ -> \":\" &!`",
  ["kind"] = "face",
  ["sign"] = "`_task.doTask(arguments: _task.puts, op: ():, clear: ^:, fill?: \":\", targets?: \":\"[])` ",
  ["out"] = " \":\" &!`",
  ["text"] = "Tasks",
}
,
  ["_dds.hosts:_"] = {
  ["line"] = "  --:: dds.hosts() -> _Populates players IDs and labels using a MQ rednet protocol._ -> `IDs, roles`",
  ["kind"] = "face",
  ["sign"] = "dds.hosts()  ",
  ["out"] = " `IDs, roles`",
  ["text"] = "Populates players IDs and labels using a MQ rednet protocol.",
}
,
  ["_trace_"] = {
  ["line"] = "  --:- trace trailname ->  _Move turtle along traced situations in named trail from one end of trail to the other._",
  ["sign"] = "trace trailname  ",
  ["text"] = "Move turtle along traced situations in named trail from one end of trail to the other.",
  ["kind"] = "cli",
}
,
  ["__mine.back:_"] = {
  ["line"] = "  --:: `_mine.back(mineheadName: \":\",  targetLevel: #:, shaftPlansBack: shafts, shaftPlansName: \":\")` -> _To minehead_ -> `\":\", \":\"  &!`",
  ["out"] = " `\":\", \":\"  &!`",
  ["sign"] = "`_mine.back(mineheadName: \":\",  targetLevel: #:, shaftPlansBack: shafts, shaftPlansName: \":\")`  ",
  ["kind"] = "face",
  ["text"] = "To minehead",
}
,
  ["_core.logging:_"] = {
  ["line"] = "  --:: core.logging(arguments: {level: #:, filename: \":\"}) -> _Set threshold level [and local log file] for status reports_ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "core.logging(arguments: {level: #:, filename: \":\"})  ",
  ["kind"] = "face",
  ["text"] = "Set threshold level [and local log file] for status reports",
}
,
  ["_place.track:_"] = {
  ["line"] = "  --:: place.track(name: \":\") -> _Returns trail_ -> `name: \":\"?, label: \":\"?, :situations:?`",
  ["out"] = " `name: \":\"?, label: \":\"?, :situations:?`",
  ["sign"] = "place.track(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Returns trail",
}
,
  ["_place.xyzf:_"] = {
  ["line"] = "  --:: place.xyzf(name: \":\"?, index: #:?) -> _Looks up index in name [defaults to current situation]._ -> `xyzf?, order: #:?`",
  ["out"] = " `xyzf?, order: #:?`",
  ["sign"] = "place.xyzf(name: \":\"?, index: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Looks up index in name [defaults to current situation].",
}
,
  ["_suck_"] = {
  ["line"] = "--:- suck direction quantity? -> Suck quantity items [or all] into available slot.",
  ["sign"] = "suck direction quantity?  ",
  ["text"] = "Suck quantity items [or all] into available slot.",
  ["kind"] = "cli",
}
,
  ["_check.open:_"] = {
  ["line"] = "  --:: check.open(testName:\":\", text: \":\") -> _Return `check` object(closure)_ -> `{part:():, message:():, call: ():, close:():}` ",
  ["kind"] = "face",
  ["sign"] = "check.open(testName:\":\", text: \":\")  ",
  ["out"] = " `{part:():, message:():, call: ():, close:():}` ",
  ["text"] = "Return `check` object(closure)",
}
,
  ["_fueling_"] = {
  ["line"] = "function turtle.fuel() --:- fueling -> _Returns energy available in turtle slots._",
  ["sign"] = "fueling  ",
  ["text"] = "Returns energy available in turtle slots.",
  ["kind"] = "cli",
}
,
  ["_mine"] = {
  ["type"] = "lib",
  ["name"] = "_mine",
  ["childs"] = {
  ["atWork"] = {
  ["returns"] = " `\":\", \":\" &: &!` <-\
",
  ["args"] = ":plan:, head: \":\", level: #:, key: \":\", value: any",
  ["type"] = "function",
  ["name"] = "_mine.atWork",
  ["description"] = "\
Make, fill in, execute at level.",
}
,
  ["back"] = {
  ["returns"] = " `\":\", \":\"  &!` <-\
",
  ["args"] = "mineheadName: \":\",  targetLevel: #:, shaftPlansBack: shafts, shaftPlansName: \":\"",
  ["type"] = "function",
  ["name"] = "_mine.back",
  ["description"] = "\
To minehead Execute shaft plans back to return to minehead from one below target level Add \"shaft\" and shaft plans name as key and value to shaft plans for inclusion in marker",
}
,
  ["shaftOp"] = {
  ["returns"] = " `\":\", \":\", #:` &! <-\
",
  ["args"] = "mineheadName: \":\", levels: #:, shaftPlans: shafts",
  ["type"] = "function",
  ["name"] = "_mine.shaftOp",
  ["description"] = "\
Dig shaft through levels.",
}
,
  ["toPost"] = {
  ["returns"] = " `\"done\", \":\", #: &!` <-\
",
  ["args"] = "markerName: \":\", borePlans: bores, shaftPlans: shafts",
  ["type"] = "function",
  ["name"] = "_mine.toPost",
  ["description"] = "\
Navigate to post",
}
,
  ["ores"] = {
  ["returns"] = " \"done\", `\":\", #: &: &!` <-\
",
  ["args"] = "markerName: \":\", thisLevel: #:, borePlans: bores",
  ["type"] = "function",
  ["name"] = "_mine.ores",
  ["description"] = "\
Excavate ores Use shaft plans and instantiated bore plans to go to marker and execute mining operations",
}
,
  ["down"] = {
  ["returns"] = " `\"done\" &!` <-\
",
  ["args"] = "mineheadName: \":\", targetLevel: #:, shaftPlansDown: downs, shaftPlansName: \":\"",
  ["type"] = "function",
  ["name"] = "_mine.down",
  ["description"] = "\
Dig shaft Start dig down from minehead, finish by placing marker one level below target level, error raised for failure. Add \"shaft\" and shaft plans name as key and value to shaft plans for inclusion in marker.",
}
,
  ["bore"] = {
  ["returns"] = " `\"done\", \":\", #: &: &!` <-\
",
  ["args"] = "markerName: \":\", borePlans: bores, shaftPlans:shafts",
  ["type"] = "function",
  ["name"] = "_mine.bore",
  ["description"] = "\
Go to marker and bore Use shaft plans and bore plans to navigate to marker, bore horizontal tunnels using bore plans. Add \"bore\" and bore plans name as key and value to bore plans for inclusion in marker. Bores plans at even or odd level, potentially leaves place marks and torches.",
}
,
}
,
}
,
  ["_core.pass:_"] = {
  ["line"] = "  --:: core.pass(ok: ^:, ...: any) -> _Pass input but report string if not ok._ -> ok: `true|false, result: ...|\":\", any?`",
  ["out"] = " ok: `true|false, result: ...|\":\", any?`",
  ["sign"] = "core.pass(ok: ^:, ...: any)  ",
  ["kind"] = "face",
  ["text"] = "Pass input but report string if not ok.",
}
,
  ["_actuate_"] = {
  ["line"] = "  --:- actuate direction -> _Move around to boot direction named GPS host and retrieve floppy (for testing)._ ",
  ["sign"] = "actuate direction  ",
  ["kind"] = "cli",
  ["text"] = "Move around to boot direction named GPS host and retrieve floppy (for testing).",
}
,
  ["_turtle.unblock:_"] = {
  ["line"] = "  --:: turtle.unblock(direction: \":\", limit: #:?) -> _Retrys dig to limit or bedrock._ -> `\"done\", nil|\"undug\" &!` ",
  ["out"] = " `\"done\", nil|\"undug\" &!` ",
  ["sign"] = "turtle.unblock(direction: \":\", limit: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Retrys dig to limit or bedrock.",
}
,
  ["dds"] = {
  ["childs"] = {
  ["roleID"] = {
  ["returns"] = " `ID: #:`  <-\
",
  ["args"] = "role: \":\"",
  ["type"] = "function",
  ["name"] = "dds.roleID",
  ["description"] = "\
ID for a Muse role",
}
,
  [":roles"] = {
  ["type"] = "value",
  ["returns"] = " `role[]`",
  ["name"] = "roles",
  ["description"] = "\
Sparse array of Computercraft labels for MUSE roles indexed by Computercraft IDs",
}
,
  [":IDs"] = {
  ["type"] = "value",
  ["returns"] = " `[role]: ID`",
  ["name"] = "IDs",
  ["description"] = "\
Dictionary of ComputerCraft computer IDs keyed by MUSE role",
}
,
  [":ID"] = {
  ["type"] = "value",
  ["returns"] = " `#:`",
  ["name"] = "ID",
  ["description"] = "\
ComputerCraft computer ID",
}
,
  [":role"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"`",
  ["name"] = "role",
  ["description"] = "\
ComputerCraft label as MUSE role",
}
,
  ["role"] = {
  ["returns"] = " `role: \":\"` <-\
",
  ["args"] = "ID: #:",
  ["type"] = "function",
  ["name"] = "dds.role",
  ["description"] = "\
Label for a Muse role",
}
,
  ["hosts"] = {
  ["returns"] = " `IDs, roles` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "dds.hosts",
  ["description"] = "\
Populates players IDs and labels using a MQ rednet protocol.",
}
,
  ["join"] = {
  ["returns"] = " `sitedLabel: \":\"` <-\
",
  ["args"] = "role: \":\", idGiven: #:?",
  ["type"] = "function",
  ["name"] = "dds.join",
  ["description"] = "\
Fix ID role association for next startup, id given by player.",
}
,
  ["map"] = {
  ["returns"] = " `IDs` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "dds.map",
  ["description"] = "\
Returns associations from Muse roles to ComputerCraft IDs",
}
,
}
,
  ["returns"] = " dds",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "dds",
  ["description"] = "\
Associates computer IDs with labels (as Muse roles) using Muse Query (MQ) rednet protocol._ -> dds",
}
,
  ["_field.plan:_"] = {
  ["line"] = "--:: field.plan(planName: \":\", fielding: fieldParameters, offset: xyz?) -> _Run plan, default offset {0,0,0}._ -> `report: \":\" &: &!`",
  ["out"] = " `report: \":\" &: &!`",
  ["sign"] = "field.plan(planName: \":\", fielding: fieldParameters, offset: xyz?)  ",
  ["kind"] = "face",
  ["text"] = "Run plan, default offset {0,0,0}.",
}
,
  ["_core.serialize:_"] = {
  ["line"] = "--:: core.serialize(input: any) -> _Executable string to instantiate input._ -> `\"return \"..\":\" &!`",
  ["out"] = " `\"return \"..\":\" &!`",
  ["sign"] = "core.serialize(input: any)  ",
  ["kind"] = "face",
  ["text"] = "Executable string to instantiate input.",
}
,
  ["_check.regression:_"] = {
  ["line"] = "function check.regression(testOrder) --:: check.regression(testOrder: \":\"[]) -> _Run ordered test (names) for regression._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "check.regression(testOrder: \":\"[])  ",
  ["out"] = " `nil`",
  ["text"] = "Run ordered test (names) for regression.",
}
,
  ["_map.write:_"] = {
  ["line"] = "function map.write(thisMap) --:: map.write(thisMap: \":\"?) -> _Delete old, write new locally. Default current._ -> `nil &!`",
  ["kind"] = "face",
  ["sign"] = "map.write(thisMap: \":\"?)  ",
  ["out"] = " `nil &!`",
  ["text"] = "Delete old, write new locally. Default current.",
}
,
  ["_core.map:_"] = {
  ["line"] = "  --:: core.map(op: ():, table: {:}) -> _Create_ `result` _by applying_ `op` _function to elements of_ `table` -> `{:}`",
  ["out"] = " `{:}`",
  ["sign"] = "core.map(op: ():, table: {:})  ",
  ["kind"] = "face",
  ["text"] = "Create `result` _by applying_ `op` _function to elements of_ `table",
}
,
  ["__field.fillTill:_"] = {
  ["line"] = "  --:: `_field.fillTill(thePlan: \":\", parameters: [nearPlace: \":\", farPlace: \":\", filling: \":\", target: \":\"?])` -> _To `put``._ -> `\":\"`",
  ["out"] = " `\":\"`",
  ["sign"] = "`_field.fillTill(thePlan: \":\", parameters: [nearPlace: \":\", farPlace: \":\", filling: \":\", target: \":\"?])`  ",
  ["kind"] = "face",
  ["text"] = "To `put``.",
}
,
  [" roam"] = {
  ["type"] = "lib",
  ["name"] = " roam",
  ["childs"] = {
}
,
}
,
  ["_core.getComputerID:_"] = {
  ["line"] = "--:: core.getComputerID(id: #:?) -> _Out of game returns id; id ignored in game._ -> `id: #:`",
  ["out"] = " `id: #:`",
  ["sign"] = "core.getComputerID(id: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Out of game returns id; id ignored in game.",
}
,
  [" map"] = {
  ["type"] = "lib",
  ["name"] = " map",
  ["childs"] = {
}
,
}
,
  ["_port.inventory:_"] = {
  ["line"] = "  --:: port.inventory(costToPay: #:, orderedItems: port.order, playerInventory: [port.item]: #:) -> _Testing_ -> `\":\"[], #:, #:`",
  ["out"] = " `\":\"[], #:, #:`",
  ["sign"] = "port.inventory(costToPay: #:, orderedItems: port.order, playerInventory: [port.item]: #:)  ",
  ["kind"] = "face",
  ["text"] = "Testing",
}
,
  ["_place.match:_"] = {
  ["line"] = "  --:: place.match(name: \":\") -> _Lookup place qualified by site, return_ `nil` _if not found._ -> `order: #:?, place: place?`",
  ["out"] = " `order: #:?, place: place?`",
  ["sign"] = "place.match(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Lookup place qualified by site, return_ `nil` _if not found.",
}
,
  ["_field.fence:_"] = {
  ["line"] = "--:: field.fence(parameters: [ranger: \":\", fencing: \":\"?]) -> _Put fencing using `layer` plan._ -> `\":\"`",
  ["out"] = " `\":\"`",
  ["sign"] = "field.fence(parameters: [ranger: \":\", fencing: \":\"?])  ",
  ["kind"] = "face",
  ["text"] = "Put fencing using `layer` plan.",
}
,
  ["_roam.come:_"] = {
  ["line"] = "--:: roam.come(:xyz:) -> _Server (turtle) side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come. -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "roam.come(:xyz:)  ",
  ["kind"] = "face",
  ["text"] = "Server (turtle) side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come.",
}
,
  ["_dig_"] = {
  ["line"] = "--:- dig direction distance hoeings...? -> Direction and distance to (possibly blocked) move, hoeings directions to hoe.",
  ["sign"] = "dig direction distance hoeings...?  ",
  ["text"] = "Direction and distance to (possibly blocked) move, hoeings directions to hoe.",
  ["kind"] = "cli",
}
,
  ["_core.merge:_"] = {
  ["line"] = "function core.merge(...) --:: core.merge(...: {:}) -> _Merge any number of flat tables into one, allowing repeats._ -> `{:}`",
  ["out"] = " `{:}`",
  ["sign"] = "core.merge(...: {:})  ",
  ["kind"] = "face",
  ["text"] = "Merge any number of flat tables into one, allowing repeats.",
}
,
  ["_field"] = {
  ["type"] = "lib",
  ["name"] = "_field",
  ["childs"] = {
  ["fillTill"] = {
  ["returns"] = " `\":\"` <-\
",
  ["args"] = "thePlan: \":\", parameters: [nearPlace: \":\", farPlace: \":\", filling: \":\", target: \":\"?]",
  ["type"] = "function",
  ["name"] = "_field.fillTill",
  ["description"] = "\
To `put``.",
}
,
  ["execute"] = {
  ["returns"] = " `\":\" &!` <-\
",
  ["args"] = "plans: _field.plans, levels: #:, fieldings: fieldParameters, planName: \":\"",
  ["type"] = "function",
  ["name"] = "_field.execute",
  ["description"] = "\
Run plans for the levels.",
}
,
  ["makeBounds"] = {
  ["returns"] = " `xyz, xyz, #:, #:` <-\
",
  ["args"] = "nearPlace: \":\", farPlace: \":\"",
  ["type"] = "function",
  ["name"] = "_field.makeBounds",
  ["description"] = "\
Get coordinate pair for named places.",
}
,
  ["runElements"] = {
  ["returns"] = " `runs:_field.runs, yDelta: #:, xzDelta: #:, xzEdge: facing` <-\
",
  ["args"] = "bounds: [xyzStart: xyz, xyzFinish: xyz]",
  ["type"] = "function",
  ["name"] = "_field.runElements",
  ["description"] = "\
Fly ox.",
}
,
  ["put"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "thePlan: \":\", start: #:, finish: #:, filling: \":\", target: \":\"?",
  ["type"] = "function",
  ["name"] = "_field.put",
  ["description"] = "\
Use`layer` or `till` plan.",
}
,
  ["cut"] = {
  ["returns"] = " `report: \":\" &:` <-\
",
  ["args"] = "places: [nearPlace: \":\", farPlace: \":\"]",
  ["type"] = "function",
  ["name"] = "_field.cut",
  ["description"] = "\
Use plan.quarry to cut.",
}
,
}
,
}
,
  ["_farm.logs:_"] = {
  ["line"] = "  --:: farm.logs(seedlings: \":\"[], :direction:) -> _Logs down and sides, plants found seedlings._ -> `report: \":\" &!`",
  ["kind"] = "face",
  ["sign"] = "farm.logs(seedlings: \":\"[], :direction:)  ",
  ["out"] = " `report: \":\" &!`",
  ["text"] = "Logs down and sides, plants found seedlings.",
}
,
  ["field"] = {
  ["childs"] = {
  ["extents"] = {
  ["returns"] = " `field.count, field.count , eP, eP, striding, ^:, ^:` <-\
",
  ["args"] = ":bounds:, :strides:, faced: \":\"?",
  ["type"] = "function",
  ["name"] = "field.extents",
  ["description"] = "\
Plots placed Returns `nplots: #:, slots: #:, strides: eP, run: eP, striding: xyz, turn: ^:, back: ^: Extents for `stride` (shorter) and `run` (longer) virtual axes for each `opName` in the `strides` entries unless `faced`.",
}
,
  [":_field.runs"] = {
  ["type"] = "value",
  ["returns"] = " `{oddlevel: _field.plans, evenlevel: _field.plans}`",
  ["name"] = "_field.runs",
  ["description"] = "\
Plans for runs at even and odd numbered levels.",
}
,
  [":striding"] = {
  ["type"] = "value",
  ["returns"] = " `[fieldOp]: xyz`",
  ["name"] = "striding",
  ["description"] = "\
dictionary keyed by `opName` of vectors incrementing game coordinate positions for `turn",
}
,
  [":fieldParameters.fills"] = {
  ["type"] = "value",
  ["returns"] = " `group|craft[]`",
  ["name"] = "fieldParameters.fills",
  ["description"] = "\
Group or list of craft items for fill material",
}
,
  [":fieldCommands"] = {
  ["type"] = "value",
  ["returns"] = " `[fieldOpName: \":\", ranger: \":\",  firstPlot: #:?, lastPlot: #:??]`",
  ["name"] = "fieldCommands",
  ["description"] = "\
For CLI",
}
,
  [":_field.plans"] = {
  ["type"] = "value",
  ["returns"] = " `{start: plan, odd: plan, even: plan, last: plan}`",
  ["name"] = "_field.plans",
  ["description"] = "\
At each level, start, even numbered, odd numbered, last run.",
}
,
  ["fill"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "parameters: [nearPlace: \":\", farPlace: \":\", fill: \":\", target: \":\"?]",
  ["type"] = "function",
  ["name"] = "field.fill",
  ["description"] = "\
Fill, Till, Replace.",
}
,
  ["paths"] = {
  ["returns"] = " `paths, yDelta: #:, xzEdge: facing` <-\
",
  ["args"] = "bounds: xyz[]",
  ["type"] = "function",
  ["name"] = "field.paths",
  ["description"] = "\
Called by plan prototype file to generate plans for plot.",
}
,
  [":paths"] = {
  ["type"] = "value",
  ["returns"] = " {start: \":\"[], odd: \":\"[], even: \":\"[], last: \":\"[]}`",
  ["name"] = "paths",
  ["description"] = "\
Flying ox traverse of three dimensional rectangular solid",
}
,
  ["plot"] = {
  ["returns"] = " `report: \":\" &: &!` <-\
",
  ["args"] = "commands: field.plotSpan, fieldsOp: ():, fieldOpName: \":\", plots: #:, offset: xyz?",
  ["type"] = "function",
  ["name"] = "field.plot",
  ["description"] = "\
Plots Called by field files. Calls `fieldsOp` from field file (which calls `field.plan`).",
}
,
  [":craft"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"`",
  ["name"] = "craft",
  ["description"] = "\
Minecraft item `detail.name` without `minecraft:` prefix",
}
,
  [":eP"] = {
  ["type"] = "value",
  ["returns"] = " `bounds`",
  ["name"] = "eP",
  ["description"] = "\
pair of coordinates for extents",
}
,
  [":strides"] = {
  ["type"] = "value",
  ["returns"] = " `[fieldOp]: #:`",
  ["name"] = "strides",
  ["description"] = "\
dictionary keyed by `opName` for the distance along the stride axis for a striding",
}
,
  [":field.plotSpan"] = {
  ["type"] = "value",
  ["returns"] = "_ `[_:, _:, first: #:?, last: #:??]`",
  ["name"] = "field.plotSpan",
  ["description"] = "\
{}` spans all plots; if only first, default plots after first",
}
,
  ["cut"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "places: [nearPlace: \":\", farPlace: \":\"]",
  ["type"] = "function",
  ["name"] = "field.cut",
  ["description"] = "\
Quarry out blocks from one place to the other.",
}
,
  ["make"] = {
  ["returns"] = " `report: \":\" &:` <-\
",
  ["args"] = "commands: fieldCommands, faced: ^:",
  ["type"] = "function",
  ["name"] = "field.make",
  ["description"] = "\
Load field files; return their `field.plot` calls",
}
,
  [":fieldOp"] = {
  ["type"] = "value",
  ["returns"] = " \":\"",
  ["name"] = "fieldOp",
  ["description"] = "\
Operation name in the set for a particular kind of field",
}
,
  [":fieldParameters"] = {
  ["type"] = "value",
  ["returns"] = " `[bounds, fieldParameters.fills?, fieldParameters.removeables??]`",
  ["name"] = "fieldParameters",
  ["description"] = "\
bounds` (and materials to fill and replace)",
}
,
  ["till"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "parameters: [nearPlace: \":\", farPlace: \":\", seed: \":\"]",
  ["type"] = "function",
  ["name"] = "field.till",
  ["description"] = "\
Till the seed from one place to the other.",
}
,
  ["plan"] = {
  ["returns"] = " `report: \":\" &: &!` <-\
",
  ["args"] = "planName: \":\", fielding: fieldParameters, offset: xyz?",
  ["type"] = "function",
  ["name"] = "field.plan",
  ["description"] = "\
Run plan, default offset {0,0,0}. Loads and executes the prototype plan (which calls `field.paths`) for each (odd, even, or last) level of a plot.",
}
,
  [":field.count"] = {
  ["type"] = "value",
  ["returns"] = " `[fieldOp]: #:`",
  ["name"] = "field.count",
  ["description"] = "\
dictionary keyed by 'opName` for number of elements in field for that operation",
}
,
  [":fieldParameters.removeables"] = {
  ["type"] = "value",
  ["returns"] = " `group|craft[]`",
  ["name"] = "fieldParameters.removeables",
  ["description"] = "\
Material replaced by fill",
}
,
  ["fence"] = {
  ["returns"] = " `\":\"` <-\
",
  ["args"] = "parameters: [ranger: \":\", fencing: \":\"?]",
  ["type"] = "function",
  ["name"] = "field.fence",
  ["description"] = "\
Put fencing using `layer` plan.",
}
,
}
,
  ["returns"] = " field, _field",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "field",
  ["description"] = "\
Fields are rectangular solids defined by a range (a `situation` pair with `fields` keyed properties)._ -> field, _field Fields are made up of plots, each plot at least small enough to deal with turtle inventory limitations.",
}
,
  ["_step.down:_"] = {
  ["line"] = "--:: step.down(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.down(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_planner.make:_"] = {
  ["line"] = "--:: planner.make(plan:plan) -> _Create path operations table for plan._ -> `pathElements, fuelOK: ^:, pathDistance: #:`",
  ["kind"] = "face",
  ["sign"] = "planner.make(plan:plan)  ",
  ["out"] = " `pathElements, fuelOK: ^:, pathDistance: #:`",
  ["text"] = "Create path operations table for plan.",
}
,
  ["_planner.mark:_"] = {
  ["line"] = "--:: planner.mark(markerName: \":\") -> _Parse marker name into parts._ -> `shaft: \":\"?, level: \":\"?, tag: \":\"?)`",
  ["kind"] = "face",
  ["sign"] = "planner.mark(markerName: \":\")  ",
  ["out"] = " `shaft: \":\"?, level: \":\"?, tag: \":\"?)`",
  ["text"] = "Parse marker name into parts.",
}
,
  ["_turtle.category:_"] = {
  ["line"] = "--:: turtle.category(name: \":\") -> _Names in category or fencings matching `name` or_ `{\"minecraft:\"..name}`. -> `\":\"[]` ",
  ["out"] = " `\":\"[]` ",
  ["sign"] = "turtle.category(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Names in category or fencings matching `name` or_ `{\"minecraft:\"..name}`.",
}
,
  ["worker"] = {
  ["childs"] = {
  ["execute"] = {
  ["returns"] = "  `\"done\", report: \":\" &: &!` <-\
",
  ["args"] = "plan, pathOperations, fuelOK: ^:, pathDistance: #:",
  ["type"] = "function",
  ["name"] = "worker.execute",
  ["description"] = "\
Do plan. Attempt recovery for_ `blocked` _or_ `lost` _conditions; raise error for_ `empty` _or_ `bedrock` _or if recovery fails.",
}
,
}
,
  ["returns"] = " worker",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "worker",
  ["description"] = "\
Run what's been created by_ `planner` _while attempting to deal with a turtle's situational difficulties._ -> worker",
}
,
  ["_come_"] = {
  ["line"] = "--:- come -> _rover turtle towards GPS player position._",
  ["sign"] = "come  ",
  ["text"] = "rover turtle towards GPS player position.",
  ["kind"] = "cli",
}
,
  ["_task.op:_"] = {
  ["line"] = "    --:: task.op (commands: [ op: \":\", arguments: \":\"[] ] ) -> _Execute tasks for low level turtle operations:_ -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "task.op (commands: [ op: \":\", arguments: \":\"[] ] )  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Execute tasks for low level turtle operations:",
}
,
  ["_logger_"] = {
  ["line"] = "--:- logger command argument... -> _ _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "logger command argument...  ",
  ["kind"] = "cli",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
}
,
  ["_roam.tail:_"] = {
  ["line"] = "--:: roam.tail(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)` -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "roam.tail(:xyz:)  ",
  ["kind"] = "face",
  ["text"] = "Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)",
}
,
  ["step"] = {
  ["type"] = "lib",
  ["name"] = "step",
  ["childs"] = {
  ["right"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.right",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["to"] = {
  ["returns"] = " `(): nil &!recovery` <-\
",
  ["args"] = ":xyzf:, theSituation:situation?",
  ["type"] = "function",
  ["name"] = "step.to",
  ["description"] = "\
Step to position from (current) sItuation. Iterate first in x direction to completion, then z, and finally y. Once complete, each iterator is exhausted. Finally turn to face if supplied. Returned iterator returns_ `nil` _when iterators for all directions are exhausted.",
}
,
  ["south"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.south",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["east"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.east",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["up"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.up",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["west"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.west",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["left"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.left",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["back"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.back",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["forward"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.forward",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["north"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.north",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["steps"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.steps",
  ["description"] = "\
Iterator (default 1 step)",
}
,
  ["down"] = {
  ["returns"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery` <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "step.down",
  ["description"] = "\
Iterator (default 1 step)",
}
,
}
,
}
,
  ["_place.count:_"] = {
  ["line"] = "--:: place.count() -> _Returns number of places._ -> `#:`",
  ["out"] = " `#:`",
  ["sign"] = "place.count()  ",
  ["kind"] = "face",
  ["text"] = "Returns number of places.",
}
,
  ["_test_"] = {
  ["line"] = "  --:- test name, label, x, y, z, facing, key?, value??} -> _Force mapped position, optionally feature and value for `point`._",
  ["sign"] = "test name, label, x, y, z, facing, key?, value??}  ",
  ["kind"] = "cli",
  ["text"] = "Force mapped position, optionally feature and value for `point`.",
}
,
  ["_Navigation_"] = {
  ["line"] = "--:< **Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?**",
  ["sign"] = "**Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?** ",
  ["kind"] = "word",
  ["text"] = "Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?",
}
,
  [" dds"] = {
  ["type"] = "lib",
  ["name"] = " dds",
  ["childs"] = {
}
,
}
,
  ["__field.execute:_"] = {
  ["line"] = "  --:: `_field.execute(plans: _field.plans, levels: #:, fieldings: fieldParameters, planName: \":\")` ->  _Run plans for the levels._ -> `\":\" &!`",
  ["out"] = " `\":\" &!`",
  ["sign"] = "`_field.execute(plans: _field.plans, levels: #:, fieldings: fieldParameters, planName: \":\")`  ",
  ["kind"] = "face",
  ["text"] = "Run plans for the levels.",
}
,
  ["_compare_"] = {
  ["line"] = "--:- compare item direction+ -> _Named item matches block in any of specified directions?_",
  ["sign"] = "compare item direction+  ",
  ["text"] = "Named item matches block in any of specified directions?",
  ["kind"] = "cli",
}
,
  ["_to_"] = {
  ["line"] = "  --:- to place | x y z face?-> _To named place or position and face. Retry permutation for different first direction._ ",
  ["sign"] = "to place | x y z face? ",
  ["text"] = "To named place or position and face. Retry permutation for different first direction.",
  ["kind"] = "cli",
}
,
  ["_layer_"] = {
  ["line"] = "--:- layer range firstPlot? lastPlot?? -> _Put foundation material in place for field._",
  ["sign"] = "layer range firstPlot? lastPlot??  ",
  ["kind"] = "cli",
  ["text"] = "Put foundation material in place for field.",
}
,
  ["_field.plot:_"] = {
  ["line"] = "--:: field.plot(commands: field.plotSpan, fieldsOp: ():, fieldOpName: \":\", plots: #:, offset: xyz?) -> _Plots_ -> `report: \":\" &: &!`",
  ["out"] = " `report: \":\" &: &!`",
  ["sign"] = "field.plot(commands: field.plotSpan, fieldsOp: ():, fieldOpName: \":\", plots: #:, offset: xyz?)  ",
  ["kind"] = "face",
  ["text"] = "Plots",
}
,
  ["task"] = {
  ["childs"] = {
  [":_task.puts"] = {
  ["type"] = "value",
  ["returns"] = " `[direction: \":\", distance: #:, puttings: \":\"[] ]`",
  ["name"] = "_task.puts",
  ["description"] = "\
Common arguments",
}
,
  ["op"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "commands: [ op: \":\", arguments: \":\"[] ] ",
  ["type"] = "function",
  ["name"] = "task.op",
  ["description"] = "\
Execute tasks for low level turtle operations:",
}
,
}
,
  ["returns"] = " task, _task",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "task",
  ["description"] = "\
Dispatch targets for_ `net` _library._ -> task, _task",
}
,
  ["place"] = {
  ["type"] = "lib",
  ["name"] = "place",
  ["childs"] = {
  ["trail"] = {
  ["returns"] = " `headSerial: \":\", tailSerial: \":\", count: #:` <-\
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
  ["near"] = {
  ["returns"] = " (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"` <-\
",
  ["args"] = "span: #:?, reference?:\":\"|[x:#:,y:#:,z:#:]",
  ["type"] = "function",
  ["name"] = "place.near",
  ["description"] = "\
 If both span and name (or a position) are specified, return places within a span of blocks of the named place (or position). If only the span is specified, return places within a span of blocks of the current situation or player position. If neither is specified return each of the named places. In any case, iterator returns include serialized places.",
}
,
  ["fix"] = {
  ["returns"] = " `xyzf`  <-\
",
  ["args"] = ":xyzf:, track: ^:?",
  ["type"] = "function",
  ["name"] = "place.fix",
  ["description"] = "\
Sets situation position, can start tracking for trail.",
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
  ["track"] = {
  ["returns"] = " `name: \":\"?, label: \":\"?, :situations:?` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.track",
  ["description"] = "\
Returns trail",
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
  ["match"] = {
  ["returns"] = " `order: #:?, place: place?` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.match",
  ["description"] = "\
Lookup place qualified by site, return_ `nil` _if not found.",
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
  ["add"] = {
  ["returns"] = " `serialized: \":\"?, order: #:?` <-\
",
  ["args"] = "name: \":\", :situation:",
  ["type"] = "function",
  ["name"] = "place.add",
  ["description"] = "\
Add situation to situations of an existing place.",
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
  ["returns"] = " `#:, order: #:?` <-\
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
  ["_cut_"] = {
  ["line"] = "--:- cut point point -> _Quarry out blocks bound by named points (defining a rectangular solid)._",
  ["sign"] = "cut point point  ",
  ["text"] = "Quarry out blocks bound by named points (defining a rectangular solid).",
  ["kind"] = "cli",
}
,
  ["grid"] = {
  ["childs"] = {
  [":grid.guide"] = {
  ["type"] = "value",
  ["returns"] = " `[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`",
  ["name"] = "grid.guide",
  ["description"] = "\
Instructions for cut",
}
,
  [":grid.cut"] = {
  ["type"] = "value",
  ["returns"] = " `\"up\"|\"down\"|\"north\"|\"south\"`",
  ["name"] = "grid.cut",
  ["description"] = "\
Directions to dig in vein",
}
,
  [":crossplan"] = {
  ["type"] = "value",
  ["returns"] = " `{:bores:, ores: {name: \":\", fixtures: \":\"[], path: \":\"[], work: plan.work} }`",
  ["name"] = "crossplan",
  ["description"] = "\
Bore and mine, minimal movement",
}
,
  ["ores"] = {
  ["returns"] = " `\"done\" &!` <-\
",
  ["args"] = "plan: crossplan, :direction:, guide: grid.guide, :ores:",
  ["type"] = "function",
  ["name"] = "grid.ores",
  ["description"] = "\
Extract ores. Given the guide for a vein, mine ores in each of the guide's cuts for that vein.",
}
,
}
,
  ["returns"] = " grid",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "grid",
  ["description"] = "\
Work functions boring, navigating, and mining ore in a grid of tunnels._ -> grid",
}
,
  ["_ores_"] = {
  ["line"] = "  --:- ores marker borePlans?  -> _Excavate ores from side tunnel near marker, return up 1 from marker._",
  ["sign"] = "ores marker borePlans?   ",
  ["text"] = "Excavate ores from side tunnel near marker, return up 1 from marker.",
  ["kind"] = "cli",
}
,
  ["_core.trace:_"] = {
  ["line"] = "--:: core.trace(err: any) -> _Reports traceback for xpcalls._ -> `err: any`",
  ["out"] = " `err: any`",
  ["sign"] = "core.trace(err: any)  ",
  ["kind"] = "face",
  ["text"] = "Reports traceback for xpcalls.",
}
,
  ["mock"] = {
  ["childs"] = {
}
,
  ["returns"] = " mock",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "mock",
  ["description"] = "\
Libraries to provide a limited simulation of turtle and command computer in-game operations._ -> mock turtle: _Generally just returns success but allows for simulated blocking, fuel consumption, refueling. commands: _Mock returns from command computer and report success.",
}
,
  ["_step.forward:_"] = {
  ["line"] = "--:: step.forward(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.forward(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["__gps.actuate:_"] = {
  ["line"] = "  --:: `_gps.actuate(commands: [command: \":\", direction: facing]) -> _Move to boot a GPS host and retrieve floppy._ -> \":\"",
  ["kind"] = "face",
  ["sign"] = "`_gps.actuate(commands: [command: \":\", direction: facing])  ",
  ["out"] = " \":\"",
  ["text"] = "Move to boot a GPS host and retrieve floppy.",
}
,
  [" check"] = {
  ["type"] = "lib",
  ["name"] = " check",
  ["childs"] = {
}
,
}
,
  ["net"] = {
  ["childs"] = {
}
,
  ["returns"] = " net",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "net",
  ["description"] = "\
Command Line Library providing turtle operations used by remote library (effectively the UI for Muse)._ -> net",
}
,
  ["_place.reset:_"] = {
  ["line"] = "--:: place.reset() -> _Resets places to the empty table._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "place.reset()  ",
  ["kind"] = "face",
  ["text"] = "Resets places to the empty table.",
}
,
  [" motion"] = {
  ["type"] = "lib",
  ["name"] = " motion",
  ["childs"] = {
}
,
}
,
  ["_field.paths:_"] = {
  ["line"] = "  --:: field.paths(bounds: xyz[]) -> _Called by plan prototype file to generate plans for plot._ -> `paths, yDelta: #:, xzEdge: facing`",
  ["out"] = " `paths, yDelta: #:, xzEdge: facing`",
  ["sign"] = "field.paths(bounds: xyz[])  ",
  ["kind"] = "face",
  ["text"] = "Called by plan prototype file to generate plans for plot.",
}
,
  ["_move.situation:_"] = {
  ["line"] = "function move.situation() --:: move.situation() -> _Clone current situation_ -> situation",
  ["out"] = " situation",
  ["sign"] = "move.situation()  ",
  ["kind"] = "face",
  ["text"] = "Clone current situation",
}
,
  ["_core.status:_"] = {
  ["line"] = "  --:: core.status(level: #:, ...: any) -> _If level less than (elimination) threshold, then report rest as string._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "core.status(level: #:, ...: any)  ",
  ["kind"] = "face",
  ["text"] = "If level less than (elimination) threshold, then report rest as string.",
}
,
  ["_sync_"] = {
  ["line"] = "--:- sync -> Muse Update (MU) broadcast local map to units at current site.",
  ["sign"] = "sync  ",
  ["text"] = "Muse Update (MU) broadcast local map to units at current site.",
  ["kind"] = "cli",
}
,
  ["__remote.clientResult:_"] = {
  ["line"] = "  --:: `_remote.clientResult(serverID: #:, resultString: \":\", callback: ():)` -> _Apply callback to deserialized client result._ -> `any`",
  ["kind"] = "face",
  ["sign"] = "`_remote.clientResult(serverID: #:, resultString: \":\", callback: ():)`  ",
  ["out"] = " `any`",
  ["text"] = "Apply callback to deserialized client result.",
}
,
  ["_place.distance:_"] = {
  ["line"] = "--:: place.distance(a: xyzf, b: xyzf) -> _Manhattan: abs(delta x) + abs(delta y) + abs(delta z)._ -> `distance: #:`",
  ["out"] = " `distance: #:`",
  ["sign"] = "place.distance(a: xyzf, b: xyzf)  ",
  ["kind"] = "face",
  ["text"] = "Manhattan: abs(delta x) + abs(delta y) + abs(delta z).",
}
,
  ["_step.west:_"] = {
  ["line"] = "--:: step.west(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.west(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["__remote.testCome:_"] = {
  ["line"] = "  --:: `_remote.testCome(turtle: \":\", command: \":\")` -> _On client:_ -> `turtle: \":\", command: \":\", xyz, ^:`",
  ["kind"] = "face",
  ["sign"] = "`_remote.testCome(turtle: \":\", command: \":\")`  ",
  ["out"] = " `turtle: \":\", command: \":\", xyz, ^:`",
  ["text"] = "On client:",
}
,
  [" net"] = {
  ["type"] = "lib",
  ["name"] = " net",
  ["childs"] = {
}
,
}
,
  ["_turtle.digTo:_"] = {
  ["line"] = "  --:: turtle.digTo(:xyzf:, limit: #:?) -> _Unblocking move._ -> `done: \":\" &: &!` ",
  ["out"] = " `done: \":\" &: &!` ",
  ["sign"] = "turtle.digTo(:xyzf:, limit: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Unblocking move.",
}
,
  ["_core.reduce:_"] = {
  ["line"] = "  --:: core.reduce(op: ():, initial: any, table: {:}) -> _Fold_ `table` _to produce_ `result` _by applying_ `op` _to_ `table` -> `any`",
  ["out"] = " `any`",
  ["sign"] = "core.reduce(op: ():, initial: any, table: {:})  ",
  ["kind"] = "face",
  ["text"] = "Fold `table` _to produce_ `result` _by applying_ `op` _to_ `table",
}
,
  ["_shaft_"] = {
  ["line"] = "  --:- shaft minehead levels shaftPlans -> _Dig down number of levels under named minehead place using specified plans._",
  ["sign"] = "shaft minehead levels shaftPlans  ",
  ["text"] = "Dig down number of levels under named minehead place using specified plans.",
  ["kind"] = "cli",
}
,
  ["_place.erase:_"] = {
  ["line"] = "--::place.erase(name: \":\") -> _Removes named place from array of places._ -> `#:, order: #:?`",
  ["out"] = " `#:, order: #:?`",
  ["sign"] = "place.erase(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Removes named place from array of places.",
}
,
  ["_step.back:_"] = {
  ["line"] = "--:: step.back(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.back(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_mine.op:_"] = {
  ["line"] = "--:: mine.op(arguments: [op: \":\", placeName: \":\", borePlansFileOrLevels: \":\"|#:, shaftPlansFile: \":\"]) -> _Dig._ -> `^:, \":\", #: &:`",
  ["out"] = " `^:, \":\", #: &:`",
  ["sign"] = "mine.op(arguments: [op: \":\", placeName: \":\", borePlansFileOrLevels: \":\"|#:, shaftPlansFile: \":\"])  ",
  ["kind"] = "face",
  ["text"] = "Dig.",
}
,
  ["_drop_"] = {
  ["line"] = "--:- drop item direction quantity? -> Drop quantity of selected items [or all].",
  ["sign"] = "drop item direction quantity?  ",
  ["text"] = "Drop quantity of selected items [or all].",
  ["kind"] = "cli",
}
,
  ["_map.op:_"] = {
  ["line"] = "  --:: map.op(commands: \":\"[]) -> _Command Line Interface_ -> `report: \":\" &:`",
  ["kind"] = "face",
  ["sign"] = "map.op(commands: \":\"[])  ",
  ["out"] = " `report: \":\" &:`",
  ["text"] = "Command Line Interface",
}
,
  ["_map.set:_"] = {
  ["line"] = "--:: map.set(name: \":\", label: \":\", x: #:, y: #:, z: #:, f: \":\") -> _Set turtle at created point -> \":\"",
  ["kind"] = "face",
  ["sign"] = "map.set(name: \":\", label: \":\", x: #:, y: #:, z: #:, f: \":\")  ",
  ["out"] = " \":\"",
  ["text"] = "Set turtle at created point",
}
,
  ["_move.left:_"] = {
  ["line"] = "--:: move.left(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.left(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_porter_"] = {
  ["line"] = "--:- porter command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "porter command argument...  ",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
  ["kind"] = "cli",
}
,
  ["_place.add:_"] = {
  ["line"] = "--:: place.add(name: \":\", :situation:) -> _Add situation to situations of an existing place._ -> `serialized: \":\"?, order: #:?`",
  ["out"] = " `serialized: \":\"?, order: #:?`",
  ["sign"] = "place.add(name: \":\", :situation:)  ",
  ["kind"] = "face",
  ["text"] = "Add situation to situations of an existing place.",
}
,
  ["_core.inext:_"] = {
  ["line"] = "--:: core.inext(table: {:}, index: #:) -> _Iterator over table beginning at index._ -> `():, {:}, #:`",
  ["out"] = " `():, {:}, #:`",
  ["sign"] = "core.inext(table: {:}, index: #:)  ",
  ["kind"] = "face",
  ["text"] = "Iterator over table beginning at index.",
}
,
  ["_grid.ores:_"] = {
  ["line"] = "  --:: grid.ores(plan: crossplan, :direction:, guide: grid.guide, :ores:) -> _Extract ores._ -> `\"done\" &!`",
  ["out"] = " `\"done\" &!`",
  ["sign"] = "grid.ores(plan: crossplan, :direction:, guide: grid.guide, :ores:)  ",
  ["kind"] = "face",
  ["text"] = "Extract ores.",
}
,
  ["_dds.join:_"] = {
  ["line"] = "  --:: dds.join(role: \":\", idGiven: #:?) -> _Fix ID role association for next startup, id given by player._ -> `sitedLabel: \":\"`",
  ["kind"] = "face",
  ["sign"] = "dds.join(role: \":\", idGiven: #:?)  ",
  ["out"] = " `sitedLabel: \":\"`",
  ["text"] = "Fix ID role association for next startup, id given by player.",
}
,
  ["_step.to:_"] = {
  ["line"] = "--:: step.to(:xyzf:, theSituation:situation?) -> _Step to position from (current) sItuation._ -> `(): nil &!recovery`",
  ["out"] = " `(): nil &!recovery`",
  ["sign"] = "step.to(:xyzf:, theSituation:situation?)  ",
  ["kind"] = "face",
  ["text"] = "Step to position from (current) sItuation.",
}
,
  ["_step.south:_"] = {
  ["line"] = "--:: step.south(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.south(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_mine.mark:_"] = {
  ["line"] = "--:: mine.mark(:plan:, :marking:) -> _Make place name, report result._ -> `markerName: \":\", label: \":\", report: \":\"`",
  ["out"] = " `markerName: \":\", label: \":\", report: \":\"`",
  ["sign"] = "mine.mark(:plan:, :marking:)  ",
  ["kind"] = "face",
  ["text"] = "Make place name, report result.",
}
,
  ["_move.ats:_"] = {
  ["line"] = "--:: move.ats(theSituation:situation?) -> _(Current) situation position and facing string (`\"\"` in game if not turtle)._ -> `xyzf: \":\"`",
  ["out"] = " `xyzf: \":\"`",
  ["sign"] = "move.ats(theSituation:situation?)  ",
  ["kind"] = "face",
  ["text"] = "(Current) situation position and facing string (`\"\"` in game if not turtle).",
}
,
  [" worker"] = {
  ["type"] = "lib",
  ["name"] = " worker",
  ["childs"] = {
}
,
}
,
  ["_core.vectorPairs:_"] = {
  ["line"] = "  --:: core.vectorPairs(start: bounds, addend: xyz, number: #:, partial: bounds?) -> _Make plots._ -> `bounds[]`",
  ["out"] = " `bounds[]`",
  ["sign"] = "core.vectorPairs(start: bounds, addend: xyz, number: #:, partial: bounds?)  ",
  ["kind"] = "face",
  ["text"] = "Make plots.",
}
,
  ["_exec.op:_"] = {
  ["line"] = "function exec.op(commandLine) --:: exec.op(commandLine: [command: \":\", ...] ) -> _CLI for Command Computer commands_ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "exec.op(commandLine: [command: \":\", ...] )  ",
  ["kind"] = "face",
  ["text"] = "CLI for Command Computer commands",
}
,
  ["moves"] = {
  ["type"] = "lib",
  ["name"] = "moves",
  ["childs"] = {
  ["to"] = {
  ["returns"] = " `code: \":\", remaining: #:, xyzf: \":\" &!recovery` <-\
",
  ["args"] = "target: \":\", first: \":\"?",
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
  ["_move.get:_"] = {
  ["line"] = "--:: move.get(:situation:?) -> _Default current situation._ -> `x: #:?, y: #:?, z: #:?, facing: \":\", fuel: #:, level: \":\"",
  ["out"] = " `x: #:?, y: #:?, z: #:?, facing: \":\", fuel: #:, level: \":\"",
  ["sign"] = "move.get(:situation:?)  ",
  ["kind"] = "face",
  ["text"] = "Default current situation.",
}
,
  ["_core.match:_"] = {
  ["line"] = "  --:: core.match(tableA: any[], tableB: any[]) -> _Find first matching item in pair of item tables._ -> `nil` | `any`",
  ["out"] = " `nil` | `any`",
  ["sign"] = "core.match(tableA: any[], tableB: any[])  ",
  ["kind"] = "face",
  ["text"] = "Find first matching item in pair of item tables.",
}
,
  ["_step.north:_"] = {
  ["line"] = "--:: step.north(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.north(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_bore_"] = {
  ["line"] = "  --:- bore marker borePlans  -> _Dig horizontally from marker using saved or specified bore and shaft plans._ ",
  ["sign"] = "bore marker borePlans   ",
  ["text"] = "Dig horizontally from marker using saved or specified bore and shaft plans.",
  ["kind"] = "cli",
}
,
  ["__field.put:_"] = {
  ["line"] = "  --:: `_field.put(thePlan: \":\", start: #:, finish: #:, filling: \":\", target: \":\"?)` -> _Use`layer` or `till` plan._ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "`_field.put(thePlan: \":\", start: #:, finish: #:, filling: \":\", target: \":\"?)`  ",
  ["kind"] = "face",
  ["text"] = "Use`layer` or `till` plan.",
}
,
  ["_look_"] = {
  ["line"] = "--:- look direction -> Detect and inspect direction, return report.",
  ["sign"] = "look direction  ",
  ["text"] = "Detect and inspect direction, return report.",
  ["kind"] = "cli",
}
,
  ["_map.get:_"] = {
  ["line"] = "function map.get(name, key) --:: map.get(name: \":\", key: \":\") -> _Get named place local feature value for key._ -> `value: any? &!`",
  ["kind"] = "face",
  ["sign"] = "map.get(name: \":\", key: \":\")  ",
  ["out"] = " `value: any? &!`",
  ["text"] = "Get named place local feature value for key.",
}
,
  ["_miner_"] = {
  ["line"] = "--:- miner command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "miner command argument...  ",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
  ["kind"] = "cli",
}
,
  ["_map.update:_"] = {
  ["line"] = "function map.update(serial) --:: map.update(serial: \":\") -> _Append received instantiated MU to local map file_. -> `nil &!`",
  ["kind"] = "face",
  ["sign"] = "map.update(serial: \":\")  ",
  ["out"] = " `nil &!`",
  ["text"] = "Append received instantiated MU to local map file_.",
}
,
  ["_fence_"] = {
  ["line"] = "--:- fence range [item] -> _Put item or available wooden fence from one point to another in range._",
  ["sign"] = "fence range [item]  ",
  ["text"] = "Put item or available wooden fence from one point to another in range.",
  ["kind"] = "cli",
}
,
  ["_turtle.digAround:_"] = {
  ["line"] = "  --:: turtle.digAround(orientation: \":\", diggings: \":\"[], name: \":\"?) -> _Unblocking dig._ -> `\"done\" &: &!`",
  ["out"] = " `\"done\" &: &!`",
  ["sign"] = "turtle.digAround(orientation: \":\", diggings: \":\"[], name: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Unblocking dig.",
}
,
  ["_remote.tail:_"] = {
  ["line"] = "  --:: remote.tail(turtle: \":\", __ : \"tail\", rates: \":\"?) -> _Repeatedly towards player position, default rate _G.Muse.rates.tail seconds -> `nil` ",
  ["kind"] = "face",
  ["sign"] = "remote.tail(turtle: \":\", __ : \"tail\", rates: \":\"?)  ",
  ["out"] = " `nil` ",
  ["text"] = "Repeatedly towards player position, default rate _G.Muse.rates.tail seconds",
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
  ["_core.echo:_"] = {
  ["line"] = "--:: core.echo(...: any) -> _For testing; just returns its arguments._ -> ...: `any`",
  ["out"] = " ...: `any`",
  ["sign"] = "core.echo(...: any)  ",
  ["kind"] = "face",
  ["text"] = "For testing; just returns its arguments.",
}
,
  ["_steps.to:_"] = {
  ["line"] = "  --:: steps.to(target: \":\") -> _Step (iterator) to target place._ -> `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["out"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["sign"] = "steps.to(target: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Step (iterator) to target place.",
}
,
  ["core"] = {
  ["childs"] = {
  ["merge"] = {
  ["returns"] = " `{:}` <-\
",
  ["args"] = "...: {:}",
  ["type"] = "function",
  ["name"] = "core.merge",
  ["description"] = "\
Merge any number of flat tables into one, allowing repeats.",
}
,
  ["serialize"] = {
  ["returns"] = " `\"return \"..\":\" &!` <-\
",
  ["args"] = "input: any",
  ["type"] = "function",
  ["name"] = "core.serialize",
  ["description"] = "\
Executable string to instantiate input.",
}
,
  ["xyzf"] = {
  ["returns"] = " `\":\"` <-\
",
  ["args"] = ":xyzf:",
  ["type"] = "function",
  ["name"] = "core.xyzf",
  ["description"] = "\
Returns specially formatted string for `xyzf`.",
}
,
  ["match"] = {
  ["returns"] = " `nil` | `any` <-\
",
  ["args"] = "tableA: any[], tableB: any[]",
  ["type"] = "function",
  ["name"] = "core.match",
  ["description"] = "\
Find first matching item in pair of item tables.",
}
,
  [":bounds"] = {
  ["type"] = "value",
  ["returns"] = " `[xyz, xyz]`",
  ["name"] = "bounds",
  ["description"] = "\
Vector pair defining a rectangular solid",
}
,
  ["optionals"] = {
  ["returns"] = " `string: \":\"|false, number: #:|false, ...: any` <-\
",
  ["args"] = "string: \":\"?, number: #:?, ...: any",
  ["type"] = "function",
  ["name"] = "core.optionals",
  ["description"] = "\
Optional number and/or string.",
}
,
  ["compose"] = {
  ["returns"] = " (): <-\
",
  ["args"] = "...: ():",
  ["type"] = "function",
  ["name"] = "core.compose",
  ["description"] = "\
Produce function equivqlent to sucessive application of argument functions",
}
,
  ["record"] = {
  ["returns"] = " `nil & !` <-\
",
  ["args"] = "message: \":\"",
  ["type"] = "function",
  ["name"] = "core.record",
  ["description"] = "\
Appends (status) message to log file on player.",
}
,
  ["setComputerLabel"] = {
  ["returns"] = " `label: \":\"` <-\
",
  ["args"] = "label: \":\"",
  ["type"] = "function",
  ["name"] = "core.setComputerLabel",
  ["description"] = "\
Sets (out-of game global) label",
}
,
  ["orient"] = {
  ["returns"] = " `xyzMap` <-\
",
  ["args"] = "vectors: xyzMap, face: \":\"?, rotate: \":\"??",
  ["type"] = "function",
  ["name"] = "core.orient",
  ["description"] = "\
Three dimensional rotation Turn from up north to face, default for no face is to rotate -90 degrees.",
}
,
  ["reduce"] = {
  ["returns"] = " `any` <-\
",
  ["args"] = "op: ():, initial: any, table: {:}",
  ["type"] = "function",
  ["name"] = "core.reduce",
  ["description"] = "\
Fold `table` _to produce_ `result` _by applying_ `op` _to_ `table",
}
,
  ["trace"] = {
  ["returns"] = " `err: any` <-\
",
  ["args"] = "err: any",
  ["type"] = "function",
  ["name"] = "core.trace",
  ["description"] = "\
Reports traceback for xpcalls.",
}
,
  ["state"] = {
  ["returns"] = " `closing` <-\
",
  ["args"] = "table: {:}?, key: \":\"?",
  ["type"] = "function",
  ["name"] = "core.state",
  ["description"] = "\
Returns closure over closure variable",
}
,
  ["sleep"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "#:?",
  ["type"] = "function",
  ["name"] = "core.sleep",
  ["description"] = "\
Mocks sleep as null operation out of game.",
}
,
  [":xyzf"] = {
  ["type"] = "value",
  ["returns"] = " `[x: #:, y: #:, z: #:, facing: \":\"?]`",
  ["name"] = "xyzf",
  ["description"] = "\
Position and facing as table",
}
,
  ["getComputerID"] = {
  ["returns"] = " `id: #:` <-\
",
  ["args"] = "id: #:?",
  ["type"] = "function",
  ["name"] = "core.getComputerID",
  ["description"] = "\
Out of game returns id; id ignored in game.",
}
,
  [":closing"] = {
  ["type"] = "value",
  ["returns"] = " `(value: any): value: any`",
  ["name"] = "closing",
  ["description"] = "\
Returns value or sets it and optional table entry to non `nil` `value`.",
}
,
  ["report"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "level: #:, ...: any",
  ["type"] = "function",
  ["name"] = "core.report",
  ["description"] = "\
If level less than `status` threshold, report `rest` as string.",
}
,
  [":xyz"] = {
  ["type"] = "value",
  ["returns"] = " `[x: #:, y: #:, z: #:]`",
  ["name"] = "xyz",
  ["description"] = "\
Minecraft coordinates: +x: east, +y: up, +z: south",
}
,
  ["logging"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "arguments: {level: #:, filename: \":\"}",
  ["type"] = "function",
  ["name"] = "core.logging",
  ["description"] = "\
Set threshold level [and local log file] for status reports",
}
,
  [":core.log"] = {
  ["type"] = "value",
  ["returns"] = " `{level: closing, file: closing, handle: closing}`",
  ["name"] = "core.log",
  ["description"] = "\
Closure variable",
}
,
  [":xyzMap"] = {
  ["type"] = "value",
  ["returns"] = " `xyz[] | [core.faces]: xyz`",
  ["name"] = "xyzMap",
  ["description"] = "\
Table of vectors either an array or dictionary",
}
,
  ["vectorPairs"] = {
  ["returns"] = " `bounds[]` <-\
",
  ["args"] = "start: bounds, addend: xyz, number: #:, partial: bounds?",
  ["type"] = "function",
  ["name"] = "core.vectorPairs",
  ["description"] = "\
Make plots. Addend is used to create a vector pair to be added cumulatively beginning with start bounds for result. The number n is the number of bounds in result where each bound is offset by addend from the prior bounds. Optionally the partial bounds are included as the first bounds in the result.",
}
,
  ["clone"] = {
  ["returns"] = " `{:}|any` <-\
",
  ["args"] = "source: {:}|any",
  ["type"] = "function",
  ["name"] = "core.clone",
  ["description"] = "\
Deep copy source table or return source if not table.",
}
,
  ["status"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "level: #:, ...: any",
  ["type"] = "function",
  ["name"] = "core.status",
  ["description"] = "\
If level less than (elimination) threshold, then report rest as string. If player, status report is printed and potentially logged. Otherwise sent to player using Muse Status (MS) protocol. If for in-game turtle with GPS and the dead reckoning and GPS disagree, include that in report.",
}
,
  ["completer"] = {
  ["returns"] = " `():` <-\
",
  ["args"] = "completions: {:}",
  ["type"] = "function",
  ["name"] = "core.completer",
  ["description"] = "\
Register command completions for shell",
}
,
  ["round"] = {
  ["returns"] = " `#:` <-\
",
  ["args"] = "n: #:",
  ["type"] = "function",
  ["name"] = "core.round",
  ["description"] = "\
Next integer down if below half fraction",
}
,
  ["pass"] = {
  ["returns"] = " ok: `true|false, result: ...|\":\", any?` <-\
",
  ["args"] = "ok: ^:, ...: any",
  ["type"] = "function",
  ["name"] = "core.pass",
  ["description"] = "\
Pass input but report string if not ok.",
}
,
  ["string"] = {
  ["returns"] = " `\":\"` <-\
",
  ["args"] = "...: any",
  ["type"] = "function",
  ["name"] = "core.string",
  ["description"] = "\
Makes string from any inputs, simplifies single entry tables.",
}
,
  ["map"] = {
  ["returns"] = " `{:}` <-\
",
  ["args"] = "op: ():, table: {:}",
  ["type"] = "function",
  ["name"] = "core.map",
  ["description"] = "\
Create `result` _by applying_ `op` _function to elements of_ `table",
}
,
  ["getComputerLabel"] = {
  ["returns"] = " `label: \":\"` <-\
",
  ["args"] = "label: \":\"?",
  ["type"] = "function",
  ["name"] = "core.getComputerLabel",
  ["description"] = "\
Out of game returns label; label ignored in game.",
}
,
  [":core.faces"] = {
  ["type"] = "value",
  ["returns"] = " \"north\"|\"south\"|\"east\"|\"west\"|\"up\"|\"down\"|\"rotate\"",
  ["name"] = "core.faces",
  ["description"] = "\
Key for composed function dictionary",
}
,
  ["permute"] = {
  ["returns"] = " `():` <-\
",
  ["args"] = "array: any[]",
  ["type"] = "function",
  ["name"] = "core.permute",
  ["description"] = "\
Iterator for (factorial) permutations of array",
}
,
  ["inext"] = {
  ["returns"] = " `():, {:}, #:` <-\
",
  ["args"] = "table: {:}, index: #:",
  ["type"] = "function",
  ["name"] = "core.inext",
  ["description"] = "\
Iterator over table beginning at index.",
}
,
  ["where"] = {
  ["returns"] = " `x: #:|false, y: #:|false, z: #:|false` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "core.where",
  ["description"] = "\
GPS location if available.",
}
,
  ["echo"] = {
  ["returns"] = " ...: `any` <-\
",
  ["args"] = "...: any",
  ["type"] = "function",
  ["name"] = "core.echo",
  ["description"] = "\
For testing; just returns its arguments.",
}
,
}
,
  ["returns"] = " core",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "core",
  ["description"] = "\
Strings, session state, cloning, error handling, reporting, UI, math, iterators, out-of-game debug support._ -> core",
}
,
  ["check"] = {
  ["childs"] = {
  ["regression"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "testOrder: \":\"[]",
  ["type"] = "function",
  ["name"] = "check.regression",
  ["description"] = "\
Run ordered test (names) for regression.",
}
,
  ["open"] = {
  ["returns"] = " `{part:():, message:():, call: ():, close:():}`  <-\
",
  ["args"] = "testName:\":\", text: \":\"",
  ["type"] = "function",
  ["name"] = "check.open",
  ["description"] = "\
Return `check` object(closure)",
}
,
}
,
  ["returns"] = " check",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "check",
  ["description"] = "\
Setup context, save and match expected results for parts of tests, run regression for those tests -> check",
}
,
  ["_move.to:_"] = {
  ["line"] = "--:: move.to(xyzf: xyzf, first: \":\"?) -> _Current situation to x, z, y, and optionally face._ -> `\"done\", #:, xyzf: \":\" &!recovery` ",
  ["out"] = " `\"done\", #:, xyzf: \":\" &!recovery` ",
  ["sign"] = "move.to(xyzf: xyzf, first: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Current situation to x, z, y, and optionally face.",
}
,
  ["planner"] = {
  ["childs"] = {
  [":plan.fixtures"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"[]`",
  ["name"] = "plan.fixtures",
  ["description"] = "\
for placement as specified by path elements beginning with a digit",
}
,
  ["mark"] = {
  ["returns"] = " `shaft: \":\"?, level: \":\"?, tag: \":\"?)` <-\
",
  ["args"] = "markerName: \":\"",
  ["type"] = "function",
  ["name"] = "planner.mark",
  ["description"] = "\
Parse marker name into parts.",
}
,
  [":markElement"] = {
  ["type"] = "value",
  ["returns"] = " `[op: \"mark\", :marking:]`",
  ["name"] = "markElement",
  ["description"] = "\
Current situation in named places",
}
,
  [":putElement"] = {
  ["type"] = "value",
  ["returns"] = " `[op: \"put\", direction: \":\", fixture: \":\"]`",
  ["name"] = "putElement",
  ["description"] = "\
Put fixture in specified direction",
}
,
  [":plan"] = {
  ["type"] = "value",
  ["returns"] = " `{name: plan.name, path: plan.path, work: plan.work, fixtures: plan.fixtures, mark: plan.mark}`",
  ["name"] = "plan",
  ["description"] = "\
How to do work",
}
,
  [":plan.work"] = {
  ["type"] = "value",
  ["returns"] = " `(:plan:, direction: \":\"): \":\"?`",
  ["name"] = "plan.work",
  ["description"] = "\
for execution at every_ `step` _iteration in plan movement direction",
}
,
  [":plan.name"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"`",
  ["name"] = "plan.name",
  ["description"] = "\
for status and error reporting",
}
,
  ["make"] = {
  ["returns"] = " `pathElements, fuelOK: ^:, pathDistance: #:` <-\
",
  ["args"] = "plan:plan",
  ["type"] = "function",
  ["name"] = "planner.make",
  ["description"] = "\
Create path operations table for plan.",
}
,
  ["load"] = {
  ["returns"] = " `plan &!`  <-\
",
  ["args"] = "planFileName: \":\"",
  ["type"] = "function",
  ["name"] = "planner.load",
  ["description"] = "\
Instantiates what is returned from a plan file.",
}
,
  [":markings"] = {
  ["type"] = "value",
  ["returns"] = " `[label: \":\"]: marking`",
  ["name"] = "markings",
  ["description"] = "\
dictionary of markings keyed by a label",
}
,
  [":pathElements"] = {
  ["type"] = "value",
  ["returns"] = " `(stepElement|putElement|markElement)[]`",
  ["name"] = "pathElements",
  ["description"] = "\
Used by `worker.execute` to run plan",
}
,
  [":stepElement"] = {
  ["type"] = "value",
  ["returns"] = " `[op: \"step\", :stepping:, direction: \":\", distance: #:]`",
  ["name"] = "stepElement",
  ["description"] = "\
Iterate steps function in direction for distance",
}
,
  [":plan.path"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"[]`",
  ["name"] = "plan.path",
  ["description"] = "\
table of space separated character sequence strings describing path",
}
,
  [":marking"] = {
  ["type"] = "value",
  ["returns"] = " `[prefix: \":\", base: \":\", label: \":\"]`",
  ["name"] = "marking",
  ["description"] = "\
literals table of marker parts",
}
,
  [":plan.mark"] = {
  ["type"] = "value",
  ["returns"] = " `(:plan:, :marking:): markerName: \":\", label: \":\", report: \":\"`",
  ["name"] = "plan.mark",
  ["description"] = "\
for execution as specified by_ `plan.path` _markers",
}
,
}
,
  ["returns"] = " planner, plan",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "planner",
  ["description"] = "\
Given a_ `plan`, _create a table of operations to be performed by_ `worker.execute`. -> planner, plan",
}
,
  ["_place.nearby:_"] = {
  ["line"] = "--:: place.nearby(:xyzf:?, :cardinals:) -> _Sorted_ -> `[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:]`",
  ["out"] = " `[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:]`",
  ["sign"] = "place.nearby(:xyzf:?, :cardinals:)  ",
  ["kind"] = "face",
  ["text"] = "Sorted",
}
,
  [" task"] = {
  ["type"] = "lib",
  ["name"] = " task",
  ["childs"] = {
}
,
}
,
  ["_port.available:_"] = {
  ["line"] = "  --:: port.available(set: [port.item]: #:) -> _For Testing: mock player inventory_ -> `[port.item]: #:`",
  ["out"] = " `[port.item]: #:`",
  ["sign"] = "port.available(set: [port.item]: #:)  ",
  ["kind"] = "face",
  ["text"] = "For Testing: mock player inventory",
}
,
  [" grid"] = {
  ["type"] = "lib",
  ["name"] = " grid",
  ["childs"] = {
}
,
}
,
  ["__gps.launch:_"] = {
  ["line"] = "  --:: `_gps.launch(commands: [command: \":\", location: \":\", yD: #:?]) -> _Check before journey then launch._ -> \":\"",
  ["kind"] = "face",
  ["sign"] = "`_gps.launch(commands: [command: \":\", location: \":\", yD: #:?])  ",
  ["out"] = " \":\"",
  ["text"] = "Check before journey then launch.",
}
,
  ["_core.setComputerLabel:_"] = {
  ["line"] = "--:: core.setComputerLabel(label: \":\") -> _Sets (out-of game global) label_ -> `label: \":\"`",
  ["out"] = " `label: \":\"`",
  ["sign"] = "core.setComputerLabel(label: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Sets (out-of game global) label",
}
,
  ["_map.puts:_"] = {
  ["line"] = "--:: map.puts(name: \":\", key: \":\", value: \":\"?) -> _Set string feature value, send MU._ -> `key: \":\", value: \":\"|true &!`",
  ["kind"] = "face",
  ["sign"] = "map.puts(name: \":\", key: \":\", value: \":\"?)  ",
  ["out"] = " `key: \":\", value: \":\"|true &!`",
  ["text"] = "Set string feature value, send MU.",
}
,
  ["_move.at:_"] = {
  ["line"] = "--:: move.at(theSituation:situation?) -> _(Current) situation xyzf._ -> `xyzf`",
  ["out"] = " `xyzf`",
  ["sign"] = "move.at(theSituation:situation?)  ",
  ["kind"] = "face",
  ["text"] = "(Current) situation xyzf.",
}
,
  [" remote"] = {
  ["type"] = "lib",
  ["name"] = " remote",
  ["childs"] = {
}
,
}
,
  ["_Filling_"] = {
  ["line"] = "--:< _Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:` ",
  ["sign"] = "_Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:`  ",
  ["text"] = "Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:",
  ["kind"] = "word",
}
,
  ["_remote"] = {
  ["type"] = "lib",
  ["name"] = "_remote",
  ["childs"] = {
  ["serverRequest"] = {
  ["returns"] = " `result: \":\"` <-\
",
  ["args"] = "clientID: #:, request: \":\"",
  ["type"] = "function",
  ["name"] = "_remote.serverRequest",
  ["description"] = "\
Request string to request table, return serialized result_.",
}
,
  ["testCome"] = {
  ["returns"] = " `turtle: \":\", command: \":\", xyz, ^:` <-\
",
  ["args"] = "turtle: \":\", command: \":\"",
  ["type"] = "function",
  ["name"] = "_remote.testCome",
  ["description"] = "\
On client: Prepare remote call to server turtle by getting player xyz position and forming argument table.",
}
,
  ["clientResult"] = {
  ["returns"] = " `any` <-\
",
  ["args"] = "serverID: #:, resultString: \":\", callback: ():",
  ["type"] = "function",
  ["name"] = "_remote.clientResult",
  ["description"] = "\
Apply callback to deserialized client result.",
}
,
  ["prepareCall"] = {
  ["returns"] = " `serverID: #:, request: \":\" &: &!` <-\
",
  ["args"] = "server: \":\", command: \":\", arguments: any[]",
  ["type"] = "function",
  ["name"] = "_remote.prepareCall",
  ["description"] = "\
Serialize server request.",
}
,
}
,
}
,
  ["_at_"] = {
  ["line"] = "--:- at -> Report current (dead reckoning) turtle position and facing or player GPS position.",
  ["sign"] = "at  ",
  ["text"] = "Report current (dead reckoning) turtle position and facing or player GPS position.",
  ["kind"] = "cli",
}
,
  ["__mine.atWork:_"] = {
  ["line"] = "  --:: `_mine.atWork(:plan:, head: \":\", level: #:, key: \":\", value: any)` -> _Make, fill in, execute at level._ -> `\":\", \":\" &: &!`",
  ["out"] = " `\":\", \":\" &: &!`",
  ["sign"] = "`_mine.atWork(:plan:, head: \":\", level: #:, key: \":\", value: any)`  ",
  ["kind"] = "face",
  ["text"] = "Make, fill in, execute at level.",
}
,
  ["_path_"] = {
  ["line"] = "--:- path range firstPlot lastPlot?? -> _Test harvest path (safely)._",
  ["sign"] = "path range firstPlot lastPlot??  ",
  ["kind"] = "cli",
  ["text"] = "Test harvest path (safely).",
}
,
  [" farm"] = {
  ["type"] = "lib",
  ["name"] = " farm",
  ["childs"] = {
}
,
}
,
  ["_core.optionals:_"] = {
  ["line"] = "  --:: core.optionals(string: \":\"?, number: #:?, ...: any) -> _Optional number and/or string._ -> `string: \":\"|false, number: #:|false, ...: any`",
  ["out"] = " `string: \":\"|false, number: #:|false, ...: any`",
  ["sign"] = "core.optionals(string: \":\"?, number: #:?, ...: any)  ",
  ["kind"] = "face",
  ["text"] = "Optional number and/or string.",
}
,
  ["_Seed_"] = {
  ["line"] = "--:< _Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `\"minecraft:\"`",
  ["sign"] = "_Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `\"minecraft:\"` ",
  ["text"] = "Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `\"minecraft:\"",
  ["kind"] = "word",
}
,
  ["_move.moves:_"] = {
  ["line"] = "--:: move.moves(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["sign"] = "move.moves(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_map.locations:_"] = {
  ["line"] = "--:: map.locations(template: {name: \":\", offset: xyz}, base: \":\", label: \":\", top: #:) -> _Add points offset from base._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "map.locations(template: {name: \":\", offset: xyz}, base: \":\", label: \":\", top: #:)  ",
  ["out"] = " `nil`",
  ["text"] = "Add points offset from base.",
}
,
  ["_core.getComputerLabel:_"] = {
  ["line"] = "--:: core.getComputerLabel(label: \":\"?) -> _Out of game returns label; label ignored in game._ -> `label: \":\"`",
  ["out"] = " `label: \":\"`",
  ["sign"] = "core.getComputerLabel(label: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Out of game returns label; label ignored in game.",
}
,
  ["_move.set:_"] = {
  ["line"] = "  --:: move.set(x: #:, y: #:, z: #:, f: facing?, fuels: #:??, level: \":\"???) -> _Set position, optionally rest of situation._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "move.set(x: #:, y: #:, z: #:, f: facing?, fuels: #:??, level: \":\"???)  ",
  ["kind"] = "face",
  ["text"] = "Set position, optionally rest of situation.",
}
,
  ["_range_"] = {
  ["line"] = "--:- range name label point point key value -> Define volume by named points, specify key and value of range property.",
  ["sign"] = "range name label point point key value  ",
  ["text"] = "Define volume by named points, specify key and value of range property.",
  ["kind"] = "cli",
}
,
  ["_Directions_"] = {
  ["line"] = "--:< **Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`orward_**",
  ["sign"] = "**Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`orward_** ",
  ["kind"] = "word",
  ["text"] = "Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`orward",
}
,
  ["turtle"] = {
  ["childs"] = {
  [":group"] = {
  ["type"] = "value",
  ["returns"] = " `\"fuel\" | \"ore\"| \"fill\" | \"dirt\" | \"stone\" | \"fence\" | \"test\"`",
  ["name"] = "group",
  ["description"] = "\
Materials",
}
,
  [":turtle.drops"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (count: #:?): ^:, \":\"?`",
  ["name"] = "turtle.drops",
  ["description"] = "\
Drop count [or all] items in selected slot to inventory.",
}
,
  ["category"] = {
  ["returns"] = " `\":\"[]`  <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "turtle.category",
  ["description"] = "\
Names in category or fencings matching `name` or_ `{\"minecraft:\"..name}`.",
}
,
  [":turtle.attacks"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (): ^:, \":\"?`",
  ["name"] = "turtle.attacks",
  ["description"] = "\
Attack in direction and return attack success.",
}
,
  [":minecraft"] = {
  ["type"] = "value",
  ["returns"] = " \":\"",
  ["name"] = "minecraft",
  ["description"] = "\
For Language Server",
}
,
  [":turtle.compares"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (): same: ^:`",
  ["name"] = "turtle.compares",
  ["description"] = "\
Check block in direction has the same ID as selected slot",
}
,
  ["unblock"] = {
  ["returns"] = " `\"done\", nil|\"undug\" &!`  <-\
",
  ["args"] = "direction: \":\", limit: #:?",
  ["type"] = "function",
  ["name"] = "turtle.unblock",
  ["description"] = "\
Retrys dig to limit or bedrock.",
}
,
  [":turtle.sucks"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (count: #:?): ^:, \":\"?`",
  ["name"] = "turtle.sucks",
  ["description"] = "\
Move count [or all] from direction to inventory.",
}
,
  [":direction"] = {
  ["type"] = "value",
  ["returns"] = " `\"north\"|\"east\"|\"south\"|\"west\"|\"up\"|\"down\"`",
  ["name"] = "direction",
  ["description"] = "\
Four compass points (cardinals) and verticals",
}
,
  ["digAround"] = {
  ["returns"] = " `\"done\" &: &!` <-\
",
  ["args"] = "orientation: \":\", diggings: \":\"[], name: \":\"?",
  ["type"] = "function",
  ["name"] = "turtle.digAround",
  ["description"] = "\
Unblocking dig. Dig (unblocking) in diggings directions, catch failure and raise error(string) re-orienting in original orientation.",
}
,
  [":turtle.detects"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (): ^:`",
  ["name"] = "turtle.detects",
  ["description"] = "\
Check block in direction is solid: not air, mob, liquid or floater.",
}
,
  [":fencings"] = {
  ["type"] = "value",
  ["returns"] = " \"birch\" | \"acacia\" | \"bamboo\" | \"cherry\" | \"chrimson\" | \"dark oak\" | \"mangrove\" | \"oak\"`",
  ["name"] = "fencings",
  ["description"] = "\
Wooden materials",
}
,
  [":ore"] = {
  ["type"] = "value",
  ["returns"] = " `\"minecraft:coal_ore\"|\"minecraft:iron_ore\"|\"minecraft:lapis_ore\"|\"minecraft:gold_ore\"|\"minecraft:diamond_ore\"|\"minecraft:redstone_ore\"|\"minecraft:emerald_ore\"|\"minecraft:nether_quartz_ore\"|\"minecraft:prismarine\"|minecraft:obsidian\"`",
  ["name"] = "ore",
  ["description"] = "\
Minecraft",
}
,
  [":turtle.digs"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (side: \":\"?): ^:, \":\"?`",
  ["name"] = "turtle.digs",
  ["description"] = "\
Try to dig block in direction and implicitly call_ suck().",
}
,
  ["check"] = {
  ["returns"] = " `matched: \":\"?` <-\
",
  ["args"] = "targets: \":\"[], :detail:",
  ["type"] = "function",
  ["name"] = "turtle.check",
  ["description"] = "\
Tries to match each target against_ `detail.name`.",
}
,
  [":turtle.puts"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (text: \":\"?): ^:, \":\"?`",
  ["name"] = "turtle.puts",
  ["description"] = "\
Attempt placing block of the selected slot in direction.",
}
,
  [":ores"] = {
  ["type"] = "value",
  ["returns"] = " `ore[]`",
  ["name"] = "ores",
  ["description"] = "\
Category",
}
,
  ["find"] = {
  ["returns"] = " `detail?`, #:?, ^:? <-\
",
  ["args"] = "targets: \":\"[]",
  ["type"] = "function",
  ["name"] = "turtle.find",
  ["description"] = "\
Selects found slot.",
}
,
  [":turtle.inspects"] = {
  ["type"] = "value",
  ["returns"] = " `[direction]: (): `^:, detail?`",
  ["name"] = "turtle.inspects",
  ["description"] = "\
If true, get detail block information in direction.",
}
,
  ["fuel"] = {
  ["returns"] = " `fuelTotal: #:` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "turtle.fuel",
  ["description"] = "\
Total energy actually available in turtle slots plus turtle fuel level. Returns \"done, \"undug\" if dig attempt was for air, water, or lava. Raises error for bedrock or dig limit reached. Arbitrary 0.5 second waits and default _G.Muse.attempts retrys for gravel; attacks",
}
,
  ["digTo"] = {
  ["returns"] = " `done: \":\" &: &!`  <-\
",
  ["args"] = ":xyzf:, limit: #:?",
  ["type"] = "function",
  ["name"] = "turtle.digTo",
  ["description"] = "\
Unblocking move. Try to move to position, dig to unblock if needed, catch (table) and raise error(string) for \"lost\" or \"empty\". Also catch and raise error (string) if attempt to dig to unblock failed for bedrock or other reason. Normally return just what a successful move would: \"done\", 0 remaining, current position.",
}
,
  ["inventory"] = {
  ["returns"] = " `detail[]` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "turtle.inventory",
  ["description"] = "\
Returns currrent turtle inventory as turtle detail table_.",
}
,
}
,
  ["returns"] = " turtle",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "turtle",
  ["description"] = "\
Replaces game definitions, unifies operations to all directions: north, east, south, west, up, down._ -> turtle Provides low level item finding, naming and turtle inventory utilities; out-of-game simulated blocking.",
}
,
  ["_field.till:_"] = {
  ["line"] = "--:: field.till(parameters: [nearPlace: \":\", farPlace: \":\", seed: \":\"]) -> _Till the seed from one place to the other._ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "field.till(parameters: [nearPlace: \":\", farPlace: \":\", seed: \":\"])  ",
  ["kind"] = "face",
  ["text"] = "Till the seed from one place to the other.",
}
,
  ["_status_"] = {
  ["line"] = "--:- status level [filename] -> _Set reporting hurdle and optionally save reporting in log file._",
  ["sign"] = "status level [filename]  ",
  ["kind"] = "cli",
  ["text"] = "Set reporting hurdle and optionally save reporting in log file.",
}
,
  [" exec"] = {
  ["type"] = "lib",
  ["name"] = " exec",
  ["childs"] = {
}
,
}
,
  ["plan"] = {
  ["type"] = "lib",
  ["name"] = "plan",
  ["childs"] = {
}
,
}
,
  ["_core.where:_"] = {
  ["line"] = "function core.where() --:: core.where() -> _GPS location if available._ -> `x: #:|false, y: #:|false, z: #:|false`",
  ["out"] = " `x: #:|false, y: #:|false, z: #:|false`",
  ["sign"] = "core.where()  ",
  ["kind"] = "face",
  ["text"] = "GPS location if available.",
}
,
  ["_wait_"] = {
  ["line"] = "--:- wait -> _Locally on turtle, wait for rednet message. Useful as recovery for uncaught turtle error._  ",
  ["sign"] = "wait  ",
  ["kind"] = "cli",
  ["text"] = "Locally on turtle, wait for rednet message. Useful as recovery for uncaught turtle error.",
}
,
  ["_place.name:_"] = {
  ["line"] = "  --:: place.name(name: \":\", label: \":\", supplied: situation?, :features:??) -> _Make or update place._ -> `\":\", #:`",
  ["out"] = " `\":\", #:`",
  ["sign"] = "place.name(name: \":\", label: \":\", supplied: situation?, :features:??)  ",
  ["kind"] = "face",
  ["text"] = "Make or update place.",
}
,
  ["_cover_"] = {
  ["line"] = "--:- cover range firstPlot? lastPlot?? -> _Replace field material (for tree farm grid)._",
  ["sign"] = "cover range firstPlot? lastPlot??  ",
  ["kind"] = "cli",
  ["text"] = "Replace field material (for tree farm grid).",
}
,
  ["_where_"] = {
  ["line"] = "--:- where [place] [count = 3] -> Report movement direction, distance to named place, and to count closest places.",
  ["sign"] = "where [place] [count = 3]  ",
  ["text"] = "Report movement direction, distance to named place, and to count closest places.",
  ["kind"] = "cli",
}
,
  ["_moves.to:_"] = {
  ["line"] = "--:: moves.to(target: \":\", first: \":\"?) -> _Move to target, first along direction._ -> `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["out"] = " `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["sign"] = "moves.to(target: \":\", first: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Move to target, first along direction.",
}
,
  ["_farmer_"] = {
  ["line"] = "--:- farmer command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "farmer command argument...  ",
  ["kind"] = "cli",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
}
,
  ["_map.borders:_"] = {
  ["line"] = "  --:: map.borders(range: place) -> _Get range elements_ -> `borders, features, position, position &!`",
  ["kind"] = "face",
  ["sign"] = "map.borders(range: place)  ",
  ["out"] = " `borders, features, position, position &!`",
  ["text"] = "Get range elements",
}
,
  ["_tail_"] = {
  ["line"] = "--:- tail rate? -> _Move `rover` every rate (default 5) seconds towards GPS player position._",
  ["sign"] = "tail rate?  ",
  ["kind"] = "cli",
  ["text"] = "Move `rover` every rate (default 5) seconds towards GPS player position.",
}
,
  ["_near_"] = {
  ["line"] = "--:- near [place] [span] -> Report points within span blocks (or all) of named place (or current player or turtle position).",
  ["sign"] = "near [place] [span]  ",
  ["text"] = "Report points within span blocks (or all) of named place (or current player or turtle position).",
  ["kind"] = "cli",
}
,
  ["_field.make:_"] = {
  ["line"] = "  --:: field.make(commands: fieldCommands, faced: ^:) -> _Load field files; return their `field.plot` calls_ -> `report: \":\" &:`",
  ["out"] = " `report: \":\" &:`",
  ["sign"] = "field.make(commands: fieldCommands, faced: ^:)  ",
  ["kind"] = "face",
  ["text"] = "Load field files; return their `field.plot` calls",
}
,
  ["__mine.ores:_"] = {
  ["line"] = "  --:: `_mine.ores(markerName: \":\", thisLevel: #:, borePlans: bores)` -> _Excavate ores_ -> \"done\", `\":\", #: &: &!`",
  ["out"] = " \"done\", `\":\", #: &: &!`",
  ["sign"] = "`_mine.ores(markerName: \":\", thisLevel: #:, borePlans: bores)`  ",
  ["kind"] = "face",
  ["text"] = "Excavate ores",
}
,
  ["_step.right:_"] = {
  ["line"] = "--:: step.right(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.right(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_core.record:_"] = {
  ["line"] = "  --:: core.record(message: \":\") -> _Appends (status) message to log file on player._ -> `nil & !`",
  ["out"] = " `nil & !`",
  ["sign"] = "core.record(message: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Appends (status) message to log file on player.",
}
,
  ["_core.orient:_"] = {
  ["line"] = "  --:: core.orient(vectors: xyzMap, face: \":\"?, rotate: \":\"??) -> _Three dimensional rotation_ -> `xyzMap`",
  ["out"] = " `xyzMap`",
  ["sign"] = "core.orient(vectors: xyzMap, face: \":\"?, rotate: \":\"??)  ",
  ["kind"] = "face",
  ["text"] = "Three dimensional rotation",
}
,
  ["_map.erase:_"] = {
  ["line"] = "--:: map.erase(name: \":\") -> _Remove named place, overwrite local map file_ -> `remaining: #:`",
  ["kind"] = "face",
  ["sign"] = "map.erase(name: \":\")  ",
  ["out"] = " `remaining: #:`",
  ["text"] = "Remove named place, overwrite local map file",
}
,
  ["_launch_"] = {
  ["line"] = "  --:- launch place yD? -> _Deploy GPS launch yD or maximum y above place, report GPS at place._",
  ["sign"] = "launch place yD?  ",
  ["kind"] = "cli",
  ["text"] = "Deploy GPS launch yD or maximum y above place, report GPS at place.",
}
,
  [" mine"] = {
  ["type"] = "lib",
  ["name"] = " mine",
  ["childs"] = {
}
,
}
,
  ["_equip_"] = {
  ["line"] = "  --:- equip direction -> _Assemble computer, modem, drive, and floppy for direction named GPS launch (for testing)._",
  ["sign"] = "equip direction  ",
  ["kind"] = "cli",
  ["text"] = "Assemble computer, modem, drive, and floppy for direction named GPS launch (for testing).",
}
,
  ["_move.down:_"] = {
  ["line"] = "--:: move.down(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.down(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf: \":\", direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  [" planner"] = {
  ["type"] = "lib",
  ["name"] = " planner",
  ["childs"] = {
}
,
}
,
  ["_worker.execute:_"] = {
  ["line"] = "--:: worker.execute(plan, pathOperations, fuelOK: ^:, pathDistance: #:) -> _Do plan._ ->  `\"done\", report: \":\" &: &!`",
  ["kind"] = "face",
  ["sign"] = "worker.execute(plan, pathOperations, fuelOK: ^:, pathDistance: #:)  ",
  ["out"] = "  `\"done\", report: \":\" &: &!`",
  ["text"] = "Do plan.",
}
,
  ["_farm.plant:_"] = {
  ["line"] = "function farm.plant(planting) --:: farm.plant(planting: \":\") -> _Tills and plants found planting._ -> `report: \":\" &!` ",
  ["kind"] = "face",
  ["sign"] = "farm.plant(planting: \":\")  ",
  ["out"] = " `report: \":\" &!` ",
  ["text"] = "Tills and plants found planting.",
}
,
  ["_remote.call:_"] = {
  ["line"] = "  --:: remote.call(server: \":\", command: \":\", arguments: any[], callback: ():?) -> _RPC:_ -> `any &: &!`",
  ["kind"] = "face",
  ["sign"] = "remote.call(server: \":\", command: \":\", arguments: any[], callback: ():?)  ",
  ["out"] = " `any &: &!`",
  ["text"] = "RPC:",
}
,
  ["_map.put:_"] = {
  ["line"] = "  --:: map.put(name: \":\", key: \":\", value: any?) -> _Set named place feature, send MU._ ->  `key: \":\"?, value: any|true|nil &!`",
  ["kind"] = "face",
  ["sign"] = "map.put(name: \":\", key: \":\", value: any?)  ",
  ["out"] = "  `key: \":\"?, value: any|true|nil &!`",
  ["text"] = "Set named place feature, send MU.",
}
,
  ["_moves.along:_"] = {
  ["line"] = "--:: moves.along(name: \":\") -> _Move from first to second situation of place._ -> `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["out"] = " `code: \":\", remaining: #:, xyzf: \":\" &!recovery`",
  ["sign"] = "moves.along(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Move from first to second situation of place.",
}
,
  ["__remote.serverRequest:_"] = {
  ["line"] = "  --:: `_remote.serverRequest(clientID: #:, request: \":\")` -> _Request string to request table, return serialized result_. -> `result: \":\"`",
  ["kind"] = "face",
  ["sign"] = "`_remote.serverRequest(clientID: #:, request: \":\")`  ",
  ["out"] = " `result: \":\"`",
  ["text"] = "Request string to request table, return serialized result_.",
}
,
  ["_remote.wait:_"] = {
  ["line"] = "--:: remote.wait() -> _Setup turtle to repeatedly wait for MC network requests, send MR results._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "remote.wait()  ",
  ["out"] = " `nil`",
  ["text"] = "Setup turtle to repeatedly wait for MC network requests, send MR results.",
}
,
  ["_locate_"] = {
  ["line"] = "--:- locate name label -> _Create point having Minecraft coordinates above `porter` Command Computer_",
  ["sign"] = "locate name label  ",
  ["text"] = "Create point having Minecraft coordinates above `porter` Command Computer",
  ["kind"] = "cli",
}
,
}
