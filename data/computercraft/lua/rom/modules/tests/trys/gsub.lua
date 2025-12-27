

local tokens = {
  ['":'] = "string", ["():"] = "function", ["{:}"] = "table", ["::"] = "any", ["_:"] = "any", 
  ["#:"] = "number", ["^:"] = "boolean", ["@:"] = "userdata", -- [""] = "", [""] = "", [""] = "", [""] = "", 
}
--[[
local function replace(text)
  for token, LLS in pairs(tokens) do
    local replaced, matched = string.gsub(text, token, LLS)
    if matched > 0 then 
      return replaced end
  end; 
  return text
end
--]]
local function replace(text)
  local replaced, count = string.gsub(text, ":?(.-)", tokens)
  print(replaced, count)
end
--]]
print(replace("foo: #:"))