-- Name: Convoy
-- Author: Wildcat (Chandawg)
-- Date Created: 29 Nov 2020
-- Date Modified: 27 Feb 2021
-- Will spawn a convoy based on the template in the miz, the command is wrapped it into the F10 menu option to be called by clients in 
-- Helos. Modified to spawn a C130 which then lands and spawns the convoy. Modified to account for a larger convoys size and added :InitCleanUp(120)to the C130 that are spawned in, this way they won't take up FC3 parking spaces

---Count Convoys
local _BlueConvoyLeft = 36
local _RedConvoyLeft = 36

--- Event Handler
BlueConvoy_EventHandler = EVENTHANDLER:New()
BlueConvoy_EventHandler:HandleEvent( EVENTS.Birth ):HandleEvent( EVENTS.Land )
RedConvoy_EventHandler = EVENTHANDLER:New()
RedConvoy_EventHandler:HandleEvent( EVENTS.Birth ):HandleEvent( EVENTS.Land )

----Function to count the remaining number of Convoys
function RemainingBlueConvoy()
  trigger.action.outTextForCoalition(2, "[TEAM] Has " .. math.floor(_BlueConvoyLeft/9) .. " Remaining Air Resupplies", 10)
end

----Function to count the remaining number of Convoys
function RemainingRedConvoy()
  trigger.action.outTextForCoalition(1, "[TEAM] Has " .. math.floor(_RedConvoyLeft/9) .. " Remaining Air Resupplies", 10)
end

---Objects to be spawned with attributes set
--https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Core.Spawn.html##(SPAWN).InitCleanUp
--InitCleanUp deletes the spawned object after not moving for 120 seconds.
Spawn_Blue_C130 = SPAWN:New( 'Blue C130' ):InitLimit(1,12)--:InitCleanUp(30)
    
Spawn_Red_C130 = SPAWN:New( 'Red C130' ):InitLimit(1,12)--:InitCleanUp(30)

Spawn_Blue_Convoy = SPAWN:New( 'Blue Convoy' ):InitLimit(36,9)

Spawn_Red_Convoy = SPAWN:New( 'Red Convoy' ):InitLimit(36,9)
                    
----Function to actually spawn the C130 from the players nose      
function BlueC130(group,rng)
  local range = rng * 1852
  local hdg = group:GetHeading()
  local pos = group:GetPointVec2()
  local spawnPt = pos:Translate(range, hdg, true)
  local spawnVec2 = spawnPt:GetVec2() 
  local spawnUnit = Spawn_Blue_C130:SpawnFromVec2(spawnVec2)
end

function RedC130(group,rng)
  local range = rng * 1852
  local hdg = group:GetHeading()
  local pos = group:GetPointVec2()
  local spawnPt = pos:Translate(range, hdg, true)
  local spawnVec2 = spawnPt:GetVec2() 
  local spawnUnit = Spawn_Red_C130:SpawnFromVec2(spawnVec2)
end
----Function to actually spawn the Convoy from the players nose once C130 has landed     
function BlueConvoy(group,rng)
  local range = rng * 1852
  local hdg = group:GetHeading()
  local pos = group:GetPointVec2()
  local spawnPt = pos:Translate(range, hdg, true)
  local spawnVec2 = spawnPt:GetVec2() 
  local spawnUnit = Spawn_Blue_Convoy:SpawnFromVec2(spawnVec2)
end

function RedConvoy(group,rng)
  local range = rng * 1852
  local hdg = group:GetHeading()
  local pos = group:GetPointVec2()
  local spawnPt = pos:Translate(range, hdg, true)
  local spawnVec2 = spawnPt:GetVec2() 
  local spawnUnit = Spawn_Red_Convoy:SpawnFromVec2(spawnVec2)
end

