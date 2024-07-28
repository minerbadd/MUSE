-- **Tests for lib/turtle extensions to turtle operations**

dofile(arg[0]:match('.*[/\\]').."/preface.lua");  -- set test environment using `preface` in execution path
local core, turtle = require("core").core, require("turtle").turtle

do local result, item = turtle.inspects["east"](); print (1, result, item.name) end

-- checkTarget(targets, itemDetail) -- item inspected by turtle is in targets?
local ores = {"minecraft:coal_ore", "minecraft:iron_ore", "minecraft:gold_ore",}
do local result = turtle.check(ores, {name = "minecraft:coal_ore"}); print(2, result) end

--category check
do local result = turtle.category("test"); print(3, table.unpack(result)) end
do local result = turtle.category("dirt"); print(4, table.unpack(result)) end
do local result = turtle.category("nomatch"); print(5, table.unpack(result), "(minecraft:nomatch expected)") end
do local result = turtle.category("fill"); print(6, table.unpack(result)) end

-- fuelAvailable() -- energy available in turtle slots
print(7, turtle.fuel(), "fuel available")

-- digUnblock(direction, limit, attempts) attempts = attempts or 0; --waits, retrys for gravel; attacks
do local result, direction, bedrock = turtle.unblock("east", 5) -- normal usage
  print(8, result, direction, bedrock and "bedrock" or "not bedrock")
end

do local ok, result, notice, direction = core.pass(pcall(turtle.unblock, "east", 5, 6)) --force fail
  if ok then print(9, "Should have failed", ok, result, notice, direction) end
  if not ok then print(9, "failure expected", result, core.string(notice)) end
end

-- inventory() -- returns currrent turtle inventory as table
for _, item in ipairs(turtle.inventory()) do local name, count = table.unpack(item)
  print(10, count, name) 
end

