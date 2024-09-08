--:! {exec: []: (:)} <- **Command Computer Command Line Library** -> muse/docs/lib/exec.md    
--:| exec: _CLL to align MUSE location with Minecraft coordinates and activate a range as a Minecraft chunk._ -> exec  

--:# **Before GPS launch, set Muse dead reckoning coordinates for turtle sitting on `porter` to be its Minecraft coordinates**    
--:+ The turtle will generally be `rover` for launch. Named point will be the launch base. Needs command computer in-game.  

--:- locate name label? -> _Create launch point having Minecraft coordinates above `porter`._    
--:+ blockAboveTest: _For testing_ -> `{nbt: {Label: ":"}, state: {facing: ":"}}`  

--:- activate range -> _Add borders from west and north to east and south of range for Minecraft forceload._  

--:# Dispatch for `exec` commands: `locate`, `activate`  

--:: exec.op(commandLine: :[command: ":", ...]) -> _CLI for Command Computer commands_ -> `":" &:`  