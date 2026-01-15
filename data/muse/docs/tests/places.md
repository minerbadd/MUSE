--:? muse/docs/tests/places.txt <- **Test `lib/places`** -> muse/docs/tests/places.md   

--:# Set configuration globals for tests by loading `lib/check`  

--:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`  

--:# Set log level default. Set lower to report less, higher to report more  

--:# Bind `testName` as the last word (without extension) in the execution path  

--:# Create the test object for this test  

--:# turtle.inspects east and up (two arms of makeDirections)  

--:# turtle.inventory -- returns currrent turtle inventory as table  

--:# turtle.check(targets, itemDetail) -- item inspected by turtle is in targets?  

--:# turtle.category check: test, dirt, nomatch, fill  

--:# turtle.fuel -- energy available in turtle slots  

--:# turtle.unblock(direction, limit) --waits, retrys for gravel; attacks  

--:# digTo unblocks and fails  

--:# digAround ok and fails  

--:# Close test object, report completion if we got here without errors  