--:? muse/docs/tests/places.txt <- **Test `lib/places`** -> muse/docs/tests/places.md   

--:# Set configuration globals for tests by loading `lib/check`  

--:# Bind `regression` parameter `true` from call by `check.regression` in `lib/check`; otherwise `nil`  

--:# Set log level default. Set lower to report less, higher to report more  

--:# Bind `testName` as the last word (without extension) in the execution path  

--:# Create the test object for this test  

--:# Name and rename some places and verify their coordinates  

--:# test2	{10, 25, 35, }	test1	{10, 20, 30, }	head2	{10, 25, 35, }	tail1	{10, 20, 30, }  

--:# Close test object, report completion if we got here without errors  