--:? muse/docs/tests/MYM.txt <- **Test `lib/MYC`** -> muse/docs/tests/MYC.md 

local MYM = require("MYM"); local x, y = MYM.x, MYM.y ---@module "signs.MYM"

print(x.add(2, 3))
print(y.sub(4, 5))
