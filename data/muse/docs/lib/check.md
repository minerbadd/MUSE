--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md    
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check  

--:# Get path to calling executable  

--:# Assumes tests directory structure as `tests/checks`  

--:# Find results (if any) from a previous test.  

--:# The poor man's object.... encapsulates but provides no inheritance facilities (didn't see the need to go there)  

--:: check.open(testName:":", text: ":") -> _Return `check` object(closure)_ -> `{part:():, message:():, close:():}`   

--:# Access functions for the `check` object, each check object is independent in itself  

--:# part(partID: ":", note: ":", fun: ():, ...: any): -> _Collect ... results for part, save or compare (for regression)_ -> `nil`  

--:# message(..: ":"): -> _Print ... if not regression_ -> `nil`  

--:# close(text: ":"): -> _Print text if regression, otherwise save results in_ `checks` _directory for test_ -> `nil`  

--:# Run each test in this test directory that has expected results   

--:: check.regression(testOrder: ":"[]) -> _Run ordered test (names) for regression._ -> `nil`  

--:# Order to run tests comes from `tests/.regression`.  

--:# Load test with `regression` parameter `true`. Apply `check.open` in test with this parameter.  