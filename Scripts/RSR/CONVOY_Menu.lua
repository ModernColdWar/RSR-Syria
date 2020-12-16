-- Name: Convoy
-- Author: Wildcat (Chandawg)
-- Date Created: 29 Nov 2020
-- Will spawn a convoy based on the template in the miz, the command is wrapped it into the F10 menu option to be called by clients in 
-- Helos

---Count Convoys
local _BlueConvoyLeft = 16
local _RedConvoyLeft = 16

--- Event Handler
BlueConvoy_EventHandler = EVENTHANDLER:New()
BlueConvoy_EventHandler:HandleEvent( EVENTS.Birth )
RedConvoy_EventHandler = EVENTHANDLER:New()
RedConvoy_EventHandler:HandleEvent( EVENTS.Birth )

----Function to count the remaining number of Convoys
function RemainingBlueConvoy()
  trigger.action.outTextForCoalition(2, "[TEAM] Has " .. math.floor(_BlueConvoyLeft/4) .. " Remaining Convoys", 10)
end

----Function to count the remaining number of Convoys
function RemainingRedConvoy()
  trigger.action.outTextForCoalition(1, "[TEAM] Has " .. math.floor(_RedConvoyLeft/4) .. " Remaining Convoys", 10)
end

---Objects to be spawned with attributes set
Spawn_Blue_Convoy = SPAWN:New( 'Blue Convoy' )
    :InitLimit(16,4)
    
Spawn_Red_Convoy = SPAWN:New( 'Red Convoy' )
    :InitLimit(16,4)
                    
----Function to actually spawn the UAV from the players nose      
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
local SetClient5 = SET_CLIENT:New():FilterCoalitions("blue"):FilterPrefixes({" Blue Cargo"}):FilterStart()
local SetClient6 = SET_CLIENT:New():FilterCoalitions("red"):FilterPrefixes({" Red Cargo"}):FilterStart()
----Menus for the client
local function CONVOY_MENU()
  SetClient5:ForEachClient(function(client5)
      if (client5 ~= nil) and (client5:IsAlive()) then 
      local group5 = client5:GetGroup()
      local groupName = group5:GetName()
            BlueMenuGroup3 = group5
            BlueMenuGroupName3 = BlueMenuGroup3:GetName()
            ----Main Menu
            BlueSpawnCONVOY = MENU_GROUP:New( BlueMenuGroup3, "CONVOY" )
            ---- Sub Menu
            BlueSpawnCONVOYMenu = MENU_GROUP:New( BlueMenuGroup3, "Spawn Convoy", BlueSpawnCONVOY)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            BlueSpawnCONVOYrng1 = MENU_GROUP_COMMAND:New( BlueMenuGroup3, "Spawn Convoy 1/10 nmi off your nose", BlueSpawnCONVOY, BlueConvoy, BlueMenuGroup3, 0.1)
            BlueSpawnCONVOY2 = MENU_GROUP_COMMAND:New( BlueMenuGroup3, "Convoys Remaining", BlueSpawnCONVOY, RemainingBlueConvoy, BlueMenuGroup3)
            ---- Enters log information
            env.info("Player name: " ..client5:GetPlayerName())
            env.info("Group Name: " ..group5:GetName())
            
            function BlueConvoy_EventHandler:OnEventBirth( EventData )
              if EventData.IniDCSGroupName == 'Blue Convoy#001' then 
              _BlueConvoyLeft = _BlueConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nBlue Team has 1 remaining Convoys",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/4).." remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#002' then
              _BlueConvoyLeft = _BlueConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nBlue Team has No remaining Convoys",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/4).. " remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#003' then
              _BlueConvoyLeft = _BlueConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nBlue Team has No remaining Convoys",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/4).. " remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Blue Convoy#004' then
              _BlueConvoyLeft = _BlueConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nBlue Team has No remaining Convoys",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client5:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nBlue team has " ..math.floor(_BlueConvoyLeft/4).. " remaining Convoys", 10)
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
            RedSpawnCONVOY = MENU_GROUP:New( RedMenuGroup3, "CONVOY" )
            ---- Sub Menu
            RedSpawnCONVOYMenu = MENU_GROUP:New( RedMenuGroup3, "Spawn Convoy", RedSpawnCONVOY)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            RedSpawnCONVOYrng1 = MENU_GROUP_COMMAND:New( RedMenuGroup3, "Spawn Convoy 1/10 nmi off your nose", RedSpawnCONVOY, RedConvoy, RedMenuGroup3, 0.1)
            RedSpawnCONVOY2 = MENU_GROUP_COMMAND:New( RedMenuGroup3, "Convoys Remaining", RedSpawnCONVOY, RemainingRedConvoy, RedMenuGroup3)
            ---- Enters log information
            env.info("Player name: " ..client6:GetPlayerName())
            env.info("Group Name: " ..group6:GetName())           
            function RedConvoy_EventHandler:OnEventBirth( EventData )
              if EventData.IniDCSGroupName == 'Red Convoy#001' then 
              _RedConvoyLeft = _RedConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nRed Team has 1 remaining Convoys",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/4).." remaining Convoy units", 10)
              elseif EventData.IniDCSGroupName == 'Red Convoy#002' then
              _RedConvoyLeft = _RedConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nRed Team has No remaining Convoys",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/4).." remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Red Convoy#003' then
              _RedConvoyLeft = _RedConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nRed Team has No remaining Convoys",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/4).." remaining Convoys", 10)
              elseif EventData.IniDCSGroupName == 'Red Convoy#004' then
              _RedConvoyLeft = _RedConvoyLeft - 1
--              MESSAGE:New("Battalion is ready for tasking \nRed Team has No remaining Convoys",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client6:GetPlayerName().. "  called in a Convoy\nContact Tactical Commander on 124.000 MHz \nRed team has "..math.floor(_RedConvoyLeft/4).." remaining Convoy units", 10)
              else
              --nothing
              end
            end

            SetClient6:Remove(client6:GetName(), true)
    end
  end)
timer.scheduleFunction(CONVOY_MENU2,nil,timer.getTime() + 1)
end


CONVOY_MENU()
CONVOY_MENU2()