----Define the client to have the menu
local SetClient5 = SET_CLIENT:New():FilterCoalitions("blue"):FilterPrefixes({" Blue Cargo", " Blue Helos"}):FilterStart()
local SetClient6 = SET_CLIENT:New():FilterCoalitions("red"):FilterPrefixes({" Red Cargo", " Red Helos"}):FilterStart()
----Menus for the client
local function CONVOY_MENU()
  SetClient5:ForEachClient(function(client5)
      if (client5 ~= nil) and (client5:IsAlive()) then 
      local group5 = client5:GetGroup()
      local groupName = group5:GetName()
            BlueMenuGroup3 = group5
            BlueMenuGroupName3 = BlueMenuGroup3:GetName()
            ----Main Menu
            BlueSpawnCONVOY = MENU_GROUP:New( BlueMenuGroup3, "Air Resupply" )
            ---- Sub Menu
            BlueSpawnCONVOYMenu = MENU_GROUP:New( BlueMenuGroup3, "C130 Resupply", BlueSpawnCONVOY)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            BlueSpawnCONVOYrng1 = MENU_GROUP_COMMAND:New( BlueMenuGroup3, "Spawn C130 Air Resupply", BlueSpawnCONVOY, BlueC130, BlueMenuGroup3, 0.1)
            BlueSpawnCONVOY2 = MENU_GROUP_COMMAND:New( BlueMenuGroup3, "Air Resupplies Remaining", BlueSpawnCONVOY, RemainingBlueConvoy, BlueMenuGroup3)
            ---- Enters log information
            env.info("Player name: " ..client5:GetPlayerName())
            env.info("Group Name: " ..group5:GetName())
            
            function BlueConvoy_EventHandler:OnEventBirth( EventData )
              if EventData.IniDCSGroupName == 'Blue Convoy#001' then
                _BlueConvoyLeft = _BlueConvoyLeft - 1
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/9).." remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#002' then
                _BlueConvoyLeft = _BlueConvoyLeft - 1
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/9).. " remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#003' then
                _BlueConvoyLeft = _BlueConvoyLeft - 1
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/9).. " remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#004' then
                _BlueConvoyLeft = _BlueConvoyLeft - 1
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/9).. " remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#005' then
                _BlueConvoyLeft = _BlueConvoyLeft - 1
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/9).. " remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#006' then
                _BlueConvoyLeft = _BlueConvoyLeft - 1
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/9).. " remaining Convoys", 10)
              else
                --nothing
              end
              if EventData.IniDCSGroupName == 'Blue C130#001' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#002' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#003' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#004' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)                  
              elseif EventData.IniDCSGroupName == 'Blue C130#005' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#006' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#007' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#008' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)                  
              elseif EventData.IniDCSGroupName == 'Blue C130#009' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)                  
              elseif EventData.IniDCSGroupName == 'Blue C130#010' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)                  
              elseif EventData.IniDCSGroupName == 'Blue C130#011' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)                  
              elseif EventData.IniDCSGroupName == 'Blue C130#012' then
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client5:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)                  
              end              
            end

            function BlueConvoy_EventHandler:OnEventLand( EventData )
              if EventData.IniDCSGroupName == 'Blue C130#001' then 
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#002' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#003' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#004' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#005' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#006' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#007' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#008' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#009' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#010' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#011' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Blue C130#012' then
                BlueConvoy(BlueMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(2,"[TEAM] Blue C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(1,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              else
                  --nothing
              end
            end
            SetClient5:Remove(client5:GetName(), true)
    end
  end)
timer.scheduleFunction(CONVOY_MENU,nil,timer.getTime() + 1)
end
local function CONVOY_MENU2()
  SetClient6:ForEachClient(function(client6)
      if (client6 ~= nil) and (client6:IsAlive()) then 
      local group6 = client6:GetGroup()
      local groupName = group6:GetName()
            RedMenuGroup3 = group6
            RedMenuGroupName3 = RedMenuGroup3:GetName()
            ----Main Menu
            RedSpawnCONVOY = MENU_GROUP:New( RedMenuGroup3, "Air Resupply" )
            ---- Sub Menu
            RedSpawnCONVOYMenu = MENU_GROUP:New( RedMenuGroup3, "C130 Resupply", RedSpawnCONVOY)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            RedSpawnCONVOYrng1 = MENU_GROUP_COMMAND:New( RedMenuGroup3, "Spawn C130 Air Resupply", RedSpawnCONVOY, RedC130, RedMenuGroup3, 0.1)
            RedSpawnCONVOY2 = MENU_GROUP_COMMAND:New( RedMenuGroup3, "Air Resupplies Remaining", RedSpawnCONVOY, RemainingRedConvoy, RedMenuGroup3)
            ---- Enters log information
            env.info("Player name: " ..client6:GetPlayerName())
            env.info("Group Name: " ..group6:GetName())           
            function RedConvoy_EventHandler:OnEventBirth( EventData )
              if EventData.IniDCSGroupName == 'Red Convoy#001' then 
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Successfully Deployed a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/9).." remaining Convoy units", 10)
                _RedConvoyLeft = _RedConvoyLeft - 1
              elseif EventData.IniDCSGroupName == 'Red Convoy#002' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Successfully Deployed a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/9).." remaining Convoys", 10)
                _RedConvoyLeft = _RedConvoyLeft - 1
              elseif EventData.IniDCSGroupName == 'Red Convoy#003' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Successfully Deployed a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/9).." remaining Convoys", 10)
                _RedConvoyLeft = _RedConvoyLeft - 1
              elseif EventData.IniDCSGroupName == 'Red Convoy#004' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Successfully Deployed a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/9).." remaining Convoy units", 10)
                _RedConvoyLeft = _RedConvoyLeft - 1
              elseif EventData.IniDCSGroupName == 'Red Convoy#005' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Successfully Deployed a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/9).." remaining Convoy units", 10)
                _RedConvoyLeft = _RedConvoyLeft - 1
              elseif EventData.IniDCSGroupName == 'Red Convoy#006' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Successfully Deployed a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/9).." remaining Convoy units", 10)
                _RedConvoyLeft = _RedConvoyLeft - 1
              else
                --nothing
              end
              if EventData.IniDCSGroupName == 'Red C130#001' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#002' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#003' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#004' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)              
              elseif EventData.IniDCSGroupName == 'Red C130#005' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#006' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#007' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#008' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)              
              elseif EventData.IniDCSGroupName == 'Red C130#009' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)              
              elseif EventData.IniDCSGroupName == 'Red C130#010' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)              
              elseif EventData.IniDCSGroupName == 'Red C130#011' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)              
              elseif EventData.IniDCSGroupName == 'Red C130#012' then
                trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  Requested an Air Resupply\nESCORT REQUESTED", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] " ..client6:GetPlayerName().. "  The Air Operations Center has detected an enemy C130\nINTERCEPT IMMEDIATELY", 10)                            
              end
            end

            function RedConvoy_EventHandler:OnEventLand( EventData )
              if EventData.IniDCSGroupName == 'Red C130#001' then 
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#002' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#003' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#004' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#005' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#006' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#007' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#008' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#009' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#010' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#011' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              elseif EventData.IniDCSGroupName == 'Red C130#012' then
                RedConvoy(RedMenuGroup3, 0.1)
                trigger.action.outTextForCoalition(1,"[TEAM] Red C-130 Resupply Mission Successful", 10)
                trigger.action.outTextForCoalition(2,"[TEAM] C-130 Target Faded Intercept Mission Failure", 10)
              else
                --nothing
              end
            end
            SetClient6:Remove(client6:GetName(), true)
    end
  end)
timer.scheduleFunction(CONVOY_MENU2,nil,timer.getTime() + 2)
end

CONVOY_MENU()
CONVOY_MENU2()