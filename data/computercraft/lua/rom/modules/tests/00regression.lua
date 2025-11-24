
local here = arg[0]:match('.*[/\\]') -- tests directory

local check = require("check").check
_G.Muse.regression = true

for _, test in check.tests() do dofile(here..test) end
-- TODO: maybe catch any thown errors and raise regression failed exception
