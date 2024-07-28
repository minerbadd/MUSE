--[[
## -- Produce LLS Signature Files, Zerobrane API, Markdown and HTML Documentation for MUSE
--]]
local executionDirectory = arg[0]:match('.*[/\\]'); 

local function splitFiles(path)   -- make a table split by \ or /
    local files = {}; for name in string.gmatch(path, "([^/\\]+)[/\\]?") do table.insert(files, name) end 
    return files
end

local files = splitFiles(executionDirectory); 
local data =  table.concat(files, "/", 1, #files - 2).."/"

local muse, rom  = data.."muse/", data.."computercraft/lua/rom/"
local apiDirectory, apiFile = muse.."signs/", "zbs.api"
local modules, programs = rom.."modules/", rom.."programs/"
local docs, code = muse.."docs/", muse.."code/"
local verbose = true

local sourceDirectories = {modules.."lib", modules.."fields", modules.."plans", modules.."charts", modules, programs}
local docsDirectories = {docs.."lib", docs.."fields", docs.."plans", docs.."charts", docs.."daemons", docs.."programs"}
local codeDirectories = {code.."lib", code.."fields", code.."plans", code.."charts", code.."daemons", code.."programs"}

local Mark = require("Mark")
Mark(apiDirectory, apiFile, sourceDirectories, docsDirectories, codeDirectories, verbose)
