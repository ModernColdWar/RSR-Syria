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

RedDetectionSetGroup = SET_GROUP:New()
RedDetectionSetGroup:FilterCoalitions("red")
RedDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS" } )
RedDetectionSetGroup:FilterStart()
RedDetection = DETECTION_AREAS:New( RedDetectionSetGroup, 50000 )
RedA2ADispatcher = AI_A2A_DISPATCHER:New( RedDetection )

RedA2ADispatcher:SetSquadron( "23rd Fighter Aviation Regiment", AIRBASE.Syria.Ramat_David, { "23rd Fighter Aviation Regiment" }, 12 )--MiG-31 Squadron
RedA2ADispatcher:SetSquadronCap( "23rd Fighter Aviation Regiment", RamatDavid_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
RedA2ADispatcher:SetSquadronCapInterval( "23rd Fighter Aviation Regiment", 2, 180, 540, 1 )
RedA2ADispatcher:SetDefaultTakeoffInAir()
RedA2ADispatcher:SetDefaultLandingAtEngineShutdown() 
                         
AWACS_Red_RamatDavid = SPAWN
  :NewWithAlias("AWACS Red Ramat David", "Magic 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  :OnSpawnGroup(function(magic_21)
    magic_21:CommandSetCallsign(2, 2)
    MESSAGE:New("Magic 2-1 is on station contact on channel 122.000 MHz",25,"Magic 2-1"):ToRed()end)
  :SpawnScheduled(3600,0.1)    
SHELLTankerRed = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_4","Shell 1-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  -- :InitCleanUp(30)
  :OnSpawnGroup(function(shell_11)
    shell_11:CommandSetCallsign(3, 1)
    MESSAGE:New("Shell 1-1 is on station, contact on channel 142.000 MHz",25,"Shell 1-1"):ToRed()end)     
  :SpawnScheduled(3600,0.1)
SHELLTankerRed2 = SPAWN
  :NewWithAlias("B_TANKER_KC135_3","Shell 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  --:InitCleanUp(30)
  :OnSpawnGroup(function(shell_21)
    shell_21:CommandSetCallsign(3, 2)
    MESSAGE:New("Shell 2-1 is on station, contact on channel 142.500 MHz",25,"Shell 2-1"):ToRed()end) 
  :SpawnScheduled(3600,0.1) 