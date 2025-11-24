

local line = "move.ats:: core.ats"

local function parse(line)
  local copySplit = "([%a%d%S]+):%s*(.-)$" -- sign: text
  local sign, text = string.match(line, copySplit)
  print (sign, text)
end

parse(line)
