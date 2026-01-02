--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md    
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check  

--:# Get path to executable calling this library  

--:# Assumes tests directory structure as `tests/checks`  

--:# _Set Configuration Variables for tests: landed turtles, default site, tracking, delays, turtle `data` directory_  

--:# Find results (if any) from a previous test.  

--:# The poor man's object.... encapsulates but provides no inheritance facilities (didn't see the need to go there)  

--:: check.open(testName:":", text: ":") -> _Return object(closure)_ -> `{part:():, message:(): , close:():}`   

--:# Access functions for the `check` object, each check object is independent in itself  

--:# Run each test in this test directory that has expected results   

--:: check.regression(testOrder: ":"[]) -> _Run ordered test names for regression._ -> `":"[]`  

--:# Order to run tests comes from `tests/.regression`.  

--:# Load test with `regression` parameter `true`. Apply `check.open` in test with this parameter.  