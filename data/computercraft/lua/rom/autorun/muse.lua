--:~ Autorun -> **Enable access to MUSE programs and start MUSE** <- muse/docs/autorun/muse.md
---@diagnostic disable-next-line: undefined-global
shell.setPath(shell.path()..":".."rom/programs/")
shell.run("rom/modules/.start.lua")
