--:? muse/docs/tests/.regression.txt <- **Run Ordered  Regression Test for Muse** -> muse/docs/tests/.regression.md  

local check = require("check").check --:# Program kept simple: all the interesting stuff is in `lib/check`
--:# Regression test order: "motion", "places", "turtle", "roam", "task", "map", "remote", "exec", "port", "gps", "mine", "field" 
check.regression({"core", "motion", "places", "turtle", "roam", "task", "map", "remote", "exec", "port", "gps", "mine", "field"})

