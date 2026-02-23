---@meta

local  remote = {}

-- On client: Prepare remote call to server turtle by getting player xyz position and forming argument table.
-- remote.hither(turtle: ":", command: ":"):  `turtle: ":", command: ":", xyz, ^:` <-

---@type fun( turtle: string,  command: string):   turtle: string,  command: string,  xyz,  boolean 
function remote.hither() end

-- RPC: Form serialized request table from command string and arguments. Get server ID from server name. Send request to server, wait for result, return call (default `remote.returns`) callback function to result.
-- remote.call(server: ":", command: ":", arguments: any[], callback: ():?):  `any` `&: &!` <-

---@type fun( server: string,  command: string,  arguments: any[],  callback: function?):   any 
function remote.call() end

-- Towards GPS player position.
-- remote.come(turtle: ":"):  `report: ":"` <-

---@type fun( turtle: string):   report: string 
function remote.come() end

-- Request string to request table, return serialized result_.
-- serverApply(clientID: #:, request: ":"):  `result: ":"` <-

---@type fun( clientID: number,  request: string):   result: string 
function serverApply() end

-- Default client side handling of server response: just print results as string.
-- remote.callback(results: any[]):  `nil` <-

---@type fun( results: any[]):   nil 
function remote.callback() end

-- Repeatedly towards player position, default rate _G.Muse.rates.tail seconds
-- remote.tail(turtle: ":", __ : "tail", rates: ":"?):  `nil`  <-

---@type fun( turtle: string,  __ : "tail",  rates: string?):   nil  
function remote.tail() end

-- Apply callback to deserialized client result.
-- clientReturn(serverID: #:, resultString: ":", callback: ():):  `any` <-

---@type fun( serverID: number,  resultString: string,  callback: function):   any 
function clientReturn() end

-- Setup turtle to repeatedly wait for MC network requests, send MR results.
-- remote.wait():  `nil` <-

---@type fun():  nil 
function remote.wait() end

-- Serialize server request.
-- clientMarshall(server: ":", command: ":", arguments: any[]):  `serverID: #:, request: ":" &: &!` <-

---@type fun( server: string,  command: string,  arguments: any[]):   serverID: number,  request: string 
function clientMarshall() end
return { remote =  remote}
