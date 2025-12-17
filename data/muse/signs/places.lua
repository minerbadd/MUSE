---@meta

local  places, place, moves, steps = {}, {}, {}, {}

-- features:  `[key: ":"]: any`
---@alias features {[ string]: any} # Dictionary of string key, any value pairs


-- place:  `{name: ":", label: ":", :situations:, :features:}`
---@alias place  {name: string, label: string, :situations:, :features:} # A point, trail, or range


-- cardinals:  (dx: #:, dz: #:): cardinal: ":"
---@alias cardinals fun(dx: number,  dz: number):  cardinal: string # Function to get one of the eight cardinal points of the compass


-- Makes two places. Trail places share a label and represent trails from head to tail and tail to head; head set by_ `place.fix`.
-- place.trail(headName: ":", tailName: ":", label: ":"):  `headSerial: ":", tailSerial: ":"` <-
---@type fun(headName: string,  tailName: string,  label: string):  headSerial: string,  tailSerial: string 
function place.trail() end

-- Resets places to the empty table.
-- place.reset():  `nil` <-
---@type fun():  nil 
function place.reset() end

-- Looks up name [defaults to current situation].
-- place.xyzf(name: ":"?, number: #:?):  `xyzf?, index: #:?` <-
---@type fun(name: string?,  number: number?):  xyzf?,  index: number? 
function place.xyzf() end

--  If both span and name (or a position) are specified, return places within a span of blocks of the named place (or position). If only the span is specified, return places within a span of blocks of the current situation or player position. If neither is specified return each of the named places. In any case, iterator returns include serialized places.
-- place.near(span: #:?, reference?: ":"|position):  (): `name: ":", label: ":", xyz, distance: #:, situations, serial: ":"` <-
---@type fun(span: number?,  reference?: string|position): fun():  name: string,  label: string,  xyz,  distance: number,  situations,  serial: string 
function place.near() end

-- Manhattan: abs(delta x) + abs(delta y) + abs(delta z).
-- place.distance(a: xyzf, b: xyzf):  `distance: #:` <-
---@type fun(a: xyzf,  b: xyzf):  distance: number 
function place.distance() end

-- Returns number of places.
-- place.count():  `#:` <-
---@type fun():  number 
function place.count() end

-- Returns trail
-- place.track(name: ":"):  `name: ":"?, label: ":"?, situations`? <-
---@type fun(name: string):  name: string?,  label: string?,  situations? 
function place.track() end

-- Set or return local `site` (isolates global).
-- place.site(value: ":"?):  `":"` <-
---@type fun(value: string?):  string 
function place.site() end

-- Lookup place qualified by site, return_ `nil` _if not found.
-- place.match(name: ":"):  `index: #:?, place?` <-
---@type fun(name: string):  index: number?,  place? 
function place.match() end

-- Return already sited name, otherwise prepend site to name
-- place.qualify(name: ":"):  `sitedName: ":"` <-
---@type fun(name: string):  sitedName: string 
function place.qualify() end

-- Add situation to situations of an existing place.
-- place.add(name: ":", :situation:):  `serialized: ":", index: #:` <-
---@type fun(name: string,  situation: situation):  serialized: string,  index: number 
function place.add() end

-- Sorted
-- place.nearby(:xyzf:?, :cardinals:):  `:[distance: #:, name: ":", label: ":", cardinal: ":", :xyzf:] <-
---@type fun(xyzf: xyzf?,  cardinals: cardinals):  : [number, string, string, string, xyzf]
function place.nearby() end

-- Sets situation position, can start tracking for trail.
-- place.fix(:xyzf:, track: ^:?):  `xyzf`   <-
---@type fun(xyzf: xyzf,  track: boolean?):  xyzf   
function place.fix() end

-- Make or update place. Include current situation or optionally supplied situation in places. Optionally update features with key = value. Return index of situation in global places and the serialized situation including its features.
-- place.name(name: ":", label: ":", supplied: situation?, :features:??):  `":", #:` <-
---@type fun(name: string,  label: string,  supplied: situation?,  features: features?):  string,  number 
function place.name() end

-- Removes named place from array of places. Return new length of places table and the (previous) index of the removed place.
-- place.erase(name: ":"):  `#:, index: #:` <-
---@type fun(name: string):  number,  index: number 
function place.erase() end
return { places =  places, place = place, moves = moves, steps = steps}
