--:! [check: [":"]: (:)] <- Regression Check Functions Library -> muse/docs/lib/check.md    
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check  

--:: check.open(theTestSetTablePath:":", theTestSetName:":", theTestName:":") -> _Return object(closure)_ -> `:[part:(:), close:(:)]:`  

--:: check.tests(testOrder:[], testSetTablePath:":", testSetName:":") -> _Return ordered test names for regression._ -> `":"[]`  