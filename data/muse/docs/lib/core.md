--:! {core: []: (:)} <- **Core Functions Library** -> muse/docs/lib/core.md    
--:| core: _Strings, session state, cloning, error handling, reporting, UI, math, iterators, lowest level turtle support._ -> core  

--:# **Managing state: clone table, generate closure for session (non-persistent) state, cache loads**  

--:: core.clone(source: {:}|any) -> _Deep copy source table or return source if not table._ -> `{:}|any`  

--:> closing: _Returns value or sets it and optional table entry to non `nil` `value`._  -> `(value: any): value: any`  

--:: core.state(table: {:}?, key: ":"?) -> _Returns closure over closure variable_ -> `closing`  

--:# **Table Utilities: merging tables and finding common items in a pair of tables**  

--:: core.merge(...: {:}) -> _Merge any number of flat tables into one, allowing repeats._ -> `{:}`  

--:: core.match(tableA: any[], tableB: any[]) -> _Find first matching item in pair of item tables._ -> `nil` | `any`  

--:# **Making Strings: both instantiable strings and simple single quoted strings for printing**  

--:: core.serialize(input: any) -> _Executable string to instantiate input._ -> `"return "..":" &!`  

--:: core.string(...: any) -> _Makes string from any inputs, simplifies single entry tables._ -> `":"`  

--:: core.xyzf(:xyzf:) -> _Returns specially formatted string for `xyzf`._ -> `":"`  

--:> xyzf: _Position and facing as table_ -> `{x: #:, y: #:, z: #:, facing: ":"}`  

--:# **Handling errors and reporting operations**  

--:: core.pass(ok: ^:, ...: any) -> _Pass input but report string if not ok._ -> ok: `true|false, result: ...|":", any?`  

--:: core.where() -> _GPS location if available._ -> `x: #:?, y: #:?, z: #:?`  

--:# **Logging and Quit Control Globals**  

--:- quit message -> _Set `quit` flag to message; next `core.status` throws `error` to abort operations._  

--:> core.log: _Closure variable_ -> `{level: closing, file: closing, handle: closing}`  

--:: core.status(level: #:, ...: any) -> _If level less than (elimination) threshold, then report rest as string._ -> `nil`    
--:+ _If player, status report is printed and potentially logged. Otherwise sent to player using Muse Status (MS) protocol._    
--:+ _If for in-game turtle with GPS and the dead reckoning and GPS disagree, include that in report._  

--:: core.report(level: #:, ...: any) -> _If level less than `status` threshold, report `rest` as string._ -> `nil`  

--:: core.logging(arguments: :[level: #:, filename: ":"]) -> _Set threshold level [and local log file] for status reports_ -> `nil`  

--:: core.record(message: ":") -> _Appends (status) message to log file on player._ -> `nil & !`  

--:: core.trace(err: any) -> _Reports traceback for xpcalls._ -> `err: any`  

--:# **User interface utilities**  

--:: core.completer(completions: {:}) -> _Register command completions for shell_ -> `(:)`  

--:: core.echo(...: any) -> _For testing; just returns its arguments._ -> ...: `any`  

--:- echo arguments ... -> _For testing: just returns its arguments._  

--:: core.optionals(string: ":"?, number: #:?, ...: any) -> _Optional number and/or string._ -> `string: ":"?, number: #:?, ...: any`  

--:# **Math utilities**  

--:: core.vectorPairs(start: bounds, addend: xyz, number: #:, partial: bounds?) -> _Make plots._ -> `bounds[]`    
--:+ _Addend is used to create a vector pair to be added cumulatively beginning with start bounds for result._    
--:+ _The number n is the number of bounds in result where each bound is offset by addend from the prior bounds._    
--:+ _Optionally the partial bounds are included as the first bounds in the result._  

--:> bounds: _Vector pair defining a rectangular solid_ -> :`[xyz, xyz]`  

--:> xyz: _Minecraft coordinates: +x: east, +y: up, +z: south_ -> :[x: #:, y: #:, z: #:]  

--:: core.orient(vectors: xyzMap, face: ":"?, rotate: ":"??) -> _Three dimensional rotation_ -> `xyzMap`    
--:+ _Turn from up north to face, default for no face is to rotate -90 degrees._  

--:> xyzMap: _Table of vectors either an array or dictionary_ -> `xyz[] | [core.faces]: xyz`  

--:> core.faces: _Key for composed function dictionary_ -> "north"|"south"|"east"|"west"|"up"|"down"|"rotate"  

--:: core.round(n: #:) -> _Next integer down if below half fraction_ -> `#:`  

--:# **Example iterator, restartable at index**  

--:: core.inext(table: {:}, index: #:) -> _Iterator over table beginning at index._ -> `(:), {:}, #:`  

--:# **Lowest level turtle and mock turtle support used by several libraries including lib/motion**  

--:: core.findItems(targets: ":"[]) -> _Selects found slot._ -> `detail?`  

--:> detail: _Defined by Computercraft_ -> `{name: detail.name, count: detail.count, damage: detail.damage}`  

--:> detail.name: _Prepended by the mod name `"minecraft:"`._ -> `":"`  

--:> detail.count: _Available in inventory_ -> `#:`  

--:> detail.damage: _Distinguishing value_ -> `#:`  

--:: core.sleep(#:?) -> _Mocks sleep as null operation out of game._ -> `nil`  

--:: core.getComputerID(id: #:?) -> _Out of game returns id; id ignored in game._ -> `id: #:`  

--:: core.getComputerLabel(label: ":"?) -> _Out of game returns label; label ignored in game._ -> `label: ":"`  

--:: core.setComputerLabel(label: ":") -> _Sets (out-of game global) label_ -> `label: ":"`  