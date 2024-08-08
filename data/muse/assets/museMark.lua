--[[
## -- Produce LLS Signature Files, Zerobrane API, Markdown and HTML Documentation for MUSE
--]]
local executionDirectory = arg[0]:match('.*[/\\]'); 
local lfs = require("lfs")

local function splitFiles(path)   -- make a table split by \ or /
  local files = {}; for name in string.gmatch(path, "([^/\\]+)[/\\]?") do table.insert(files, name) end 
  return files
end

local files = splitFiles(executionDirectory); 
local data =  table.concat(files, "/", 1, #files - 2).."/"

local muse, rom  = data.."muse/", data.."computercraft/lua/rom/"
local apiDirectory, apiFile = muse.."signs/", "zbs.api"
local modules, programs, helps = rom.."modules/", rom.."programs/", rom.."help/"
local docs, code = muse.."docs/", muse.."code/"; local help = docs.."help.txt"
local verbose = true

local sourceDirectories = {modules.."lib", modules.."fields", modules.."plans", modules.."charts", modules, programs}
local docsDirectories = {docs.."lib", docs.."fields", docs.."plans", docs.."charts", docs.."daemons", docs.."programs"}
local codeDirectories = {code.."lib", code.."fields", code.."plans", code.."charts", code.."daemons", code.."programs"}

local Mark = require("Mark")
Mark(apiDirectory, apiFile, sourceDirectories, docsDirectories, codeDirectories, verbose)

local function makeHelp(helps, help) -- helps directory, output concatenated help file
  local helpers = {}; for helpFile in lfs.dir(helps) do 
    local helpPath = helps..helpFile
    local helpFileHandle = io.open(helpPath, "r")
    if helpFileHandle then 
      local helpLines = helpFileHandle:read("*all"); helpFileHandle:close()
      local helpLine = string.gsub(helpLines, "\n \n", ": ")
      helpers[#helpers + 1] = string.gsub(helpLine, "\n", "")
    end
  end; local helpText = table.concat(helpers, "\n\n")
  local helpsHandle = assert(io.open(help, "w"))
  helpsHandle:write(helpText); helpsHandle:close()
end

makeHelp(helps, help) -- 

