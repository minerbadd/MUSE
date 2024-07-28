--:! {worker:[]: (:)} <- **Functions Library to Execute Plans** -> muse/docs/lib/worker.md      
--:| worker: _Run what's been created by_ `planner` _while attempting to deal with a turtle's situational difficulties._ -> worker  

--:: worker.execute(plan, pathOperations, fuelOK: ^:, pathDistance: #:) -> _Do plan._ ->  `"done", report: ":" &: &!`    
--:+ _Attempt recovery for_ `blocked` _or_ `lost` _conditions; raise error for_ `empty` _or_ `bedrock` _or if recovery fails._  