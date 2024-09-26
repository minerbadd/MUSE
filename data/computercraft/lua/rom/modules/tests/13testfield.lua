-- Test for field operations

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path

local core, place, map, turtle = require("core").core, require("places").place, require("map").map, require("turtle").turtle
local field, roam = require("field").field, require("roam").roam

map.map(_G.Muse.path.."tests/maps/".."TF.map"); place.site("TF"); core.log.level(3); turtle.blocking(false)
map.charts(_G.Muse.path.."charts/")

map.op {"test", "farm00", "testing", "90", "20", "290", "west"}
map.op {"test", "farm30", "testing", "100", "20", "300", "west"}
map.op {"range", "farm3000", "testing", "farm30", "farm00", "moondust"}

print(1, roam.op {"trace", "farm3000" }) -- range as really short trail

print(2, field.cut {"farm30", "farm00"})
print(3, field.fill {"farm30", "farm00", "dirt"})
print(3.1, field.fill {"farm30", "farm00", "potato", "dirt"})
print(3.2, field.till {"farm30", "farm00", "dirt", "potato"})

print(4, field.fence {"farm3000", "fence"}, "should fail, moondust") 

map.put("farm3000", "fences") -- now  has fences property 
print(5, field.fence {"farm3000"})
print(5.1, field.fence {"farm3000", "birch"})
print(5.2, field.fence {"farm3000", "oak"})
print(5.2, field.fence {"farm3000", "minecraft:birch_fence"})

--map.op {"test", "farm40", "testing", "-1320", "63", "773", "north"}
map.op {"test", "tara", "testing", "100", "20", "300", "east"}
print(6, map.op {"chart", "farm40", "tara", "SE", "64"}); print(6, map.op {"view", "tara"})
--print(6.1, map.op {"chart", "farm40ES", "corner", "ES", "64"}); print(6.1, map.op {"view", "farm40ES"})

print(7, field.fence {"tara:east", "birch"})

print(8, field.make {"path", "tara:pens"})
print(8.1, field.make {"path", "tara:pens", "2"})
print(8.2, field.make {"path", "tara:pens", "2", "6"})
print(8.3, field.make {"path", "tara:canes", "2", "6"})
print(8.4, field.make {"path", "tara:crops", "2", "6"})
print(8.5, field.make {"path", "tara:trees", "2", "6"})

print(9, field.make {"quarry", "tara:trees", "2", "2"})
print(9.1, field.make {"layer", "tara:trees", "2", "2"})
print(9.2, field.make {"cover", "tara:trees", "2", "2"})
print(9.3, field.make {"finish", "tara:trees", "2", "2"})
print(9.4, field.make {"harvest", "tara:trees", "2", "2"})

print(10, field.make {"quarry", "tara:crops", "2", "2"})
print(10.1, field.make {"layer", "tara:crops", "2", "2"})
print(10.2, field.make {"cover", "tara:crops", "2", "2"})
print(10.3, field.make {"finish", "tara:crops", "2", "2"})
print(10.4, field.make {"harvest", "tara:crops", "2", "2"})

print(11, field.make {"quarry", "tara:pens", "2", "2"})
print(11.1, field.make {"layer", "tara:pens", "2", "2"})
print(11.2, field.make {"cover", "tara:pens", "2", "2"})
print(11.3, field.make {"finish", "tara:pens", "2", "2"})
print(11.4, field.make {"harvest", "tara:pens", "2", "2"})

print(12, field.make {"quarry", "tara:canes", "2", "2"})
print(12.1, field.make {"layer", "tara:canes", "2", "2"})
print(12.2, field.make {"cover", "tara:canes", "2", "2"})
print(12.3, field.make {"finish", "tara:canes", "2", "2"})
print(12.4, field.make {"harvest", "tara:canes", "2", "2"})

--[[
map.point: TF.treesNW {121, 64, 312}  {100, 20, 300}, north
map.point: TF.treesSE {138, 64, 317}  {100, 20, 300}, north

map.point: TF.pensNW {100, 64, 300}  {100, 20, 300}, north
map.point: TF.pensSE {116, 64, 318}  {100, 20, 300}, north

map.point: TF.caneNW {118, 64, 301}  {100, 20, 300}, north
map.point: TF.caneSE {120, 64, 317}  {100, 20, 300}, north

map.point: TF.cropsNW {121, 64, 301}  {100, 20, 300}, north
map.point: TF.cropsSE {138, 64, 311}  {100, 20, 300}, north

map.point: TF.fenceNW {117, 64, 300}  {100, 20, 300}, north
map.point: TF.fenceSW {117, 64, 318}  {100, 20, 300}, north
map.point: TF.fenceNE {140, 64, 300}  {100, 20, 300}, north
map.point: TF.fenceEN {140, 64, 301}  {100, 20, 300}, north
map.point: TF.fenceES {140, 64, 317}  {100, 20, 300}, north
map.point: TF.fenceSE {140, 64, 318}  {100, 20, 300}, north
--]]

