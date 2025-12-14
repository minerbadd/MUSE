--:? muse/docs/tests/00regression.txt <- **Run Regression Test for Muse** -> muse/docs/tests/00regression.md  

local here = arg[0]:match('.*[/\\]') -- this tests directory

local check = require("check").check
_G.Muse.regression = true

local testSetTablePath, testSetName = _G.Muse.path.."tests/checks/", "00musechecks.lua"
-- `testSetTablePath`: directory of files holding test set dictionary and expected test results
-- `testSetName`: dictionary of file names for expected results for tests (as file names)

for _, test in check.tests(testSetTablePath, testSetName) do dofile(here..test) end 
--:# Run each test in this test directory that has expected results 
-- TODO: maybe catch any thown errors and raise regression failed exception
