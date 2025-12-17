--:! [move: [":"]: (:), step: [":"]: (:) ] <- **Move and Step Function Libraries** -> muse/docs/lib/motion.md      
--:| motion: _Libraries to move turtles and move turtles by steps allowing operations at each step._ -> motion, move, step    
--:+ move: **Position setting, tracking, and reporting by dead reckoning checked by fuel consumption.**      
--:+ step: **Iterators (closures) for moving block by block, potentially doing operations at each block.**  

--:# _Provide fuel level check to validate a dead reckoning move, can track movement for retracing move as a trail._      
--:+ _Report error conditions `"blocked"`, `"lost"` (for apparent but invalid movement), `"empty"` (for no fuel)._      
--:+ _Throw some errors as tables rather than strings to allow for attempted recovery operations._   

--:# **State variables for turtle motion:** (maintained across programs within session, not persistent beyond that).  

--:> situation: _Dead reckoning_ -> `{position:position, facing:facing, fuel: situation.fuel, level: situation.level}`  

--:> situation.fuel: _Simulated fuel level checked against reported fuel to validate dead reckoning_ -> `#:`  

--:> situation.level: _For tracking_ -> `"same"|"rise"|"fall"`  

--:> position: _Computercraft co-ordinates (+x east, +y up, +z south)_ -> `{x: #:, y: #:, z: #:}`  

--:> facing: _For movement in four NESW cardinal directions_ -> `"north"|"east"|"south"|"west"`   

--:> situations: _Tracking history_ -> `situation[]`  

--:## **Some Utilities: position reporting and setting:**  

--:: move.get(:situation:?) -> _Default current situation._ -> `x: #:, y: #:, z: #:, facing: ":", fuel: #:, level: ":"`  

--:: move.track(enable: ^:) -> _Set tracking condition_ -> `enable: ^:`  

--:: move.set(x: #:, y: #:, z: #:, f: facing?, fuel: #:??, level: ":"???) -> _Set position, optionally rest of situation._ -> `nil`  

--:: move.situations(:situations:) -> _Set `_G.Muse.situations` to situations._ -> situations  

--:: move.clone() -> _Clone current situation_ -> situation  

--:: move.clones() -> _Deep copy `_G.Muse.situations`._ ->  situations  

--:: move.at(:situation:?) -> _(Current) situation xyzf._ -> `xyzf`  

--:: move.ats(:situation:?) -> _(Current) situation position and facing string (`""` in game if not turtle)._ -> `xyzf: ":"`  

--:: move.where(tx: #:?, ty: #:?, tz: #:?, tf: ":"?) -> _Returns GPS results if available._ -> `x: #:, y: #:, z: #:, facing: ":", ^: ok`    
--:+ _If no GPS, returns the optional (testing) parameters or, if not supplied, current dead reckoning position in situation._  

--:> recovery: _For some errors_ -> `{call: ":", failure: ":", cause: ":", remaining: #:, :xyzf:, :direction:, operation: ":"}`  

--:# **Forward! Up! Down! move, step ... again (raising errors, providing for recovery)**  

--:# **Tracking Movement: completing movement**  

--:# **Exposed APIs for move functions: turn left|right or face cardinal if needed, then repeat count forward**  

--:: move.moves(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.left(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.right(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.north(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.east(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.south(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.west(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.up(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.down(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.forward(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:: move.back(count: #:?) -> _Count 0: just turn, 1: default_ ->  `"done", remaining: #:, xyzf, direction &!recovery`   

--:# **Exposed APIs for step functions: turn or face direction if needed then step count forward in that direction**   

--:: step.steps(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:> stepping: _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.left(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.right(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.north(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.east(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.south(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.left(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.up(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.down(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.forward(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:: step.back(count: #:?) -> _Iterator (default 1 step)_ -> `(): "done", remaining: #:, xyzf, direction &!recovery`  

--:# **Move or Step to target xyzf position**  

--:: move.to(xyzf: xyzf, first: ":"?) -> _Current situation to x, z, y, and optionally face._ -> `"done", #:, xyzf &!recovery`     
--:+ _Optional argument_ `first` _is "x", "y", or "z" to select first move in that direction to deal with blockages._  

--:: step.to(:xyzf:, situation:situation?) -> _Step to position from (current) sItuation._ -> (`:): nil &!recovery`    
--:+ _Iterate first in x direction to completion, then z, and finally y. Once complete, each iterator is exhausted._    
--:+ _Finally turn to face if supplied. Returned iterator returns_ `nil` _when iterators for all directions are exhausted._  