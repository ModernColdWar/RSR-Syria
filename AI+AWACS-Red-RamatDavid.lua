AWACS_Red_RamatDavid = SPAWN:New( "AWACS Red Ramat David" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )

RedDetectionSetGroup2 = SET_GROUP:New()
RedDetectionSetGroup2:FilterCoalitions("red")
RedDetectionSetGroup2:FilterPrefixes( { "EWR", "AWACS" } )
RedDetectionSetGroup2:FilterStart()
RedDetection2 = DETECTION_AREAS:New( RedDetectionSetGroup, 50000 )
RedA2ADispatcher2 = AI_A2A_DISPATCHER:New( RedDetection2 )

--Zones for CAP
RamatDavid_SouthCAPZone = ZONE_POLYGON:New( "Ramat David CAP Zone", GROUP:FindByName( "Ramat David CAP Zone" ) )

TEXACOTankerRed2 = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_4","TEXACO Red 2")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("TEXACO Red 2-1 is back on station",25,"TEXACO Red 2-1"):ToRed()
  end)
  :SpawnScheduled(3600,0.1) 

TEXACOTankerRed2 = SPAWN
  :NewWithAlias("B_TANKER_KC135_4","SHELL Red 2")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("SHELL Red 2-1 is back on station",25,"SHELL Red 2-1"):ToRed()
  end)
  :SpawnScheduled(3600,0.1) 

RedA2ADispatcher2:SetSquadron( "23rd Fighter Aviation Regiment", AIRBASE.Syria.Ramat_David, { "23rd Fighter Aviation Regiment" }, 12 ) 
--MiG-31 Squadron
RedA2ADispatcher2:SetSquadronCap( "23rd Fighter Aviation Regiment", RamatDavid_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
RedA2ADispatcher2:SetSquadronCapInterval( "23rd Fighter Aviation Regiment", 2, 180, 540, 1 )

RedA2ADispatcher2:SetDefaultTakeoffInAir()
RedA2ADispatcher2:SetDefaultLandingAtEngineShutdown()