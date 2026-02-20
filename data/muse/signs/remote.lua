---@meta

local  remote, _remote = {}, {}

-- Serialize server request.
-- remote.marshall(server: ":", command: ":", arguments: any[]):  `serverID: #:, request: ":" &: &!` <-

---@type fun( server: string,  command: string,  arguments: any[]):   serverID: number,  request: string 
function remote.marshall() end

-- RPC: Form serialized request table from command string and arguments. Get server ID from server name. Send request to server, wait for result, return call (default `remote.return`) callback function to result.
-- remote.call(server: ":", command: ":", arguments: any[], callback: ():?):  `any &: &!` <-

---@type fun( server: string,  command: string,  arguments: any[],  callback: function):   any 
function remote.call() end

-- Towards GPS player position.
-- remote.come(turtle: ":"):  `report: ":"` <-

---@type fun( turtle: string):   report: string 
function remote.come() end

-- Apply callback to deserialized client result.
-- remote.return(serverID: #:, resultString: ":", callback: ():):  `any` <-

---@type fun( serverID: number,  resultString: string,  callback: function):   any 
function remote.return() end

-- Default client side handling of server response: just print results as string.
-- remote.callback(results: any[]):  `nil` <-

---@type fun( results: any[]):   nil 
function remote.callback() end

-- Setup turtle to repeatedly wait for MC network requests, send MR results.
-- remote.wait():  `nil` <-

---@type fun():  nil 
function remote.wait() end

-- Request string to request table, return serialized result_.
-- remote.apply(clientID: #:, request: ":"):  `result: ":"` <-

---@type fun( clientID: number,  request: string):   result: string 
function remote.apply() end

-- Repeatedly towards player position, default rate _G.Muse.rates.tail seconds
-- remote.tail(turtle: ":", __ : "tail", rates: ":"?):  `nil`  <-

---@type fun( turtle: string,  __ : "tail",  rates: string?):   nil  
function remote.tail() end

-- On client: Prepare remote call to server turtle by getting player xyz position and forming argument table.
-- _remote.prepareHither(turtle: ":", command: ":"):  `turtle: ":", command: ":", xyz, ^:` <-

---@type fun( turtle: string,  command: string):   turtle: string,  command: string,  xyz,  boolean 
function _remote.prepareHither() end
return { remote =  remote, _remote = _remote}
