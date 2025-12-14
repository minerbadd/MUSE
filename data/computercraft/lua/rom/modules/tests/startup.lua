--:? muse/docs/tests/startup.txt <- **Run Regression Test for Muse** -> muse/docs/tests/startup.md  
---@diagnostic disable: undefined-field
os.setComputerLabel('gpsW');
fs.delete('startup.lua')
fs.copy('disk/install.lua', 'startup.lua'); 
os.sleep(5); 
os.reboot(); 
