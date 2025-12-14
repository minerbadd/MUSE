---@meta

local  core = {}

-- Merge any number of flat tables into one, allowing repeats.
-- core.merge(...: {:}):  `{:}` <-
---@type fun(...: table):  table 
function core.merge() end

-- GPS location if available.
-- core.where():  `x: #:?, y: #:?, z: #:?` <-
---@type fun():  x: number?,  y: number?,  z: number? 
function core.where() end

-- Returns specially formatted string for `xyzf`.
-- core.xyzf(:xyzf:):  `":"` <-
---@type fun(xyzf: xyzf):  string 
function core.xyzf() end

-- Selects found slot.
-- core.findItems(targets: ":"[]):  `detail?` <-
---@type fun(targets: string[]):  detail? 
function core.findItems() end

-- Find first matching item in pair of item tables.
-- core.match(tableA: any[], tableB: any[]):  `nil` | `any` <-
---@type fun(tableA: any[],  tableB: any[]):  nil | any 
function core.match() end

-- bounds:  :`[xyz, xyz]`
---@alias bounds [xyz, xyz] # Vector pair defining a rectangular solid


-- detail.name:  `":"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias detail.name  string # Prepended by the mod name `"minecraft:"`.


-- Optional number and/or string.
-- core.optionals(string: ":"?, number: #:?, ...: any):  `string: ":"?, number: #:?, ...: any` <-
---@type fun(string: string?,  number: number?,  ...: any):  string: string?,  number: number?,  ...: any 
function core.optionals() end

-- Appends (status) message to log file on player.
-- core.record(message: ":"):  `nil & !` <-
---@type fun(message: string):  nil 
function core.record() end

-- Sets (out-of game global) label
-- core.setComputerLabel(label: ":"):  `label: ":"` <-
---@type fun(label: string):  label: string 
function core.setComputerLabel() end

-- Three dimensional rotation Turn from up north to face, default for no face is to rotate -90 degrees.
-- core.orient(vectors: xyzMap, face: ":"?, rotate: ":"??):  `xyzMap` <-
---@type fun(vectors: xyzMap,  face: string?,  rotate: string?):  xyzMap 
function core.orient() end

-- Reports traceback for xpcalls.
-- core.trace(err: any):  `err: any` <-
---@type fun(err: any):  err: any 
function core.trace() end

-- Returns closure over closure variable
-- core.state(table: {:}?, key: ":"?):  `closing` <-
---@type fun(table: table?,  key: string?):  closing 
function core.state() end

-- Mocks sleep as null operation out of game.
-- core.sleep(#:?):  `nil` <-
---@type fun(number?):  nil 
function core.sleep() end

-- xyzf:  `{x: #:, y: #:, z: #:, facing: ":"}`
---@alias xyzf {x: number,  y: number,  z: number,  facing: string} # Position and facing as table


-- Out of game returns id; id ignored in game.
-- core.getComputerID(id: #:?):  `id: #:` <-
---@type fun(id: number?):  id: number 
function core.getComputerID() end

-- closing:  `(value: any): value: any`
---@alias closing fun(value: any):  value: any # Returns value or sets it and optional table entry to non `nil` `value`.


-- If level less than `status` threshold, report `rest` as string.
-- core.report(level: #:, ...: any):  `nil` <-
---@type fun(level: number,  ...: any):  nil 
function core.report() end

-- xyz:  :[x: #:, y: #:, z: #:]
---@alias xyz [number, number, number] # Minecraft coordinates: +x: east, +y: up, +z: south


-- Pass input but report string if not ok.
-- core.pass(ok: ^:, ...: any):  ok: `true|false, result: ...|":", any?` <-
---@type fun(ok: boolean,  ...: any):  ok: true|false,  result: ...|string,  any? 
function core.pass() end

-- core.log:  `{level: closing, file: closing, handle: closing}`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias core.log {level: closing,  file: closing,  handle: closing} # Closure variable


-- xyzMap:  `xyz[] | [core.faces]: xyz`
---@alias xyzMap  xyz[] # Table of vectors either an array or dictionary


-- For testing; just returns its arguments.
-- core.echo(...: any):  ...: `any` <-
---@type fun(...: any):  ...: any 
function core.echo() end

-- Set threshold level [and local log file] for status reports
-- core.logging(arguments: :[level: #:, filename: ":"]):  `nil` <-
---@type fun(arguments: [number, string]):  nil 
function core.logging() end

-- Iterator over table beginning at index.
-- core.inext(table: {:}, index: #:):  `(:), {:}, #:` <-
---@type fun(table: table,  index: number):  function,  table,  number 
function core.inext() end

-- Deep copy source table or return source if not table.
-- core.clone(source: {:}|any):  `{:}|any` <-
---@type fun(source: table|any):  table|any 
function core.clone() end

-- detail.damage:  `#:`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias detail.damage  number # Distinguishing value


-- Register command completions for shell
-- core.completer(completions: {:}):  `(:)` <-
---@type fun(completions: table):  function 
function core.completer() end

-- If level less than (elimination) threshold, then report rest as string. If player, status report is printed and potentially logged. Otherwise sent to player using Muse Status (MS) protocol. If for in-game turtle with GPS and the dead reckoning and GPS disagree, include that in report.
-- core.status(level: #:, ...: any):  `nil` <-
---@type fun(level: number,  ...: any):  nil 
function core.status() end

-- detail:  `{name: detail.name, count: detail.count, damage: detail.damage}`
---@alias detail {name: detail.name,  count: detail.count,  damage: detail.damage} # Defined by Computercraft


-- Makes string from any inputs, simplifies single entry tables.
-- core.string(...: any):  `":"` <-
---@type fun(...: any):  string 
function core.string() end

-- Out of game returns label; label ignored in game.
-- core.getComputerLabel(label: ":"?):  `label: ":"` <-
---@type fun(label: string?):  label: string 
function core.getComputerLabel() end

-- Executable string to instantiate input.
-- core.serialize(input: any):  `"return "..":" &!` <-
---@type fun(input: any):  "return "..string 
function core.serialize() end

-- core.faces:  "north"|"south"|"east"|"west"|"up"|"down"|"rotate"
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias core.faces  "north"|"south"|"east"|"west"|"up"|"down"|"rotate" # Key for composed function dictionary


-- Iterator for permutations of array
-- core.permute(array: any[]):  `(:)` <-
---@type fun(array: any[]):  function 
function core.permute() end

-- detail.count:  `#:`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias detail.count  number # Available in inventory


-- Next integer down if below half fraction
-- core.round(n: #:):  `#:` <-
---@type fun(n: number):  number 
function core.round() end

-- Make plots. Addend is used to create a vector pair to be added cumulatively beginning with start bounds for result. The number n is the number of bounds in result where each bound is offset by addend from the prior bounds. Optionally the partial bounds are included as the first bounds in the result.
-- core.vectorPairs(start: bounds, addend: xyz, number: #:, partial: bounds?):  `bounds[]` <-
---@type fun(start: bounds,  addend: xyz,  number: number,  partial: bounds?):  bounds[]
function core.vectorPairs() end
return { core =  core}
