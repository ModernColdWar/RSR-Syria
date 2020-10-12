AWACS_Red_Damascus= SPAWN:New( "AWACS Red Damascus" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )

RedDetectionSetGroup3 = SET_GROUP:New()
RedDetectionSetGroup3:FilterCoalitions("red")
RedDetectionSetGroup3:FilterPrefixes( { "EWR", "AWACS" } )
RedDetectionSetGroup3:FilterStart()
RedDetection3 = DETECTION_AREAS:New( RedDetectionSetGroup3, 50000 )
RedA2ADispatcher3 = AI_A2A_DISPATCHER:New( RedDetection3 )

--Zones for CAP
Damascus_SouthCAPZone = ZONE_POLYGON:New( "Damascus CAP Zone", GROUP:FindByName( "Damascus CAP Zone" ) )

TEXACOTankerRed3 = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_6","TEXACO Red 3")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("TEXACO Red 3-1 is back on station",25,"TEXACO Red 3-1"):ToRed()
  end)
  :SpawnScheduled(3600,0.1) 

TEXACOTankerRed3 = SPAWN
  :NewWithAlias("B_TANKER_KC135_6","SHELL Red 3")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("SHELL Red 3-1 is back on station",25,"SHELL Red 3-1"):ToRed()
  end)
  :SpawnScheduled(3600,0.1) 

RedA2ADispatcher3:SetSquadron( "24th Fighter Aviation Regiment", AIRBASE.Syria.Damascus, { "24th Fighter Aviation Regiment" }, 24 ) 
--MiG-31 Squadron
RedA2ADispatcher3:SetSquadronCap( "24th Fighter Aviation Regiment", Damascus_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
RedA2ADispatcher3:SetSquadronCapInterval( "24th Fighter Aviation Regiment", 4, 180, 540, 1 )

RedA2ADispatcher3:SetDefaultTakeoffInAir()
RedA2ADispatcher3:SetDefaultLandingAtEngineShutdown()