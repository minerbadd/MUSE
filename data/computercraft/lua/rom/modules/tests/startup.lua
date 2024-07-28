---@diagnostic disable: undefined-field
os.setComputerLabel('gpsW');
fs.delete('startup.lua')
fs.copy('disk/install.lua', 'startup.lua'); 
os.sleep(5); 
os.reboot(); 
