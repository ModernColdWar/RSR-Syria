--[[
function spawnAWACS(spawnTemplatePrefix, spawnLimit)
    SPAWN:New(spawnTemplatePrefix)
         :InitLimit(1, spawnLimit)
         :InitRepeat()
         :SpawnScheduled(3600, 0.05)
end
--]]

--[[
function SpawnE3()
  E3_AWACS = SPAWN:New("Darkstar Awacs Group")
        :OnSpawnGroup(
            function(group)
                local zone1 = ZONE:New("Awacs Zone 1")
                local zone2 = ZONE:New("Awacs Zone 2")
                local AltRTB = 1500
                local OrbitAlt = 4444
                local OrbitSpeed = 250
                local AWACSPatrol = AI_AWACS:New(group, zone1, zone2, OrbitAlt, OrbitSpeed, AltRTB)
                local HomeAirbase = AIRBASE:FindByName(AIRBASE.Syria.Incirlik)
--                local HomeAirbase = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB)
                AWACSPatrol:SetHomeAirbase(HomeAirbase)
                AWACSPatrol:SetSpeed(450, 500)
                AWACSPatrol:SetRTBSpeed(300, 350)
                AWACSPatrol:SetAltitude(4444, 5000)
                AWACSPatrol:SetDisengageRadius(1000000)
                AWACSPatrol:SetFuelThreshold(0.91)
                AWACSPatrol:SetDamageThreshold(0.05)
                AWACSPatrol:__Start(3)
                
                --Tanker Takeoff--
                group:HandleEvent( EVENTS.Takeoff)
                  function group:OnEventTakeoff( EventData )
                  group:MessageToAll( "Taking Off from Incirlik", 15 )
                  MESSAGE:New( group:GetTypeName().." "..group:GetCallsign().."" ..group:GetFuel().. " fuel low!\nLess than 20000lbs for offload - RTB imminent", 30 ):ToAll()  
                  end
              
               --Tanker RTB----Spawn
               --local TestScheduler = SCHEDULER:New( nil, 
               --function()
               -- TankerFuel = group:GetFuel()
               -- if TankerFuel <= 0.99 and TankerMSG ~=1 then
               -- group:MessageToAll( "Tanker RTB, 3000")   
               -- TankerMSG = 1
               -- KC_135MPRS_SPAWN()
              --end
              --end, {}, 1, 1)
            end
        )
        --:InitRepeatOnEngineShutDown()
        --:InitLimit(2,99)
        :SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Syria.Incirlik ), SPAWN.Takeoff.Cold )
end   

SpawnE3()
--]]

AWACS_Blue_Incirlik = SPAWN:New( "AWACS Blue Incirlik" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )
--AWACS_Red_Aleppo = SPAWN:New( "AWACS Red Aleppo" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )

RedDetectionSetGroup = SET_GROUP:New()
RedDetectionSetGroup:FilterCoalitions("red")
RedDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS" } )
RedDetection = DETECTION_AREAS:New( RedDetectionSetGroup, 50000 )
RedA2ADispatcher = AI_A2A_DISPATCHER:New( RedDetection )

BlueDetectionSetGroup = SET_GROUP:New()
BlueDetectionSetGroup:FilterCoalitions("blue")
BlueDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS" } )
BlueDetectionSetGroup:FilterStart()
BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 50000 )
BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

