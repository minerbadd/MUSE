--[[
## -- Produce LLS Signature Files, Zerobrane API, Markdown and HTML Documentation for MUSE
--]]
local executionDirectory = arg[0]:match('.*[/\\]'); 

local function splitFiles(path)   -- make a table split by \ or /
  local files = {}; for name in string.gmatch(path, "([^/\\]+)[/\\]?") do table.insert(files, name) end 
  return files
end

local files = splitFiles(executionDirectory); 
local data =  table.concat(files, "/", 1, #files - 1).."/data/"

local muse, rom  = data.."muse/", data.."computercraft/lua/rom/"
local apiDirectory, apiFile = muse.."signs/", "muse.lua"
local modules, programs  = rom.."modules/", rom.."programs/"
local helps = rom.."help/" -- `helps` must be aligned with `sign` fields of `HELP` file marks 
local docs, code = muse.."docs/", muse.."code/"
local verbose = false

local sourceDirectories = {
  modules.."lib", modules.."fields", modules.."plans", modules.."charts", modules, programs, modules.."tests"
  }
local codeDirectories = {
  code.."lib", code.."fields", code.."plans", code.."charts", code.."daemons", code.."programs", code.."tests"
  }
local docsDirectories = {
  docs.."lib", docs.."fields", docs.."plans", docs.."charts", docs.."daemons", docs.."programs", docs.."tests"
  }

local marks = require("Mark"); local marker, helper = marks.marker, marks.helper
marker(apiDirectory, apiFile, sourceDirectories, docsDirectories, codeDirectories, verbose)
helper(helps, docs.."programs.txt"); helper(docs.."tests", docs.."tests.txt")
