--:? muse/docs/tests/.regression.txt <- **Run Ordered  Regression Test for Muse** -> muse/docs/tests/.regression.md  

local check = require("check").check

check.all({"motion", "places", "turtle", "roam", "task", "map", "remote", "exec", "port", "gps", "mine", "field"})

