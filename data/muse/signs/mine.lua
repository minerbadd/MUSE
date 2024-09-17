---@meta

local  mine, _mine = {}, {}

-- downs.even:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias downs.even  plan # Mark, dig, ladder, and fill an even level (for landing platforms)


-- downs.last:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias downs.last  plan # Mark last level dug


-- shafts.back:  `levels`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias shafts.back  levels # Plan for returning to minehead, placing fixtures and safety shelves for player


-- downs:  `{downs.even: plan, downs.odd: plan, downs.last: plan }`
---@alias downs {downs.even: plan,  downs.odd: plan,  downs.last: plan } # Mark, dig, ladder, and fill one level (for landing platforms)


-- shafts.higher:  `levels`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias shafts.higher  levels # Plan for navigating from one (even or odd) level to the next higher


-- bores.odd:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias bores.odd  plan # Plan for boring tunnels at odd levels


-- bores.fix:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias bores.fix  plan # Plan for fixtures: shaft area ladders and placing barrel


-- levels.odd:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias levels.odd  plan # Plan for navigating from one even level to the next


-- levels:  `{levels.even: plan, levels.odd: plan}`
---@alias levels {levels.even: plan,  levels.odd: plan} # Traverse (and fill shelves for  player safety in back plan) shaft


-- bores.name:  `":"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias bores.name  string # Included in error and status reports


-- shafts.lower:  `levels`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias shafts.lower  levels # Plan for navigating from one (even or odd) level to the next lower


-- bores:  `{bores.name: ":", bores.post: mine.post, bores.even: plan, bores.odd: plan, bores.fix: plan }`
---@alias bores {bores.name: string,  bores.post: mine.post,  bores.even: plan,  bores.odd: plan,  bores.fix: plan } # Horizontals


-- downs.odd:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias downs.odd  plan # Mark, dig, ladder, and fill an odd level (for landing platforms)


-- mine.post:  (markerName: ":", :bores:):  `marking[]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias mine.post fun(markerName: string,  bores: bores):   marking[] # Navigate shaft and bores to go to marker.


-- levels.even:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias levels.even  plan # Plan for navigating from one even level to the next


-- shafts:  `{shafts.name: ":", shafts.down: downs, shafts.back: levels, shafts.lower: levels, shafts.higher: levels}`
---@alias shafts {shafts.name: string,  shafts.down: downs,  shafts.back: levels,  shafts.lower: levels,  shafts.higher: levels} # Dig


-- shafts.name:  `":"`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias shafts.name  string # Included in error and status reports


-- Make place name, report result. Called by `worker.execute` to make marker name and use it to add map point for navigation in mine. Puts plan name value in marker (keyed by `"shaft"` or `"bore"`) so marker is enough for navigating in shaft or bore. Marker place name formed as `head:level:base` or `head:base` or `head` with place labelled as `"outer"|"inner"|"shaft"`.
-- mine.mark(:plan:, :marking:):  `markerName: ":", label: ":", report: ":"` <-
---@type fun(plan: plan,  marking: marking):  markerName: string,  label: string,  report: string 
function mine.mark() end

-- Dig. Dig shaft; go to post at level; bore, mark, and torch; get ores. Markers hold saved plans.
-- mine.op(arguments: :[op: ":", placeName: ":", borePlansFileOrLevels: ":"|#:, shaftPlansFile: ":"]):  `^:, ":", #: &:` <-
---@type fun(arguments: [string, string, string|number, string]):  boolean,  string,  number 
function mine.op() end

-- bores.even:  `plan`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias bores.even  plan # Plan for boring tunnels at even levels


-- shafts.down:  `downs`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias shafts.down  downs # Plan for digging shaft one level through even and odd levels


-- Navigate to post
-- _mine.toPost(markerName: ":", borePlans: bores, shaftPlans: shafts):  `"done", ":", #: &!` <-
---@type fun(markerName: string,  borePlans: bores,  shaftPlans: shafts):  "done",  string,  number 
function _mine.toPost() end

-- To minehead Execute shaft plans back to return to minehead from one below target level Add "shaft" and shaft plans name as key and value to shaft plans for inclusion in marker
-- _mine.back(mineheadName: ":",  targetLevel: #:, shaftPlansBack: shafts, shaftPlansName: ":"):  `":", ":"  &!` <-
---@type fun(mineheadName: string,   targetLevel: number,  shaftPlansBack: shafts,  shaftPlansName: string):  string,  string  
function _mine.back() end

-- Dig shaft through levels.
-- _mine.shaftOp(mineheadName: ":", levels: #:, shaftPlans: shafts):  `":", ":", #:` &! <-
---@type fun(mineheadName: string,  levels: number,  shaftPlans: shafts):  string,  string,  number 
function _mine.shaftOp() end

-- Make, fill in, execute at level.
-- _mine.atWork(:plan:, head: ":", level: #:, key: ":", value: any):  `":", ":" &: &!` <-
---@type fun(plan: plan,  head: string,  level: number,  key: string,  value: any):  string,  string 
function _mine.atWork() end

-- Excavate ores Use shaft plans and instantiated bore plans to go to marker and execute mining operations
-- _mine.ores(markerName: ":", thisLevel: #:, borePlans: bores):  "done", `":", #: &: &!` <-
---@type fun(markerName: string,  thisLevel: number,  borePlans: bores):  "done",  string,  number 
function _mine.ores() end

-- Dig shaft Start dig down from minehead, finish by placing marker one level below target level, error raised for failure. Add "shaft" and shaft plans name as key and value to shaft plans for inclusion in marker.
-- _mine.down(mineheadName: ":", targetLevel: #:, shaftPlansDown: downs, shaftPlansName: ":"):  `"done" &!` <-
---@type fun(mineheadName: string,  targetLevel: number,  shaftPlansDown: downs,  shaftPlansName: string):  "done" 
function _mine.down() end

-- Go to marker and bore Use shaft plans and bore plans to navigate to marker, bore horizontal tunnels using bore plans. Add "bore" and bore plans name as key and value to bore plans for inclusion in marker. Bores plans at even or odd level, potentially leaves place marks and torches.
-- _mine.bore(markerName: ":", borePlans: bores, shaftPlans:shafts):  `"done", ":", #: &: &!` <-
---@type fun(markerName: string,  borePlans: bores,  shaftPlans:shafts):  "done",  string,  number 
function _mine.bore() end
return { mine =  mine, _mine = _mine}
