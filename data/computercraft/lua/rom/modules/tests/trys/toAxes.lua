

--local core = require("core").core
local axes = {"y", "z", "x"}

local function toAxes(change, currentAxes, targetAxes) 
  print(table.concat(change, " "))
  local targets = {}; 
  for i in ipairs(change) do targets[change[i]] =  targetAxes[change[i]] 
    for _, axis in ipairs(change) do 
      currentAxes[axis] = targets[axis] or currentAxes[axis] 
    end; -- if move.to({currentAxes.x, currentAxes.y, currentAxes.z, "north"}) ~= "done" then return end
  end; return "done" -- success!
end

-- toAxes({"y", "x", "z"}, {x = 10, y = 20, z = 30}, {x = 100, y = 200, z = 300})

local function perm(array, n) -- adapted from https://www.lua.org/pil/9.3.html
  if n == 0 then coroutine.yield(array) -- or printResult(a) to test
  else
    for i = 1, n do
      array[n], array[i] = array[i], array[n] -- put i-th element as the last one
      perm(array, n - 1) -- generate all permutations of the other elements      
      array[n], array[i] = array[i], array[n] -- -- restore i-th element
    end
  end
end

local function permute(array) -- return iterator for (factorial) permutations
  --:: core.permute(array: any[]) -> `():`
  return coroutine.wrap(function() perm(array, #array) end)
end

local function permuting(currentAxes, targetAxes) 
  local code; --local x, y, z = move.get()  -- dead reckoning 
  for change in permute(axes) do code = toAxes(change, currentAxes, targetAxes); 
    -- if code == "done" then return "done" end -- successful movement; else try another permutation
  end -- tried all permutations but not at target; if any movement, try permutations from new position
  --local mx, my, mz = move.get(); local distance = math.abs(x - mx) + math.abs(y - my) + math.abs(z - mz)
  return --distance == 0 and code or permuting({x = mx, y = my, z = mz}, targetAxes)
end

local function moveHere(tx, ty, tz, ttx, tty, ttz)
  return permuting({x = tx, y = ty, z = tz}, {x = ttx, y= tty, z = ttz}) -- currentAxes, targetAxes
end

moveHere(10, 20, 30, 100, 200, 300)