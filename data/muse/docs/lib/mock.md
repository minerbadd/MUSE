--:! {turtle: [":"]: ():, commands: [":"]: ():} <- **Mock Functions Library** (for out-of-game test) -> muse/docs//lib/mock.md     
--:| mock: _Libraries to provide a limited simulation of turtle and command computer in-game operations._ -> mock    
--:+ turtle: _Generally just returns success but allows for simulated blocking, fuel consumption, refueling._      
--:+ commands: _Mock returns from command computer and report success._  

--:# _Mock turtle has coal, torches, fences, dirt, ladders, wheat seeds, reeds, sand, and saplings._    
--:+ _As well as barrels, granite, potatoes, carrots, beetroot seeds, and kelp._    
--:+ _And advanced computers, ender modems, disk drives and floppies in its slots._  

--:# turtle.select(slot: #:) -> _Attempts to select the specified slot._ -> `selected: ^:`  

--:# turtle.item(slot: #:?) ->  _Detail of specified or currently selected slot._ -> `nil | detail`  

--:# turtle.refuel(): -> _Reset fuel level_ -> `^:`  

--:# turtle.getFuelLevel(): -> _Return fuel level_ -> `#:`  

--:# _Inspection by_ `turtle.inspect()` _shows dirt for down direction, coal for up, otherwise nothing._  

--:# _Turns just report success, other motions decrement the simulated fuel and report success unless blocked._    
--:+ _Only forward motion can be blocked in simulation._  

--:# _Primitive turtle operations are mocked: attack, dig, place, detect, compare, drop, and suck._  

--:# _Only_ `turtle.digDown()` _is blockable_  

--:# _A few command computer operations are mocked: `getBlockPosition`, `getBlockInfo`, and `exec`._  

--:# commands.getBlockPosition(x: #:, y:, #:, z: #) -> _Mock position._ -> `x: #:, y:, #:, z: #`  

--:# commands.getBlockInfo(_: _: , _: _: ,_: _: , resultTable: {:}) -> _Mock info._ -> `resultTable: {:}`  

--:# commands.exec(_: _:, result: any) -> _Mock exec command._ -> `result: any`  