--[[
## Remote Procedure Calls, RPCs: lib/remote.lua, Client Side `come` and `tail`
```md
--:! {remote: []: (:) } <- **Functions Library for Remote Procedure Calls** -> muse/docs/lib/remote.md  
--:| remote: _Client and server side support for RPCs and client (player) side support for_ `come` _and_ `tail`. -> remote, _remote
--:+ **Test functions are provided for out-of-game, no network operation.**

```
The library for MUSE support of remote procedure calls (RPC) is `lib/remote`. To do an RPC there are a bunch of steps choreographed between the `client`, generally the player's pocket computer, and the `server`, pretty much any other computer, turtle or otherwise. (Not the GPS computers though; they're busy doing GPS stuff.) 

At the dance waiting to be asked, all but the player's pocket computer are running `remote.wait` finishing up their execution of the `.start` daemon. They'll wait to receive a `rednet` MUSE Call (`MC`) protocol message. After doing the work requested by the call, they'll answer the call with a `rednet` MUSE Response (`MR`) protocol message. And then, in what we can think of as the RPC thread, go back to waiting.

We'll get to more about the dancing in a bit but first, the expected library introduction. Loading `lib/net` generates a dispatch table with references to the libraries that actually do the work of the remote call. 
  ```Lua
--]]
local _remote, remote = {}, {} ---@module "signs.remote" -- for functions that are internal and exported from library

package.path = _G.Muse.package
local cores = require("core"); local core = cores.core ---@module "signs.core"
local motion = require("motion"); local move = motion.move ---@module "signs.motion"
local ddss = require("dds"); local dds = ddss.dds ---@module "signs.dds"
local nets = require("net"); local net = nets.net ---@module "signs.net"

local rednet, parallel = _G.rednet, _G.parallel -- to supress static analysis lint warnings
--[[
``` 
<a id="dance"/a>As promised: the dance. It all starts, of course, with `remote.call`. The arguments to the call are evaluated by the client and then packaged up into strings that can be sent over the network by `prepareCall`. (This is testable out of game.) This lot is sent along to the the chosen server by `clientSend` as an `MC` protocol message. The client thread then waits for an `MR` protocol message in `clientReceive`.

The selected server, waiting for an `MC` protocol message as we've said, gets one. It kicks off a series of steps by calling `serverSend`. This calls `serverRequest` which calls `serverCall` which passes the actual work over to a library through a dispatch in `lib/net` as promised. The call chain then gets unwound: the computed result of doing the work gets returned to `serverRequest` which turns the computed result into strings that can be passed over the network. (Out-of-game, the steps from `serverRequest` to `serverCall` are testable with no need to deal with the network.) The return to `serverSend` sends a `MR` protocol message back to the client waiting in `clientReceive`. The call stack is then popped back to its caller, `remote.wait`. This is where we (or at least the server) came in. The server's work here is done.

Receiving the `MR` protocol message in `clientReceive`, the client deserializes the strings from the computed result on the server and returns the result to the caller of `remote.call` by calling `clientResult` (testable out-of-game). Yeah, it's as simple as that. So much for the overview. The details, God within or not, follow.

#Server Request: The End of the Beginning
<a id="serverRequest"/a> The most important part of the RPC work is done by a function that can be tested out-of-game: `serverRequest`. It's the first one we'll look at even though one of the last in the call chain for an RPC. It runs on the server and calls `serverCall` to do the work on the server. Its `request` argument is a serialized table whose first element is a string representing a command and whose second element is a table of strings representing the arguments of that command. (We can send strings over the network.) Execution of the function supporting the command has been deferred until it will be applied to the arguments at the remote server computer. The arguments themselves are evaluated locally at the client caller before being packaged up, that is, serialized, for transmission.

Lua's `load` function creates a deserializing function (or an indication of error). Calling that function creates the command (string) and a table of arguments for actual execution of the remote procedure. The command string is a key index dispatching into the table of functions exported by <a href="net.html" target="_blank"> `lib/net` </a> for remote execution. The function retrieved from that table of functions (`net[command]`) is applied on the server to the instantiated argument table to get (and return) a serialized table of computed `results`. For compatibility and safety, the table of functions includes only those functions that have been provided for execution in the remote (server) environment.
```Lua
--]]
--:# **Server Side Remote Call Operations: Protocols to Receive Muse Calls (MC), Send Muse Responses (MR)**
local function serverCall(command, argumentTable) -- **execute the call on the server**
  local netCall = net[command]; if not netCall then return "remote: No operation defined for "..command end
  local results = netCall(argumentTable); -- **TADA..actually do it: index into net functions applied to arguments** 
  return results
end

function _remote.serverRequest(clientID, request) -- test as `remote.testRequest`
  --:: `_remote.serverRequest(clientID: #:, request: ":")` -> _Request string to request table, return serialized result_. -> `result: ":"`
  local requestLoad, requestError = load(request); local client = dds.role(clientID) or clientID -- fallback:`join` no reboot
  core.status(3, "remote", "MR Request", request, "from", client)
  if not requestLoad then error("remote.request: Can't instantiate "..request.." from "..client.." "..requestError) end
  local command, argumentTable = table.unpack(requestLoad()) -- `command: ":"` for dispatch into net RPC functions
  core.status(3, "remote", "MR Dispatch", command, "from", client, "for", argumentTable)
  return core.serialize(serverCall(command, argumentTable)) -- table serialized as string
end; remote.testRequest = _remote.serverRequest; -- Test through_ `lib/net` _for server execution
--[[
```
Note that there's deliberately no executable representation for functions in the serialized argument table. It's just a string. While MUSE happens to operate in a homogeneous environment, no assumptions are made about compatible execution environments. That's a real issue in the real world. 

Further, while there are no untrusted actors in the MUSE environment, in other environments passing representations of functions could create an exposure that rogue actors could exploit. Additionally, <a href="core.html#serialize" target="_blank"> as we've seen </a>, special attention is paid in serialization of strings that could be evaluated to create exposures. All that as given however, only rogue wary functions are good for sever side execution. We're looking at you, `map.chart`.

#Server Send: The Server's Work Here Is Done
<a id="serverSend"></a> Because of testing considerations, the actual (instrumented) network operations are handled by relatively simple implementations. The `serverSend` function just calls `serverRequest`, the function we've just discussed and sends the serialized result back to the client using the `MR` (Muse Response) protocol to the requesting client (which will be the player's pocket computer). The `remote.wait` loop (`while true do`) patiently waits for `MC` (Muse Call) protocol messages and calls `serverSend` function whenever it receives one.
```Lua
--]]
local function serverSend(clientID, request) -- send serialized response from server execution of call
  core.status(4, "remote", "MC Server", request, "from", clientID)
  local result = _remote.serverRequest(clientID, request)
  core.status(4, "remote", "MR Server", result, "for", clientID)
  rednet.send(clientID, result, "MR") -- result back to player as `clientReceive()`
end -- server is done; remote.`wait()` for the next MuseCall ("MC") rednet message

function remote.wait() -- in-game turtle servers wait for MC calls and send MR results
--:: remote.wait() -> _Setup turtle to repeatedly wait for MC network requests, send MR results._ -> `nil`
  print("MC: Waiting On Call"); while true do -- Muse Call and Response
    local clientID, request = rednet.receive("MC")  -- Muse Call ("MC")
    serverSend(clientID, request) -- by Muse Response ("MR")
  end
end
--[[
```
The  <a href="../wait.html" target="_blank"> `wait` command </a> can be executed locally on a turtle to get a turtle waiting again for `MC` network messages after it has had an uncaught error. This is just a development convenience.

#Client Result: The End of the End
<a id="clientResult"></a> 
Back on the client that called for the RPC, the `clientResult` and `clientReceive` functions handle the return value from the remote call server. In the same way as done for the server side functions, `clientResult` can be tested out-of-game. It uses Lua's `load` function as `serverRequest` does. In this case, to deserialize the `result` from the serialized table sent over the network by the server. It applies a supplied <a href="https://en.wikipedia.org/wiki/Callback_(computer_programming)" target="_blank"> _deferred `callback`_ </a> function to the deserialized result table and saves the value `returned` by applying that function in a variable local to the library.
```Lua
--]]
--:# **Client Side Remote Call Operations: Protocols to Send Muse Calls (MC), Receive Muse Responses (MR)**
function _remote.clientResult(serverID, resultString, callback) -- test as `remote.testResult`
  --:: `_remote.clientResult(serverID: #:, resultString: ":", callback: (:))` -> _Apply callback to deserialized client result._ -> `any`
  core.status(3, "remote", "MR Client", resultString, "from", dds.role(serverID)) -- on player
  local resultFunction, resultError = load(resultString) -- unserialized for execution
  if resultFunction then local result = resultFunction(); return callback(result) end -- specified by caller of `remote.call` 
  error("remote.result: Can't load "..resultString.." from "..dds.role(serverID).." "..resultError) -- on player
end; remote.testResult = _remote.clientResult; -- export for testing

local returned -- result of applying callback to deserialized response from server

local function clientReceive(callback) -- receive result from "MR" protocol, apply callback to deserialized result
  core.status(4, "remote", "MR Client Waiting")
  local serverID, resultString = rednet.receive("MR") -- **waiting for result from server**
  core.status(4, "remote", "MR Client Received", resultString, "from", dds.role(serverID)) -- on player
  returned =  _remote.clientResult(serverID, resultString, callback) -- gets the value from calling the callback
end
--[[
```
The MUSE DDS facilities called on above <a href="dds.html" target="_blank"> are worth an excursion</a>. They map a MUSE role to a ComputerCraft computer ID by calling `dds.roleID` and back again calling `dds.role`. This abstracts away the need to be concerned with the detail of which ComputerCraft computer IDs happen to be assigned to which turtles performing which MUSE roles in a Minecraft world.

#Client Send: The Beginning of the Beginning
<a id="clientSend"/a> Working backwards toward the origin of the remote call, let's look at `prepareCall`, testable in the out-of-game environment. It serializes a table that has the command as the first element and a table of arguments for the command as its second. The serialized `request` and the ID for the turtle server are returned to `clientSend` which, in the same pattern we've seen above, does the actual network operations to kick off the RPC.  In this case, the client player waits with `parallelWaitForAny` for a network event. When it receives the kind it's waiting for, it invokes an anonymous closure calling `clientReceive` with a `callback` argument.
```Lua
--]]
-- _Send serialized string from `remote.call` to network and wait for result from server_
function _remote.prepareCall(server, command, arguments) -- test as `remote.testCall`
--:: `_remote.prepareCall(server: ":", command: ":", arguments: any[]})` -> _Serialize server request._ -> `serverID: #:, request: ":" &: &!`
  local serialOK, request = core.pass(pcall(core.serialize, {command, arguments})) 
  if not serialOK then error("remote.call: Can't serialize "..command.." for".." "..request) end
  local serverID = dds.roleID(server); if not serverID then error("remote.call: unknown target "..server) end
  return serverID, request -- on player client for send to turtle server
end; remote.testCall = _remote.prepareCall

local function clientSend(serverID, request, callback) 
  core.status(3, "remote", "MC Sending", request, "to", serverID..":"..dds.role(serverID)) -- on player
  rednet.send(serverID, request, "MC" ); 
  parallel.waitForAny(function() clientReceive(callback) end)
  return returned -- side effect of clientReceive (parallel.waitForAny in CC:Tweaked returns `nil`)
end

local function localCall(clientID, serverID, request, callback) -- no need for network: client and server are the same
  local resultString = _remote.serverRequest(clientID, request)
  returned =  _remote.clientResult(serverID, resultString, callback)
end
--[[
```
#Calling It
<a id="call"/a>The client's `remote.call` function makes use of all the pieces we've looked at above. Together they prepare and send a `request` with the `command` together with its client evaluated `argumentsTable` to the named turtle server. The remotely supplied function supporting the command is remotely applied to its arguments and the result packaged up for the client.

The `remote.returns` function is the default `callback` function handling the result back on the client. 
```Lua
--]]
function remote.call(server, command, arguments, callback) -- client command line: command, arguments
  --:: remote.call(server: ":", command: ":", arguments: any[], callback: (:)?) -> _RPC:_ -> `any &: &!`
  --:+ _Form serialized request table from command string and arguments. Get server ID from server name._
  --:+ _Send request to server, wait for result, return call (default `remote.return`) callback function to result._
  callback = callback or remote.returns -- a default (see below) if no `callback` argument
  local serverID, request = _remote.prepareCall(server, command, arguments); local clientID = core.getComputerID(0)
  if dds.roleID(server) ==  clientID then return localCall(clientID, serverID, request, callback) end -- short circuit
  local callOK, report = core.pass(pcall(clientSend, serverID, request, callback)) -- send and wait
  if not callOK then error("remote.call: Sending "..command.." request to "..server.." failed".." "..report) 
  end; return report
end

function remote.returns(results) print(core.string(results)) end 
--:: remote.returns(results: any[]) -> _Default client side handling of server response: just print results as string._ -> `nil`
--[[
```
#Come Hither
<a id="come"/a>That's all that seems to need saying about the design ideas for `remote.call`. Next, let's see a couple of ways of how it's used.

The `remote.come` and `remote.tail` functions locally evaluate <a href="core.html#where" target="_blank"> `where` </a> the player is, its `x`, `y`, `z` coordinates, and make a `remote.call` to the turtle server to perform a `command` using the turtle's `xyz` position table as the arguments for that command. The `come` and `tail` entries in the `lib/net` dispatch table reference the server side functions, `roam.com` and `roam.tail` which actually move the turtle.
```Lua
--]]
--:# **Turtle fetch functions:** `come` **(once) and** `tail` **(repeatedly) to player**
function _remote.prepareCome(turtle, command) -- **TEST** as much as possible done for out-game test
  --:: `_remote.testCome(turtle: ":", command: ":")` -> _On client:_ -> `turtle: ":", command: ":", xyz, ^:`
  --:+ _Prepare remote call to server turtle by getting player xyz position and forming argument table._
  local x, y, z, ok = move.where(); return turtle, command, {x, y, z}, ok -- player position, everything needed for `call`
end; remote.testCome = _remote.prepareCome

function remote.come(turtle) -- **needs GPS**
  --:: remote.come(turtle: ":") -> _Towards GPS player position._ -> `report: ":"`
  --:- come -> _Turtle towards GPS player position._
  local server, command, xyz, ok = _remote.prepareCome(turtle, "come")
  if not ok then error("remote.come: GPS failed") end
  local report = remote.call(server, command, xyz) or ""
  core.status(3, "remote", "come", report)
  return report 
end

function remote.tail(turtle, _, rates) --  **needs GPS**; turtle tails player by repeated commands to `come`
  --:: remote.tail(turtle: ":", __ : "tail", rates: ":"?) -> _Repeatedly towards player position, default rate _G.Muse.rates.tail seconds -> `nil` 
  --:- tail rate? -> _Turtle every rate seconds towards player._
  local rate = tonumber(rates) or _G.Muse.rates.tail; while true do -- assume good GPS
    local result, report = remote.call(_remote.prepareCome(turtle)) -- server, command, xyz
    core.status(5, "remote", "tail", result or "", report or ""); core.sleep(rate)
  end
end
--[[
```
#Exporting the Test Bindings
<a id="test"/a>The last part of `lib/remote` exports bindings for functions that can be used to test the library in the out-of-game environment.
```Lua
--]]
return {remote = remote}
--[[
```
#Excursions
Finally, in distributed operations, the kind of reporting that `core.status` and its close relatives provide can make clear what otherwise is very difficult to figure out. With all we're up to, it's time to follow the <a href="core.html#status" target="_blank"> link for an excursion</a> into that deferred discussion of the implementation of `core.status`. 

Then look at how <a href="net.html" target="_blank"> `lib/net`</a> actually creates the remote CLI we said we would discuss.

You can return to the next chapter of _Mining Muse_ with this <a href="../../Mining MUSE.html#Chapter6" target="_blank"> link</a> to actually dig stuff.
--]]