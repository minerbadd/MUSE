--:! {check: []: (:)} <- **Regression Check Functions Library** -> muse/docs/lib/check.md    
--:| check: _Setup context, save and match expected results for parts of tests, run regression for those tests_ -> check  

--:: check.open(theTestSetTablePath:":", theTestSetName:":", theTestName:":") -> _Return object(closure)._ -> `:[part:(:), close:(:)]`  

--:: check.tests(testSetTablePath:":", testSetName:":") -> _Return iterator._ -> `(:)`  