--:! {check: [":"]: ():} <- Regression Check Functions Library -> muse/docs/lib/check.md    
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check  

--:# _Set Configuration Variables for tests: landed turtles, default site, tracking, delays, turtle `data` directory_  

--:: check.open(theTestSetTablePath:":", theTestSetName:":", theTestName:":") -> _Return object(closure)_ -> `{part:():, close:():}`  

--:: check.tests(testOrder: ":"[], testSetTablePath:":", testSetName:":") -> _Return ordered test names for regression._ -> `":"[]`  