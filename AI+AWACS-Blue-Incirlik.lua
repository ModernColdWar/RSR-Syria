AWACS_Blue_Incirlik = SPAWN:New( "AWACS Blue Incirlik" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )

BlueDetectionSetGroup = SET_GROUP:New()
BlueDetectionSetGroup:FilterCoalitions("blue")
BlueDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS" } )
BlueDetectionSetGroup:FilterStart()
BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 50000 )
BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

--Zones for CAP
--Need CAP Zones for Damascus, Aleppo, Incirlik, 
Incirlik_NorthCAPZone = ZONE_POLYGON:New( "Incirlik CAP Zone", GROUP:FindByName( "Incirlik CAP Zone" ) )


TEXACOTankerBlue = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_1","TEXACO Blue 1-1")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("TEXACO Blue 1-1 is back on station",25,"TEXACO Blue 1-1"):ToBlue()
  end)
  :SpawnScheduled(3600,0.1) 

TEXACOTankerBlue = SPAWN
  :NewWithAlias("B_TANKER_KC135_1","SHELL Blue 1-1")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("SHELL Blue 1-1 is back on station",25,"SHELL Blue 1-1"):ToBlue()
  end)
  :SpawnScheduled(3600,0.1) 
  
BlueA2ADispatcher:SetSquadron( "313th Tactical Fighter Squadron", AIRBASE.Syria.Incirlik, { "313th Tactical Fighter Squadron" }, 12 ) --F4 Squadron
BlueA2ADispatcher:SetSquadronCap( "313th Tactical Fighter Squadron", Incirlik_NorthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
BlueA2ADispatcher:SetSquadronCapInterval( "313th Tactical Fighter Squadron", 2, 180, 540, 1 )


BlueA2ADispatcher:SetDefaultTakeoffInAir()
BlueA2ADispatcher:SetDefaultLandingAtEngineShutdown()