--[[
--Zones for CAP
--Need CAP Zones for Damascus, Aleppo, Incirlik, 
KrasC_NorthCAPZone = ZONE_POLYGON:New( "Kras-C CAP Zone", GROUP:FindByName( "Kras-C CAP Zone" ) )

Vaziani_SouthCAPZone = ZONE_POLYGON:New( "Vaziani CAP Zone", GROUP:FindByName( "Vaziani CAP Zone" ) )

function M.onMissionStart(awacsBases, awacsSpawnLimit)
    if KrasC_Ownership == "blue" then
      TEXACOTankerBlue = SPAWN
        :NewWithAlias("B_TANKER_KC135MPRS_1","TEXACO Blue 1")
        :InitLimit(1,3)
        :InitCleanUp(30)
        :OnSpawnGroup(function(SpawnedGroup)
          MESSAGE:New("TEXACO 1-1 is back on station",25,"TEXACO 1-1"):ToBlue()
          end)
        :SpawnScheduled(1800,0.1)
    elseif KrasC_Ownership == "red" then
      TEXACOTankerRed = SPAWN
        :NewWithAlias("R_TANKER_KC135MPRS_1","TEXACO Red 1")
        :InitLimit(1,3)
        :InitCleanUp(30)
        :OnSpawnGroup(function(SpawnedGroup)
          MESSAGE:New("TEXACO 141 is back on station",25,"TEXACO 141"):ToRed()
          end)
        :SpawnScheduled(1800,0.1)
    end   

    local Vaziani_Ownership = state.getOwner("Vaziani")
    if Vaziani_Ownership == "red" then
      RedA2ADispatcher:SetSquadron( "472nd Fighter Aviation Regiment", AIRBASE.Caucasus.Vaziani, { "472nd Fighter Aviation Regiment" }, 6 ) -- MiG-23 Squadron
      RedA2ADispatcher:SetSquadronCap( "472nd Fighter Aviation Regiment", Vaziani_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
      RedA2ADispatcher:SetSquadronCapInterval( "472nd Fighter Aviation Regiment", 2, 180, 540, 1 )
    elseif Vaziani_Ownership == "blue" then
      BlueA2ADispatcher:SetSquadron( "313th Tactical Fighter Squadron", AIRBASE.Caucasus.Vaziani, { "313th Tactical Fighter Squadron" }, 12 ) --F4 Squadron
      BlueA2ADispatcher:SetSquadronCap( "313th Tactical Fighter Squadron", Vaziani_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
      BlueA2ADispatcher:SetSquadronCapInterval( "313th Tactical Fighter Squadron", 2, 180, 540, 1 )
    end
    if Vaziani_Ownership == "blue" then
      TEXACOTankerBlue2 = SPAWN
        :NewWithAlias("B_TANKER_KC135MPRS_2","TEXACO Blue 2")
        :InitLimit(1,3)
        :InitCleanUp(30)
        :OnSpawnGroup(function(SpawnedGroup)
          MESSAGE:New("TEXACO 2-1 is back on station",25,"TEXACO 2-1"):ToBlue()
          end)
        :SpawnScheduled(1800,0.1)
    elseif Vaziani_Ownership == "red" then
      TEXACOTankerRed2 = SPAWN
        :NewWithAlias("R_TANKER_KC135MPRS_2","TEXACO Red 2")
        :InitLimit(1,3)
        :InitCleanUp(30)
        :OnSpawnGroup(function(SpawnedGroup)
          MESSAGE:New("TEXACO is back on station",25,"TEXACO 142"):ToRed()
          end)
        :SpawnScheduled(1800,0.1)
    end       
end

RedA2ADispatcher:SetDefaultTakeoffInAir()
RedA2ADispatcher:SetDefaultLandingAtEngineShutdown()
BlueA2ADispatcher:SetDefaultTakeoffInAir()
BlueA2ADispatcher:SetDefaultLandingAtEngineShutdown()

TEXACOTankerBlue3 = SPAWN
  :NewWithAlias("B_TANKER_S3_1","TEXACO Blue 3")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
    MESSAGE:New("TEXACO 3-1 is back on station",25,"TEXACO 3-1"):ToBlue()
    end)
  :SpawnScheduled(1800,0.1)
TEXACOTankerRed3 = SPAWN
  :NewWithAlias("R_TANKER_S3_1","TEXACO Red 3")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
    MESSAGE:New("TEXACO 3-1 is back on station",25,"TEXACO 1-1"):ToBlue()
    end)
  :SpawnScheduled(1800,0.1)
BlueCarrierAWACS = SPAWN
  :NewWithAlias("B_AWACS_E2_1","Overlord Blue 1")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
    MESSAGE:New("Overlord 1-1 is back on station",25,"Overlord"):ToBlue()
    end)
  :SpawnScheduled(1800,0.1)
RedCarrierAWACS = SPAWN
  :NewWithAlias("R_AWACS_E2_1","Overlord Red 1")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
    MESSAGE:New("Overlord 1-1 is back on station",25,"Overlord"):ToRed()
    end)
  :SpawnScheduled(1800,0.1)
--]]