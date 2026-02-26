--:! {remote: [":"]: ():} <- **Functions Library for Remote Procedure Calls** -> muse/docs/lib/remote.md      
--:| remote: _Client and server side support for RPCs and client (player) side support for_ `come` _and_ `tail`. -> remote    
--:+ **Multiple returns are not supported. Errors are caught on servers and provided as error string to clients.**    
--:+ _For testing out-of-game, if client and server are the same, there are no network operations._  

--:# **Server Side Remote Call Operations: Protocols to Receive Muse Calls (MC), Send Muse Responses (MR)**  

--:: `serverApply(clientID: #:, request: ":")` -> _Request string to request table, return serialized result_. -> `result: ":"`  

--:: remote.wait() -> _Setup turtle to repeatedly wait for MC network requests, send MR results._ -> `nil`  

--:# **Client Side Remote Call Operations: Protocols to Send Muse Calls (MC), Receive Muse Responses (MR)**  

--:: `clientReturn(serverID: #:, resultString: ":", callback: ():)` -> _Apply callback to deserialized client result._ -> `any`  

--:: `clientMarshall(server: ":", command: ":", arguments: any[])` -> _Serialize server request._ -> `serverID: #:, request: ":" &: &!`  

--:: remote.call(server: ":", command: ":", arguments: any[], callback: ():?) -> _RPC:_ -> `any` `&: &!`    
--:+ _Form serialized request table from command string and arguments. Get server ID from server name._    
--:+ _Send request to server, wait for result, return call (default `remote.returns`) callback function to result._  

--:: remote.callback(results: any[]) -> _Default client side handling of server response: just print results as string._ -> `nil`  

--:# **Turtle fetch functions:** `come` **(once) and** `tail` **(repeatedly) to player**  

--:: remote.hither(turtle: ":", command: ":")` -> _On client:_ -> `turtle: ":", command: ":", xyz, ^:`    
--:+ _Prepare remote call to server turtle by getting player xyz position and forming argument table._  

--:: remote.come(turtle: ":") -> _Towards GPS player position._ -> `report: ":"`  

--:- come -> _Turtle towards GPS player position._  

--:: remote.tail(turtle: ":", __ : "tail", rates: ":"?) -> _Repeatedly towards player position, default rate _G.Muse.rates.tail seconds -> `nil`   

--:- tail rate? -> _Turtle every rate seconds towards player._  