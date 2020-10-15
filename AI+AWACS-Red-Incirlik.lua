AWACS_Red_Incirlik = SPAWN:New( "AWACS Red Incirlik" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )

RedDetectionSetGroup = SET_GROUP:New()
RedDetectionSetGroup:FilterCoalitions("red")
RedDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS" } )
RedDetectionSetGroup:FilterStart()
RedDetection = DETECTION_AREAS:New( RedDetectionSetGroup, 50000 )
RedA2ADispatcher = AI_A2A_DISPATCHER:New( RedDetection )

--Zones for CAP
--Need CAP Zones for Damascus, Aleppo, Incirlik, 
Incirlik_NorthCAPZone = ZONE_POLYGON:New( "Incirlik CAP Zone", GROUP:FindByName( "Incirlik CAP Zone" ) )

TEXACOTankerRed = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_2","TEXACO Red 1")
  :InitLimit(1,3)
--  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("TEXACO 2-1 is back on station",25,"TEXACO 2-1"):ToRed()
  end)
  :SpawnScheduled(1800,0.1) 

SHELLTankerRed = SPAWN
  :NewWithAlias("B_TANKER_KC135_1","SHELL Blue 1-1")
  :InitLimit(1,3)
--  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("SHELL Red 1-1 is back on station",25,"SHELL Red 1-1"):ToRed()
  end)
  :SpawnScheduled(3600,0.1) 
  
RedA2ADispatcher:SetSquadron( "22nd Fighter Aviation Regiment", AIRBASE.Syria.Incirlik, { "22nd Fighter Aviation Regiment" }, 12 ) --Mig31 Squadron
RedA2ADispatcher:SetSquadronCap( "22nd Fighter Aviation Regiment", Incirlik_NorthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
RedA2ADispatcher:SetSquadronCapInterval( "22nd Fighter Aviation Regiment", 2, 180, 540, 1 )

RedA2ADispatcher:SetDefaultTakeoffInAir()
RedA2ADispatcher:SetDefaultLandingAtEngineShutdown()

