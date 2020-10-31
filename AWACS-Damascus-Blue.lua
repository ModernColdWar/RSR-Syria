--    Incirlik_Air_Defenses = SPAWN:New( "Incirlik AD Spawn" )
--     :InitLimit( 6, 1)
--     :InitRandomizeTemplate( Spawn_Blue_AD )
--     :SpawnScheduled( 1, 0.5 )
--     :InitRandomizePosition( 'DOESNOTMATTER', 500, 1 )                          
    --[[
    Spawns AWACs, Tanker, and AI-CAP if controlled by blue
    For the numbers after the moose CommandSetCallsign refer to https://wiki.hoggitworld.com/view/DCS_command_setCallsign
    --]]
Damascus_SouthCAPZone = ZONE_POLYGON:New( "Damascus CAP Zone", GROUP:FindByName( "Damascus CAP Zone" ) )    

BlueDetectionSetGroup = SET_GROUP:New()
BlueDetectionSetGroup:FilterCoalitions("blue")
BlueDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS " } )
BlueDetectionSetGroup:FilterStart()
BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 50000 )
BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

BlueA2ADispatcher:SetSquadron( "315th Tactical Fighter Squadron", AIRBASE.Syria.Damascus, { "315th Tactical Fighter Squadron" }, 12 ) --F4 Squadron
BlueA2ADispatcher:SetSquadronCap( "315th Tactical Fighter Squadron", Damascus_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
BlueA2ADispatcher:SetSquadronCapInterval( "315th Tactical Fighter Squadron", 2, 180, 540, 1 )
BlueA2ADispatcher:SetDefaultTakeoffInAir()
BlueA2ADispatcher:SetDefaultLandingAtEngineShutdown() 

AWACS_Blue_Damascus = SPAWN
  :NewWithAlias("AWACS Blue Damascus", "Magic 3-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  :OnSpawnGroup(function(magic_31)
    magic_31:CommandSetCallsign(2, 2)
    MESSAGE:New("Magic 3-1 is on station contact on channel 253.000 MHz",25,"Magic 3-1"):ToBlue()end)
  :SpawnScheduled(3600,0.1)    
ARCOTankerBlue = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_5","Arco 1-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  -- :InitCleanUp(30)
  :OnSpawnGroup(function(Arco_11)
    Arco_11:CommandSetCallsign(2, 1)
    MESSAGE:New("Arco 1-1 is on station, contact on channel 143.000 MHz",25,"Arco 1-1"):ToBlue()end)      
  :SpawnScheduled(3600,0.1)
ARCOTankerBlue2 = SPAWN
  :NewWithAlias("B_TANKER_KC135_5","Arco 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  --:InitCleanUp(30)
  :OnSpawnGroup(function(arco_21)
    arco_21:CommandSetCallsign(2, 2)
    MESSAGE:New("Arco 2-1 is on station, contact on channel 143.500 MHz",25,"Arco 2-1"):ToBlue()end)  
  :SpawnScheduled(3600,0.1)
