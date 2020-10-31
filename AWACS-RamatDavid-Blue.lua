--    Incirlik_Air_Defenses = SPAWN:New( "Incirlik AD Spawn" )
--     :InitLimit( 6, 1)
--     :InitRandomizeTemplate( Spawn_Blue_AD )
--     :SpawnScheduled( 1, 0.5 )
--     :InitRandomizePosition( 'DOESNOTMATTER', 500, 1 )                          
    --[[
    Spawns AWACs, Tanker, and AI-CAP if controlled by blue
    For the numbers after the moose CommandSetCallsign refer to https://wiki.hoggitworld.com/view/DCS_command_setCallsign
    --]]
    
RamatDavid_SouthCAPZone = ZONE_POLYGON:New( "Ramat David CAP Zone", GROUP:FindByName( "Ramat David CAP Zone" ) )

BlueDetectionSetGroup = SET_GROUP:New()
BlueDetectionSetGroup:FilterCoalitions("blue")
BlueDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS " } )
BlueDetectionSetGroup:FilterStart()
BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 50000 )
BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

BlueA2ADispatcher:SetSquadron( "314th Tactical Fighter Squadron", AIRBASE.Syria.Ramat_David, { "314th Tactical Fighter Squadron" }, 12 ) --F4 Squadron
BlueA2ADispatcher:SetSquadronCap( "314th Tactical Fighter Squadron", RamatDavid_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
BlueA2ADispatcher:SetSquadronCapInterval( "314th Tactical Fighter Squadron", 2, 180, 540, 1 )
BlueA2ADispatcher:SetDefaultTakeoffInAir()
BlueA2ADispatcher:SetDefaultLandingAtEngineShutdown() 

AWACS_Blue_RamatDavid = SPAWN
  :NewWithAlias("AWACS Blue Ramat David", "Magic 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  :OnSpawnGroup(function(magic_21)
    magic_21:CommandSetCallsign(2, 2)
    MESSAGE:New("Magic 2-1 is on station contact on channel 252.000 MHz",25,"Magic 2-1"):ToBlue()end      )
  :SpawnScheduled(3600,0.1)    
SHELLTankerBlue = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_3","Shell 1-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  -- :InitCleanUp(30)
  :OnSpawnGroup(function(shell_11)
    shell_11:CommandSetCallsign(3, 1)
    MESSAGE:New("Shell 1-1 is on station, contact on channel 142.000 MHz",25,"Shell 1-1"):ToBlue()end)      
  :SpawnScheduled(3600,0.1)
SHELLTankerBlue2 = SPAWN
  :NewWithAlias("B_TANKER_KC135_3","Shell 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  --:InitCleanUp(30)
  :OnSpawnGroup(function(shell_21)
    shell_21:CommandSetCallsign(3, 2)
    MESSAGE:New("Shell 2-1 is on station, contact on channel 142.500 MHz",25,"Shell 2-1"):ToBlue()end)  
  :SpawnScheduled(3600,0.1)
