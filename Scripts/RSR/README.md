# RSR-Syria

A persistent PvP mission for DCS world.

## Installation

 1. From your install folder (not saved games), open `Scripts/MissionScripting.lua`
 2. Comment out all the lines in the do block below the sanitization function with `-\-`.  This allows the LUA engine access to the file system. It should look similar to:
```lua
  --sanitizeModule('os')
  --sanitizeModule('io')
  --sanitizeModule('lfs')
  --require = nil
  --loadlib = nil
```
 3. Clone this repository: from your `Saved Games\DCS\Scripts` folder run `git clone https://github.com/ModernColdWar/RSR-Syria.git RSR`.  This should create a folder named `RSR` and in the end it should look like `Saved Games\DCS\Scripts\RSR`
 4. If you are new to github, and don't understand how to do step 3, you can download the files in a zip, then place the RSR folder and Hooks folders into your `Saved Games\DCS\Scripts`.
 5. Update your mission file to include a `DO SCRIPT` trigger to run `dofile(lfs.writedir() .. [[Scripts\RSR\RSR.lua]])` Or Download the latest mission file in use <a href="https://github.com/ModernColdWar/Miz-Files">Mission Files</a>
 6. Follow the steps on the [Developer Setup wiki page](https://github.com/ModernColdWar/RedStormRising/wiki/DeveloperSetup).

## <a href="https://github.com/ModernColdWar/RedStormRising">LUA files</a>
The RSR/RedStormRising repository contains all the lua files required to run the mission. Once tested, submited and approved they are sent to the server and loaded. All the scripts are loaded through the RSR.lua 
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/AWACS_Tankers.lua">AWACS-Tankers.lua</a>
The <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/AWACS_Tankers.lua">AWACS-Tankers.lua</a> Contains moose snippets that generate an F10 menu to allow aircraft to call in AWACS and Tankers into the mission. 
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/CSAR.lua">CSAR.lua</a>
The <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/CSAR.lua">CSAR.lua</a> script allows for downed pilots to be recovered, and thier life returned. We also use the CSAR script to manage pilots lifes on a per restart basis.
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/EWRS.lua">EWRS.lua</a>
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/JTAC_Designate.lua">JTAC-Designate.lua</a>
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/Moose.lua">Moose.lua</a>
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/SGS_RSR.lua">SGS_RSR.lua</a>
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/UAV_Recon.lua">UAV-Recon.lua</a>
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/WeaponManager.lua">WeaponManager.lua</a>
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/mist_4_4_90.lua">mist_4_4_90.lua</a>
### <a href="https://github.com/ModernColdWar/RSR-Syria/blob/main/RSR/warehouseResupply.lua">warehouseResupply.lua</a>
