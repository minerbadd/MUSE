---@meta

local  motion, move, step = {}, {}, {}

-- situations:  `situation[]`
---@alias situations  situation[] # Tracking history


-- facing:  `"north"|"east"|"south"|"west"` 
---@alias facing  "north" | "east" | "south" | "west"  # For movement in four NESW cardinal directions


-- stepping:  `(): "done", remaining: #:, xyzf, direction &!recovery`
---@alias stepping fun(): "done"  remaining: number  xyzf  direction  # Iterator (default 1 step)


-- situation.level:  `"same"|"rise"|"fall"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias situation.level  "same" | "rise" | "fall" # For tracking


-- recovery:  `[call: ":", failure: ":", cause: ":", remaining: #:, :xyzf:, :direction:, operation: ":"]`
---@alias recovery [  string,   string,   string,   number,   xyzf,   direction,   string] # For some errors


-- situation:  `{:position:, :facing:, fuel: situation.fuel, level: situation.level}`
---@alias situation { position: position,  facing: facing,  fuel: situation.fuel,  level: situation.level} # Dead reckoning


-- situation.fuel:  `#:`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias situation.fuel  number # Simulated fuel level checked against reported fuel to validate dead reckoning


-- position:  `{x: #:, y: #:, z: #:}`
---@alias position { x: number,  y: number,  z: number} # Computercraft co-ordinates (+x east, +y up, +z south)


-- Count 0: just turn, 1: default
-- move.right(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.right() end

-- Current situation to x, z, y, and optionally face. Optional argument_ `first` _is "x", "y", or "z" to select first move in that direction to deal with blockages.
-- move.to(xyzf: xyzf, first: ":"?):  `"done", #:, xyzf &!recovery`  <-

---@type fun( xyzf: xyzf,  first: string?):   "done"  number  xyzf 
function move.to() end

-- Set `_G.Muse.situations` to situations.
-- move.situations(:situations:):  situations <-

---@type fun( situations: situations):   situations 
function move.situations() end

-- Count 0: just turn, 1: default
-- move.east(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.east() end

-- Count 0: just turn, 1: default
-- move.down(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.down() end

-- Set tracking condition
-- move.track(enable: ^:):  `enable: ^:` <-

---@type fun( enable: boolean):   enable: boolean 
function move.track() end

-- Count 0: just turn, 1: default
-- move.left(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.left() end

-- Count 0: just turn, 1: default
-- move.back(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.back() end

-- Count 0: just turn, 1: default
-- move.forward(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.forward() end

-- Count 0: just turn, 1: default
-- move.north(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.north() end

-- Deep copy `_G.Muse.situations`.
-- move.clones():   situations <-

---@type fun():  situations 
function move.clones() end

-- (Current) situation xyzf.
-- move.at(:situation:?):  `xyzf` <-

---@type fun( situation: situation?):   xyzf 
function move.at() end

-- (Current) situation position and facing string (`""` in game if not turtle).
-- move.ats(:situation:?):  `xyzf: ":"` <-

---@type fun( situation: situation?):   xyzf: string 
function move.ats() end

-- Count 0: just turn, 1: default
-- move.up(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.up() end

-- Count 0: just turn, 1: default
-- move.west(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.west() end

-- Returns GPS results if available. If no GPS, returns the optional (testing) parameters or, if not supplied, current dead reckoning position in situation.
-- move.where(tx: #:?, ty: #:?, tz: #:?, tf: ":"?):  `x: #:, y: #:, z: #:, facing: ":", ^: ok` <-

---@type fun( tx: number?,  ty: number?,  tz: number?,  tf: string?):   x: number  y: number  z: number  facing: string  boolean ok 
function move.where() end

-- Count 0: just turn, 1: default
-- move.moves(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.moves() end

-- Count 0: just turn, 1: default
-- move.south(count: #:?):   `"done", remaining: #:, xyzf, direction &!recovery`  <-

---@type fun( count: number?):    "done"  remaining: number  xyzf  direction 
function move.south() end

-- Set position, optionally rest of situation.
-- move.set(x: #:, y: #:, z: #:, f: facing?, fuel: #:??, level: ":"???):  `nil` <-

---@type fun( x: number,  y: number,  z: number,  f: facing?,  fuel: number?,  level: string?):   nil 
function move.set() end

-- Clone current situation
-- move.clone():  situation <-

---@type fun(): situation 
function move.clone() end

-- Default current situation.
-- move.get(:situation:?):  `x: #:, y: #:, z: #:, facing: ":", fuel: #:, level: ":"` <-

---@type fun( situation: situation?):   x: number  y: number  z: number  facing: string  fuel: number  level: string 
function move.get() end

-- Iterator (default 1 step)
-- step.right(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.right() end

-- Step to position from (current) sItuation. Iterate first in x direction to completion, then z, and finally y. Once complete, each iterator is exhausted. Finally turn to face if supplied. Returned iterator returns_ `nil` _when iterators for all directions are exhausted.
-- step.to(:xyzf:, situation:situation?):  `(): nil &!recovery` <-

---@type fun( xyzf: xyzf,  situation:situation?):  fun(): nil 
function step.to() end

-- Iterator (default 1 step)
-- step.south(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.south() end

-- Iterator (default 1 step)
-- step.east(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.east() end

-- Iterator (default 1 step)
-- step.down(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.down() end

-- Iterator (default 1 step)
-- step.steps(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.steps() end

-- Iterator (default 1 step)
-- step.left(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.left() end

-- Iterator (default 1 step)
-- step.back(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.back() end

-- Iterator (default 1 step)
-- step.forward(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.forward() end

-- Iterator (default 1 step)
-- step.north(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.north() end

-- Iterator (default 1 step)
-- step.up(count: #:?):  `(): "done", remaining: #:, xyzf, direction &!recovery` <-

---@type fun( count: number?):  fun(): "done"  remaining: number  xyzf  direction 
function step.up() end
return { motion =  motion, move = move, step = step}
