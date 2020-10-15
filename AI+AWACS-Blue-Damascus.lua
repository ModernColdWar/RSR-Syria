AWACS_Blue_Damascus = SPAWN:New( "AWACS Blue Damascus" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )

BlueDetectionSetGroup3 = SET_GROUP:New()
BlueDetectionSetGroup3:FilterCoalitions("blue")
BlueDetectionSetGroup3:FilterPrefixes( { "EWR", "AWACS" } )
BlueDetectionSetGroup3:FilterStart()
BlueDetection3 = DETECTION_AREAS:New( BlueDetectionSetGroup3, 30000 )
BlueA2ADispatcher3 = AI_A2A_DISPATCHER:New( BlueDetection3 )

--Zones for CAP
Damascus_SouthCAPZone = ZONE_POLYGON:New( "Damascus CAP Zone", GROUP:FindByName( "Damascus CAP Zone" ) )

TEXACOTankerBlue3 = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_5","TEXACO Blue 3")
  :InitLimit(1,3)
--  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("TEXACO Blue 3-1 is back on station",25,"TEXACO Blue 3-1"):ToBlue()
  end)
  :SpawnScheduled(3600,0.1) 

SHELLTankerBlue3 = SPAWN
  :NewWithAlias("B_TANKER_KC135_5","SHELL Blue 3")
  :InitLimit(1,3)
--  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("SHELL Blue 3-1 is back on station",25,"SHELL Blue 3-1"):ToBlue()
  end)
  :SpawnScheduled(3600,0.1) 
  
BlueA2ADispatcher3:SetSquadron( "315th Tactical Fighter Squadron", AIRBASE.Syria.Damascus, { "315th Tactical Fighter Squadron" }, 12 ) --F4 Squadron

BlueA2ADispatcher3:SetSquadronCap( "315th Tactical Fighter Squadron", Damascus_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )

BlueA2ADispatcher3:SetSquadronCapInterval( "315th Tactical Fighter Squadron", 2, 180, 540, 1 )

BlueA2ADispatcher3:SetDefaultTakeoffInAir()
BlueA2ADispatcher3:SetDefaultLandingAtEngineShutdown()