--:! {check: []: (:)} <- Regression Check Functions Library -> muse/docs/lib/check.md    
--:| check: Setup context, save and match expected results for parts of tests, run regression for those tests -> check  

--:: check.open(theTestSetTablePath:":", theTestSetName:":", theTestName:":") -> _Return object(closure)._ -> `:[part:(:), close:(:)]`  

--:: check.tests(testSetTablePath:":", testSetName:":") -> _Return iterator._ -> `(:)`  