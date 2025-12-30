--:? muse/docs/tests/.regression.txt <- **Run Regression Test for Muse** -> muse/docs/tests/.regression.md  

local check = require("check").check
_G.Muse.regression = true

local testOrder = {"motion", "places", "turtle", "roam", "task", "map", "remote", "exec", "port", "gps", "mine", "field"}

local testSetTablePath, testSetName = _G.Muse.checks, _G.Muse.tests
-- `testSetTablePath`: directory of files holding test set dictionary and expected test results
-- `testSetName`: dictionary of file names for expected results for tests (as file names)

for _, test in ipairs(check.tests(testOrder, testSetTablePath, testSetName)) do dofile(here..test..".lua") end 
--:# Run each test in this test directory that has expected results 
-- TODO: maybe catch any thown errors and raise regression failed exception

_G.Muse.regression = false
