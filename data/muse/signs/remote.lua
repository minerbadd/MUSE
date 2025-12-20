---@meta

local  remote, _remote = {}, {}

-- Default client side handling of server response: just print results as string.
-- remote.returns(results: any[]):  `nil` <-

---@type fun(results: any[]):  nil 
function remote.returns() end

-- Towards GPS player position.
-- remote.come(turtle: ":"):  `report: ":"` <-

---@type fun(turtle: string):  report: string 
function remote.come() end

-- Setup turtle to repeatedly wait for MC network requests, send MR results.
-- remote.wait():  `nil` <-

---@type fun():  nil 
function remote.wait() end

-- Repeatedly towards player position, default rate _G.Muse.rates.tail seconds
-- remote.tail(turtle: ":", __ : "tail", rates: ":"?):  `nil`  <-

---@type fun(turtle: string,  __ : "tail",  rates: string?):  nil  
function remote.tail() end

-- RPC: Form serialized request table from command string and arguments. Get server ID from server name. Send request to server, wait for result, return call (default `remote.return`) callback function to result.
-- remote.call(server: ":", command: ":", arguments: any[], callback: (:)?):  `any &: &!` <-

---@type fun(server: string,  command: string,  arguments: any[],  callback: function?):  any 
function remote.call() end

-- Request string to request table, return serialized result_.
-- _remote.serverRequest(clientID: #:, request: ":"):  `result: ":"` <-

---@type fun(clientID: number,  request: string):  result: string 
function _remote.serverRequest() end

-- On client: Prepare remote call to server turtle by getting player xyz position and forming argument table.
-- _remote.testCome(turtle: ":", command: ":"):  `turtle: ":", command: ":", xyz, ^:` <-

---@type fun(turtle: string,  command: string):  turtle: string,  command: string,  xyz,  boolean 
function _remote.testCome() end

-- Apply callback to deserialized client result.
-- _remote.clientResult(serverID: #:, resultString: ":", callback: (:)):  `any` <-

---@type fun(serverID: number,  resultString: string,  callback: function):  any 
function _remote.clientResult() end

-- Serialize server request.
-- _remote.prepareCall(server: ":", command: ":", arguments: any[]):  `serverID: #:, request: ":" &: &!` <-

---@type fun(server: string,  command: string,  arguments: any[]):  serverID: number,  request: string 
function _remote.prepareCall() end
return { remote =  remote, _remote = _remote}
