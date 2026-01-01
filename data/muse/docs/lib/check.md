--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md    
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check  

--:# _Set Configuration Variables for tests: landed turtles, default site, tracking, delays, turtle `data` directory_  

--:: check.open(testName:":", text: ":") -> _Return object(closure)_ -> `{part:():, close:():}`   

--:# Run each test in this test directory that has expected results   

--:: check.all(testOrder: ":"[]) -> _Run ordered test names for regression._ -> `":"[]`  