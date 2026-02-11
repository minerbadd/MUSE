--:! {remote: [":"]: ():} <- **Functions Library for Remote Procedure Calls** -> muse/docs/lib/remote.md      
--:| remote: _Client and server side support for RPCs and client (player) side support for_ `come` _and_ `tail`. -> remote, _remote    
--:+ **Test functions are provided for out-of-game operations without a network.**  

--:# **Server Side Remote Call Operations: Protocols to Receive Muse Calls (MC), Send Muse Responses (MR)**  

--:: remote.wait() -> _Setup turtle to repeatedly wait for MC network requests, send MR results._ -> `nil`  

--:# **Client Side Remote Call Operations: Protocols to Send Muse Calls (MC), Receive Muse Responses (MR)**  

--:: remote.call(server: ":", command: ":", arguments: any[], callback: ():?) -> _RPC:_ -> `any &: &!`    
--:+ _Form serialized request table from command string and arguments. Get server ID from server name._    
--:+ _Send request to server, wait for result, return call (default `remote.return`) callback function to result._  

--:: remote.returns(results: any[]) -> _Default client side handling of server response: just print results as string._ -> `nil`  

--:# **Turtle fetch functions:** `come` **(once) and** `tail` **(repeatedly) to player**    
--:+ _Prepare remote call to server turtle by getting player xyz position and forming argument table._  

--:: remote.come(turtle: ":") -> _Towards GPS player position._ -> `report: ":"`  

--:- come -> _Turtle towards GPS player position._  

--:: remote.tail(turtle: ":", __ : "tail", rates: ":"?) -> _Repeatedly towards player position, default rate _G.Muse.rates.tail seconds -> `nil`   

--:- tail rate? -> _Turtle every rate seconds towards player._  