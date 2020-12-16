-- Name: UAV Recon
-- Author: Wildcat (Chandawg)
-- Date Created: 03 Nov 2020
-- Trying to spawn a UAV, then spawn it based on Client Helo position, then wrap it into a F10 menu option to be called by clients in 
-- Helos

---Count UAVs
local _BlueUAVsLeft = 6
local _RedUAVsLeft = 6

function RemainingBlueUAVs()
  trigger.action.outTextForCoalition(2, "[TEAM] Has " .. _BlueUAVsLeft .. " Remaining UAVs", 10)
end

function RemainingRedUAVs()
  trigger.action.outTextForCoalition(1, "[TEAM] Has " .. _RedUAVsLeft .. " Remaining UAVs", 10)
end

--- Event Handler
BlueUAV_EventHandler = EVENTHANDLER:New()
BlueUAV_EventHandler:HandleEvent( EVENTS.Birth )



--- Event Handler
RedUAV_EventHandler = EVENTHANDLER:New()
RedUAV_EventHandler:HandleEvent( EVENTS.Birth )


---Objects to be spawned with attributes set

--[[
Spawn_Blue_UAV = SPAWN:NewWithAlias("Blue UAV-Recon-FAC","Pontiac 1-1")
    :InitLimit(2,6)
    :InitKeepUnitNames(true)
    :OnSpawnGroup(function(SpawnedGroup)
      ctld.JTACAutoLase(SpawnedGroup.GroupName, 1687)
      end)
--    local _playerName = ctld.getPlayerNameOrType(_heli)
--    local _groupName = 'RECON_' .. _types[1] .. '_' .. _id .. ' (' .. _playerName .. ')' -- encountered some issues with       
    --:SpawnScheduled(30,0.5)
--]]
Spawn_Blue_UAV = SPAWN:NewWithAlias("Blue UAV-Recon-FAC","Pontiac 1-1")
    :InitLimit(2,6)
    
Spawn_Red_UAV = SPAWN:NewWithAlias("Red UAV-Recon-FAC","Pontiac 6-1")
    :InitLimit(2,6)
    :InitKeepUnitNames(true)

                    
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
            BlueSpawnRECONmenu = MENU_GROUP:New( BlueMenuGroup, "Spawn MQ-1 Recon UAV", BlueSpawnRECON)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            BlueSpawnRECONrng1 = MENU_GROUP_COMMAND:New( BlueMenuGroup, "1 nmi", BlueSpawnRECON, BlueUAV, BlueMenuGroup, 1)
            BlueSpawnRECONrng5 = MENU_GROUP_COMMAND:New( BlueMenuGroup, "5 nmi", BlueSpawnRECON, BlueUAV, BlueMenuGroup, 5)
            BlueSpawnRECONrng10 = MENU_GROUP_COMMAND:New( BlueMenuGroup, "10 nmi", BlueSpawnRECON, BlueUAV, BlueMenuGroup, 10)
            BlueRemainingUAVs = MENU_GROUP_COMMAND:New( BlueMenuGroup, "Remaining UAVs", BlueSpawnRECON, RemainingBlueUAVs, BlueMenuGroup)
            ---- Enters log information
            env.info("Player name: " ..client1:GetPlayerName())
            env.info("Group Name: " ..group1:GetName())

            function BlueUAV_EventHandler:OnEventBirth( EventData )
              if EventData.IniDCSGroupName == 'Pontiac 1-1#001' then 
              _BlueUAVsLeft = _BlueUAVsLeft - 1
