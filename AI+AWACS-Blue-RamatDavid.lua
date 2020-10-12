AWACS_Blue_RamatDavid = SPAWN:New( "AWACS Blue Ramat David" ):InitLimit( 1, 4 ):SpawnScheduled( 3600, 0.1 )

BlueDetectionSetGroup2 = SET_GROUP:New()
BlueDetectionSetGroup2:FilterCoalitions("blue")
BlueDetectionSetGroup2:FilterPrefixes( { "EWR", "AWACS" } )
BlueDetectionSetGroup2:FilterStart()
BlueDetection2 = DETECTION_AREAS:New( BlueDetectionSetGroup2, 30000 )
BlueA2ADispatcher2 = AI_A2A_DISPATCHER:New( BlueDetection2 )

--Zones for CAP
RamatDavid_SouthCAPZone = ZONE_POLYGON:New( "Ramat David CAP Zone", GROUP:FindByName( "Ramat David CAP Zone" ) )

TEXACOTankerBlue2 = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_3","TEXACO Blue 2")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("TEXACO Blue 2-1 is back on station",25,"TEXACO Blue 2-1"):ToBlue()
  end)
  :SpawnScheduled(3600,0.1) 

TEXACOTankerBlue2 = SPAWN
  :NewWithAlias("B_TANKER_KC135_3","SHELL Blue 2")
  :InitLimit(1,3)
  :InitCleanUp(30)
  :OnSpawnGroup(function(SpawnedGroup)
  MESSAGE:New("SHELL Blue 2-1 is back on station",25,"SHELL Blue 2-1"):ToBlue()
  end)
  :SpawnScheduled(3600,0.1) 

BlueA2ADispatcher2:SetSquadron( "314th Tactical Fighter Squadron", AIRBASE.Syria.Ramat_David, { "314th Tactical Fighter Squadron" }, 12 ) --F4 Squadron

BlueA2ADispatcher2:SetSquadronCap( "314th Tactical Fighter Squadron", RamatDavid_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )

BlueA2ADispatcher2:SetSquadronCapInterval( "314th Tactical Fighter Squadron", 2, 180, 540, 1 )

BlueA2ADispatcher2:SetDefaultTakeoffInAir()
BlueA2ADispatcher2:SetDefaultLandingAtEngineShutdown()