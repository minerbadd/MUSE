--:? muse/docs/tests/places.txt <- **Run Regression Test for Muse** -> muse/docs/tests/places.md  
-- **Tests for `place`, `moves`, and `steps` interfaces of lib/places** 

dofile(arg[0]:match('.*[/\\]').."/)_preface.lua");  -- set test environment using `preface` in execution path

local core, places = require("core").core, require("places")
local place, moves, steps = places.place, places.moves, places.steps

place.site("TP")

-- fix = fixPlace, -- (x,y,z,f) for gps calibration ->  {x, y, z, facing} 
do local xyzf = place.fix({10, 20, 30,"east"}); print(1, table.unpack(xyzf)) end

--name = namePlace, -- (name, label) a situation then adds to global places -> string, index
print(2, place.name("test1", "label1"))

-- xyzf = xyzfPlace, -- (name) looks up name -> `nil` | {xyzf}
do local xyzf = place.fix({20, 30, 40,"west"}); print(3, table.unpack(xyzf)) end
print(4, place.name("test2", "label2"))

do local xyzf, index = place.xyzf("test1"); print(5, index, core.string(xyzf)) end
do local xyzf, index = place.xyzf("test2"); print(6, index, core.string(xyzf)) end

-- match = matchPlace, -- (name) looks up name, nil if not found -> `nil` | (`index, place`) 
local a1, a2 = place.match("test1"); print(7, a1, core.serialize(a2))

-- distance = distance, -- ({xyzf}, {xyzf}) -> # Manhatten distance
print(8, place.distance(place.xyzf("test1"), place.xyzf("test2")))
-- near = nearPlaces, -- ([span, [place] ])] iterator -> name, label, xyz, index, string
for name, label, xyz, index, situations in place.near(20, {10, 20, 30}) do 
  print(9, name, label, core.string(xyz), index, #situations) 
end

--nearby = nearby, -- (xyz,[cardinal]) -> namedPlaces, a list of named places sorted by distance from xyz
print(10, core.string(place.nearby({20,35,40})))

do local a, b = place.erase("test1"); print(11,a,b); end
print(12, core.string(place.nearby({20,35,40})))

do local xyzf = place.fix({10, 15, 25, "west"}); print(13, table.unpack(xyzf)) end --replace
print(14, place.name("test2", "label2"))

do local xyzf = place.fix({10, 20, 30,"east"}); print(15, table.unpack(xyzf)) end
print(16, place.name("test1", "label1"))

do local code, remaining, at = moves.to("test2", "y") -- -- test2: 10, max(15, 50), 25, "west" 
  print(16, code, remaining, core.string(at)) 
end 

do local xyzf = place.fix({10, 25, 35, "west"}); print(17, table.unpack(xyzf)) end
print(18, place.name("test2", "label2")) -- start trail at test2: 10,25,35,"west"

for name, label, xyz, index, situations in place.near() do -- check places
  print(19, name, label, core.string(xyz), index, #situations) 
end

--to = goToPlace, --(placename) -> y-first movement, returns code, remaining, xyzf
do local code, remaining, at = moves.to("test1"); 
  print(20, code, remaining, core.string(at)) 
end -- go from test2 to test1

--trail = makeTrail, -- headName, tailName, label -> headString, tailString 
do local hs, ts = place.trail("head2", "tail1", "trail21"); 
  print(21, hs); print(22, ts) 
end -- trails goes from test2(head2) to test1(tail1) and back from tail1(test1) back to test2(head2); at test1

for name, label, xyz, index, situations in place.near() do -- check places with trails
  print(23, name, label, core.string(xyz), index, #situations) 
end

--test2	{10, 25, 35, }	test1	{10, 20, 30, }	head2	{10, 25, 35, }	tail1	{10, 20, 30, }

-- along = goTrail, --(head|tail) traverse situations returns code, index into situations or nil , xyzf
do local code, remaining, at = moves.along("tail1"); -- goes to head2(test2) {10, 25, 35, }
  print(24, code, remaining, core.string(at)) 
end 

-- to = stepToPlace, --  (place) -> iterator() -> returns code, remaining, xyzf
for code, remaining, at, direction, all in steps.to("test1") do -- {10, 25, 35, } to {10, 20, 30, }
  print(25, code, remaining, core.string(at), direction, all)
end

-- along = stepTrail, -- (head|tail) -> iterator() that will step along each situation of a trail
for code, remaining, at, direction, all, indexSituations in steps.along("tail1") do -- reverse to {10, 25, 35, }
  print(26, code, remaining, core.string(at), direction, all, indexSituations)
end
