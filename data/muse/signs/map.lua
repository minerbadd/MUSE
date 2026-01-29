---@meta

local  map = {}

-- Get named place local feature value for key.
-- map.get(name: ":", key: ":"):  `value: any? &!` <-

---@type fun( name: string,  key: string):   value: any? 
function map.get() end

-- Add points offset from base. Add labelled points using template names and offsets from named base point or top for y-axis.
-- map.locations(template: {name: ":", offset: xyz}, base: ":", label: ":", top: #:):  `nil` <-

---@type fun( template: { name: string,  offset: xyz},  base: string,  label: string,  top: number):   nil 
function map.locations() end

-- Delete old, write new locally. Default current.
-- map.write(thisMap: ":"?):  `nil &!` <-

---@type fun( thisMap: string?):   nil 
function map.write() end

-- Set turtle at created point
-- map.set(name: ":", label: ":", x: #:, y: #:, z: #:, f: ":"):  ":", #: <-

---@type fun( name: string,  label: string,  x: number,  y: number,  z: number,  f: string):   string,  number 
function map.set() end

-- Reinstantiate places from map file.
-- map.read(thisMap: ":"):  `index: #: &!` <-

---@type fun( thisMap: string):   index: number 
function map.read() end

-- Create, send point update.
-- map.point(name: ":", label: ":", :xyzf:):  `nil & !` <-

---@type fun( name: string,  label: string,  xyzf: xyzf):   nil 
function map.point() end

-- Set named place feature, send MU.
-- map.put(name: ":", key: ":", value: any?):   `key: ":"?, value: any|true|nil &!` <-

---@type fun( name: string,  key: string,  value: any?):    key: string?,  value: any | true | nil 
function map.put() end

-- Instantiate string as named place, include in named places.
-- map.place(placeString: ":"):  `serial: ":"?, index: #:? &!` <-

---@type fun( placeString: string):   serial: string?,  index: number? 
function map.place() end

-- Command Line Interface
-- map.op(commands: ":"[]):  `report: ":" &:` <-

---@type fun( commands: string[]):   report: string 
function map.op() end

-- Find orientation using position changes for non-zero movement.
-- map.testFacing(dx: #:, dz: #:):  `facing: ":" & !` <-

---@type fun( dx: number,  dz: number):   facing: string 
function map.testFacing() end

-- Less generic retrieval interface: gets string feature value.
-- map.gets(name: ":", key: ":"):  `":"?` <-

---@type fun( name: string,  key: string):   string? 
function map.gets() end

-- Set string feature value, send MU.
-- map.puts(name: ":", key: ":", value: ":"?):  `key: ":", value: ":"|true &!` <-

---@type fun( name: string,  key: string,  value: string?):   key: string,  value: string | true 
function map.puts() end

-- Get range elements
-- map.borders(target: ":"):  `borders, features, position, position &!` <-

---@type fun( target: string):   borders,  features,  position,  position 
function map.borders() end

-- borders:  {east: #:, west: #:, north: #:, south: #:, top: #:, bottom: #:}
---@alias borders { east: number,  west: number,  north: number,  south: number,  top: number,  bottom: number} # Range boundarires


-- Append received instantiated MU to local map file_.
-- map.update(serial: ":"):  `nil &!` <-

---@type fun( serial: string):   nil 
function map.update() end

-- Remove named place, overwrite local map file
-- map.erase(name: ":"):  `remaining: #:` <-

---@type fun( name: string):   remaining: number 
function map.erase() end
return { map =  map}
