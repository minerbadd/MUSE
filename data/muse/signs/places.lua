---@meta

local  places, place, moves, steps = {}, {}, {}, {}

-- features:  `[key: ":"]: any`
---@alias features { [ string]: any } # Dictionary of string key, any value pairs


-- place:  `[name: ":", label: ":", :situations:, :features:]`
---@alias place [  string,   string,   situations,   features] # A point, trail, or range


-- cardinals:  (dx: #:, dz: #:): cardinal: ":"
---@alias cardinals fun( dx: number,  dz: number):   cardinal: string # Function to get one of the eight cardinal points of the compass


-- Makes two places. Trail places share a label and represent trails from head to tail and tail to head; head set by_ `place.fix`.
-- place.trail(headName: ":", tailName: ":", label: ":"):  `headSerial: ":", tailSerial: ":", count: #:` <-

---@type fun( headName: string,  tailName: string,  label: string):   headSerial: string,  tailSerial: string,  count: number 
function place.trail() end

-- Resets places to the empty table.
-- place.reset():  `nil` <-

---@type fun():  nil 
function place.reset() end

-- Looks up index in name [defaults to current situation].
-- place.xyzf(name: ":"?, index: #:?):  `xyzf?, order: #:?` <-

---@type fun( name: string?,  index: number?):   xyzf?,  order: number? 
function place.xyzf() end

--  If both span and name (or a position) are specified, return places within a span of blocks of the named place (or position). If only the span is specified, return places within a span of blocks of the current situation or player position. If neither is specified return each of the named places. In any case, iterator returns include serialized places.
-- place.near(span: #:?, reference?:":"|[x:#:,y:#:,z:#:]):  (): `name: ":", label: ":", xyz, distance: #:, situations, serial: ":"` <-

---@type fun( span: number?,  reference?:string | [ number, number, number]):  fun():  name: string,  label: string,  xyz,  distance: number,  situations,  serial: string 
function place.near() end

-- Returns number of places.
-- place.count():  `#:` <-

---@type fun():  number 
function place.count() end

-- Sets situation position, can start tracking for trail.
-- place.fix(:xyzf:, track: ^:?):  `xyzf`   <-

---@type fun( xyzf: xyzf,  track: boolean?):   xyzf   
function place.fix() end

-- Returns trail
-- place.track(name: ":"):  `name: ":"?, label: ":"?, :situations:?` <-

---@type fun( name: string):   name: string?,  label: string?,  situations: situations? 
function place.track() end

-- Set or return local `site` (isolates global).
-- place.site(value: ":"?):  `":"` <-

---@type fun( value: string?):   string 
function place.site() end

-- Lookup place qualified by site, return_ `nil` _if not found.
-- place.match(name: ":"):  `order: #:?, place: place?` <-

---@type fun( name: string):   order: number?,  place: place? 
function place.match() end

-- Return already sited name, otherwise prepend site to name
-- place.qualify(name: ":"):  `sitedName: ":"` <-

---@type fun( name: string):   sitedName: string 
function place.qualify() end

-- Add situation to situations of an existing place.
-- place.add(name: ":", :situation:):  `serialized: ":"?, order: #:?` <-

---@type fun( name: string,  situation: situation):   serialized: string?,  order: number? 
function place.add() end

-- Sorted
-- place.nearby(:xyzf:?, :cardinals:):  `[distance: #:, name: ":", label: ":", cardinal: ":", :xyzf:]` <-

---@type fun( xyzf: xyzf?,  cardinals: cardinals):  [  number,   string,   string,   string,   xyzf]
function place.nearby() end

-- Manhattan: abs(delta x) + abs(delta y) + abs(delta z).
-- place.distance(a: xyzf, b: xyzf):  `distance: #:` <-

---@type fun( a: xyzf,  b: xyzf):   distance: number 
function place.distance() end

-- Make or update place. Include current situation or optionally supplied situation in places. Optionally update features with key = value. Return order of situation in global places and the serialized situation including its features.
-- place.name(name: ":", label: ":", supplied: situation?, :features:??):  `":", #:` <-

---@type fun( name: string,  label: string,  supplied: situation?,  features: features?):   string,  number 
function place.name() end

-- Removes named place from array of places. Return new length of places table and the (previous) order of the removed place.
-- place.erase(name: ":"):  `#:, order: #:?` <-

---@type fun( name: string):   number,  order: number? 
function place.erase() end

-- Move to target, first along direction.
-- moves.to(target: ":", first: ":"?):  `code: ":", remaining: #:, xyzf: ":" &!recovery` <-

---@type fun( target: string,  first: string?):   code: string,  remaining: number,  xyzf: string 
function moves.to() end

-- Move from first to second situation of place. If the named place is the head of a trail, go from there to its tail. If it's a tail of a trail, go to its head.
-- moves.along(name: ":"):  `code: ":", remaining: #:, xyzf: ":" &!recovery` <-

---@type fun( name: string):   code: string,  remaining: number,  xyzf: string 
function moves.along() end

-- Step (iterator) to target place.
-- steps.to(target: ":"):  `(): code: ":", remaining: #:, xyzf: ":" &!recovery` <-

---@type fun( target: string):  fun():  code: string,  remaining: number,  xyzf: string 
function steps.to() end

-- Iterator: first to next situation of place. If the named place is the head of a trail, step from there to its tail. If it's a tail of a trail, step to its head.
-- steps.along(name: ":"):  `(): code: ":", remaining: #:, xyzf: ":" &!recovery` <-

---@type fun( name: string):  fun():  code: string,  remaining: number,  xyzf: string 
function steps.along() end
return { places =  places, place = place, moves = moves, steps = steps}
