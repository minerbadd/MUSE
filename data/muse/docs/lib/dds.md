--:! {dds: []: (:)} <- **In-game (only) MUSE Discovery Service Library** -> muse/docs/lib/dds.md      
--:| dds: _Associates computer IDs with labels (as Muse roles) using Muse Query (MQ) rednet protocol._ -> dds  

--:> IDs: _Dictionary of ComputerCraft computer IDs keyed by MUSE role_ -> `[role]: ID`  

--:> ID: _ComputerCraft computer ID_ -> `#:`  

--:> roles: _Dictionary of Computercraft labels for MUSE roles keyed by Computercraft (string) IDs_ -> `[ID]: ":"`  

--:> role: _ComputerCraft label as MUSE role_ -> `":"`  

--:: dds.roleID(role: ":") -> _ID for a Muse role_ -> `ID: #:`   

--:: dds.role(ID: ":") ->  _Label for a Muse role_ -> `role: ":"`  

--:: dds.hosts() -> _Populates players IDs and labels using a MQ rednet protocol._ -> `IDs, roles`  

--:: dds.join(role: ":", id: #:?) -> _Fix ID role association for next startup, id given by player._ -> `sitedLabel: ":"`  

--:: dds.map() -> _Returns associations from Muse roles to ComputerCraft IDs_ -> `IDs`  