-- Name: Convoy
-- Author: Wildcat (Chandawg)
-- Date Created: 29 Nov 2020
-- Will spawn a convoy based on the template in the miz, the command is wrapped it into the F10 menu option to be called by clients in 
-- Helos

--- Event Handler

BlueConvoy_EventHandler = EVENTHANDLER:New()
BlueConvoy_EventHandler:HandleEvent( EVENTS.Birth )

function BlueConvoy_EventHandler:OnEventBirth( EventData )
  if EventData.IniDCSGroupName == 'Blue Convoy#001' then 
  MESSAGE:New("Battalion is ready for tasking \nBlue Team has 1 remaining Convoys",10):ToBlue()
  elseif EventData.IniDCSGroupName == 'Blue Convoy#002' then
  MESSAGE:New("Battalion is ready for tasking \nBlue Team has No remaining Convoys",10):ToBlue()
  else
  --nothing
  end
end

--- Event Handler
RedConvoy_EventHandler = EVENTHANDLER:New()
RedConvoy_EventHandler:HandleEvent( EVENTS.Birth )

--Function to weed through birth events for the UAV Spawn
function RedConvoy_EventHandler:OnEventBirth( EventData )
  if EventData.IniDCSGroupName == 'Red Convoy#001' then 
  MESSAGE:New("Battalion is ready for tasking \nRed Team has 1 remaining Convoys",10):ToRed()
  elseif EventData.IniDCSGroupName == 'Red Convoy#002' then
  MESSAGE:New("Battalion is ready for tasking \nRed Team has No remaining Convoys",10):ToRed()
  else
  --nothing
  end
end
---Objects to be spawned with attributes set


Spawn_Blue_Convoy = SPAWN:New( 'Blue Convoy' )
    :InitLimit(16,2)
    
Spawn_Red_Convoy = SPAWN:New( 'Red Convoy' )
    :InitLimit(16,2)
                    
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
            ---- Enters log information
            env.info("Player name: " ..client5:GetPlayerName())
            env.info("Group Name: " ..group5:GetName())
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
            ---- Enters log information
            env.info("Player name: " ..client6:GetPlayerName())
            env.info("Group Name: " ..group6:GetName())
            SetClient6:Remove(client6:GetName(), true)
    end
  end)
timer.scheduleFunction(CONVOY_MENU2,nil,timer.getTime() + 1)
end


CONVOY_MENU()
CONVOY_MENU2()