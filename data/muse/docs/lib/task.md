--:! [task: [":"]: (:) ] <- **Command Line Library for Tasks: Low Level Turtle Operations** -> muse/docs/lib/task.md      
--:| task: _Dispatch targets for_ `net` _library._ -> task, _task  

--:< **Directions are  _`u`p, `d`own, `n`orth, `e`ast, `w`est, `s`outh, `f`orward_**  

--:- find name...? -> _Report and select first slot found [or if no name, just report inventory]._  

--:- attack direction -> _Attempts attack in specified direction._   

--:- look direction -> _Detect and inspect direction, return report._  

--:- compare item direction... -> _Named item matches block in any of specified directions?_  

--:- drop item direction quantity? -> _Drop quantity of selected items [or all]._   

--:- suck direction quantity? -> _Suck quantity items [or all] into available slot._   

--:- dig direction distance hoeing... -> _Direction and distance to (possibly blocked) move, hoeings directions to hoe._    
--:+ _Dig along trails by specifying `direction` as `along` and trailname as `distance`. Can dig `here`._    
--:+ _Tilling down, the common case for tilling, requires an air block beneath and a dirt block beneath that._  

--:- put filling direction distance putting... -> _Direction, distance to move, placing filling in puttings directions._    
--:+ _Put along trails by specifying `direction` as `along` and trailname as `distance`. Can put `here`._  

--:- change target filling direction distance putting... -> _Move distance in direction replacing target with filling._    
--:+ _Change along trails by specifying `direction` as `along` and trailname as `distance`. Can change `here`._  

--:: task.op (commands: [ op: ":", arguments: ":"[] ] ) -> _Execute tasks for low level turtle operations:_ -> `":" &:`  