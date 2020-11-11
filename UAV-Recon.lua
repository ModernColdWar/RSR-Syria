-- Name: UAV Recon
-- Author: Wildcat (Chandawg)
-- Date Created: 03 Nov 2020
-- Trying to spawn a UAV, then spawn it based on Client Helo position, then wrap it into a F10 menu option to be called by clients in 
-- Helos
BlueUAV_EventHandler = EVENTHANDLER:New()
BlueUAV_EventHandler:HandleEvent( EVENTS.Birth )

function BlueUAV_EventHandler:OnEventBirth( EventData )
  if EventData.IniDCSGroupName == 'Pontiac 1-1#001' then -- can get the number if you watch events like INFO    TERRAIN: lObjectFire::lObjectFire for building id=87883834
  MESSAGE:New("A UAV has been spawned, Blue Team has 3 remaining UAVs",10):ToBlue()
  elseif EventData.IniDCSGroupName == 'Pontiac 1-1#002' then
  MESSAGE:New("A UAV has been spawned, Blue Team has 2 remaining UAVs",10):ToBlue()
  elseif EventData.IniDCSGroupName == 'Pontiac 1-1#003' then
  MESSAGE:New("A UAV has been spawned, Blue Team has 1 remaining UAVs",10):ToBlue()
  elseif EventData.IniDCSGroupName == 'Pontiac 1-1#004' then
  MESSAGE:New("A UAV has been spawned, Blue Team has no remaining UAVs",10):ToBlue()
  else
  --nothing
  end
end

RedUAV_EventHandler = EVENTHANDLER:New()
RedUAV_EventHandler:HandleEvent( EVENTS.Birth )

function RedUAV_EventHandler:OnEventBirth( EventData )
  if EventData.IniDCSGroupName == 'Pontiac 6-1#001' then -- can get the number if you watch events like INFO    TERRAIN: lObjectFire::lObjectFire for building id=87883834
  MESSAGE:New("A UAV has been spawned, Red Team has 3 remaining UAVs",10):ToRed()
  elseif EventData.IniDCSGroupName == 'Pontiac 6-1#002' then
  MESSAGE:New("A UAV has been spawned, Red Team has 2 remaining UAVs",10):ToRed()
  elseif EventData.IniDCSGroupName == 'Pontiac 6-1#003' then
  MESSAGE:New("A UAV has been spawned, Red Team has 1 remaining UAVs",10):ToRed()
  elseif EventData.IniDCSGroupName == 'Pontiac 6-1#004' then
  MESSAGE:New("A UAV has been spawned, Red Team has no remaining UAVs",10):ToRed()
  else
  --nothing
  end
end
---Objects to be spawned with attributes set
Spawn_Blue_UAV = SPAWN:NewWithAlias("Blue UAV-Recon-FAC","Pontiac 1-1")
    :InitLimit(2,6)
    :OnSpawnGroup(function(Pontiac_11)
      Pontiac_11:CommandSetCallsign(8, 1)
      MESSAGE:New("Pontiac 1-1 is on station contact on channel 133.000 MHz",25,"Pontiac 1-1"):ToBlue()
      end)
    --:SpawnScheduled(30,0.5)
    
--- Event Handler
--Function to weed through birth events for the UAV Spawn

--[[UAVLimit = 4
function Spawn_Blue_UAV:InitUnControlled(UnControlled)_OnBirth( EventData )
  if EventData.IniDCSGroupName == 'Pontiac 6-1#001' then 
    env.info("UAV Spawned")
    MESSAGE:New("Test UAV Spawn Message"):ToAll()    
    else
    --ignore
    end
end
Spawn_Blue_UAV:HandleEvent( EVENTS.Birth )--]]

Spawn_Red_UAV = SPAWN:NewWithAlias("Red UAV-Recon-FAC","Pontiac 6-1")
    :InitLimit(2,6)
    :InitKeepUnitNames(true)
    :OnSpawnGroup(function(Pontiac_61)
      Pontiac_61:CommandSetCallsign(8, 6)
      MESSAGE:New("Pontiac 6-1 is on station contact on channel 133.000 MHz",25,"Pontiac 6-1"):ToRed()end)
          
