--[[
## -- Produce LLS Signature Files, Zerobrane API, Markdown and HTML Documentation for MUSE
--]]
local executionDirectory = arg[0]:match('.*[/\\]'); 
--local lfs = require("lfs")
_G.Muse = {}
local core = require("core").core

local function splitFiles(path)   -- make a table split by \ or /
  local files = {}; for name in string.gmatch(path, "([^/\\]+)[/\\]?") do table.insert(files, name) end 
  return files
end

local files = splitFiles(executionDirectory); 
local MUSE =  table.concat(files, "/", 1, #files - 1)
local data = MUSE.."/data/"
local assets = MUSE.."/assets/"
--local muse = data.."muse/"
local rom  = data.."computercraft/lua/rom/"
--local apiDirectory, apiFile = muse.."signs/", "muse.lua"
local modules = rom.."modules/"
--local programs = rom.."programs/" 
--local helps = rom.."help/" -- `helps` must be aligned with `sign` fields of `HELP` file marks 
--local docs, code = muse.."docs/", muse.."code/"
--local verbose = false
--[[
local sourceDirectories = {
  modules.."lib", modules.."fields", modules.."plans", modules.."charts", modules, programs, modules.."tests"}
local codeDirectories = {
  code.."lib", code.."fields", code.."plans", code.."charts", code.."daemons", code.."programs", code.."tests"}
local docsDirectories = {
  docs.."lib", docs.."fields", docs.."plans", docs.."charts", docs.."daemons", docs.."programs", docs.."tests"}
--]]

local apiTest = require("apiMark").file
local ZBSapi, outLines, helpLines = apiTest(modules.."lib/places.lua", assets.."ZBIplaces.lua")
print(#outlines, #helplines)