--              MESSAGE:New("Pontiac 1-1 is on station contact on channel 133.000 MHz \nBlue Team has 5 remaining UAVs",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client1:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nBlue team has ".._BlueUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 1-1#002' then
              _BlueUAVsLeft = _BlueUAVsLeft - 1
--              MESSAGE:New("Pontiac 1-1 is on station contact on channel 133.000 MHz \nBlue Team has 4 remaining UAVs",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client1:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nBlue team has ".._BlueUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 1-1#003' then
              _BlueUAVsLeft = _BlueUAVsLeft - 1
--              MESSAGE:New("Pontiac 1-1 is on station contact on channel 133.000 MHz \nBlue Team has 3 remaining UAVs",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client1:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nBlue team has ".._BlueUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 1-1#004' then
              _BlueUAVsLeft = _BlueUAVsLeft - 1
--              MESSAGE:New("Pontiac 1-1 is on station contact on channel 133.000 MHz \nBlue Team has 2 remaining UAVs",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client1:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nBlue team has ".._BlueUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 1-1#005' then
              _BlueUAVsLeft = _BlueUAVsLeft - 1
--              MESSAGE:New("Pontiac 1-1 is on station contact on channel 133.000 MHz \nBlue Team has 1 remaining UAVs",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client1:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nBlue team has ".._BlueUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 1-1#006' then
              _BlueUAVsLeft = _BlueUAVsLeft - 1
--              MESSAGE:New("Pontiac 1-1 is on station contact on channel 133.000 MHz \nBlue Team has no remaining UAVs",10):ToBlue()
              trigger.action.outTextForCoalition(2,"[TEAM] " ..client1:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nBlue team has ".._BlueUAVsLeft.." remaining UAVs", 10)
              else
              --nothing
              end
            end

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
            SpawnRECONmenu = MENU_GROUP:New( RedMenuGroup, "Spawn MQ-1 Recon UAV", RedSpawnRECON2)
            ---- Command for the sub Menu the number on the end is the argument for the command (the rng) for the function
            RedSpawnRECONrng1 = MENU_GROUP_COMMAND:New( RedMenuGroup, "1 nmi", RedSpawnRECON2, RedUAV, RedMenuGroup, 1)
            RedSpawnRECONrng5 = MENU_GROUP_COMMAND:New( RedMenuGroup, "5 nmi", RedSpawnRECON2, RedUAV, RedMenuGroup, 5)
            RedSpawnRECONrng10 = MENU_GROUP_COMMAND:New( RedMenuGroup, "10 nmi", RedSpawnRECON2, RedUAV, RedMenuGroup, 10)
            RedRemainingUAVs = MENU_GROUP_COMMAND:New( RedMenuGroup, "Remaining UAVs", RedSpawnRECON2, RemainingRedUAVs, RedMenuGroup)
            ---- Enters log information
            env.info("Player name: " ..client2:GetPlayerName())
            env.info("Group Name: " ..group2:GetName())

            function RedUAV_EventHandler:OnEventBirth( EventData )
              if EventData.IniDCSGroupName == 'Pontiac 6-1#001' then 
              _RedUAVsLeft = _RedUAVsLeft - 1
--              MESSAGE:New("Pontiac 6-1 is on station contact on channel 133.000 MHz \nRed Team has 5 remaining UAVs",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client2:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nRed team has ".._RedUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 6-1#002' then
              _RedUAVsLeft = _RedUAVsLeft - 1
--              MESSAGE:New("Pontiac 6-1 is on station contact on channel 133.000 MHz \nRed Team has 4 remaining UAVs",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client2:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nRed team has ".._RedUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 6-1#003' then
              _RedUAVsLeft = _RedUAVsLeft - 1
--              MESSAGE:New("Pontiac 6-1 is on station contact on channel 133.000 MHz \nRed Team has 3 remaining UAVs",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client2:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nRed team has ".._RedUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 6-1#004' then
              _RedUAVsLeft = _RedUAVsLeft - 1
--              MESSAGE:New("Pontiac 6-1 is on station contact on channel 133.000 MHz \nRed Team has 2 remaining UAVs",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client2:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nRed team has ".._RedUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 6-1#005' then
              _RedUAVsLeft = _RedUAVsLeft - 1
--              MESSAGE:New("Pontiac 6-1 is on station contact on channel 133.000 MHz \nRed Team has 1 remaining UAVs",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client2:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nRed team has ".._RedUAVsLeft.." remaining UAVs", 10)
              elseif EventData.IniDCSGroupName == 'Pontiac 6-1#006' then
              _RedUAVsLeft = _RedUAVsLeft - 1
--             MESSAGE:New("Pontiac 6-1 is on station contact on channel 133.000 MHz \nRed Team has no remaining UAVs",10):ToRed()
              trigger.action.outTextForCoalition(1,"[TEAM] " ..client2:GetPlayerName().. " called in a UAV\nContact via F10/F8 Designation for JTAC \nRed team has ".._RedUAVsLeft.." remaining UAVs", 10)
              else
              --nothing
              end
            end

            SetClient2:Remove(client2:GetName(), true)
    end
  end)
timer.scheduleFunction(UAV_MENU2,nil,timer.getTime() + 1)
end


UAV_MENU()
UAV_MENU2()