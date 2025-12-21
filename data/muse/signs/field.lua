---@meta

local  field, _field = {}, {}

-- Plots placed Returns `nplots: #:, slots: #:, strides: eP, run: eP, striding: xyz, turn: ^:, back: ^: Extents for `stride` (shorter) and `run` (longer) virtual axes for each `opName` in the `strides` entries unless `faced`.
-- field.extents(:bounds:, :strides:, faced: ":"?):  `field.count, field.count , eP, eP, striding, ^:, ^:` <-

---@type fun(bounds: bounds,  strides: strides,  faced: string?):  field.count,  field.count ,  eP,  eP,  striding,  boolean,  boolean 
function field.extents() end

-- _field.runs:  `{oddlevel: _field.plans, evenlevel: _field.plans}`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias _field.runs {oddlevel: _field.plans,  evenlevel: _field.plans} # Plans for runs at even and odd numbered levels.


-- striding:  `[fieldOp]: xyz`
---@alias striding { [fieldOp]: xyz } # dictionary keyed by `opName` of vectors incrementing game coordinate positions for `turn


-- fieldParameters.fills:  `group|craft[]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias fieldParameters.fills  group|craft[] # Group or list of craft items for fill material


-- fieldCommands:  `:[fieldOpName: ":", ranger: ":",  firstPlot: #:?, lastPlot: #:??]`
---@alias fieldCommands  : [ string,  string,  number?,  number?] # For CLI


-- _field.plans:  `{start: plan, odd: plan, even: plan, last: plan}`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias _field.plans {start: plan,  odd: plan,  even: plan,  last: plan} # At each level, start, even numbered, odd numbered, last run.


-- Fill, Till, Replace.
-- field.fill(parameters: :[nearPlace: ":", farPlace: ":", fill: ":", target: ":"?]):  `":" &:` <-

---@type fun(parameters: [ string,  string,  string,  string?]):  string 
function field.fill() end

-- Called by plan prototype file to generate plans for plot.
-- field.paths(bounds: xyz[]):  `paths, yDelta: #:, xzEdge: facing` <-

---@type fun(bounds: xyz[]):  paths,  yDelta: number,  xzEdge: facing 
function field.paths() end

-- paths:  {start: ":"[], odd: ":"[], even: ":"[], last: ":"[]}`
---@alias paths  {start: string[],  odd: string[],  even: string[],  last: string[] # Flying ox traverse of three dimensional rectangular solid


-- Plots Called by field files. Calls `fieldsOp` from field file (which calls `field.plan`).
-- field.plot(commands: field.plotSpan, fieldsOp: (:), fieldOpName: ":", plots: #:, offset: xyz?):  `report: ":" &: &!` <-

---@type fun(commands: field.plotSpan,  fieldsOp: function,  fieldOpName: string,  plots: number,  offset: xyz?):  report: string 
function field.plot() end

-- craft:  `":"`
---@alias craft  string # Minecraft item `detail.name` without `minecraft:` prefix


-- eP:  `bounds`
---@alias eP  bounds # pair of coordinates for extents


-- strides:  `[fieldOp]: #:`
---@alias strides { [fieldOp]: number } # dictionary keyed by `opName` for the distance along the stride axis for a striding


-- field.plotSpan: _ `:[_:, _:, first: #:?, last: #:??]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias field.plotSpan _ : [any,   any,  number?,  number?] # {}` spans all plots; if only first, default plots after first


-- Quarry out blocks from one place to the other.
-- field.cut(places: :[nearPlace: ":", farPlace: ":"]):  `":" &:` <-

---@type fun(places: [ string,  string]):  string 
function field.cut() end

-- Load field files; return their `field.plot` calls
-- field.make(commands: fieldCommands, faced: ^:):  `report: ":" &:` <-

---@type fun(commands: fieldCommands,  faced: boolean):  report: string 
function field.make() end

-- fieldOp:  ":"
---@alias fieldOp  string # Operation name in the set for a particular kind of field


-- fieldParameters:  `:[bounds, fieldParameters.fills?, fieldParameters.removeables??]`
---@alias fieldParameters  : [bounds,   fieldParameters.fills?,   fieldParameters.removeables?] # bounds` (and materials to fill and replace)


-- Till the seed from one place to the other.
-- field.till(parameters: :[nearPlace: ":", farPlace: ":", seed: ":"]):  `":" &:` <-

---@type fun(parameters: [ string,  string,  string]):  string 
function field.till() end

-- Run plan, default offset {0,0,0}. Loads and executes the prototype plan (which calls `field.paths`) for each (odd, even, or last) level of a plot.
-- field.plan(planName: ":", fielding: fieldParameters, offset: xyz?):  `report: ":" &: &!` <-

---@type fun(planName: string,  fielding: fieldParameters,  offset: xyz?):  report: string 
function field.plan() end

-- field.count:  `[fieldOp]: #:`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias field.count { [fieldOp]: number } # dictionary keyed by 'opName` for number of elements in field for that operation


-- fieldParameters.removeables:  `group|craft[]`
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias fieldParameters.removeables  group|craft[] # Material replaced by fill


-- Put fencing using `layer` plan.
-- field.fence(parameters: :[ranger: ":", fencing: ":"?]):  `":"` <-

---@type fun(parameters: [ string,  string?]):  string 
function field.fence() end

-- To `put``.
-- _field.fillTill(thePlan: ":", parameters: :[nearPlace: ":", farPlace: ":", filling: ":", target: ":"?]):  `":"` <-

---@type fun(thePlan: string,  parameters: [ string,  string,  string,  string?]):  string 
function _field.fillTill() end

-- Run plans for the levels.
-- _field.execute(plans: _field.plans, levels: #:, fieldings: fieldParameters, planName: ":"):  `":" &!` <-

---@type fun(plans: _field.plans,  levels: number,  fieldings: fieldParameters,  planName: string):  string 
function _field.execute() end

-- Get coordinate pair for named places.
-- _field.makeBounds(nearPlace: ":", farPlace: ":"):  `xyz, xyz, #:, #:` <-

---@type fun(nearPlace: string,  farPlace: string):  xyz,  xyz,  number,  number 
function _field.makeBounds() end

-- Fly ox.
-- _field.runElements(bounds: :[xyzStart: xyz, xyzFinish: xyz]):  `runs:_field.runs, yDelta: #:, xzDelta: #:, xzEdge: facing` <-

---@type fun(bounds: [ xyz,  xyz]):  runs:_field.runs,  yDelta: number,  xzDelta: number,  xzEdge: facing 
function _field.runElements() end

-- Use`layer` or `till` plan.
-- _field.put(thePlan: ":", start: #:, finish: #:, filling: ":", target: ":"?):  `":" &:` <-

---@type fun(thePlan: string,  start: number,  finish: number,  filling: string,  target: string?):  string 
function _field.put() end

-- Use plan.quarry to cut.
-- _field.cut(places: :[nearPlace: ":", farPlace: ":"]):  `report: ":" &:` <-

---@type fun(places: [ string,  string]):  report: string 
function _field.cut() end
return { field =  field, _field = _field}
