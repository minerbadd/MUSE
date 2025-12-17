--:! [port: [":"]: (:)] <- **Transport Operations Command Line Library** -> muse/docs/lib/port.md      
--:| port: _CLL for `book` and `port` commands assessing and clearing player inventory for specified teleport._ -> port  

--:# Partially consumed inventory items add to the energy `bank` used to decrease a future porting cost in a session.  

--:# Default player inventory items are considered for `book` and `port` (porting) operations.  

--:> port.item: _Short inventory item name for booking_ -> `"iron"|"copper"|"gold"|"redstone"`  

--:# Rather arbitrarly, height for porting includes a player standing on a turtle  

--:# **Support and test functions for `book` and `port` operations.**    
--:+ _Assess player inventory considered for energy available to do work._  

--:: port.inventory(costToPay: #:, orderedItems: port.order, playerInventory: [port.item]: #:) -> _Testing_ -> `":"[], #:, #:`    
--:+ _Returns payment inventory used for `costToPay`, excess energy to bank, inventory energy used_  

--:> port.order: _Order in which inventory items will be considered for booking_ -> `port.item[]`  

--:: port.available(set: [port.item]: #:) -> _For Testing: mock player inventory_ -> `[port.item]: #:`  

--:: port.book(name: ":", label: ":", from: place, to: place, span: #:, ordering: port.order) -> _Testing_ -> `booking: ":"`    
--:+ _Booking (string) names the `range` entry that will be used to specify a `port` operation and how to pay for it._    
--:+ _Return needed inventory for booking and bankable if > 0_  

--:# **Booking from place spanning area to place, offering items for port operation**  

--:- book name label from to span? item??... ->  _Spanned range with (default) items as properties; return cost less bank._  

--:# Save booking as a `range` with `span` and offered or default ordering of items as `range` properties  

--:# **Port operation consuming player inventory offered in booking.**  

--:- port booking -> _As provided in booking, consume player inventory to teleport entities from one area to another._  

--:# **If this is in-game, do the port and if successful, pay for it by clearing counts of selected items**  

--:: port.op(commands: ":"[]) -> _Command Line Interface for teleport book and trip:_ -> `":" &:`  