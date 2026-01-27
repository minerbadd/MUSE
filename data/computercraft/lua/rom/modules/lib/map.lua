--[[
## Persistence, Errors, and CLL for `place`: `lib/map` 
```md
--:! {map: [":"] (): } <- **Map Command Line Library** -> muse/docs/lib/map.md  
--:| map: _Orientation and position reporting, broadcast and persistence of places_ -> map
``` 
The `map` library continues the development of `place`, introduced by <a href="places.html" target="_blank"> `lib/places`</a>.
It's MUSE's other major representation of state (after `situations`). A `place` can be a `point`, a `range`, or a `trail`, all built on by `lib/map` using `place` data structures. We've come across trails before in <a href="places.html#trail" target="_blank"> `lib/places`</a>. 
To review, they are named (and labelled) `situations` created by `tracking` in the <a href="motion.html#tracking" target="_blank"> `lib/motion` </a>library. A `range` is a named (and labeled) `point` pair delimiting a rectangular solid. A `point` is a named (and labelled) single entry table whose single element is a `situation`. The names of places are used for lookup. The labels are just user supplied supplementary information. 

To ease understanding, the module introduction for `map` shown below is organized in much the same way as described for <a href="motion.html"> `lib/motion`</a>. 

What's new in `lib/map` are network operations and the use of 
<a href="https://en.wikipedia.org/wiki/Daemon_(computing)" target="_blank">
_daemons_</a> to deal with network events. You may have already run across the 
<a href="code/daemons/.status.html" target="_blank"> `.status` </a> daemon handling the `MS` (MUSE Statue) rednet protocol. The 
<a href="code/daemons/.update.html" target="_blank"> `.update` </a> daemon handling the `MU` (MUSE Update) rednet protocol, and the
<a href="code/daemons/.erase.html" target="_blank"> `.erase` </a> daemon handling the `MX` (MUSE eXcise) rednet protocol look
much the same, easing testing by quickly passing control to a library to do the real work. There'll be more of this throughout our discussions of how MUSE programs are implemented.

There's a bunch of <a href="#programs" target="_blank"> programs </a> that provide the command line user interface. Look at one or two of them briefly to see that there's so very little there there.

```Lua
--]]
local map = {}; map.hints = {} ---@module "signs.map" -- for functions exported from library

local cores = require("core"); local core = cores.core ---@module "signs.core"
local moves = require("motion"); local move = moves.move ---@module "signs.motion"
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.dds"
local places = require("places"); local place = places.place ---@module "signs.places"

local rednet, player, turtle = _G.rednet, _G.pocket, _G.turtle -- references to ComputerCraft libraries

local siteFile = _G.Muse.data.."site.txt" -- The `_G.Muse.data` directory is local to each ComputerCraft computer.

function map.map(value) _G.Muse.map = value or _G.Muse.map; return  _G.Muse.map end -- isolate global
function map.charts(value) _G.Muse.charts = value or _G.Muse.charts return _G.Muse.charts end -- isolate global
--[[
```
<a id="place"></a> 
Places are persistent: saved to disk storage and deserialized for each session from that storage. The player's and each turtle's places are stored on that player's or turtle's local storage as independent, distributed copies. 

The `map.place` function deserializes a place from a <a href="core.html#serialize" target="_blank"> serialized </a> representation of the table. It calls <a href="places.html#name" target="_blank"> `place.name`</a> to include the deserialized place in the table of known places and to return the serialized representation together with an index into the table of know places. Lua does most of the work. All that's left to do is to look for errors.
```Lua
--]]
--:# **File and Broadcast Operations for points, trails, and ranges (including features)**
function map.place(placeString) -- restores place using string from serialization
  --:: map.place(placeString: ":") -> _Instantiate string as named place, include in named places._ -> `serial: ":", index: #: &!`
  local restorePlace, fail = load(placeString); -- try to restore if place not `nil` or empty
  if fail or not restorePlace then error("map.place: "..placeString.." failed") end
  local thisPlace = restorePlace(); if thisPlace and #thisPlace > 0 then 
    local name, label, situations, features = table.unpack(thisPlace) 
    return place.name(name, label, situations, features) 
  end 
end
--[[
```
<a id="read"></a> 
The `map.read` and `map.write` functions do the actual disk operations. There's a lot of defensive error checking.
```Lua
--]]
function map.read(thisMap) -- reinstantiate places; if no map file, create an empty one
  --:: map.read(thisMap: ":") -> _Reinstantiate places from map file._ -> `serial: ":", index: #: &!`
  if not io.open(thisMap, "r") then io.open(thisMap, "w"):close(); assert(io.open(thisMap, "r")) end
  place.reset(); for line in io.lines(thisMap) do map.place(line) end    
  return place.count() 
end

function map.write(thisMap) --:: map.write(thisMap: ":"?) -> _Delete old, write new locally. Default current._ -> `nil &!`
  thisMap = thisMap or map.map(); if not thisMap then error("map.write: No map file established") end 
  local removeMap, removeReport = io.open(thisMap, "w"):close() -- old places file may include erased places
  if not removeMap then error("map.write: Can't remove obsolete "..thisMap.."because"..removeReport) end
  local createMap, createReport = io.open(thisMap, "a") --write places file cleaned by read
  if not createMap then error("map.write: Can't create new "..thisMap.."because"..createReport) end
  
  -- TODO: alternatively collect entries in a table and write the table as "w" in one go
  for _, _, _, _, _, placeString in place.near() do -- write out all named places
    local appendMap, appendReport = createMap:write(placeString, "\n") 
    if not appendMap then error("map.write: Can't update "..thisMap.." because "..appendReport) end
  end

  local closeMap, closeReport = io.close(createMap) -- close and report
  if not closeMap then error("map.write: Can't close "..thisMap.." because "..closeReport) end
  core.report(1, tostring(place.count()).." places in "..thisMap) 
end
--[[
```
<a id="sited"></a> 
For when the player or an unlanded turtle, one not ever to be tied to a site, is in a new and far far better place.
```Lua
--]]
local function sited(site) 
  --:- site name? -> _Remote operation to report or change site (persistently) after, e.g., porting `rover`._
  if not site then return place.site() end -- just report
  local siteFileHandle = assert(io.open(siteFile, "w"), "map.sited: can't write "..siteFile)
  siteFileHandle:write(place.site(site).."\n"); siteFileHandle:close()
  return place.site(site) 
end; map.hints["site"] = {["?name"] = {} }

local function store(site) -- used in `.start` to persist `site` and load clean map
  -- :: store(site: ":") -> _Persists `site` in local store and loads local map._ -> `report: ":"`
  local siteFile = io.open(siteFile, "r"); if not siteFile then sited(site) end
  if not map.map() then map.map(_G.Muse.map) end
  local places = map.read(map.map()); map.write(map.map());
  return site..": "..places.." places"
end; map.hints["store"] = {["?site"] = {} } 
--[[
```
<a id="update"></a> 
Calling the local `update` function does the update locally and broadcasts it on the `MU` protocol to the `player`, the `porter` and all turtles registered by `join`, a command issued by the player to site a landed turtle that has not yet been landed. (We'll get to the implementation of `dds.join` when we discuss `lib/remote`.) The network broadcast is used to keep distributed memory and distributed storage in sync across the network using the <a href="../daemons/.update.html" target="_blank"> `.update`</a>
daemon. The <a href="https://en.wikipedia.org/wiki/Daemon_(computing)" target="_blank">
_daemon_</a> responds to received network messages by calling `map.place` (above) to update the local memory and `map.update` (below) to update local storage. 
```Lua
--]]
local function join(site, role) sited(site); return dds.join(role) end -- dds.join qualifies role for landed turtle
--:- join site role -> _Set site and join landed turtle to it with specified role._
 map.hints["join"] = {["?site "] = {["?role"] = {} }} 
 
local function update(serial) -- update locally, broadcasts to others (not self)
  map.update(serial); if rednet then rednet.broadcast(serial, "MU") end -- rednet only available in-game
end

function map.update(serial) --:: map.update(serial: ":") -> _Append received instantiated MU to local map file_. -> `nil &!`
  local thisMap = map.map(); if not thisMap then error("map.update: No map file established") 
  end; local file, openReport = io.open(thisMap, "a") -- map exists, open for append
  if not file then error("map.update: Can't open "..thisMap.. " to add place ".. openReport) end
  local appendOK, appendReport = file:write(serial, "\n") -- **do it**
  core.status(4, "map update:", place.count(), "places") 
  if not appendOK then error("map.update: Failed for "..thisMap.." "..appendReport) end
end
--[[
```
<a id="sync"></a> 
Using the <a href="places.html#near" target="_blank"> `place.near`</a>
iterator, the local `sync` function `MU` broadcasts all the places known by the local computer to all `MQ` registered computers. The function yields control between each broadcast to allow each broadcast to complete.
```Lua
--]]
--:# **Map File Operations**
local function sync() --:- sync -> _Muse Update (MU) broadcast local map to (MQ) registered units._
  if rednet then for name, _, _, index, situations, serial in place.near() do 
    core.status(4, "map", "sync", name, #situations, index)
    rednet.broadcast(serial, "MU"); os.sleep(0) -- need to yield for each broadcast!
  end; return tostring(place.count()).." places" end 
end
--[[
```
<a id="erase"></a> 
The `erase` operation works much like `update`. The daemon for erase is, not surprisingly, <a href="../daemons/.erase.html" target="_blank"> `.erase` </a>. 
```Lua
--]]
local function erase(name) --:- erase name -> _Remove named place, broadcast Muse eXcise (MX)._
  --:# **Referenced through `map.op` for CLI dispatch**
  if not name then error("map.erase: Missing place name") end
  local placesRemaining = map.erase(name) -- handle local erase (below)
  if rednet then rednet.broadcast(name, "MX") end -- to erase distributed copies
  return tostring(placesRemaining).." remaining places."
end; map.hints["erase"] = {["?placename"] = {}} 

function map.erase(name) local remaining = place.erase(name); map.write(); return remaining end -- handle local erase
--:: map.erase(name: ":") -> _Remove named place, overwrite local map file_ -> `remaining: #:`
--[[
```
<a id="get"></a>  
Places include a <a href="places.html#name" target="_blank"> dictionary of name-value pairs</a> we've called features. 
This is a way to allow other libraries to add attributes to places without needing to make changes to the implementation of `lib/places`. This sort of thing helps maintenance as the code base evolves to deal with new requirements. That's especially important for a network of computers each having their own version of persistent data structures. That said, names of features (feature keys) are unrestricted. There's no explicit protection against unintended clashes. Rope provided. Invent some naming protocol and use with care. 
```Lua
--]]
function map.get(name, key) --:: map.get(name: ":", key: ":") -> _Get named place local feature value for key._ -> `value: any? &!`
  local index, namedPlace = place.match(name); if not index then return nil end
  assert(namedPlace, "map.get: can't get features for unknown place "..name) 
  local _, _, _, features = table.unpack(namedPlace); assert(features, "map.get: no features for "..name)
  return features[key]
end

map.gets = map.get --:: map.gets(name: ":", key: ":") -> _Less generic retrieval interface: gets string feature value._ -> `":"?`

function map.put(name, key, value)  
  --:: map.put(name: ":", key: ":", value: any?) -> _Set named place feature, send MU._ ->  `key: ":"?, value: any|true|nil &!`
  local index, namedPlace = place.match(name); if not index then return nil end
---@diagnostic disable-next-line: param-type-mismatch
  local _, label, situations, features = table.unpack(namedPlace); features[key] = value or true;
  local serial = place.name(name, label, situations, features); update(serial) -- all MU correspondents
  core.status(4, "map put", place.qualify(name), key, value); return key, value or true
end
map.puts = map.put 
--:: map.puts(name: ":", key: ":", value: ":"?) -> _Set string feature value, send MU._ -> `key: ":", value: ":"|true &!`
--[[
```
The `map.gets` and `map.puts` interfaces above (defined for code analysis) share implementations with their more generic interfaces. If that's wanted.

<a id="facing"> </a> 
The `getFacing` function finds the direction the turtle is facing by looking for changes in its GPS location after moving it forward or backward in the `x` or `z` coordinates. There's an extended ternary operator construction to sort this out. The `backward` `movement` table has reversed directions so the same function can be used for both forward and backward movement.

Exporting `map.testFacing` provides a testing interface that does not depend on GPS or networking.
```Lua
--]]
--:# **Report direction turtle is facing (requires GPS in game)**
local forward, backward = {"east", "west", "south", "north"}, {"west", "east", "north", "south"}

local function getFacing (dx, dz, movement) -- `movement` is `forward` or `backward` 
  local ew, we, sn, ns = table.unpack(movement) 
  local facing = 
  (dx > 0 and ew or 
    (dx < 0 and we or -- neither west or east
      (dz > 0 and sn or 
        (dz < 0 and ns or "none")))) -- "none" means no movement: blocked
  if facing ~= "none" then return facing end
  error("map.getFacing: Failed"..tostring(dx).." "..tostring(dz))
end

--:: map.testFacing(dx: #:, dz: #:) -> _Find orientation using position changes for non-zero movement._ -> `facing: ":" & !`
map.testFacing = getFacing -- exported for out-of-game testing

local function xzChange(ax, az, tx, ty, tz) -- t* for out-game debug
  local bx, _, bz, _, ok = move.where(tx, ty, tz); if ok then return bx - ax, bz - az end
  error("map.xzChange: GPS failed")
end
--[[
```
<a id="changes"></a> 
Looking for `changes` in turtle position involves a lot of potential failures to move the turtle. All these failures are funneled through calls to <a href="core.html#pass" target="_blank"> `core.pass`</a>
so a breakpoint can be placed there to look at error conditions before they are otherwise handled. The `core.pass` function catches exceptions thrown by callers and, recursively, their callers <a href="https://en.wikipedia.org/wiki/
Turtles__all__the__way__down" target="_blank"> all the way down</a>. Caught errors are thrown here with information useful for knowing turtle position. A (really clumsy) alternative might be for all those callers to return (and return and return) an error code to indicate a problem. For a small number of levels of callers this might work but as the call depths increase, maintainability gets tricky, quickly. 
```Lua
--]]
local function facingForward(x, y, z) -- distance forward then move back to original position
  -- local advance = {north = {0,0,-1}, east = {1,0,0}, south = {0,0,1}, west = {-1,0,0}}
  -- advancing east: positive dx; advancing south: positive dz
  local dx, dz = xzChange(x, z, x - 1, y, z); local moveOK = core.pass(pcall(move.back, 1)); 
  if moveOK then return getFacing(dx, dz, forward) end
  error("map.facingForward: Move back failed to find facing "..x..", "..y..", "..z)
end

local function facingBack(x, y, z) -- distance back then move forward
  -- local retreat = {north = {0,0,1}, east = {-1,0,0}, south = {0,0,-1}, west = {1,0,0}}
  -- retreating west: positive dx; retreating north: positive dz
  local dx, dz = xzChange(x, z, x + 1, y, z); local moveOK = core.pass(pcall(move.forward, 1)); 
  if moveOK then return getFacing(dx, dz, backward) end
  error("map.facingBack: Move forward failed to find facing at "..x..", "..y..", "..z)
end

local function changes(x, y, z) -- get facing by moving turtle and see how x and z change
  local backOK = core.pass(pcall(move.back, 1)); if backOK then return facingBack(x, y, z) end 
  local forwardOK = core.pass(pcall(move.forward, 1)); if forwardOK then return facingForward(x, y, z) end
  move.right(0); local backRight = core.pass(pcall(move.back, 1)); if backRight then return facingBack(x, y, z) end 
  local forwardRight, code = core.pass(pcall(move.forward, 1)); if forwardRight then return facingForward(x, y, z) end
  error("map.changes: Move to find facing failed "..tostring(forwardOK)..", and back ".. tostring(backOK)..
    " for map at "..x..", "..y..", "..z.." because "..code)
end
--[[
```
<a id="fix"></a> 
All the turtle movement we've just spoken of is in support of establishing a known position and orientation (a `fix`) to anchor future dead reckoning of turtle position and orientation. The `fix` function also fixes the beginning of a `trail`.
```Lua
--]]
_G.Muse.trailhead = _G.Muse.trailhead or {}; 

local trailhead = _G.Muse.trailhead -- survives between commands

local function fix(trail, tx, ty, tz, tf) -- just for turtles in-game , t* for test (no gps) -> "report:
  --:- fix trail? -> _Set and report GPS turtle position for dead reckoning. Optionally begin named trailhead._
  if not turtle and not tf then return "Not a turtle" end -- in-game for turtles, not for player or other computers
  local x, y, z, _, ok = move.where(tx, ty, tz, tf); if not ok then return "(No GPS)" end
  local facing = tf or changes(x, y, z) -- if no tf **turtle dance to find orientation**
  local fixed = place.fix({x, y, z, facing}, trail) -- set position and start a track if starting a trail
  if trail then trailhead.name = place.qualify(trail) end -- use trailhead.name in call to `trail`
  local xf, yf, zf = table.unpack(fixed); local fixes = core.round(xf)..", "..core.round(yf)..", "..core.round(zf)
  return "{"..fixes.."} "..trailhead.name; 
end map.hints["fix"] = {["??trailname"] = {} }
--[[
```
<a id="point"></a> 
The constructors for points, trails, and ranges will be made available to the `map` CLI. It all starts with points..
```Lua
--]]
--:< **Places - Points, Locations, Trails, and Ranges of Maps**
local function point(name, label, trail, tx, ty, tz, tf) -- t* for no gps; tf for player; -> "done", serial: ":", index: #: 
  --:- point name label trail? -> _Add named labeled point, can start trail, MU updated map. (Player situation needs GPS.)_ 
  --:+ _Optional `trail` starts turtle movement `track` ended by call to `trail` limited by `Muse.tracking.limit`._
  assert(name and label, "map.point: Please provide name and label")
  local x, y, z, f = move.where(tx, ty, tz, tf);
  if trail then fix(trail, x, y, z, f or "north") end -- dance and track in `fix` if trail
  local serial, index = place.name(name, label); update(serial) -- append 
  return place.qualify(name)..", "..label.." ("..index..")", index
end; map.hints["point"] = {["?name "] = {["?label "] = {["??trailname"] = {}}} }

function map.set(name, label, x, y, z, f) return point(name, label, false, x, y, z, f) end
--:: map.set(name: ":", label: ":", x: #:, y: #:, z: #:, f: ":") -> _Set turtle at created point -> ":"

function map.point(name, label, xyzf) 
  --:: map.point(name: ":", label: ":", :xyzf:) -> _Create, send point update._ -> `nil & !`
  core.status(2, "map.point:", place.qualify(name), core.xyzf(xyzf))
  local x, y, z, f = table.unpack(xyzf) 
  local situations = { {position = {x = x, y = y, z = z}, facing = f} }
  update(place.name(name, label, situations)) 
end
--[[
```
<a id="locations"></a> 
Locations are a set of related points sharing a label, each xyz offset from each other.
```Lua
--]]
local function addBase(template, xBase, yBase, zBase, top)
  local points = {}; for name, offset in pairs(template) do 
    local xOffset, yOffset, zOffset = table.unpack(offset)
    local yPoint = tonumber(yOffset) and (yBase + yOffset) or top
    points[name] = {xBase + xOffset, yPoint, zBase + zOffset, ""}
  end; return points
end

function map.locations(template, base, label, top)
--:: map.locations(template: {name: ":", offset: xyz}, base: ":", label: ":", top: #:) -> _Add points offset from base._ -> `nil`
--:+ _Add labelled points using template names and offsets from named base point or top for y-axis._
  local basePlace = assert(place.xyzf(base), "map: locations unknown base")
  local xBase, yBase, zBase = table.unpack(basePlace) 
  local points = addBase(template, xBase, yBase, zBase, tonumber(top))
  for name, xyzf in pairs(points) do map.point(name, label, xyzf) end
end; 
--[[
```
<a id="trail"></a> 
Trails are a sequence of points travelled by a turtle moving forward; then paired with that sequence in reverse.
```Lua
--]]
local function trail(tailName, label) -- not useful for player
  --:- trail name label -> _Include named point at head and (current situation) tail of a new trail, update map._ 
  --:+ _Call to `trail` establishes a trail of tracked turtle movements from the head of the trail named and started by `point`._
  --:+ _It also establishes a trail from the tail of the trail named by `trail` back to the head of the trail._
  --:+ _Both trails (from the head to the tail of the `trail` and back) share a `label` as specified in the call to `trail`._
  --:+ _Turtles can move along trails with calls to <a href="roam.html#trace" target="_blank">`roam.trace`</a>._ 
  local headString, tailString = place.trail(trailhead.name, tailName, label); 
  update(headString); update(tailString); 
  return "Trail from "..place.qualify(trailhead.name).." to "..place.qualify(tailName).." as "..label
end; map.hints["trail"] = {["?name "] = {["?label"] = {}} }
--[[
```
<a id="range"></a> 
A range defines a rectangular volume established by a pair of points.
```Lua
--]]
local function range(name, label, nameA, nameB, key, value) -- -> "report", index: #:
  --:- range name label point point key? value?? -> _Volume by named points, optional key and value for feature._ 
  assert(name and label, "map: need name and label for range")
  assert(nameA and nameB, "map: need end points for range")
  local _, placeA = place.match(nameA); assert(placeA, "map: "..nameA.." not found for range")
  local _, placeB = place.match(nameB); assert(placeB, "map: "..nameB.." not found for range")
  local _, _, situationsA = table.unpack(placeA); local situationA = situationsA[1] -- trails not relevant
  local _, _, situationsB = table.unpack(placeB); local situationB = situationsB[1]
  place.name(name, label, situationA); local _, rangePlace = place.match(name)
---@diagnostic disable-next-line: param-type-mismatch
  local _, _, _, features = table.unpack(rangePlace); if key then features[key] = value or true end
  local serial, index = place.add(name, situationB) -- range had everything but second place
  core.status(5, "map range: "..place.qualify(name).." from "..place.qualify(nameA).." to "..place.qualify(nameB))
  update(serial); return "Range "..place.qualify(name).." at "..index.. " in places", index -- append serialized range;
end; map.hints["range"] = {["?name "] = {["?label "] = {["?from "] = {["?to "] = {["??key "] = {["???value"] = {}}}}}}}
--[[
```
<a id="chart"></a> 
A chart defines a point together with a set of ranges accessed by the `features` of that point.
```Lua
--]]
local function chart(chartName, ...)
  --:- chart filename ... -> _Loads and runs named file in `charts` directory to create named point and associated ranges._
  --:+ **While there are conventions (indicated), there's no restriction in what loading and running the file actually does!**
  --:+ _The function generated by loading the file is applied to the ... parameters following the chart file name._
  --:+ _This chart file function is expected to create ranges establishing the `chart` and a way to reference those ranges._
  --:+ _There is nothing to enforce this expectation. The chart file could do (oh, my) pretty much anything._ 
  local chartFile = map.charts()..chartName..".lua"; local charting, message = loadfile(chartFile) -- get the field function 
  assert(charting, message); local results = {core.pass(pcall(charting, ...))} -- **run chart file, put multiple returns in table** 
  local ok, report = table.unpack(results); if not ok then return "map.chart: failed "..report end
  return core.string(table.unpack(results, 2)) -- pack a table with unpacked multiple return (all except `ok`)
end; map.hints["chart"] = {["?chartFileName "] = {["?..."] = {}}}

function map.borders(range) 
  --:: map.borders(range: place) -> _Get range elements_ -> `borders, features, position, position &!`
  --:> borders: _Range boundarires_ -> {east: #:, west: #:, north: #:, south: #:, top: #:, bottom: #:}
  local _, matched = place.match(range); assert(matched, "map.borders: range "..range.." not found")
  local _, _, situations, features = table.unpack(matched); local borders = {}; 
  local x1, y1, z1 = move.get(situations[1]); local x2, y2, z2 = move.get(situations[2]) 
  assert(x1 and y1 and z1 and x2 and y2 and z2, "map.borders: "..range.." badly formed")
  borders.east, borders.west = x1 > x2 and x1 or x2, x1 > x2 and x2 or x1
  borders.south, borders.north = z1 > z2 and z1 or z2, z1 > z2 and z2 or z1
  borders.top, borders.bottom = y1 > y2 and y1 or y2, y1 > y2 and y2 or y1
  return borders, features, situations[1].position, situations[2] and situations[2].position
end
--[[
```
<a id="at"></a> 
The rest of the support for the `map` CLI is built on the `lib/motion` and `lib/places` libraries.
```Lua
--]]
--:< **Navigation in Maps: Where Are We, What's Nearby, and Where Are We Heading?**
local function at() -- gps for player, dead reckoning for turtle -> `"xyzf"`
  --:- at -> _Report current (dead reckoning) turtle position and facing or player GPS position._ 
  if player then local x, y, z, _, ok = move.where(); 
    return ok and core.xyzf({core.round(x), core.round(y), core.round(z)}) or "No GPS"
  end; return move.ats() -- report turtle's current situation position and face
end 

local function test(name, label, x, y, z, facing, key, value) -- makes named place for coordinates, sets turtle position there
  --:- test name, label, x, y, z, facing, key?, value??} -> _Force mapped position, optionally feature and value for `point`._
  core.status(4, "map", "test", place.qualify(name), label, x, y, z, facing, key, value)
  assert(name and label and tonumber(x) and tonumber(y) and tonumber(z) and facing, "map.test: bad arguments for test")
  local _, index = point(name, label, name, x, y, z, facing); if key then map.put(name, key, value) end -- test: name = trailhead
  return "As "..place.qualify(name).." "..move.ats().." ("..index..")"
end; 
--[[
```
<a id="cardinal"></a> 
There's a useful trick used in selecting which of eight cardinal directions to report. An index is computed where orthogonal dimensions (`px`, `pz`, `hitan`, and `lotan`) are projected onto a single dimensional index while preserving the relevant indicator for each of those orthogonal dimensions.
```Lua
--]]
local compass = {"NW", "NE", "SW", "SE", "N", "N", "S", "S", "W", "E", "W", "E"}
local visible = 3 -- arbitrarily close enough to see the target

local function cardinal(dx, dz) -- tangent(22.5 degrees) = 0.4142; (67.5 degrees) = 2.4142
  local px = dx > 0 and 1 or 0; local pz = dz > 0 and 2 or 0;
  local close = math.abs(dx) < visible and math.abs(dz) < visible
  local hitan = (not close and math.abs(dz/dx) > 2.4142) and 4 or 0
  local lotan = (not close and math.abs(dz/dx) < 0.4142) and 8 or 0
  return close and "--" or compass[px + pz + hitan + lotan + 1] -- projection
end
--[[
```
<a id="toNamedPlace"></a> 
Yet more (straight forward) support for the `map` CLI built on `lib/places`. 
```Lua
--]]
local function toNamedPlace(namedPlace, xyz) -- distance and direction to named place
  local x, _, z = table.unpack(xyz) 
  local _, match = place.match(namedPlace); if not match then return "unknown" end
  local _, _, situations = table.unpack(match); local xPlace, yPlace, zPlace = move.get(situations[1]);
  assert(xPlace and yPlace and zPlace, "map toNamedPlace situations "..namedPlace.." coordinates missing")
  local xyzPlace = {core.round(xPlace), core.round(yPlace), core.round(zPlace)}
  local distance = core.round(place.distance(xyzPlace, xyz)) 
  return namedPlace.." "..distance.." "..cardinal(xPlace - x, zPlace - z).." "..core.xyzf(xyzPlace).."\n"
end

local linesLimit = 3 ; -- arbitrary limit on default number of `nearby` lines printed

local function toNearby(xyz, count) -- sorted distance and direction to limited list of nearby points
  local parts = {}; local sorted = place.nearby(xyz, cardinal) -- sorted
  for index, place in ipairs(sorted) do 
---@diagnostic disable-next-line: param-type-mismatch
    if index <= count or index <= linesLimit then local distance, name, _, cardinal = table.unpack(place)
      parts[#parts + 1] = name.." "..core.round(distance).." "..cardinal
    end
  end; return table.concat(parts, "\n")  
end

_G.Muse.xyzPrior = _G.Muse.xyzPrior or {}; local prior = _G.Muse.xyzPrior -- survives command

local function where(namedPlace, count, tx, ty, tz)  -- t* for testing -> report: ":"
  --:- where place? count?? -> _Report movement direction, distance to named place (or all) three (or count) closest places._ 
---@diagnostic disable-next-line: param-type-mismatch
  namedPlace, count, tx, ty, tz = core.optionals(namedPlace, count, tx, ty, tz)
  local x, y, z, _, ok = move.where(tx, ty, tz); local xyz = {x, y, z}; if not ok then return "no GPS" end
  local cardinalString = (prior.hx and prior.hz) and cardinal(x - prior.hx, z - prior.hz) or "--"
  local xyzString = "{"..core.round(x)..", "..core.round(y)..", "..core.round(z).."}"; 
  local head = "->: ".. cardinalString.." "..xyzString.."\n"; 
  prior.hx, prior.hy, prior.hz = x, y, z --reset reference
  local forNamedPlace = namedPlace and toNamedPlace(namedPlace, xyz) or ""
  local nearby = count and "Nearby:\n"..toNearby(xyz, tonumber(count)) or ""
  return head .. forNamedPlace .. nearby
end; map.hints["where"] =  {["?place "] = {["??count"] = {}}} 

local function headings(rate, ...)
  --:- headings rate? place? count?? -> _Repeated movement report at specified rate (or every _G.Muse.rates.headings) seconds)._
  local rateNumber = tonumber(rate); local rest = rateNumber and {...} or {rate, ...}; rateNumber = rateNumber or 5
  core.report(1, "Headings", rateNumber, table.unpack(rest)) --rateNumber, rate,
  while true do core.report(1, where(table.unpack(rest))); core.sleep(rateNumber) end
end; map.hints["headings"] = {["??place "] = {["??rate "] = {["???#lines"] = {}}}}
--[[
```
<a id="near"></a> 
Note the use of the `place.near` iterator and the anonymous function argument to `table.sort`.
```Lua
--]]
local function near(placeName, span) -- list places near span (or all) near place (or player position or turtle situation)
--:- near place? span?? -> _Report points within span blocks (or all) of named place (or current player or turtle position)._
  local itemCount, report, position = 0, {}, player and {core.where()}
  if position and #position == 0 then error("map.near: GPS failure "..core.string(position)) end
  local spanned = tonumber(placeName) and placeName or tonumber(span)-- consider span as placeName
  
  for namepoint, labelpoint, xyzfpoint, distance, situations in place.near(spanned, placeName or position) do 
    itemCount = itemCount +1; local x, y, z = table.unpack(xyzfpoint); local xyzfString = core.xyzf({x, y, z})
    report[#report + 1] = {core.round(distance), " "..namepoint..": "..xyzfString.." "..labelpoint.." ["..#situations.."]"}
  end; table.sort(report, function(a,b) return a[1] < b[1] end) -- anonymous sort function on `distance`
  
  for i = 1, #report do local distance, text = table.unpack(report[i]); report[i] = tostring(distance)..text end
  
  local result= "Found "..itemCount.." near\n"..table.concat(report, "\n"); core.status(4, "map.near", result); return result
end; map.hints["near"] = {["?place "] = {["??span"] = {}}}

local function view(target)
  --:- view place -> _Report place details including name, label (if any), features and all situations._
  local index, placed = place.match(assert(target, "map: need place to view")); 
  assert(placed, "map value: no match for "..place.qualify(target))
  local name, label, situations, features = table.unpack(placed)
  
  local situationStrings = {} for _, situation in ipairs(situations) do 
    situationStrings[#situationStrings + 1] = core.xyzf({move.get(situation)})
  end; local situationList = table.concat(situationStrings, "\n")
  return name..": "..(label or "_").." ("..index..")\n"..core.string(features).."\n"..situationList
end; map.hints["view"] = {["?place"] = {}}
--[[
```
<a id="ops"></a> 
Just a big dispatch table, easily amended and extended. The CLI is just a thin layer on the capabilities provided by the library. 
```Lua
--]]
local ops = { --:# **Command Line Interface** 
  erase = erase, store = store, sync = sync, point = point, range = range, -- for all
  view = view, site = sited, chart = chart, join = join, -- for all
  near = near, at = at, where = where, headings = headings, -- position relative to places for players and turtles
  fix = fix, trail = trail,  -- just for turtles
  test = test, -- just to set test conditions
}
--[[
```
<a id="op"></a> 
As we'll see in a future chapter, the CLI can be operated remotely. Catching all the errors thrown (recursively) by callers (of callers of callers....) allows continued operation at the remote computer after an error. 
```Lua
--]]
function map.op(commands) 
  --:: map.op(commands: ":"[]) -> _Command Line Interface_ -> `report: ":" &:`
  local ok, report = core.pass(pcall(ops[commands[1]], table.unpack(commands, 2))) --the actual `command` and its parameters 
  if ok then return report else return "map: "..core.string(report).." for "..(core.getComputerLabel() or "unknown")
  end -- report failure for error
end

return {map = map}
--[[
```
<a id="programs"></a> 
Players can use 
<a href="../programs/erase.html" target="_blank"> `erase`</a>, 
<a href="../programs/sync.html" target="_blank"> `sync`</a>, 
<a href="../programs/point.html" target="_blank"> `point`</a>, 
<a href="../programs/range.html" target="_blank"> `range`</a>, 
<a href="../programs/view.html" target="_blank"> `view`</a>, and 
<a href="../programs/site.html" target="_blank"> `site`</a>, 
<a href="../programs/chart.html" target="_blank"> `chart`</a>, 
<a href="../programs/join.html" target="_blank"> `join`</a>, 
<a href="../programs/near.html" target="_blank"> `near`</a>, 
<a href="../programs/at.html" target="_blank"> `at`</a>, 
<a href="../programs/where.html" target="_blank"> `where`</a> commands. 
<a href="../programs/headings.html" target="_blank"> `headings`</a>, 

Follow the links just provided to see their (fairly trivial and boringly similar) implementations. It's easy to fiddle with this layer. That's good because experience with a UI usually suggests changes to it.

Look at <a href="../tests/map.html" target = "_blank"> `tests/map` </a> and <a href="check.html" target = "_blank"> `lib/check`</a>` to see how testing works for this module.


That's it for `lib/map`. Follow the <a href="../../MiningMUSE.html#Chapter5"> link</a> to return to _MiningMUSE_.
--]]
