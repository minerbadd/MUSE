--:! {dds: [":"]: ():} <- **In-game (only) MUSE Discovery Service Library** -> muse/docs/lib/dds.md      
--:| dds: _Associates computer IDs with labels (as Muse roles) using Muse Query (MQ) rednet protocol._ -> dds  

--:> IDs: _Dictionary of ComputerCraft computer IDs keyed by MUSE role_ -> `[role]: ID`  

--:> ID: _ComputerCraft computer ID_ -> `#:`  

--:> roles: _Sparse array of Computercraft labels for MUSE roles indexed by Computercraft IDs_ -> `role[]`  

--:> role: _ComputerCraft label as MUSE role (may be qualified by_ `site` _for landed turtles)_ -> `":"`  

--:: dds.roleID(role: ":") -> _ID for a Muse role (qualified if need be)_ -> `ID: #:`   

--:: dds.role(ID: #:) ->  _Muse role (label) for a computer ID_ -> `role: ":"`  

--:: dds.join(role: ":", id: #:) -> _Qualify ID role association (label), id given by player._ -> `name: ":"`    
--:+ _On player to join a turtle to network and give it a role (and then over network through_ `lib/map` _to turtle)_  

--:: dds.site(site: ":"?) -> _Write (new) site file, set site and return it_ -> sited: ":"  

--:: dds.qualify(site: ":"?) -> _Create site file (default current site) if needed, set site, return role_ -> `qualified: ":"`  

--:: dds.playerID(id: #:?) -> _Isolate global_ -> #:  

--:: dds.hosts() -> _Populates players IDs and labels using a MQ rednet protocol._ -> `nil`  

--:: dds.map() -> Iterator from Muse roles to ComputerCraft IDs_ -> `():`, `{:}, `nil`  