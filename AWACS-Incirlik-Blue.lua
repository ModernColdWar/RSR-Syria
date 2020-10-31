--    Incirlik_Air_Defenses = SPAWN:New( "Incirlik AD Spawn" )
--     :InitLimit( 6, 1)
--     :InitRandomizeTemplate( Spawn_Blue_AD )
--     :SpawnScheduled( 1, 0.5 )
--     :InitRandomizePosition( 'DOESNOTMATTER', 500, 1 )                          
    --[[
    Spawns AWACs, Tanker, and AI-CAP if controlled by blue
    For the numbers after the moose CommandSetCallsign refer to https://wiki.hoggitworld.com/view/DCS_command_setCallsign
    --]]
    
Incirlik_NorthCAPZone = ZONE_POLYGON:New( "Incirlik CAP Zone", GROUP:FindByName( "Incirlik CAP Zone" ) )

BlueDetectionSetGroup = SET_GROUP:New()
BlueDetectionSetGroup:FilterCoalitions("blue")
BlueDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS " } )
BlueDetectionSetGroup:FilterStart()
BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 50000 )
BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

BlueA2ADispatcher:SetSquadron( "313th Tactical Fighter Squadron", AIRBASE.Syria.Incirlik, { "313th Tactical Fighter Squadron" }, 12 ) --F4 Squadron
BlueA2ADispatcher:SetSquadronCap( "313th Tactical Fighter Squadron", Incirlik_NorthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
BlueA2ADispatcher:SetSquadronCapInterval( "313th Tactical Fighter Squadron", 2, 180, 540, 1 )
BlueA2ADispatcher:SetDefaultTakeoffInAir()
BlueA2ADispatcher:SetDefaultLandingAtEngineShutdown()

AWACS_Blue_Incirlik = SPAWN
  :NewWithAlias("AWACS Blue Incirlik", "Magic 1-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  :OnSpawnGroup(function(magic_11)
    magic_11:CommandSetCallsign(2, 1)
    MESSAGE:New("Magic 1-1 is on station contact on channel 251.000 MHz",25,"Magic 1-1"):ToBlue()end)
  :SpawnScheduled(3600,0.1)
TEXACOTankerBlue = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_1","Texaco 1-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  -- :InitCleanUp(30)
  :OnSpawnGroup(function(texaco_11)
    texaco_11:CommandSetCallsign(1, 1)
    MESSAGE:New("Texaco 1-1 is on station, contact on channel 141.000 MHz",25,"Texaco 1-1"):ToBlue()end)
  :SpawnScheduled(3600,0.1)
TEXACOTankerBlue2 = SPAWN
  :NewWithAlias("B_TANKER_KC135_1","Texaco 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  --:InitCleanUp(30)
  :OnSpawnGroup(function(texaco_21)
    texaco_21:CommandSetCallsign(1, 2)
    MESSAGE:New("Texaco 2-1 is on station, contact on channel 141.500 MHz",25,"Texaco 2-1"):ToBlue()end)  
  :SpawnScheduled(3600,0.1) 