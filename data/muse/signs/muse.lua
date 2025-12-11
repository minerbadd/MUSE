return {
  ["_status_"] = {
  ["line"] = "--:- status level [filename] -> _Set reporting hurdle and optionally save reporting in log file._",
  ["sign"] = "status level [filename]  ",
  ["text"] = "Set reporting hurdle and optionally save reporting in log file.",
  ["kind"] = "cli",
}
,
  ["_join_"] = {
  ["line"] = "local role, id = ...; --:- join role id -> _Temporarily set mapping for next startup, id from turtle nameplate._",
  ["sign"] = "join role id  ",
  ["text"] = "Temporarily set mapping for next startup, id from turtle nameplate.",
  ["kind"] = "cli",
}
,
  ["_check.open:_"] = {
  ["line"] = "  --:: check.open(theTestSetTablePath:\":\", theTestSetName:\":\", theTestName:\":\") -> _Return object(closure)._ -> `:[part:(:), close:(:)]`",
  ["out"] = " `:[part:(:), close:(:)]`",
  ["sign"] = "check.open(theTestSetTablePath:\":\", theTestSetName:\":\", theTestName:\":\")  ",
  ["kind"] = "face",
  ["text"] = "Return object(closure).",
}
,
  ["_check.tests:_"] = {
  ["line"] = "  --:: check.tests(testSetTablePath:\":\", testSetName:\":\") -> _Return iterator._ -> `(:)`",
  ["out"] = " `(:)`",
  ["sign"] = "check.tests(testSetTablePath:\":\", testSetName:\":\")  ",
  ["kind"] = "face",
  ["text"] = "Return iterator.",
}
,
  ["_porter_"] = {
  ["line"] = "--:- porter command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "porter command argument...  ",
  ["kind"] = "cli",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
}
,
  [" check"] = {
  ["type"] = "lib",
  ["name"] = " check",
  ["childs"] = {
}
,
}
,
  ["_logger_"] = {
  ["line"] = "--:- logger command argument... -> _ _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "logger command argument...  ",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
  ["kind"] = "cli",
}
,
  ["_farmer_"] = {
  ["line"] = "--:- farmer command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "farmer command argument...  ",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
  ["kind"] = "cli",
}
,
  ["_tail_"] = {
  ["line"] = "--:- tail rate? -> _Move `rover` every rate (default 5) seconds towards GPS player position._",
  ["sign"] = "tail rate?  ",
  ["text"] = "Move `rover` every rate (default 5) seconds towards GPS player position.",
  ["kind"] = "cli",
}
,
  ["_miner_"] = {
  ["line"] = "--:- miner command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "miner command argument...  ",
  ["kind"] = "cli",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
}
,
  ["_wait_"] = {
  ["line"] = "--:- wait -> _Locally on turtle, wait for rednet message. Useful as recovery for uncaught turtle error._  ",
  ["sign"] = "wait  ",
  ["text"] = "Locally on turtle, wait for rednet message. Useful as recovery for uncaught turtle error.",
  ["kind"] = "cli",
}
,
  ["_come_"] = {
  ["line"] = "--:- come -> _rover turtle towards GPS player position._",
  ["sign"] = "come  ",
  ["kind"] = "cli",
  ["text"] = "rover turtle towards GPS player position.",
}
,
  ["_rover_"] = {
  ["line"] = "--:- rover command argument... -> _See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface._",
  ["sign"] = "rover command argument...  ",
  ["text"] = "See <a href=\"../lib/net.html\" target=\"_blank\">/lib/net</a> for the remote command line interface.",
  ["kind"] = "cli",
}
,
  ["check"] = {
  ["childs"] = {
  ["tests"] = {
  ["returns"] = " `(:)` <-\
",
  ["args"] = "testSetTablePath:\":\", testSetName:\":\"",
  ["type"] = "function",
  ["name"] = "check.tests",
  ["description"] = "\
Return iterator.",
}
,
  ["open"] = {
  ["returns"] = " `:[part:(:), close:(:)]` <-\
",
  ["args"] = "theTestSetTablePath:\":\", theTestSetName:\":\", theTestName:\":\"",
  ["type"] = "function",
  ["name"] = "check.open",
  ["description"] = "\
Return object(closure).",
}
,
}
,
  ["returns"] = " check",
  ["kind"] = "module",
  ["type"] = "lib",
  ["name"] = "check",
  ["description"] = "\
Setup context, save and match expected results for parts of tests, run regression for those tests_ -> check",
}
,
}
