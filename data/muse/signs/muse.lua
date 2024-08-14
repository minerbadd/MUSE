return {
  ["__remote.testCome:_"] = {
  ["line"] = "  --:: `_remote.testCome(turtle: \":\", command: \":\")` -> _On client:_ -> `turtle: \":\", command: \":\", xyz, ^:`",
  ["out"] = " `turtle: \":\", command: \":\", xyz, ^:`",
  ["sign"] = "`_remote.testCome(turtle: \":\", command: \":\")`  ",
  ["kind"] = "face",
  ["text"] = "On client:",
}
,
  ["_join_"] = {
  ["line"] = "local role, id = ...; --:- join role id -> _Temporarily set mapping for next startup, id from turtle nameplate._",
  ["sign"] = "join role id  ",
  ["text"] = "Temporarily set mapping for next startup, id from turtle nameplate.",
  ["kind"] = "cli",
}
,
  ["gps"] = {
  ["childs"] = {
  ["op"] = {
  ["returns"] = " `report: \":\"` &: <-\
",
  ["args"] = "commands: {command: \":\"[] }",
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
  ["out"] = " `nil & !`",
  ["sign"] = "map.point(name: \":\", label: \":\", :xyzf:)  ",
  ["kind"] = "face",
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
  ["args"] = "arguments: _task.puts, op: (:), clear: ^:, fill: \":\"?, targets: \":\"[]?",
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
  ["kind"] = "face",
  ["sign"] = "`_mine.down(mineheadName: \":\", targetLevel: #:, shaftPlansDown: downs, shaftPlansName: \":\")`  ",
  ["out"] = " `\"done\" &!`",
  ["text"] = "Dig shaft",
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
  ["_core.clone:_"] = {
  ["line"] = "  --:: core.clone(source: {:}|any) -> _Deep copy source table or return source if not table._ -> `{:}|any`",
  ["kind"] = "face",
  ["sign"] = "core.clone(source: {:}|any)  ",
  ["out"] = " `{:}|any`",
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
  ["kind"] = "face",
  ["sign"] = "core.sleep(#:?)  ",
  ["out"] = " `nil`",
  ["text"] = "Mocks sleep as null operation out of game.",
}
,
  ["_core.string:_"] = {
  ["line"] = "function core.string(...) --:: core.string(...: any) -> _Makes string from any inputs, simplifies single entry tables._ -> `\":\"`",
  ["kind"] = "face",
  ["sign"] = "core.string(...: any)  ",
  ["out"] = " `\":\"`",
  ["text"] = "Makes string from any inputs, simplifies single entry tables.",
}
,
  ["_dds.map:_"] = {
  ["line"] = "function dds.map() return pairs(IDs) end --:: dds.map() -> _Returns associations from Muse roles to ComputerCraft IDs_ -> `IDs`",
  ["out"] = " `IDs`",
  ["sign"] = "dds.map()  ",
  ["kind"] = "face",
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
  ["kind"] = "cli",
  ["text"] = "Till the seed bounds by named points (defining a rectangular solid).",
}
,
  ["_cover_"] = {
  ["line"] = "--:- cover range firstPlot? lastPlot?? -> _Replace field material (for tree farm grid)._",
  ["sign"] = "cover range firstPlot? lastPlot??  ",
  ["text"] = "Replace field material (for tree farm grid).",
  ["kind"] = "cli",
}
,
  ["map"] = {
  ["childs"] = {
  ["get"] = {
  ["returns"] = " `value: any?` &! <-\
",
  ["args"] = "name: \":\", key: \":\"",
  ["type"] = "function",
  ["name"] = "map.get",
  ["description"] = "\
Get named place local feature value for key.",
}
,
  ["locations"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "template: :[name: \":\", offset: xyz], base: \":\", label: \":\", top: #:",
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
  ["op"] = {
  ["returns"] = " `report: \":\" &:` <-\
",
  ["args"] = "commands: \":\"[]}",
  ["type"] = "function",
  ["name"] = "map.op",
  ["description"] = "\
Command Line Interface",
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
  ["gets"] = {
  ["returns"] = " `\":\"?` <-\
",
  ["args"] = "name: \":\", key: \":\"",
  ["type"] = "function",
  ["name"] = "map.gets",
  ["description"] = "\
Less generic retrieval: gets string feature value.",
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
  [":borders"] = {
  ["type"] = "value",
  ["returns"] = " {east: #:, west: #:, north: #:, south: #:, top: #:, bottom: #:}",
  ["name"] = "borders",
  ["description"] = "\
Range boundarires",
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
  ["line"] = "--:: move.north(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.north(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_finish_"] = {
  ["line"] = "--:- finish range firstPlot lastPlot?? -> _Complete field preparation for farming._",
  ["sign"] = "finish range firstPlot lastPlot??  ",
  ["text"] = "Complete field preparation for farming.",
  ["kind"] = "cli",
}
,
  ["_core.where:_"] = {
  ["line"] = "function core.where() --:: core.where() -> _GPS location if available._ -> `x: #:?, y: #:?, z: #:?`",
  ["kind"] = "face",
  ["sign"] = "core.where()  ",
  ["out"] = " `x: #:?, y: #:?, z: #:?`",
  ["text"] = "GPS location if available.",
}
,
  ["_step.north:_"] = {
  ["line"] = "--:: step.north(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.north(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_point_"] = {
  ["line"] = "  --:- point name label trail? -> _Add named labeled point, can start trail, MU updated map. (Player situation needs GPS.)_ ",
  ["sign"] = "point name label trail?  ",
  ["text"] = "Add named labeled point, can start trail, MU updated map. (Player situation needs GPS.)",
  ["kind"] = "cli",
}
,
  ["steps"] = {
  ["type"] = "lib",
  ["name"] = "steps",
  ["childs"] = {
}
,
}
,
  ["__field.runElements:_"] = {
  ["line"] = "  --:: `_field.runElements(bounds: :[xyzStart: xyz, xyzFinish: xyz])` -> _Fly ox._ -> `runs:_field.runs, yDelta: #:, xzDelta: #:, xzEdge: facing`",
  ["kind"] = "face",
  ["sign"] = "`_field.runElements(bounds: :[xyzStart: xyz, xyzFinish: xyz])`  ",
  ["out"] = " `runs:_field.runs, yDelta: #:, xzDelta: #:, xzEdge: facing`",
  ["text"] = "Fly ox.",
}
,
  ["_move.down:_"] = {
  ["line"] = "--:: move.down(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.down(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["__field.put:_"] = {
  ["line"] = "  --:: `_field.put(thePlan: \":\", start: #:, finish: #:, filling: \":\", target: \":\"?)` -> _Use`layer` or `till` plan._ -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "`_field.put(thePlan: \":\", start: #:, finish: #:, filling: \":\", target: \":\"?)`  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Use`layer` or `till` plan.",
}
,
  ["_move.where:_"] = {
  ["line"] = "--:: move.where(tx: #:?, ty: #:?, tz: #:?, tf: \":\"?) -> _Returns GPS results if available._ -> `x: #:, y: #:, z: #:, facing: \":\", ^: ok`",
  ["kind"] = "face",
  ["sign"] = "move.where(tx: #:?, ty: #:?, tz: #:?, tf: \":\"?)  ",
  ["out"] = " `x: #:, y: #:, z: #:, facing: \":\", ^: ok`",
  ["text"] = "Returns GPS results if available.",
}
,
  ["_dds.join:_"] = {
  ["line"] = "  --:: dds.join(role: \":\", id: #:?) -> _Fix ID role association for next startup, id given by player._ -> `sitedLabel: \":\"`",
  ["out"] = " `sitedLabel: \":\"`",
  ["sign"] = "dds.join(role: \":\", id: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Fix ID role association for next startup, id given by player.",
}
,
  ["_core.report:_"] = {
  ["line"] = "  --:: core.report(level: #:, ...: any) -> _If level less than `status` threshold, report `rest` as string._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "core.report(level: #:, ...: any)  ",
  ["out"] = " `nil`",
  ["text"] = "If level less than `status` threshold, report `rest` as string.",
}
,
  ["_quit_"] = {
  ["line"] = "--:- quit message -> _Set `quit` flag to message; next `core.status` throws `error` to abort operations._",
  ["sign"] = "quit message  ",
  ["kind"] = "cli",
  ["text"] = "Set `quit` flag to message; next `core.status` throws `error` to abort operations.",
}
,
  ["_move.situations:_"] = {
  ["line"] = "--:: move.situations(:situations:) -> _Set `_G.Muse.situations` to situations._ -> situations",
  ["kind"] = "face",
  ["sign"] = "move.situations(:situations:)  ",
  ["out"] = " situations",
  ["text"] = "Set `_G.Muse.situations` to situations.",
}
,
  ["_field.extents:_"] = {
  ["line"] = "--:: field.extents(:bounds:, :strides:, faced: \":\"?) -> _Plots placed_ -> `field.count, field.count , eP, eP, striding, ^:, ^:`",
  ["kind"] = "face",
  ["sign"] = "field.extents(:bounds:, :strides:, faced: \":\"?)  ",
  ["out"] = " `field.count, field.count , eP, eP, striding, ^:, ^:`",
  ["text"] = "Plots placed",
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
  ["returns"] = " `{name: \":\", label: \":\", :situations:, :features:}`",
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
  ["line"] = "  --:- chart filename ... -> _Loads and runs named file in `charts` directory to create named point and associated ranges._",
  ["sign"] = "chart filename ...  ",
  ["text"] = "Loads and runs named file in `charts` directory to create named point and associated ranges.",
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
  [":downs"] = {
  ["type"] = "value",
  ["returns"] = " `{downs.even: plan, downs.odd: plan, downs.last: plan }`",
  ["name"] = "downs",
  ["description"] = "\
Mark, dig, ladder, and fill one level (for landing platforms)",
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
  [":shafts.down"] = {
  ["type"] = "value",
  ["returns"] = " `downs`",
  ["name"] = "shafts.down",
  ["description"] = "\
Plan for digging shaft one level through even and odd levels",
}
,
  ["op"] = {
  ["returns"] = " `^:, \":\", #: &:` <-\
",
  ["args"] = "arguments: :[op: \":\", placeName: \":\", borePlansFileOrLevels: \":\"|#:, shaftPlansFile: \":\"]",
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
  [":mine.post"] = {
  ["type"] = "value",
  ["returns"] = " (markerName: \":\", :bores:):  `marking[]`",
  ["name"] = "mine.post",
  ["description"] = "\
Navigate shaft and bores to go to marker.",
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
  [":shafts.name"] = {
  ["type"] = "value",
  ["returns"] = " `\":\"`",
  ["name"] = "shafts.name",
  ["description"] = "\
Included in error and status reports",
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
  [":downs.odd"] = {
  ["type"] = "value",
  ["returns"] = " `plan`",
  ["name"] = "downs.odd",
  ["description"] = "\
Mark, dig, ladder, and fill an odd level (for landing platforms)",
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
  ["kind"] = "cli",
  ["text"] = "Chained movement.",
}
,
  ["_farm.replacer:_"] = {
  ["line"] = "  --:: farm.replacer(putAim: direction, item: \":\"[]|\":\", removables: \":\"[]) -> _Remove, put._ -> `(_:, :direction:): \":\" &!` ",
  ["out"] = " `(_:, :direction:): \":\" &!` ",
  ["sign"] = "farm.replacer(putAim: direction, item: \":\"[]|\":\", removables: \":\"[])  ",
  ["kind"] = "face",
  ["text"] = "Remove, put.",
}
,
  ["_attack_"] = {
  ["line"] = "local function attack(...) --:- attack direction -> _Attempts attack in specified direction._ ",
  ["sign"] = "attack direction  ",
  ["text"] = "Attempts attack in specified direction.",
  ["kind"] = "cli",
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
  ["_roam.op:_"] = {
  ["line"] = "function roam.op(arguments) --:: roam.op(arguments: \":\"[]) -> _Move turtle:_ -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "roam.op(arguments: \":\"[])  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Move turtle:",
}
,
  ["_view_"] = {
  ["line"] = "  --:- view place -> _Report place details including all situations and features._",
  ["sign"] = "view place  ",
  ["text"] = "Report place details including all situations and features.",
  ["kind"] = "cli",
}
,
  ["_core.completer:_"] = {
  ["line"] = "function core.completer(completions) --:: core.completer(completions: {:}) -> _Register command completions for shell_ -> `(:)`",
  ["kind"] = "face",
  ["sign"] = "core.completer(completions: {:})  ",
  ["out"] = " `(:)`",
  ["text"] = "Register command completions for shell",
}
,
  ["__mine.shaftOp:_"] = {
  ["line"] = "  --:: `_mine.shaftOp(mineheadName: \":\", levels: #:, shaftPlans: shafts)` -> _Dig shaft through levels._ -> `\":\", \":\", #:` &!",
  ["kind"] = "face",
  ["sign"] = "`_mine.shaftOp(mineheadName: \":\", levels: #:, shaftPlans: shafts)`  ",
  ["out"] = " `\":\", \":\", #:` &!",
  ["text"] = "Dig shaft through levels.",
}
,
  ["_move.up:_"] = {
  ["line"] = "--:: move.up(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.up(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_field.make:_"] = {
  ["line"] = "  --:: field.make(commands: fieldCommands, faced: ^:) -> _Load field files; return their `field.plot` calls_ -> `report: \":\" &:`",
  ["kind"] = "face",
  ["sign"] = "field.make(commands: fieldCommands, faced: ^:)  ",
  ["out"] = " `report: \":\" &:`",
  ["text"] = "Load field files; return their `field.plot` calls",
}
,
  ["_core.round:_"] = {
  ["line"] = "--:: core.round(n: #:) -> _Next integer down if below half fraction_ -> `#:`",
  ["kind"] = "face",
  ["sign"] = "core.round(n: #:)  ",
  ["out"] = " `#:`",
  ["text"] = "Next integer down if below half fraction",
}
,
  ["_core.findItems:_"] = {
  ["line"] = "  --:: core.findItems(targets: \":\"[]) -> _Selects found slot._ -> `detail?`",
  ["kind"] = "face",
  ["sign"] = "core.findItems(targets: \":\"[])  ",
  ["out"] = " `detail?`",
  ["text"] = "Selects found slot.",
}
,
  ["_trail_"] = {
  ["line"] = "  --:- trail name label -> _Include named point at head and (current situation) tail of a new trail, update map._ ",
  ["sign"] = "trail name label  ",
  ["text"] = "Include named point at head and (current situation) tail of a new trail, update map.",
  ["kind"] = "cli",
}
,
  ["_dds.role:_"] = {
  ["line"] = "function dds.role(ID) return roles[ID] end --:: dds.role(ID: \":\") ->  _Label for a Muse role_ -> `role: \":\"`",
  ["out"] = " `role: \":\"`",
  ["sign"] = "dds.role(ID: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Label for a Muse role",
}
,
  ["_map.borders:_"] = {
  ["line"] = "  --:: map.borders(range: place) -> _Get range elements_ -> `borders, features, position, position &!`",
  ["out"] = " `borders, features, position, position &!`",
  ["sign"] = "map.borders(range: place)  ",
  ["kind"] = "face",
  ["text"] = "Get range elements",
}
,
  ["_activate_"] = {
  ["line"] = "  --:- activate range -> _Add borders from west and north to east and south of range for Minecraft forceload._",
  ["sign"] = "activate range  ",
  ["kind"] = "cli",
  ["text"] = "Add borders from west and north to east and south of range for Minecraft forceload.",
}
,
  ["_turtle.fuel:_"] = {
  ["line"] = "  --:: turtle.fuel() -> _Total energy actually available in turtle slots plus turtle fuel level._ -> `fuelTotal: #:`",
  ["kind"] = "face",
  ["sign"] = "turtle.fuel()  ",
  ["out"] = " `fuelTotal: #:`",
  ["text"] = "Total energy actually available in turtle slots plus turtle fuel level.",
}
,
  ["_step.left:_"] = {
  ["line"] = "--:: step.left(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.left(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_core.orient:_"] = {
  ["line"] = "  --:: core.orient(vectors: xyzMap, face: \":\"?, rotate: \":\"??) -> _Three dimensional rotation_ -> `xyzMap`",
  ["kind"] = "face",
  ["sign"] = "core.orient(vectors: xyzMap, face: \":\"?, rotate: \":\"??)  ",
  ["out"] = " `xyzMap`",
  ["text"] = "Three dimensional rotation",
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
Repeatedly towards player position, default rate 0.5 seconds.",
}
,
  ["call"] = {
  ["returns"] = " `any &: &!` <-\
",
  ["args"] = "server: \":\", command: \":\", arguments: any[], callback: (:)?",
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
  ["_map.erase:_"] = {
  ["line"] = "--:: map.erase(name: \":\") -> _Remove named place, overwrite local map file_ -> `remaining: #:`",
  ["out"] = " `remaining: #:`",
  ["sign"] = "map.erase(name: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Remove named place, overwrite local map file",
}
,
  ["_step.steps:_"] = {
  ["line"] = "--:: step.steps(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.steps(count: #:?)  ",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_turtle.find:_"] = {
  ["line"] = "  --:: turtle.find(targets: \":\"[]) -> _Selects found slot._ -> `detail?`",
  ["out"] = " `detail?`",
  ["sign"] = "turtle.find(targets: \":\"[])  ",
  ["kind"] = "face",
  ["text"] = "Selects found slot.",
}
,
  ["_steps.along:_"] = {
  ["line"] = "--:: steps.along(name: \":\") -> _Iterator: first to next situation of place._ -> `(): code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["kind"] = "face",
  ["sign"] = "steps.along(name: \":\")  ",
  ["out"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["text"] = "Iterator: first to next situation of place.",
}
,
  ["__mine.toPost:_"] = {
  ["line"] = "  --:: `_mine.toPost(markerName: \":\", borePlans: bores, shaftPlans: shafts)` -> _Navigate to post_ -> `\"done\", \":\", #: &!`",
  ["kind"] = "face",
  ["sign"] = "`_mine.toPost(markerName: \":\", borePlans: bores, shaftPlans: shafts)`  ",
  ["out"] = " `\"done\", \":\", #: &!`",
  ["text"] = "Navigate to post",
}
,
  ["_quarry_"] = {
  ["line"] = "--:- quarry range firstPlot? lastPlot?? -> _Dig out the field to level it._",
  ["sign"] = "quarry range firstPlot? lastPlot??  ",
  ["text"] = "Dig out the field to level it.",
  ["kind"] = "cli",
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
  [":position"] = {
  ["type"] = "value",
  ["returns"] = " `{x: #:, y: #:, z: #:}`",
  ["name"] = "position",
  ["description"] = "\
Computercraft co-ordinates (+x east, +y up, +z south)",
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
  [":situation.fuel"] = {
  ["type"] = "value",
  ["returns"] = " `#:`",
  ["name"] = "situation.fuel",
  ["description"] = "\
Simulated fuel level checked against reported fuel to validate dead reckoning",
}
,
  [":recovery"] = {
  ["type"] = "value",
  ["returns"] = " `{call: \":\", failure: \":\", cause: \":\", remaining: #:, :xyzf:, :direction:, operation: \":\"}`",
  ["name"] = "recovery",
  ["description"] = "\
For some errors",
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
  [":situation"] = {
  ["type"] = "value",
  ["returns"] = " `{position:position, facing:facing, fuel: situation.fuel, level: situation.level}`",
  ["name"] = "situation",
  ["description"] = "\
Dead reckoning",
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
}
,
  ["returns"] = " motion, move, step",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "motion",
  ["description"] = "\
Libraries to move turtles and move turtles by steps allowing operations at each step._ -> motion, move, step move: **Position setting, tracking, and reporting by dead reckoning checked by fuel consumption. step: **Iterators (closures) for moving block by block, potentially doing operations at each block.",
}
,
  ["_core.match:_"] = {
  ["line"] = "  --:: core.match(tableA: any[], tableB: any[]) -> _Find first matching item in pair of item tables._ -> `nil` | `any`",
  ["kind"] = "face",
  ["sign"] = "core.match(tableA: any[], tableB: any[])  ",
  ["out"] = " `nil` | `any`",
  ["text"] = "Find first matching item in pair of item tables.",
}
,
  ["_gps"] = {
  ["type"] = "lib",
  ["name"] = "_gps",
  ["childs"] = {
  ["equip"] = {
  ["returns"] = " \":\" <-\
",
  ["args"] = "commands: :[command: \":\", direction: facing]",
  ["type"] = "function",
  ["name"] = "_gps.equip",
  ["description"] = "\
Assemble parts.",
}
,
  ["actuate"] = {
  ["returns"] = " \":\" <-\
",
  ["args"] = "commands: :[command: \":\", direction: facing]",
  ["type"] = "function",
  ["name"] = "_gps.actuate",
  ["description"] = "\
Move to boot a GPS host and retrieve floppy.",
}
,
  ["launch"] = {
  ["returns"] = " \":\" <-\
",
  ["args"] = "commands: :[command: \":\", location: \":\", yD: #:?]",
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
  ["_map.place:_"] = {
  ["line"] = "  --:: map.place(placeString: \":\") -> _Instantiate string as named place, include in named places._ -> `serial: \":\", index: #: &!`",
  ["out"] = " `serial: \":\", index: #: &!`",
  ["sign"] = "map.place(placeString: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Instantiate string as named place, include in named places.",
}
,
  ["_harvest_"] = {
  ["line"] = "--:- harvest range firstPlot lastPlot?? -> _Harvest (and replant if needed)._",
  ["sign"] = "harvest range firstPlot lastPlot??  ",
  ["text"] = "Harvest (and replant if needed).",
  ["kind"] = "cli",
}
,
  ["__gps.equip:_"] = {
  ["line"] = "  --:: `_gps.equip(commands: :[command: \":\", direction: facing])` -> _Assemble parts._ -> \":\"",
  ["out"] = " \":\"",
  ["sign"] = "`_gps.equip(commands: :[command: \":\", direction: facing])`  ",
  ["kind"] = "face",
  ["text"] = "Assemble parts.",
}
,
  ["_find_"] = {
  ["line"] = "local function find(target) --:- find name...? -> _Report and select first slot found [or if no name, just report inventory]._",
  ["sign"] = "find name...?  ",
  ["text"] = "Report and select first slot found [or if no name, just report inventory].",
  ["kind"] = "cli",
}
,
  ["_site_"] = {
  ["line"] = "  --:- site name? -> _Remote operation to report or change site (persistently) after, e.g., porting `rover`._",
  ["sign"] = "site name?  ",
  ["text"] = "Remote operation to report or change site (persistently) after, e.g., porting `rover`.",
  ["kind"] = "cli",
}
,
  ["_field.cut:_"] = {
  ["line"] = "--:: field.cut(places: :[nearPlace: \":\", farPlace: \":\"]) -> _Quarry out blocks from one place to the other._ -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "field.cut(places: :[nearPlace: \":\", farPlace: \":\"])  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Quarry out blocks from one place to the other.",
}
,
  ["_steps.to:_"] = {
  ["line"] = "  --:: steps.to(target: \":\") -> _Step (iterator) to target place._ -> `(): code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["kind"] = "face",
  ["sign"] = "steps.to(target: \":\")  ",
  ["out"] = " `(): code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["text"] = "Step (iterator) to target place.",
}
,
  ["_map.read:_"] = {
  ["line"] = "  --:: map.read(thisMap: \":\") -> _Reinstantiate places from map file._ -> `serial: \":\", index: #: &!`",
  ["out"] = " `serial: \":\", index: #: &!`",
  ["sign"] = "map.read(thisMap: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Reinstantiate places from map file.",
}
,
  ["move"] = {
  ["type"] = "lib",
  ["name"] = "move",
  ["childs"] = {
  ["right"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.right",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["where"] = {
  ["returns"] = " `x: #:, y: #:, z: #:, facing: \":\", ^: ok` <-\
",
  ["args"] = "tx: #:?, ty: #:?, tz: #:?, tf: \":\"?",
  ["type"] = "function",
  ["name"] = "move.where",
  ["description"] = "\
Returns GPS results if available. If no GPS, returns the optional (testing) parameters or, if not supplied, current dead reckoning position in situation.",
}
,
  ["situations"] = {
  ["returns"] = " situations <-\
",
  ["args"] = ":situations:",
  ["type"] = "function",
  ["name"] = "move.situations",
  ["description"] = "\
Set `_G.Muse.situations` to situations.",
}
,
  ["east"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.east",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["down"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.down",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["track"] = {
  ["returns"] = " `enable: ^:` <-\
",
  ["args"] = "enable: ^:",
  ["type"] = "function",
  ["name"] = "move.track",
  ["description"] = "\
Set tracking condition",
}
,
  ["left"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.left",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["back"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.back",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["forward"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.forward",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["north"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.north",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["clones"] = {
  ["returns"] = "  situations <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "move.clones",
  ["description"] = "\
Deep copy `_G.Muse.situations`.",
}
,
  ["at"] = {
  ["returns"] = " `xyzf` <-\
",
  ["args"] = ":situation:?",
  ["type"] = "function",
  ["name"] = "move.at",
  ["description"] = "\
(Current) situation xyzf.",
}
,
  ["ats"] = {
  ["returns"] = " `xyzf: \":\"` <-\
",
  ["args"] = ":situation:?",
  ["type"] = "function",
  ["name"] = "move.ats",
  ["description"] = "\
(Current) situation position and facing string (`\"\"` in game if not turtle).",
}
,
  ["up"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.up",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["west"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.west",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["to"] = {
  ["returns"] = " `\"done\", #:, xyzf &!recovery`  <-\
",
  ["args"] = "xyzf: xyzf, first: \":\"?",
  ["type"] = "function",
  ["name"] = "move.to",
  ["description"] = "\
Current situation to x, z, y, and optionally face. Optional argument_ `first` _is \"x\", \"y\", or \"z\" to select first move in that direction to deal with blockages.",
}
,
  ["clone"] = {
  ["returns"] = " situation <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "move.clone",
  ["description"] = "\
Clone current situation",
}
,
  ["set"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "x: #:, y: #:, z: #:, f: facing?, fuel: #:??, level: \":\"???",
  ["type"] = "function",
  ["name"] = "move.set",
  ["description"] = "\
Set position, optionally rest of situation.",
}
,
  ["south"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.south",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["moves"] = {
  ["returns"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery`  <-\
",
  ["args"] = "count: #:?",
  ["type"] = "function",
  ["name"] = "move.moves",
  ["description"] = "\
Count 0: just turn, 1: default",
}
,
  ["get"] = {
  ["returns"] = " `x: #:, y: #:, z: #:, facing: \":\", fuel: #:, level: \":\"` <-\
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
  ["_core.echo:_"] = {
  ["line"] = "--:: core.echo(...: any) -> _For testing; just returns its arguments._ -> ...: `any`",
  ["kind"] = "face",
  ["sign"] = "core.echo(...: any)  ",
  ["out"] = " ...: `any`",
  ["text"] = "For testing; just returns its arguments.",
}
,
  ["_wait_"] = {
  ["line"] = "--:- wait -> _Locally on turtle, wait for rednet message. Useful as recovery for uncaught turtle error._  ",
  ["sign"] = "wait  ",
  ["text"] = "Locally on turtle, wait for rednet message. Useful as recovery for uncaught turtle error.",
  ["kind"] = "cli",
}
,
  ["_step.up:_"] = {
  ["line"] = "--:: step.up(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.up(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_port.book:_"] = {
  ["line"] = "  --:: port.book(name: \":\", label: \":\", from: place, to: place, span: #:, ordering: port.order) -> _Testing_ -> `booking: \":\"`",
  ["kind"] = "face",
  ["sign"] = "port.book(name: \":\", label: \":\", from: place, to: place, span: #:, ordering: port.order)  ",
  ["out"] = " `booking: \":\"`",
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
  ["line"] = "  --:: gps.op(commands: {command: \":\"[] }) -> _Command Line Interface._ -> `report: \":\"` &:",
  ["out"] = " `report: \":\"` &:",
  ["sign"] = "gps.op(commands: {command: \":\"[] })  ",
  ["kind"] = "face",
  ["text"] = "Command Line Interface.",
}
,
  ["_remote.returns:_"] = {
  ["line"] = "--:: remote.returns(results: any[]) -> _Default client side handling of server response: just print results as string._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "remote.returns(results: any[])  ",
  ["kind"] = "face",
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
  ["kind"] = "face",
  ["sign"] = "port.op(commands: \":\"[])  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Command Line Interface for teleport book and trip:",
}
,
  ["_turtle.check:_"] = {
  ["line"] = "  --:: turtle.check(targets: \":\"[], :detail:) -> _Tries to match each target against_ `detail.name`. -> ``matched: ^:`",
  ["kind"] = "face",
  ["sign"] = "turtle.check(targets: \":\"[], :detail:)  ",
  ["out"] = " ``matched: ^:`",
  ["text"] = "Tries to match each target against_ `detail.name`.",
}
,
  ["_items_"] = {
  ["line"] = "function turtle.items() return core.string(turtle.inventory()) end --:- items -> _Returns items in turtle inventory as string._",
  ["sign"] = "items  ",
  ["kind"] = "cli",
  ["text"] = "Returns items in turtle inventory as string.",
}
,
  ["_rover_"] = {
  ["line"] = "--:- rover command argument... -> _See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface._",
  ["sign"] = "rover command argument...  ",
  ["text"] = "See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface.",
  ["kind"] = "cli",
}
,
  ["_put_"] = {
  ["line"] = "  --:- put filling direction distance putting... -> _Direction, distance to move, placing filling in puttings directions._",
  ["sign"] = "put filling direction distance putting...  ",
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
  ["line"] = "--:: place.near(span: #:?, reference?: \":\"|position) -> __ -> (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"`",
  ["kind"] = "face",
  ["sign"] = "place.near(span: #:?, reference?: \":\"|position)  ",
  ["out"] = " (): `name: \":\", label: \":\", xyz, distance: #:, situations, serial: \":\"`",
  ["text"] = "",
}
,
  ["_turtle.detail:_"] = {
  ["line"] = "turtle.detail = mock.getItemDetail --:: turtle.detail(slot: #:?) -> _Detail of selected or specified slot._ -> `detail` ",
  ["kind"] = "face",
  ["sign"] = "turtle.detail(slot: #:?)  ",
  ["out"] = " `detail` ",
  ["text"] = "Detail of selected or specified slot.",
}
,
  ["_fill_"] = {
  ["line"] = "--:- fill point point filling [target] -> _Layer fill bounds by points; optionally swaps out only target blocks._",
  ["sign"] = "fill point point filling [target]  ",
  ["kind"] = "cli",
  ["text"] = "Layer fill bounds by points; optionally swaps out only target blocks.",
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
  ["line"] = "local function erase(name) --:- erase name -> _Remove named place, broadcast Muse eXcise (MX)._",
  ["sign"] = "erase name  ",
  ["text"] = "Remove named place, broadcast Muse eXcise (MX).",
  ["kind"] = "cli",
}
,
  ["_map.gets:_"] = {
  ["line"] = "map.gets = map.get --:: map.gets(name: \":\", key: \":\") -> _Less generic retrieval: gets string feature value._ -> `\":\"?`",
  ["out"] = " `\":\"?`",
  ["sign"] = "map.gets(name: \":\", key: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Less generic retrieval: gets string feature value.",
}
,
  ["_core.xyzf:_"] = {
  ["line"] = "function core.xyzf(xyzf) --:: core.xyzf(:xyzf:) -> _Returns specially formatted string for `xyzf`._ -> `\":\"`",
  ["kind"] = "face",
  ["sign"] = "core.xyzf(:xyzf:)  ",
  ["out"] = " `\":\"`",
  ["text"] = "Returns specially formatted string for `xyzf`.",
}
,
  ["_move.right:_"] = {
  ["line"] = "--:: move.right(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.right(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_turtle.blocking:_"] = {
  ["line"] = "--:: turtle.blocking(^:) -> _Isolate global to control blocking for out-of-game debug._ -> `^:`",
  ["kind"] = "face",
  ["sign"] = "turtle.blocking(^:)  ",
  ["out"] = " `^:`",
  ["text"] = "Isolate global to control blocking for out-of-game debug.",
}
,
  ["__mine.bore:_"] = {
  ["line"] = "  --:: `_mine.bore(markerName: \":\", borePlans: bores, shaftPlans:shafts)` -> _Go to marker and bore_ -> `\"done\", \":\", #: &: &!`",
  ["kind"] = "face",
  ["sign"] = "`_mine.bore(markerName: \":\", borePlans: bores, shaftPlans:shafts)`  ",
  ["out"] = " `\"done\", \":\", #: &: &!`",
  ["text"] = "Go to marker and bore",
}
,
  ["_grid.ores:_"] = {
  ["line"] = "  --:: grid.ores(:plan:, :direction:, guide: grid.guide, :ores:) -> _Extract ores._ -> `\"done\" &!`",
  ["kind"] = "face",
  ["sign"] = "grid.ores(:plan:, :direction:, guide: grid.guide, :ores:)  ",
  ["out"] = " `\"done\" &!`",
  ["text"] = "Extract ores.",
}
,
  ["_turtle.inventory:_"] = {
  ["line"] = "  --:: turtle.inventory() -> _Returns currrent turtle inventory as turtle detail table_. -> `detail[]`",
  ["kind"] = "face",
  ["sign"] = "turtle.inventory()  ",
  ["out"] = " `detail[]`",
  ["text"] = "Returns currrent turtle inventory as turtle detail table_.",
}
,
  ["_dds.roleID:_"] = {
  ["line"] = "function dds.roleID(role) return IDs[role] end --:: dds.roleID(role: \":\") -> _ID for a Muse role_ -> `ID: #:` ",
  ["out"] = " `ID: #:` ",
  ["sign"] = "dds.roleID(role: \":\")  ",
  ["kind"] = "face",
  ["text"] = "ID for a Muse role",
}
,
  ["_map.testFacing:_"] = {
  ["line"] = "--:: map.testFacing(dx: #:, dz: #:) -> _Find orientation using position changes for non-zero movement._ -> `facing: \":\" & !`",
  ["out"] = " `facing: \":\" & !`",
  ["sign"] = "map.testFacing(dx: #:, dz: #:)  ",
  ["kind"] = "face",
  ["text"] = "Find orientation using position changes for non-zero movement.",
}
,
  ["_move.back:_"] = {
  ["line"] = "--:: move.back(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.back(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_Seed_"] = {
  ["line"] = "--:< _Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `\"minecraft:\"`",
  ["sign"] = "_Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `\"minecraft:\"` ",
  ["kind"] = "word",
  ["text"] = "Seed may be one of the turtle categories or a Minecraft detail name without the prefix_ `\"minecraft:\"",
}
,
  ["_move.forward:_"] = {
  ["line"] = "--:: move.forward(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.forward(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
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
  ["_farm.put:_"] = {
  ["line"] = "--:: farm.put(putAim: direction, item: \":\"[]|\":\") -> _Puts found item in aimed direction._ ->  `report: \":\" &!`",
  ["out"] = "  `report: \":\" &!`",
  ["sign"] = "farm.put(putAim: direction, item: \":\"[]|\":\")  ",
  ["kind"] = "face",
  ["text"] = "Puts found item in aimed direction.",
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
  ["_echo_"] = {
  ["line"] = "function core.echo(...) return ... end --:- echo arguments ... -> _For testing: just returns its arguments._",
  ["sign"] = "echo arguments ...  ",
  ["kind"] = "cli",
  ["text"] = "For testing: just returns its arguments.",
}
,
  ["__task.doTask:_"] = {
  ["line"] = "  --:: `_task.doTask(arguments: _task.puts, op: (:), clear: ^:, fill: \":\"?, targets: \":\"[]?)`-> _Tasks_ -> \":\" &!`",
  ["out"] = " \":\" &!`",
  ["sign"] = "`_task.doTask(arguments: _task.puts, op: (:), clear: ^:, fill: \":\"?, targets: \":\"[]?)` ",
  ["kind"] = "face",
  ["text"] = "Tasks",
}
,
  ["_core.optionals:_"] = {
  ["line"] = "  --:: core.optionals(string: \":\"?, number: #:?, ...: any) -> _Optional number and/or string._ -> `string: \":\"?, number: #:?, ...: any`",
  ["kind"] = "face",
  ["sign"] = "core.optionals(string: \":\"?, number: #:?, ...: any)  ",
  ["out"] = " `string: \":\"?, number: #:?, ...: any`",
  ["text"] = "Optional number and/or string.",
}
,
  ["_trace_"] = {
  ["line"] = "  --:- trace trailname ->  _Move turtle along traced situations in named trail from one end of trail to the other._",
  ["sign"] = "trace trailname  ",
  ["kind"] = "cli",
  ["text"] = "Move turtle along traced situations in named trail from one end of trail to the other.",
}
,
  ["__mine.back:_"] = {
  ["line"] = "  --:: `_mine.back(mineheadName: \":\",  targetLevel: #:, shaftPlansBack: shafts, shaftPlansName: \":\")` -> _To minehead_ -> `\":\", \":\"  &!`",
  ["kind"] = "face",
  ["sign"] = "`_mine.back(mineheadName: \":\",  targetLevel: #:, shaftPlansBack: shafts, shaftPlansName: \":\")`  ",
  ["out"] = " `\":\", \":\"  &!`",
  ["text"] = "To minehead",
}
,
  ["_core.logging:_"] = {
  ["line"] = "  --:: core.logging(arguments: :[level: #:, filename: \":\"]) -> _Set threshold level [and local log file] for status reports_ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "core.logging(arguments: :[level: #:, filename: \":\"])  ",
  ["out"] = " `nil`",
  ["text"] = "Set threshold level [and local log file] for status reports",
}
,
  ["_place.track:_"] = {
  ["line"] = "  --:: place.track(name: \":\") -> _Returns trail_ -> `name: \":\"?, label: \":\"?, situations`?",
  ["kind"] = "face",
  ["sign"] = "place.track(name: \":\")  ",
  ["out"] = " `name: \":\"?, label: \":\"?, situations`?",
  ["text"] = "Returns trail",
}
,
  ["_remote.tail:_"] = {
  ["line"] = "  --:: remote.tail(turtle: \":\", __ : \"tail\", rates: \":\"?) -> _Repeatedly towards player position, default rate 0.5 seconds.__ -> `nil` ",
  ["out"] = " `nil` ",
  ["sign"] = "remote.tail(turtle: \":\", __ : \"tail\", rates: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Repeatedly towards player position, default rate 0.5 seconds.",
}
,
  ["_suck_"] = {
  ["line"] = "local function suck(...) --:- suck direction quantity? -> _Suck quantity items [or all] into available slot._ ",
  ["sign"] = "suck direction quantity?  ",
  ["text"] = "Suck quantity items [or all] into available slot.",
  ["kind"] = "cli",
}
,
  ["_fueling_"] = {
  ["line"] = "function turtle.fuel() --:- fueling -> _Returns energy available in turtle slots._",
  ["sign"] = "fueling  ",
  ["kind"] = "cli",
  ["text"] = "Returns energy available in turtle slots.",
}
,
  ["_mine"] = {
  ["type"] = "lib",
  ["name"] = "_mine",
  ["childs"] = {
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
}
,
}
,
  ["_core.pass:_"] = {
  ["line"] = "  --:: core.pass(ok: ^:, ...: any) -> _Pass input but report string if not ok._ -> ok: `true|false, result: ...|\":\", any?`",
  ["kind"] = "face",
  ["sign"] = "core.pass(ok: ^:, ...: any)  ",
  ["out"] = " ok: `true|false, result: ...|\":\", any?`",
  ["text"] = "Pass input but report string if not ok.",
}
,
  ["_actuate_"] = {
  ["line"] = "  --:- actuate direction -> _Move around to boot direction named GPS host and retrieve floppy (for testing)._ ",
  ["sign"] = "actuate direction  ",
  ["text"] = "Move around to boot direction named GPS host and retrieve floppy (for testing).",
  ["kind"] = "cli",
}
,
  ["_turtle.unblock:_"] = {
  ["line"] = "  --:: turtle.unblock(direction: \":\", limit: #:?) -> _Retrys (default 5) dig to limit or bedrock._ -> `\"done\", nil|\"undug\" &!` ",
  ["kind"] = "face",
  ["sign"] = "turtle.unblock(direction: \":\", limit: #:?)  ",
  ["out"] = " `\"done\", nil|\"undug\" &!` ",
  ["text"] = "Retrys (default 5) dig to limit or bedrock.",
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
  ["returns"] = " `[ID]: \":\"`",
  ["name"] = "roles",
  ["description"] = "\
Dictionary of Computercraft labels for MUSE roles keyed by Computercraft (string) IDs",
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
  ["args"] = "ID: \":\"",
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
  ["args"] = "role: \":\", id: #:?",
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
  ["kind"] = "face",
  ["sign"] = "field.plan(planName: \":\", fielding: fieldParameters, offset: xyz?)  ",
  ["out"] = " `report: \":\" &: &!`",
  ["text"] = "Run plan, default offset {0,0,0}.",
}
,
  ["_core.serialize:_"] = {
  ["line"] = "--:: core.serialize(input: any) -> _Executable string to instantiate input._ -> `\"return \"..\":\" &!`",
  ["kind"] = "face",
  ["sign"] = "core.serialize(input: any)  ",
  ["out"] = " `\"return \"..\":\" &!`",
  ["text"] = "Executable string to instantiate input.",
}
,
  ["_exec.op:_"] = {
  ["line"] = "function exec.op(commandLine)                                            --:: exec.op(commandLine: :[command: \":\", ...]) -> _CLI for Command Computer commands_ -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "exec.op(commandLine: :[command: \":\", ...])  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "CLI for Command Computer commands",
}
,
  ["__field.fillTill:_"] = {
  ["line"] = "  --:: `_field.fillTill(thePlan: \":\", parameters: :[nearPlace: \":\", farPlace: \":\", filling: \":\", target: \":\"?])`-> _To `put``._ -> `\":\"`",
  ["kind"] = "face",
  ["sign"] = "`_field.fillTill(thePlan: \":\", parameters: :[nearPlace: \":\", farPlace: \":\", filling: \":\", target: \":\"?])` ",
  ["out"] = " `\":\"`",
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
  ["kind"] = "face",
  ["sign"] = "core.getComputerID(id: #:?)  ",
  ["out"] = " `id: #:`",
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
  ["kind"] = "face",
  ["sign"] = "port.inventory(costToPay: #:, orderedItems: port.order, playerInventory: [port.item]: #:)  ",
  ["out"] = " `\":\"[], #:, #:`",
  ["text"] = "Testing",
}
,
  ["_place.match:_"] = {
  ["line"] = "  --:: place.match(name: \":\") -> _Lookup place qualified by site, return_ `nil` _if not found._ -> `index: #:?, place?`",
  ["kind"] = "face",
  ["sign"] = "place.match(name: \":\")  ",
  ["out"] = " `index: #:?, place?`",
  ["text"] = "Lookup place qualified by site, return_ `nil` _if not found.",
}
,
  ["_field.fence:_"] = {
  ["line"] = "--:: field.fence(parameters: :[ranger: \":\", fencing: \":\"?]) -> _Put fencing using `layer` plan._ -> `\":\"`",
  ["kind"] = "face",
  ["sign"] = "field.fence(parameters: :[ranger: \":\", fencing: \":\"?])  ",
  ["out"] = " `\":\"`",
  ["text"] = "Put fencing using `layer` plan.",
}
,
  ["_roam.come:_"] = {
  ["line"] = "  --:: roam.come(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come. -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "roam.come(:xyz:)  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Server side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come.",
}
,
  ["_turtle.digAround:_"] = {
  ["line"] = "  --:: turtle.digAround(orientation: \":\", name: \":\", diggings: \":\"[]) -> _Unblocking dig._ -> `\"done\" &: &!`",
  ["kind"] = "face",
  ["sign"] = "turtle.digAround(orientation: \":\", name: \":\", diggings: \":\"[])  ",
  ["out"] = " `\"done\" &: &!`",
  ["text"] = "Unblocking dig.",
}
,
  ["_core.merge:_"] = {
  ["line"] = "function core.merge(...) --:: core.merge(...: {:}) -> _Merge any number of flat tables into one, allowing repeats._ -> `{:}`",
  ["kind"] = "face",
  ["sign"] = "core.merge(...: {:})  ",
  ["out"] = " `{:}`",
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
  ["args"] = "thePlan: \":\", parameters: :[nearPlace: \":\", farPlace: \":\", filling: \":\", target: \":\"?]",
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
  ["args"] = "bounds: :[xyzStart: xyz, xyzFinish: xyz]",
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
  ["args"] = "places: :[nearPlace: \":\", farPlace: \":\"]",
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
  ["out"] = " `report: \":\" &!`",
  ["sign"] = "farm.logs(seedlings: \":\"[], :direction:)  ",
  ["kind"] = "face",
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
Plots placed Returns `nplots:[fieldOp #:}, slots:[fieldOp]: #:}, strides: eP, run: eP, striding, turn: ^:, back: ^: Extents for `stride` (shorter) and `run` (longer) virtual axes for each `opName` in the `strides` entries unless `faced`.",
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
dictionary keyed by `opName` of vectors incrementing game coordinate positions",
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
  ["returns"] = " :`[fieldOpName: \":\", ranger: \":\",  firstPlot: #:?, lastPlot: #:??]`",
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
  ["args"] = "parameters: :[nearPlace: \":\", farPlace: \":\", fill: \":\", target: \":\"?]",
  ["type"] = "function",
  ["name"] = "field.fill",
  ["description"] = "\
Fill, Till, Replace.",
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
  [":paths"] = {
  ["type"] = "value",
  ["returns"] = " `{start: \":\"[], odd: \":\"[], even: \":\"[], last: \":\"[]}`",
  ["name"] = "paths",
  ["description"] = "\
Flying ox traverse of three dimensional rectangular solid",
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
  ["returns"] = " `:[xyz, xyz]`",
  ["name"] = "eP",
  ["description"] = "\
pair of coordinates for extents",
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
  [":field.plotSpan"] = {
  ["type"] = "value",
  ["returns"] = "_ :`[_:, _:, first: #:?, last: #:??]`",
  ["name"] = "field.plotSpan",
  ["description"] = "\
{}` spans all plots; if only first, default plots after first",
}
,
  ["cut"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "places: :[nearPlace: \":\", farPlace: \":\"]",
  ["type"] = "function",
  ["name"] = "field.cut",
  ["description"] = "\
Quarry out blocks from one place to the other.",
}
,
  ["fence"] = {
  ["returns"] = " `\":\"` <-\
",
  ["args"] = "parameters: :[ranger: \":\", fencing: \":\"?]",
  ["type"] = "function",
  ["name"] = "field.fence",
  ["description"] = "\
Put fencing using `layer` plan.",
}
,
  ["plot"] = {
  ["returns"] = " `report: \":\" &: &!` <-\
",
  ["args"] = "commands: field.plotSpan, fieldsOp: (:), fieldOpName: \":\", plots: #:, offset: xyz?",
  ["type"] = "function",
  ["name"] = "field.plot",
  ["description"] = "\
Plots Called by field files. Calls `fieldsOp` from field file (which calls `field.plan`).",
}
,
  [":fieldParameters"] = {
  ["type"] = "value",
  ["returns"] = " :`[bounds, fieldParameters.fills?, fieldParameters.removeables??]`",
  ["name"] = "fieldParameters",
  ["description"] = "\
bounds` (and materials to fill and replace)",
}
,
  ["till"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "parameters: :[nearPlace: \":\", farPlace: \":\", seed: \":\"]",
  ["type"] = "function",
  ["name"] = "field.till",
  ["description"] = "\
Till the seed from one place to the other.",
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
}
,
  ["returns"] = " field, _field",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "field",
  ["description"] = "\
Fields are rectangular solids defined by a range (a `situation` pair with `field` keyed properties)._ -> field, _field Fields are made up of plots, each plot at least small enough to deal with turtle inventory limitations.",
}
,
  ["_step.down:_"] = {
  ["line"] = "--:: step.down(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.down(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_planner.make:_"] = {
  ["line"] = "--:: planner.make(plan:plan) -> _Create path operations table for plan._ -> `pathElements, fuelOK: ^:, pathDistance: #:`",
  ["out"] = " `pathElements, fuelOK: ^:, pathDistance: #:`",
  ["sign"] = "planner.make(plan:plan)  ",
  ["kind"] = "face",
  ["text"] = "Create path operations table for plan.",
}
,
  ["_planner.mark:_"] = {
  ["line"] = "--:: planner.mark(markerName: \":\") -> _Parse marker name into parts._ -> `shaft: \":\"?, level: \":\"?, tag: \":\"?)`",
  ["out"] = " `shaft: \":\"?, level: \":\"?, tag: \":\"?)`",
  ["sign"] = "planner.mark(markerName: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Parse marker name into parts.",
}
,
  ["_turtle.category:_"] = {
  ["line"] = "--:: turtle.category(name: \":\") -> _Names in category or fencings matching `name` or_ `{\"minecraft:\"..name}`. -> `\":\"[]` ",
  ["kind"] = "face",
  ["sign"] = "turtle.category(name: \":\")  ",
  ["out"] = " `\":\"[]` ",
  ["text"] = "Names in category or fencings matching `name` or_ `{\"minecraft:\"..name}`.",
}
,
  ["_grid.mark:_"] = {
  ["line"] = "--:: grid.mark(:plan:, :marking:) -> _Make place name, report result._ -> `markerName: \":\", label: \":\", report: \":\"`",
  ["kind"] = "face",
  ["sign"] = "grid.mark(:plan:, :marking:)  ",
  ["out"] = " `markerName: \":\", label: \":\", report: \":\"`",
  ["text"] = "Make place name, report result.",
}
,
  ["_look_"] = {
  ["line"] = "local function look(...) --:- look direction -> _Detect and inspect direction, return report._",
  ["sign"] = "look direction  ",
  ["text"] = "Detect and inspect direction, return report.",
  ["kind"] = "cli",
}
,
  ["_come_"] = {
  ["line"] = "--:- come -> _rover turtle towards GPS player position._",
  ["sign"] = "come  ",
  ["kind"] = "cli",
  ["text"] = "rover turtle towards GPS player position.",
}
,
  ["_map.locations:_"] = {
  ["line"] = "--:: map.locations(template: :[name: \":\", offset: xyz], base: \":\", label: \":\", top: #:) -> _Add points offset from base._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "map.locations(template: :[name: \":\", offset: xyz], base: \":\", label: \":\", top: #:)  ",
  ["kind"] = "face",
  ["text"] = "Add points offset from base.",
}
,
  ["_Directions_"] = {
  ["line"] = "--:< **Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`ront_**",
  ["sign"] = "**Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`ront_** ",
  ["text"] = "Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`ront",
  ["kind"] = "word",
}
,
  ["_roam.tail:_"] = {
  ["line"] = "--:: roam.tail(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)` -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "roam.tail(:xyz:)  ",
  ["out"] = " `\":\" &:`",
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
  ["returns"] = " (`:): nil &!recovery` <-\
",
  ["args"] = ":xyzf:, situation:situation?",
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
}
,
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
  ["_test_"] = {
  ["line"] = "  --:- test name, label, x, y, z, facing, key?, value??} -> _Force mapped position, optionally feature and value for `point`._",
  ["sign"] = "test name, label, x, y, z, facing, key?, value??}  ",
  ["text"] = "Force mapped position, optionally feature and value for `point`.",
  ["kind"] = "cli",
}
,
  ["_Navigation_"] = {
  ["line"] = "--:< **Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?**",
  ["sign"] = "**Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?** ",
  ["text"] = "Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?",
  ["kind"] = "word",
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
  ["kind"] = "face",
  ["sign"] = "`_field.execute(plans: _field.plans, levels: #:, fieldings: fieldParameters, planName: \":\")`  ",
  ["out"] = " `\":\" &!`",
  ["text"] = "Run plans for the levels.",
}
,
  ["_compare_"] = {
  ["line"] = "local function compare(...) --:- compare item direction... -> _Named item matches block in any of specified directions?_",
  ["sign"] = "compare item direction...  ",
  ["text"] = "Named item matches block in any of specified directions?",
  ["kind"] = "cli",
}
,
  ["_to_"] = {
  ["line"] = "  --:- to place | x y z face?-> _To named place or position and face. Retry for different first direction._ ",
  ["sign"] = "to place | x y z face? ",
  ["kind"] = "cli",
  ["text"] = "To named place or position and face. Retry for different first direction.",
}
,
  ["_layer_"] = {
  ["line"] = "--:- layer range firstPlot? lastPlot?? -> _Put foundation material in place for field._",
  ["sign"] = "layer range firstPlot? lastPlot??  ",
  ["text"] = "Put foundation material in place for field.",
  ["kind"] = "cli",
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
  ["__gps.launch:_"] = {
  ["line"] = "  --:: `_gps.launch(commands: :[command: \":\", location: \":\", yD: #:?]) -> _Check before journey then launch._ -> \":\"",
  ["out"] = " \":\"",
  ["sign"] = "`_gps.launch(commands: :[command: \":\", location: \":\", yD: #:?])  ",
  ["kind"] = "face",
  ["text"] = "Check before journey then launch.",
}
,
  ["_field_"] = {
  ["line"] = "--:- field `quarry|layer|cover|finish|harvest|path` -> _Prepare and harvest field for farming._ ",
  ["sign"] = "field `quarry|layer|cover|finish|harvest|path`  ",
  ["text"] = "Prepare and harvest field for farming.",
  ["kind"] = "cli",
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
  ["_place.nearby:_"] = {
  ["line"] = "--:: place.nearby(:xyzf:?, :cardinals:) -> _Sorted_ -> `:[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:]",
  ["kind"] = "face",
  ["sign"] = "place.nearby(:xyzf:?, :cardinals:)  ",
  ["out"] = " `:[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:]",
  ["text"] = "Sorted",
}
,
  ["grid"] = {
  ["childs"] = {
  [":grid.guide"] = {
  ["type"] = "value",
  ["returns"] = " `:[ look: grid.cut, dig: grid.cut[], lookMore: grid.cut, digMore: grid.cut[] ]`",
  ["name"] = "grid.guide",
  ["description"] = "\
Instructions for cut",
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
  [":grid.cut"] = {
  ["type"] = "value",
  ["returns"] = " `\"up\"|\"down\"|\"north\"|\"south\"`",
  ["name"] = "grid.cut",
  ["description"] = "\
Directions to dig in vein",
}
,
  ["ores"] = {
  ["returns"] = " `\"done\" &!` <-\
",
  ["args"] = ":plan:, :direction:, guide: grid.guide, :ores:",
  ["type"] = "function",
  ["name"] = "grid.ores",
  ["description"] = "\
Extract ores. Given the guide for a vein, mine ores in each of the guide's cuts for that vein.",
}
,
  ["mark"] = {
  ["returns"] = " `markerName: \":\", label: \":\", report: \":\"` <-\
",
  ["args"] = ":plan:, :marking:",
  ["type"] = "function",
  ["name"] = "grid.mark",
  ["description"] = "\
Make place name, report result. Called by `worker.execute` to make marker name and use it to add map point for navigation in mine. Puts plan name value in marker (keyed by `\"shaft\"` or `\"bore\"`) so marker is enough for navigating in shaft or bore. Marker place name formed as `head:level:base` or `head:base` or `head` with place labelled as `\"outer\"|\"inner\"|\"shaft\"`.",
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
  ["kind"] = "cli",
  ["text"] = "Excavate ores from side tunnel near marker, return up 1 from marker.",
}
,
  ["_core.trace:_"] = {
  ["line"] = "--:: core.trace(err: any) -> _Reports traceback for xpcalls._ -> `err: any`",
  ["kind"] = "face",
  ["sign"] = "core.trace(err: any)  ",
  ["out"] = " `err: any`",
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
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.forward(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_move.left:_"] = {
  ["line"] = "--:: move.left(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.left(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
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
  ["kind"] = "face",
  ["sign"] = "place.reset()  ",
  ["out"] = " `nil`",
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
  ["_core.inext:_"] = {
  ["line"] = "--:: core.inext(table: {:}, index: #:) -> _Iterator over table beginning at index._ -> `(:), {:}, #:`",
  ["kind"] = "face",
  ["sign"] = "core.inext(table: {:}, index: #:)  ",
  ["out"] = " `(:), {:}, #:`",
  ["text"] = "Iterator over table beginning at index.",
}
,
  ["__remote.clientResult:_"] = {
  ["line"] = "  --:: `_remote.clientResult(serverID: #:, resultString: \":\", callback: (:))` -> _Apply callback to deserialized client result._ -> `any`",
  ["out"] = " `any`",
  ["sign"] = "`_remote.clientResult(serverID: #:, resultString: \":\", callback: (:))`  ",
  ["kind"] = "face",
  ["text"] = "Apply callback to deserialized client result.",
}
,
  ["__field.cut:_"] = {
  ["line"] = "  --:: `_field.cut(places: :[nearPlace: \":\", farPlace: \":\"])` -> _Use plan.quarry to cut._ -> `report: \":\" &:`",
  ["kind"] = "face",
  ["sign"] = "`_field.cut(places: :[nearPlace: \":\", farPlace: \":\"])`  ",
  ["out"] = " `report: \":\" &:`",
  ["text"] = "Use plan.quarry to cut.",
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
  ["_core.status:_"] = {
  ["line"] = "  --:: core.status(level: #:, ...: any) -> _If level less than (elimination) threshold, then report rest as string._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "core.status(level: #:, ...: any)  ",
  ["out"] = " `nil`",
  ["text"] = "If level less than (elimination) threshold, then report rest as string.",
}
,
  ["_port_"] = {
  ["line"] = "  --:- port booking -> _As provided in booking, consume player inventory to teleport entities from one area to another._",
  ["sign"] = "port booking  ",
  ["kind"] = "cli",
  ["text"] = "As provided in booking, consume player inventory to teleport entities from one area to another.",
}
,
  ["_place.xyzf:_"] = {
  ["line"] = "  --:: place.xyzf(name: \":\"?, number: #:?) -> _Looks up name [defaults to current situation]._ -> `xyzf?, index: #:?`",
  ["kind"] = "face",
  ["sign"] = "place.xyzf(name: \":\"?, number: #:?)  ",
  ["out"] = " `xyzf?, index: #:?`",
  ["text"] = "Looks up name [defaults to current situation].",
}
,
  ["_sync_"] = {
  ["line"] = "local function sync() --:- sync -> _Muse Update (MU) broadcast local map to (MQ) registered units._",
  ["sign"] = "sync  ",
  ["text"] = "Muse Update (MU) broadcast local map to (MQ) registered units.",
  ["kind"] = "cli",
}
,
  ["_move.east:_"] = {
  ["line"] = "--:: move.east(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.east(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["exec"] = {
  ["childs"] = {
  ["op"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "commandLine: :[command: \":\", ...]",
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
  ["_field.fill:_"] = {
  ["line"] = "--:: field.fill(parameters: :[nearPlace: \":\", farPlace: \":\", fill: \":\", target: \":\"?]) -> _Fill, Till, Replace._ -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "field.fill(parameters: :[nearPlace: \":\", farPlace: \":\", fill: \":\", target: \":\"?])  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Fill, Till, Replace.",
}
,
  ["_moves.along:_"] = {
  ["line"] = "--:: moves.along(name: \":\") -> _Move from first to second situation of place._ -> `code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["kind"] = "face",
  ["sign"] = "moves.along(name: \":\")  ",
  ["out"] = " `code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["text"] = "Move from first to second situation of place.",
}
,
  ["_map.write:_"] = {
  ["line"] = "function map.write(thisMap) --:: map.write(thisMap: \":\"?) -> _Delete old, write new locally. Default current._ -> `nil &!`",
  ["out"] = " `nil &!`",
  ["sign"] = "map.write(thisMap: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Delete old, write new locally. Default current.",
}
,
  ["_turtle.digTo:_"] = {
  ["line"] = "  --:: turtle.digTo(:xyzf:, limit: #:?) -> _Unblocking move._ -> `code: \":\", remaining: #:, xyzf: \":\" &: &!` ",
  ["kind"] = "face",
  ["sign"] = "turtle.digTo(:xyzf:, limit: #:?)  ",
  ["out"] = " `code: \":\", remaining: #:, xyzf: \":\" &: &!` ",
  ["text"] = "Unblocking move.",
}
,
  ["_equip_"] = {
  ["line"] = "  --:- equip direction -> _Assemble computer, modem, drive, and floppy for direction named GPS launch (for testing)._",
  ["sign"] = "equip direction  ",
  ["text"] = "Assemble computer, modem, drive, and floppy for direction named GPS launch (for testing).",
  ["kind"] = "cli",
}
,
  ["_core.state:_"] = {
  ["line"] = "  --:: core.state(table: {:}?, key: \":\"?) -> _Returns closure over closure variable_ -> `closing`",
  ["kind"] = "face",
  ["sign"] = "core.state(table: {:}?, key: \":\"?)  ",
  ["out"] = " `closing`",
  ["text"] = "Returns closure over closure variable",
}
,
  ["_place.erase:_"] = {
  ["line"] = "--::place.erase(name: \":\") -> _Removes named place from array of places._ -> `#:, index: #:`",
  ["kind"] = "face",
  ["sign"] = "place.erase(name: \":\")  ",
  ["out"] = " `#:, index: #:`",
  ["text"] = "Removes named place from array of places.",
}
,
  ["_step.back:_"] = {
  ["line"] = "--:: step.back(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.back(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_mine.op:_"] = {
  ["line"] = "--:: mine.op(arguments: :[op: \":\", placeName: \":\", borePlansFileOrLevels: \":\"|#:, shaftPlansFile: \":\"]) -> _Dig._ -> `^:, \":\", #: &:`",
  ["kind"] = "face",
  ["sign"] = "mine.op(arguments: :[op: \":\", placeName: \":\", borePlansFileOrLevels: \":\"|#:, shaftPlansFile: \":\"])  ",
  ["out"] = " `^:, \":\", #: &:`",
  ["text"] = "Dig.",
}
,
  ["_drop_"] = {
  ["line"] = "local function drop(...) --:- drop item direction quantity? -> _Drop quantity of selected items [or all]._ ",
  ["sign"] = "drop item direction quantity?  ",
  ["text"] = "Drop quantity of selected items [or all].",
  ["kind"] = "cli",
}
,
  ["_map.op:_"] = {
  ["line"] = "  --:: map.op(commands: \":\"[]}) -> _Command Line Interface_ -> `report: \":\" &:`",
  ["out"] = " `report: \":\" &:`",
  ["sign"] = "map.op(commands: \":\"[]})  ",
  ["kind"] = "face",
  ["text"] = "Command Line Interface",
}
,
  ["_field.paths:_"] = {
  ["line"] = "  --:: field.paths(bounds: xyz[]) -> _Called by plan prototype file to generate plans for plot._ -> `paths, yDelta: #:, xzEdge: facing`",
  ["kind"] = "face",
  ["sign"] = "field.paths(bounds: xyz[])  ",
  ["out"] = " `paths, yDelta: #:, xzEdge: facing`",
  ["text"] = "Called by plan prototype file to generate plans for plot.",
}
,
  ["_map.get:_"] = {
  ["line"] = "function map.get(name, key) --:: map.get(name: \":\", key: \":\") -> _Get named place local feature value for key._ -> `value: any?` &!",
  ["out"] = " `value: any?` &!",
  ["sign"] = "map.get(name: \":\", key: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Get named place local feature value for key.",
}
,
  ["_porter_"] = {
  ["line"] = "--:- porter command argument... -> _See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface._",
  ["sign"] = "porter command argument...  ",
  ["kind"] = "cli",
  ["text"] = "See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface.",
}
,
  ["_place.add:_"] = {
  ["line"] = "--:: place.add(name: \":\", :situation:) -> _Add situation to situations of an existing place._ -> `serialized: \":\", index: #:`",
  ["kind"] = "face",
  ["sign"] = "place.add(name: \":\", :situation:)  ",
  ["out"] = " `serialized: \":\", index: #:`",
  ["text"] = "Add situation to situations of an existing place.",
}
,
  ["_map.set:_"] = {
  ["line"] = "--:: map.set(name: \":\", label: \":\", x: #:, y: #:, z: #:, f: \":\") -> _Set turtle at created point -> \":\"",
  ["out"] = " \":\"",
  ["sign"] = "map.set(name: \":\", label: \":\", x: #:, y: #:, z: #:, f: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Set turtle at created point",
}
,
  ["__remote.prepareCall:_"] = {
  ["line"] = "--:: `_remote.prepareCall(server: \":\", command: \":\", arguments: any[]})` -> _Serialize server request._ -> `serverID: #:, request: \":\" &: &!`",
  ["out"] = " `serverID: #:, request: \":\" &: &!`",
  ["sign"] = "`_remote.prepareCall(server: \":\", command: \":\", arguments: any[]})`  ",
  ["kind"] = "face",
  ["text"] = "Serialize server request.",
}
,
  ["_near_"] = {
  ["line"] = "--:- near place? span?? -> _Report points within span blocks (or all) of named place (or current player or turtle position)._",
  ["sign"] = "near place? span??  ",
  ["text"] = "Report points within span blocks (or all) of named place (or current player or turtle position).",
  ["kind"] = "cli",
}
,
  ["_step.right:_"] = {
  ["line"] = "--:: step.right(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.right(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_step.south:_"] = {
  ["line"] = "--:: step.south(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.south(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
}
,
  ["_remote.come:_"] = {
  ["line"] = "  --:: remote.come(turtle: \":\") -> _Towards GPS player position._ -> `report: \":\"`",
  ["out"] = " `report: \":\"`",
  ["sign"] = "remote.come(turtle: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Towards GPS player position.",
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
Server side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come.",
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
Server (turtle) side support for_ `come` _and_ `tail`, _chained motion commands, motion to or tracing._ -> roam",
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
  ["__mine.ores:_"] = {
  ["line"] = "  --:: `_mine.ores(markerName: \":\", thisLevel: #:, borePlans: bores)` -> _Excavate ores_ -> \"done\", `\":\", #: &: &!`",
  ["kind"] = "face",
  ["sign"] = "`_mine.ores(markerName: \":\", thisLevel: #:, borePlans: bores)`  ",
  ["out"] = " \"done\", `\":\", #: &: &!`",
  ["text"] = "Excavate ores",
}
,
  ["_dig_"] = {
  ["line"] = "--:- dig direction distance hoeing... -> _Direction and distance to (possibly blocked) move, hoeings directions to hoe._",
  ["sign"] = "dig direction distance hoeing...  ",
  ["text"] = "Direction and distance to (possibly blocked) move, hoeings directions to hoe.",
  ["kind"] = "cli",
}
,
  ["moves"] = {
  ["type"] = "lib",
  ["name"] = "moves",
  ["childs"] = {
}
,
}
,
  ["_step.to:_"] = {
  ["line"] = "--:: step.to(:xyzf:, situation:situation?) -> _Step to position from (current) sItuation._ -> (`:): nil &!recovery`",
  ["kind"] = "face",
  ["sign"] = "step.to(:xyzf:, situation:situation?)  ",
  ["out"] = " (`:): nil &!recovery`",
  ["text"] = "Step to position from (current) sItuation.",
}
,
  ["task"] = {
  ["childs"] = {
  [":_task.puts"] = {
  ["type"] = "value",
  ["returns"] = " :[direction: \":\", distance: #:, puttings: \":\"[] ]`",
  ["name"] = "_task.puts",
  ["description"] = "\
Common arguments",
}
,
  ["op"] = {
  ["returns"] = " `\":\" &:` <-\
",
  ["args"] = "commands: :[ op: \":\", arguments: \":\"[] ] ",
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
  ["__field.makeBounds:_"] = {
  ["line"] = "  --:: `_field.makeBounds(nearPlace: \":\", farPlace: \":\")` -> _Get coordinate pair for named places._ -> `xyz, xyz, #:, #:`",
  ["kind"] = "face",
  ["sign"] = "`_field.makeBounds(nearPlace: \":\", farPlace: \":\")`  ",
  ["out"] = " `xyz, xyz, #:, #:`",
  ["text"] = "Get coordinate pair for named places.",
}
,
  ["_fix_"] = {
  ["line"] = "  --:- fix trail? -> _Set and report GPS turtle position for dead reckoning. Optionally begin named trailhead._",
  ["sign"] = "fix trail?  ",
  ["text"] = "Set and report GPS turtle position for dead reckoning. Optionally begin named trailhead.",
  ["kind"] = "cli",
}
,
  ["_Places_"] = {
  ["line"] = "--:< **Places - Points, Locations, Trails, and Ranges of Maps**",
  ["sign"] = "**Places - Points, Locations, Trails, and Ranges of Maps** ",
  ["text"] = "Places - Points, Locations, Trails, and Ranges of Maps",
  ["kind"] = "word",
}
,
  ["_turtle.select:_"] = {
  ["line"] = "turtle.select = mock.select --:: turtle.select(slot: #:) -> _Attempts to select the specified slot._ -> `selected: ^:`",
  ["kind"] = "face",
  ["sign"] = "turtle.select(slot: #:)  ",
  ["out"] = " `selected: ^:`",
  ["text"] = "Attempts to select the specified slot.",
}
,
  ["_planner.load:_"] = {
  ["line"] = "  --:: planner.load(planFileName: \":\") -> _Instantiates what is returned from a plan file._ -> `plan &!` ",
  ["out"] = " `plan &!` ",
  ["sign"] = "planner.load(planFileName: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Instantiates what is returned from a plan file.",
}
,
  ["_miner_"] = {
  ["line"] = "--:- miner command argument... -> _See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface._",
  ["sign"] = "miner command argument...  ",
  ["kind"] = "cli",
  ["text"] = "See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface.",
}
,
  ["_map.update:_"] = {
  ["line"] = "function map.update(serial) --:: map.update(serial: \":\") -> _Append received instantiated MU to local map file_. -> `nil &!`",
  ["out"] = " `nil &!`",
  ["sign"] = "map.update(serial: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Append received instantiated MU to local map file_.",
}
,
  ["_fence_"] = {
  ["line"] = "--:- fence range [item] -> _Put item or available wooden fence from one point to another in range._",
  ["sign"] = "fence range [item]  ",
  ["kind"] = "cli",
  ["text"] = "Put item or available wooden fence from one point to another in range.",
}
,
  ["_move.moves:_"] = {
  ["line"] = "--:: move.moves(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.moves(count: #:?)  ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["__mine.atWork:_"] = {
  ["line"] = "  --:: `_mine.atWork(:plan:, head: \":\", level: #:, key: \":\", value: any)` -> _Make, fill in, execute at level._ -> `\":\", \":\" &: &!`",
  ["kind"] = "face",
  ["sign"] = "`_mine.atWork(:plan:, head: \":\", level: #:, key: \":\", value: any)`  ",
  ["out"] = " `\":\", \":\" &: &!`",
  ["text"] = "Make, fill in, execute at level.",
}
,
  ["_path_"] = {
  ["line"] = "--:- path range firstPlot lastPlot?? -> _Test harvest path (safely)._",
  ["sign"] = "path range firstPlot lastPlot??  ",
  ["text"] = "Test harvest path (safely).",
  ["kind"] = "cli",
}
,
  ["_dds.hosts:_"] = {
  ["line"] = "  --:: dds.hosts() -> _Populates players IDs and labels using a MQ rednet protocol._ -> `IDs, roles`",
  ["out"] = " `IDs, roles`",
  ["sign"] = "dds.hosts()  ",
  ["kind"] = "face",
  ["text"] = "Populates players IDs and labels using a MQ rednet protocol.",
}
,
  ["_step.east:_"] = {
  ["line"] = "--:: step.east(count: #:?) -> _Iterator (default 1 step)_ -> `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["out"] = " `(): \"done\", remaining: #:, xyzf, direction &!recovery`",
  ["sign"] = "step.east(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Iterator (default 1 step)",
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
  ["where"] = {
  ["returns"] = " `x: #:?, y: #:?, z: #:?` <-\
",
  ["args"] = "",
  ["type"] = "function",
  ["name"] = "core.where",
  ["description"] = "\
GPS location if available.",
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
  ["findItems"] = {
  ["returns"] = " `detail?` <-\
",
  ["args"] = "targets: \":\"[]",
  ["type"] = "function",
  ["name"] = "core.findItems",
  ["description"] = "\
Selects found slot.",
}
,
  ["inext"] = {
  ["returns"] = " `(:), {:}, #:` <-\
",
  ["args"] = "table: {:}, index: #:",
  ["type"] = "function",
  ["name"] = "core.inext",
  ["description"] = "\
Iterator over table beginning at index.",
}
,
  [":bounds"] = {
  ["type"] = "value",
  ["returns"] = " :`[xyz, xyz]`",
  ["name"] = "bounds",
  ["description"] = "\
Vector pair defining a rectangular solid",
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
  ["optionals"] = {
  ["returns"] = " `string: \":\"?, number: #:?, ...: any` <-\
",
  ["args"] = "string: \":\"?, number: #:?, ...: any",
  ["type"] = "function",
  ["name"] = "core.optionals",
  ["description"] = "\
Optional number and/or string.",
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
  ["returns"] = " `{x: #:, y: #:, z: #:, facing: \":\"}`",
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
  ["returns"] = " :[x: #:, y: #:, z: #:]",
  ["name"] = "xyz",
  ["description"] = "\
Minecraft coordinates: +x: east, +y: up, +z: south",
}
,
  ["logging"] = {
  ["returns"] = " `nil` <-\
",
  ["args"] = "arguments: :[level: #:, filename: \":\"]",
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
  [":detail.damage"] = {
  ["type"] = "value",
  ["returns"] = " `#:`",
  ["name"] = "detail.damage",
  ["description"] = "\
Distinguishing value",
}
,
  ["completer"] = {
  ["returns"] = " `(:)` <-\
",
  ["args"] = "completions: {:}",
  ["type"] = "function",
  ["name"] = "core.completer",
  ["description"] = "\
Register command completions for shell",
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
  [":detail"] = {
  ["type"] = "value",
  ["returns"] = " `{name: detail.name, count: detail.count, damage: detail.damage}`",
  ["name"] = "detail",
  ["description"] = "\
Defined by Computercraft",
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
  [":detail.count"] = {
  ["type"] = "value",
  ["returns"] = " `#:`",
  ["name"] = "detail.count",
  ["description"] = "\
Available in inventory",
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
}
,
  ["returns"] = " core",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "core",
  ["description"] = "\
Strings, session state, cloning, error handling, reporting, UI, math, iterators, lowest level turtle support._ -> core",
}
,
  ["_move.west:_"] = {
  ["line"] = "--:: move.west(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.west(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
}
,
  ["_move.to:_"] = {
  ["line"] = "--:: move.to(xyzf: xyzf, first: \":\"?) -> _Current situation to x, z, y, and optionally face._ -> `\"done\", #:, xyzf &!recovery` ",
  ["kind"] = "face",
  ["sign"] = "move.to(xyzf: xyzf, first: \":\"?)  ",
  ["out"] = " `\"done\", #:, xyzf &!recovery` ",
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
  [":plan.mark"] = {
  ["type"] = "value",
  ["returns"] = " `(:plan:, :marking:): markerName: \":\", label: \":\", report: \":\"`",
  ["name"] = "plan.mark",
  ["description"] = "\
for execution as specified by_ `plan.path` _markers",
}
,
  [":markElement"] = {
  ["type"] = "value",
  ["returns"] = " `:[op: \"mark\", :marking:]`",
  ["name"] = "markElement",
  ["description"] = "\
Current situation in named places",
}
,
  [":marking"] = {
  ["type"] = "value",
  ["returns"] = " :`[prefix: \":\", base: \":\", label: \":\"]`",
  ["name"] = "marking",
  ["description"] = "\
tuple table of marker parts",
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
  ["returns"] = " :`[op: \"step\", :stepping:, direction: \":\", distance: #:]`",
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
  [":putElement"] = {
  ["type"] = "value",
  ["returns"] = " `:[op: \"put\", direction: \":\", fixture: \":\"]",
  ["name"] = "putElement",
  ["description"] = "\
Put fixture in specified direction",
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
}
,
  ["returns"] = " planner, plan, moves, steps",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "planner",
  ["description"] = "\
Given a_ `plan`, _create a table of operations to be performed by_ `worker.execute`. -> planner, plan, moves, steps",
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
  [":port.item"] = {
  ["type"] = "value",
  ["returns"] = " `\"iron\"|\"copper\"|\"gold\"|\"redstone\"`",
  ["name"] = "port.item",
  ["description"] = "\
Short inventory item name for booking",
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
  ["kind"] = "face",
  ["sign"] = "port.available(set: [port.item]: #:)  ",
  ["out"] = " `[port.item]: #:`",
  ["text"] = "For Testing: mock player inventory",
}
,
  ["_change_"] = {
  ["line"] = "    --:- change target filling direction distance putting... -> _Move distance in direction replacing target with filling._",
  ["sign"] = "change target filling direction distance putting...  ",
  ["text"] = "Move distance in direction replacing target with filling.",
  ["kind"] = "cli",
}
,
  ["_task.op:_"] = {
  ["line"] = "    --:: task.op (commands: :[ op: \":\", arguments: \":\"[] ] ) -> _Execute tasks for low level turtle operations:_ -> `\":\" &:`",
  ["out"] = " `\":\" &:`",
  ["sign"] = "task.op (commands: :[ op: \":\", arguments: \":\"[] ] )  ",
  ["kind"] = "face",
  ["text"] = "Execute tasks for low level turtle operations:",
}
,
  ["_logger_"] = {
  ["line"] = "--:- logger command argument... -> _See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface._",
  ["sign"] = "logger command argument...  ",
  ["text"] = "See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface.",
  ["kind"] = "cli",
}
,
  ["_map.puts:_"] = {
  ["line"] = "--:: map.puts(name: \":\", key: \":\", value: \":\"?) -> _Set string feature value, send MU._ -> `key: \":\", value: \":\"|true &!`",
  ["out"] = " `key: \":\", value: \":\"|true &!`",
  ["sign"] = "map.puts(name: \":\", key: \":\", value: \":\"?)  ",
  ["kind"] = "face",
  ["text"] = "Set string feature value, send MU.",
}
,
  ["turtle"] = {
  ["childs"] = {
  ["detail"] = {
  ["returns"] = " `detail`  <-\
",
  ["args"] = "slot: #:?",
  ["type"] = "function",
  ["name"] = "turtle.detail",
  ["description"] = "\
Detail of selected or specified slot.",
}
,
  [":turtle.drops"] = {
  ["type"] = "value",
  ["returns"] = " `[:direction:]: (count: #:?): ^:, \":\"?`",
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
  ["returns"] = " `[:direction:]: (): ^:, \":\"?`",
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
  ["returns"] = " `[:direction:]: (): same: ^:`",
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
Retrys (default 5) dig to limit or bedrock. Returns \"done, \"undug\" if dig attempt was for air, water, or lava. Raises error for bedrock or dig limit reached.",
}
,
  [":turtle.sucks"] = {
  ["type"] = "value",
  ["returns"] = " `[:direction:]: (count: #:?): ^:, \":\"?`",
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
Four compass points and verticals",
}
,
  ["digTo"] = {
  ["returns"] = " `code: \":\", remaining: #:, xyzf: \":\" &: &!`  <-\
",
  ["args"] = ":xyzf:, limit: #:?",
  ["type"] = "function",
  ["name"] = "turtle.digTo",
  ["description"] = "\
Unblocking move. Try to move to position, dig to unblock if needed, catch (table) and raise error(string) for \"lost\" or \"empty\". Also catch and raise error (string) if attempt to dig to unblock failed for bedrock or other reason. Normally return just what a successful move would: \"done\", 0 remaining, current position.",
}
,
  ["digAround"] = {
  ["returns"] = " `\"done\" &: &!` <-\
",
  ["args"] = "orientation: \":\", name: \":\", diggings: \":\"[]",
  ["type"] = "function",
  ["name"] = "turtle.digAround",
  ["description"] = "\
Unblocking dig. Dig (unblocking) in diggings directions, catch failure and raise error(string) re-orienting in original orientation.",
}
,
  [":turtle.detects"] = {
  ["type"] = "value",
  ["returns"] = " `[:direction:]: (): ^:`",
  ["name"] = "turtle.detects",
  ["description"] = "\
Check block in direction is solid: not air, mob, liquid or floater.",
}
,
  ["item"] = {
  ["returns"] = " `nil | detail` <-\
",
  ["args"] = "slot: #:?",
  ["type"] = "function",
  ["name"] = "turtle.item",
  ["description"] = "\
Detail of specified or currently selected slot.",
}
,
  ["block"] = {
  ["returns"] = "  `blocked: ^:` <-\
",
  ["args"] = "blocked: ^:",
  ["type"] = "function",
  ["name"] = "turtle.block",
  ["description"] = "\
Out-of-game debug: sets blocking for simulating turtle being blocked.",
}
,
  ["check"] = {
  ["returns"] = " ``matched: ^:` <-\
",
  ["args"] = "targets: \":\"[], :detail:",
  ["type"] = "function",
  ["name"] = "turtle.check",
  ["description"] = "\
Tries to match each target against_ `detail.name`.",
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
  [":turtle.inspects"] = {
  ["type"] = "value",
  ["returns"] = " `[:direction:]: (): `^:`, `detail?`",
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
Total energy actually available in turtle slots plus turtle fuel level.",
}
,
  ["select"] = {
  ["returns"] = " `selected: ^:` <-\
",
  ["args"] = "slot: #:",
  ["type"] = "function",
  ["name"] = "turtle.select",
  ["description"] = "\
Attempts to select the specified slot.",
}
,
  [":turtle.puts"] = {
  ["type"] = "value",
  ["returns"] = " `[:direction:]: (text: \":\"?): ^:, \":\"?`",
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
  [":group"] = {
  ["type"] = "value",
  ["returns"] = " `\"fuel\" | \"ore\"| \"fill\" | \"dirt\" | \"stone\" | \"fence\" | \"test\"`",
  ["name"] = "group",
  ["description"] = "\
Materials",
}
,
  [":turtle.digs"] = {
  ["type"] = "value",
  ["returns"] = " `[:direction:]: (side: \":\"?): ^:, \":\"?`",
  ["name"] = "turtle.digs",
  ["description"] = "\
Try to dig block in direction and call_ suck().",
}
,
  ["find"] = {
  ["returns"] = " `detail?` <-\
",
  ["args"] = "targets: \":\"[]",
  ["type"] = "function",
  ["name"] = "turtle.find",
  ["description"] = "\
Selects found slot.",
}
,
  ["blocking"] = {
  ["returns"] = " `^:` <-\
",
  ["args"] = "^:",
  ["type"] = "function",
  ["name"] = "turtle.blocking",
  ["description"] = "\
Isolate global to control blocking for out-of-game debug.",
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
  [" remote"] = {
  ["type"] = "lib",
  ["name"] = " remote",
  ["childs"] = {
}
,
}
,
  ["_field.plot:_"] = {
  ["line"] = "--:: field.plot(commands: field.plotSpan, fieldsOp: (:), fieldOpName: \":\", plots: #:, offset: xyz?) -> _Plots_ -> `report: \":\" &: &!`",
  ["kind"] = "face",
  ["sign"] = "field.plot(commands: field.plotSpan, fieldsOp: (:), fieldOpName: \":\", plots: #:, offset: xyz?)  ",
  ["out"] = " `report: \":\" &: &!`",
  ["text"] = "Plots",
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
Return serialized result_.",
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
  ["args"] = "serverID: #:, resultString: \":\", callback: (:)",
  ["type"] = "function",
  ["name"] = "_remote.clientResult",
  ["description"] = "\
Apply callback to deserialized client result.",
}
,
  ["prepareCall"] = {
  ["returns"] = " `serverID: #:, request: \":\" &: &!` <-\
",
  ["args"] = "server: \":\", command: \":\", arguments: any[]}",
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
  ["_status_"] = {
  ["line"] = "--:- status level [filename] -> _Set reporting hurdle and optionally save reporting in log file._",
  ["sign"] = "status level [filename]  ",
  ["text"] = "Set reporting hurdle and optionally save reporting in log file.",
  ["kind"] = "cli",
}
,
  ["_Filling_"] = {
  ["line"] = "--:< _Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:` ",
  ["sign"] = "_Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:`  ",
  ["kind"] = "word",
  ["text"] = "Filling and target may be one of the turtle categories or a Minecraft detail name without prefix_ `minecraft:",
}
,
  ["_core.setComputerLabel:_"] = {
  ["line"] = "--:: core.setComputerLabel(label: \":\") -> _Sets (out-of game global) label_ -> `label: \":\"`",
  ["kind"] = "face",
  ["sign"] = "core.setComputerLabel(label: \":\")  ",
  ["out"] = " `label: \":\"`",
  ["text"] = "Sets (out-of game global) label",
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
 If both the span and name or position are specified, return places within a span of blocks of the named place or position. If only the span is specified, return places within a span of blocks of the current situation or player position. If neither is specified return each of the named places. In any case, iterator returns include serialized places.",
}
,
  ["xyzf"] = {
  ["returns"] = " `xyzf?, index: #:?` <-\
",
  ["args"] = "name: \":\"?, number: #:?",
  ["type"] = "function",
  ["name"] = "place.xyzf",
  ["description"] = "\
Looks up name [defaults to current situation].",
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
  ["returns"] = " `name: \":\"?, label: \":\"?, situations`? <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.track",
  ["description"] = "\
Returns trail",
}
,
  ["nearby"] = {
  ["returns"] = " `:[distance: #:, name: \":\", label: \":\", cardinal: \":\", :xyzf:] <-\
",
  ["args"] = ":xyzf:?, :cardinals:",
  ["type"] = "function",
  ["name"] = "place.nearby",
  ["description"] = "\
Sorted",
}
,
  ["match"] = {
  ["returns"] = " `index: #:?, place?` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.match",
  ["description"] = "\
Lookup place qualified by site, return_ `nil` _if not found.",
}
,
  ["add"] = {
  ["returns"] = " `serialized: \":\", index: #:` <-\
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
Make or update place. Include current situation or optionally supplied situation in places. Optionally update features with key = value. Return index of situation in global places and the serialized situation including its features.",
}
,
  ["erase"] = {
  ["returns"] = " `#:, index: #:` <-\
",
  ["args"] = "name: \":\"",
  ["type"] = "function",
  ["name"] = "place.erase",
  ["description"] = "\
Removes named place from array of places. Return new length of places table and the (previous) index of the removed place.",
}
,
}
,
}
,
  ["_move.south:_"] = {
  ["line"] = "--:: move.south(count: #:?) -> _Count 0: just turn, 1: default_ ->  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["out"] = "  `\"done\", remaining: #:, xyzf, direction &!recovery` ",
  ["sign"] = "move.south(count: #:?)  ",
  ["kind"] = "face",
  ["text"] = "Count 0: just turn, 1: default",
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
  ["__gps.actuate:_"] = {
  ["line"] = "  --:: `_gps.actuate(commands: :[command: \":\", direction: facing]) -> _Move to boot a GPS host and retrieve floppy._ -> \":\"",
  ["out"] = " \":\"",
  ["sign"] = "`_gps.actuate(commands: :[command: \":\", direction: facing])  ",
  ["kind"] = "face",
  ["text"] = "Move to boot a GPS host and retrieve floppy.",
}
,
  ["_core.getComputerLabel:_"] = {
  ["line"] = "--:: core.getComputerLabel(label: \":\"?) -> _Out of game returns label; label ignored in game._ -> `label: \":\"`",
  ["kind"] = "face",
  ["sign"] = "core.getComputerLabel(label: \":\"?)  ",
  ["out"] = " `label: \":\"`",
  ["text"] = "Out of game returns label; label ignored in game.",
}
,
  ["_move.set:_"] = {
  ["line"] = "  --:: move.set(x: #:, y: #:, z: #:, f: facing?, fuel: #:??, level: \":\"???) -> _Set position, optionally rest of situation._ -> `nil`",
  ["kind"] = "face",
  ["sign"] = "move.set(x: #:, y: #:, z: #:, f: facing?, fuel: #:??, level: \":\"???)  ",
  ["out"] = " `nil`",
  ["text"] = "Set position, optionally rest of situation.",
}
,
  ["_range_"] = {
  ["line"] = "  --:- range name label point point key? value?? -> _Volume by named points, optional key and value for feature._ ",
  ["sign"] = "range name label point point key? value??  ",
  ["text"] = "Volume by named points, optional key and value for feature.",
  ["kind"] = "cli",
}
,
  ["_at_"] = {
  ["line"] = "  --:- at -> _Report current (dead reckoning) turtle position and facing or player GPS position._ ",
  ["sign"] = "at  ",
  ["text"] = "Report current (dead reckoning) turtle position and facing or player GPS position.",
  ["kind"] = "cli",
}
,
  ["_move.clones:_"] = {
  ["line"] = "--:: move.clones() -> _Deep copy `_G.Muse.situations`._ ->  situations",
  ["kind"] = "face",
  ["sign"] = "move.clones()  ",
  ["out"] = "  situations",
  ["text"] = "Deep copy `_G.Muse.situations`.",
}
,
  ["_field.till:_"] = {
  ["line"] = "--:: field.till(parameters: :[nearPlace: \":\", farPlace: \":\", seed: \":\"]) -> _Till the seed from one place to the other._ -> `\":\" &:`",
  ["kind"] = "face",
  ["sign"] = "field.till(parameters: :[nearPlace: \":\", farPlace: \":\", seed: \":\"])  ",
  ["out"] = " `\":\" &:`",
  ["text"] = "Till the seed from one place to the other.",
}
,
  ["_book_"] = {
  ["line"] = "  --:- book name label from to span? item??... ->  _Spanned range with (default) items as properties; return cost less bank._",
  ["sign"] = "book name label from to span? item??...  ",
  ["kind"] = "cli",
  ["text"] = "Spanned range with (default) items as properties; return cost less bank.",
}
,
  ["_move.at:_"] = {
  ["line"] = "--:: move.at(:situation:?) -> _(Current) situation xyzf._ -> `xyzf`",
  ["kind"] = "face",
  ["sign"] = "move.at(:situation:?)  ",
  ["out"] = " `xyzf`",
  ["text"] = "(Current) situation xyzf.",
}
,
  ["_move.track:_"] = {
  ["line"] = "--:: move.track(enable: ^:) -> _Set tracking condition_ -> `enable: ^:`",
  ["kind"] = "face",
  ["sign"] = "move.track(enable: ^:)  ",
  ["out"] = " `enable: ^:`",
  ["text"] = "Set tracking condition",
}
,
  ["_turtle.block:_"] = {
  ["line"] = "--:: turtle.block(blocked: ^:) -> _Out-of-game debug: sets blocking for simulating turtle being blocked._ ->  `blocked: ^:`",
  ["kind"] = "face",
  ["sign"] = "turtle.block(blocked: ^:)  ",
  ["out"] = "  `blocked: ^:`",
  ["text"] = "Out-of-game debug: sets blocking for simulating turtle being blocked.",
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
  ["_post_"] = {
  ["line"] = "  --:- post marker borePlans?  -> _Go to marker (and up 1) from current level with saved or specified plans._",
  ["sign"] = "post marker borePlans?   ",
  ["kind"] = "cli",
  ["text"] = "Go to marker (and up 1) from current level with saved or specified plans.",
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
  ["_where_"] = {
  ["line"] = "  --:- where place? count?? -> _Report movement direction, distance to named place (or all) three (or count) closest places._ ",
  ["sign"] = "where place? count??  ",
  ["text"] = "Report movement direction, distance to named place (or all) three (or count) closest places.",
  ["kind"] = "cli",
}
,
  ["_moves.to:_"] = {
  ["line"] = "--:: moves.to(target: \":\", first: \":\") -> _Move to target, first along direction._ -> `code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["kind"] = "face",
  ["sign"] = "moves.to(target: \":\", first: \":\")  ",
  ["out"] = " `code: \":\", remaining: #:, xyzf: \":\" &! recovery`",
  ["text"] = "Move to target, first along direction.",
}
,
  ["_farmer_"] = {
  ["line"] = "--:- farmer command argument... -> _See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface._",
  ["sign"] = "farmer command argument...  ",
  ["text"] = "See [muse/docs/lib/net.html](../lib/net.html) for the remote command line interface.",
  ["kind"] = "cli",
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
  ["_tail_"] = {
  ["line"] = "--:- tail rate? -> _Move `rover` every rate (default 5) seconds towards GPS player position._",
  ["sign"] = "tail rate?  ",
  ["text"] = "Move `rover` every rate (default 5) seconds towards GPS player position.",
  ["kind"] = "cli",
}
,
  ["_headings_"] = {
  ["line"] = "  --:- headings rate? place? count?? -> _Repeated movement report at specified rate (or every five) seconds)._",
  ["sign"] = "headings rate? place? count??  ",
  ["text"] = "Repeated movement report at specified rate (or every five) seconds).",
  ["kind"] = "cli",
}
,
  ["_move.get:_"] = {
  ["line"] = "  --:: move.get(:situation:?) -> _Default current situation._ -> `x: #:, y: #:, z: #:, facing: \":\", fuel: #:, level: \":\"`",
  ["kind"] = "face",
  ["sign"] = "move.get(:situation:?)  ",
  ["out"] = " `x: #:, y: #:, z: #:, facing: \":\", fuel: #:, level: \":\"`",
  ["text"] = "Default current situation.",
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
  ["_core.vectorPairs:_"] = {
  ["line"] = "  --:: core.vectorPairs(start: bounds, addend: xyz, number: #:, partial: bounds?) -> _Make plots._ -> `bounds[]`",
  ["kind"] = "face",
  ["sign"] = "core.vectorPairs(start: bounds, addend: xyz, number: #:, partial: bounds?)  ",
  ["out"] = " `bounds[]`",
  ["text"] = "Make plots.",
}
,
  ["_worker.execute:_"] = {
  ["line"] = "--:: worker.execute(plan, pathOperations, fuelOK: ^:, pathDistance: #:) -> _Do plan._ ->  `\"done\", report: \":\" &: &!`",
  ["out"] = "  `\"done\", report: \":\" &: &!`",
  ["sign"] = "worker.execute(plan, pathOperations, fuelOK: ^:, pathDistance: #:)  ",
  ["kind"] = "face",
  ["text"] = "Do plan.",
}
,
  ["_core.record:_"] = {
  ["line"] = "  --:: core.record(message: \":\") -> _Appends (status) message to log file on player._ -> `nil & !`",
  ["kind"] = "face",
  ["sign"] = "core.record(message: \":\")  ",
  ["out"] = " `nil & !`",
  ["text"] = "Appends (status) message to log file on player.",
}
,
  ["_turtle.item:_"] = {
  ["line"] = "turtle.item = mock.getItemDetail --:: turtle.item(slot: #:?) ->  _Detail of specified or currently selected slot._ -> `nil | detail`",
  ["kind"] = "face",
  ["sign"] = "turtle.item(slot: #:?)  ",
  ["out"] = " `nil | detail`",
  ["text"] = "Detail of specified or currently selected slot.",
}
,
  ["_launch_"] = {
  ["line"] = "  --:- launch place yD? -> _Deploy GPS launch yD or maximum y above place, report GPS at place._",
  ["sign"] = "launch place yD?  ",
  ["text"] = "Deploy GPS launch yD or maximum y above place, report GPS at place.",
  ["kind"] = "cli",
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
  ["_bore_"] = {
  ["line"] = "  --:- bore marker borePlans  -> _Dig horizontally from marker using saved or specified bore and shaft plans._ ",
  ["sign"] = "bore marker borePlans   ",
  ["kind"] = "cli",
  ["text"] = "Dig horizontally from marker using saved or specified bore and shaft plans.",
}
,
  ["_cut_"] = {
  ["line"] = "--:- cut point point -> _Quarry out blocks bound by named points (defining a rectangular solid)._",
  ["sign"] = "cut point point  ",
  ["kind"] = "cli",
  ["text"] = "Quarry out blocks bound by named points (defining a rectangular solid).",
}
,
  ["_move.clone:_"] = {
  ["line"] = "--:: move.clone() -> _Clone current situation_ -> situation",
  ["kind"] = "face",
  ["sign"] = "move.clone()  ",
  ["out"] = " situation",
  ["text"] = "Clone current situation",
}
,
  ["_move.ats:_"] = {
  ["line"] = "--:: move.ats(:situation:?) -> _(Current) situation position and facing string (`\"\"` in game if not turtle)._ -> `xyzf: \":\"`",
  ["kind"] = "face",
  ["sign"] = "move.ats(:situation:?)  ",
  ["out"] = " `xyzf: \":\"`",
  ["text"] = "(Current) situation position and facing string (`\"\"` in game if not turtle).",
}
,
  ["_farm.plant:_"] = {
  ["line"] = "function farm.plant(planting) --:: farm.plant(planting: \":\") -> _Tills and plants found planting._ -> `report: \":\" &!` ",
  ["out"] = " `report: \":\" &!` ",
  ["sign"] = "farm.plant(planting: \":\")  ",
  ["kind"] = "face",
  ["text"] = "Tills and plants found planting.",
}
,
  ["_remote.call:_"] = {
  ["line"] = "  --:: remote.call(server: \":\", command: \":\", arguments: any[], callback: (:)?) -> _RPC:_ -> `any &: &!`",
  ["out"] = " `any &: &!`",
  ["sign"] = "remote.call(server: \":\", command: \":\", arguments: any[], callback: (:)?)  ",
  ["kind"] = "face",
  ["text"] = "RPC:",
}
,
  ["_map.put:_"] = {
  ["line"] = "  --:: map.put(name: \":\", key: \":\", value: any?) -> _Set named place feature, send MU._ ->  `key: \":\"?, value: any|true|nil &!`",
  ["out"] = "  `key: \":\"?, value: any|true|nil &!`",
  ["sign"] = "map.put(name: \":\", key: \":\", value: any?)  ",
  ["kind"] = "face",
  ["text"] = "Set named place feature, send MU.",
}
,
  ["_shaft_"] = {
  ["line"] = "  --:- shaft minehead levels shaftPlans -> _Dig down number of levels under named minehead place using specified plans._",
  ["sign"] = "shaft minehead levels shaftPlans  ",
  ["kind"] = "cli",
  ["text"] = "Dig down number of levels under named minehead place using specified plans.",
}
,
  ["__remote.serverRequest:_"] = {
  ["line"] = "  --:: `_remote.serverRequest(clientID: #:, request: \":\")` -> _Return serialized result_. -> `result: \":\"`",
  ["out"] = " `result: \":\"`",
  ["sign"] = "`_remote.serverRequest(clientID: #:, request: \":\")`  ",
  ["kind"] = "face",
  ["text"] = "Return serialized result_.",
}
,
  ["_remote.wait:_"] = {
  ["line"] = "--:: remote.wait() -> _Setup turtle to repeatedly wait for MC network requests, send MR results._ -> `nil`",
  ["out"] = " `nil`",
  ["sign"] = "remote.wait()  ",
  ["kind"] = "face",
  ["text"] = "Setup turtle to repeatedly wait for MC network requests, send MR results.",
}
,
  ["_locate_"] = {
  ["line"] = "  --:- locate name label? -> _Create launch point having Minecraft coordinates above `porter`._",
  ["sign"] = "locate name label?  ",
  ["kind"] = "cli",
  ["text"] = "Create launch point having Minecraft coordinates above `porter`.",
}
,
}
