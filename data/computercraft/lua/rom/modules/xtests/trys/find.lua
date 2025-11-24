
--[[
local function mark(markerName)
--:: planner.mark(markerName: ":") -> _Parse marker name into parts._ -> `nil` | `(shaft: ":", level: ":", tag: ":")`
  if not markerName then return nil end
  local _, _, site, shaft, level, tag = string.find(markerName, "(%w-)%.?(%w*):?(%w*):?(%w*)$")
  return site, shaft, level, tag
end

print(mark("tm.nnn:03:qqq"))
print(mark("nnn:03:qqq"))
print(mark("nnn:03"))
print(mark("nnn:03"))
print(mark("nnn"))
print(mark("tm.nnn"))
--]]
local function ranging(ranger)
  local _, _, site, first, second = string.find(ranger, "(%w-)%.?(%w*):?(%w*)$")
  local nosite, nosecond = site == "", second == ""
  local sited = nosite and first or site.."."..first
  return not nosecond and sited, nosecond and sited or second -- farm, range
end

local function printing(farm, range)
print("Farm "..(farm or "~")..", Range "..(range or "~"))
end

printing(ranging("tm.farm:range"))
printing(ranging("farm:range"))
printing(ranging("range"))