----Function to actually spawn the UAV from the players nose      
function BlueUAV(group,rng)
  local range = rng * 1852
  local hdg = group:GetHeading()
  local pos = group:GetPointVec2()
  local spawnPt = pos:Translate(range, hdg, true)
  local spawnVec3 = spawnPt:GetVec3() 
  local spawnUnit = Spawn_Blue_UAV:SpawnFromVec3(spawnVec3)
end

function RedUAV(group,rng)
  local range = rng * 1852
  local hdg = group:GetHeading()
  local pos = group:GetPointVec2()
  local spawnPt = pos:Translate(range, hdg, true)
  local spawnVec3 = spawnPt:GetVec3() 
  local spawnUnit = Spawn_Red_UAV:SpawnFromVec3(spawnVec3)
end

----Define the client to have the menu
local SetClient = SET_CLIENT:New():FilterCoalitions("blue"):FilterPrefixes({" Blue Cargo"}):FilterStart()
local SetClient2 = SET_CLIENT:New():FilterCoalitions("red"):FilterPrefixes({" Red Cargo"}):FilterStart()
----Menus for the client
local function UAV_MENU()
  SetClient:ForEachClient(function(client1)
      if (client1 ~= nil) and (client1:IsAlive()) then 
      local group1 = client1:GetGroup()
      local groupName = group1:GetName()
            BlueMenuGroup = group1
            BlueMenuGroupName = BlueMenuGroup:GetName()
            ----Main Menu
            BlueSpawnRECON = MENU_GROUP:New( BlueMenuGroup, "RECON" )
            ---- Sub Menu
            BlueSpawnRECONmenu = MENU_GROUP:New( BlueMenuGroup, "Spawn MQ-9 Recon UAV", BlueSpawnRECON)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            BlueSpawnRECONrng1 = MENU_GROUP_COMMAND:New( BlueMenuGroup, "1 nmi", BlueSpawnRECON, BlueUAV, BlueMenuGroup, 1)
            BlueSpawnRECONrng5 = MENU_GROUP_COMMAND:New( BlueMenuGroup, "5 nmi", BlueSpawnRECON, BlueUAV, BlueMenuGroup, 5)
            BlueSpawnRECONrng10 = MENU_GROUP_COMMAND:New( BlueMenuGroup, "10 nmi", BlueSpawnRECON, BlueUAV, BlueMenuGroup, 10)
            ---- Enters log information
            env.info("Player name: " ..client1:GetPlayerName())
            env.info("Group Name: " ..group1:GetName())
            SetClient:Remove(client1:GetName(), true)
    end
  end)
timer.scheduleFunction(UAV_MENU,nil,timer.getTime() + 1)
end
local function UAV_MENU2()
  SetClient2:ForEachClient(function(client2)
      if (client2 ~= nil) and (client2:IsAlive()) then 
      local group2 = client2:GetGroup()
      local groupName = group2:GetName()
            RedMenuGroup = group2
            RedMenuGroupName = RedMenuGroup:GetName()
            ----Main Menu
            RedSpawnRECON2 = MENU_GROUP:New( RedMenuGroup, "RECON" )
            ---- Sub Menu
            SpawnRECONmenu = MENU_GROUP:New( RedMenuGroup, "Spawn MQ-9 Recon UAV", RedSpawnRECON2)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            RedSpawnRECONrng1 = MENU_GROUP_COMMAND:New( RedMenuGroup, "1 nmi", RedSpawnRECON2, RedUAV, RedMenuGroup, 1)
            RedSpawnRECONrng5 = MENU_GROUP_COMMAND:New( RedMenuGroup, "5 nmi", RedSpawnRECON2, RedUAV, RedMenuGroup, 5)
            RedSpawnRECONrng10 = MENU_GROUP_COMMAND:New( RedMenuGroup, "10 nmi", RedSpawnRECON2, RedUAV, RedMenuGroup, 10)
            ---- Enters log information
            env.info("Player name: " ..client2:GetPlayerName())
            env.info("Group Name: " ..group2:GetName())
            SetClient2:Remove(client2:GetName(), true)
    end
  end)
timer.scheduleFunction(UAV_MENU2,nil,timer.getTime() + 1)
end


UAV_MENU()
UAV_MENU2()