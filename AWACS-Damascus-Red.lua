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

RedDetectionSetGroup = SET_GROUP:New()
RedDetectionSetGroup:FilterCoalitions("red")
RedDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS" } )
RedDetectionSetGroup:FilterStart()
RedDetection = DETECTION_AREAS:New( RedDetectionSetGroup, 50000 )

RedA2ADispatcher = AI_A2A_DISPATCHER:New( RedDetection )
RedA2ADispatcher:SetSquadron( "24th Fighter Aviation Regiment", AIRBASE.Syria.Damascus, { "24th Fighter Aviation Regiment" }, 24 ) --MiG-31 Squadron
RedA2ADispatcher:SetSquadronCap( "24th Fighter Aviation Regiment", Damascus_SouthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
RedA2ADispatcher:SetSquadronCapInterval( "24th Fighter Aviation Regiment", 4, 180, 540, 1 )
RedA2ADispatcher:SetDefaultTakeoffInAir()
RedA2ADispatcher:SetDefaultLandingAtEngineShutdown()  

AWACS_Red_Damascus = SPAWN
  :NewWithAlias("AWACS Red Damascus", "Magic 3-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  :OnSpawnGroup(function(magic_31)
    magic_31:CommandSetCallsign(2, 3)
    MESSAGE:New("Magic 3-1 is on station contact on channel 123.000 MHz",25,"Magic 3-1"):ToRed()end)
  :SpawnScheduled(3600,0.1)    
ARCOTankerRed = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_6","Arco 1-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  -- :InitCleanUp(30)
  :OnSpawnGroup(function(Arco_11)
    Arco_11:CommandSetCallsign(2, 1)
    MESSAGE:New("Arco 1-1 is on station, contact on channel 143.000 MHz",25,"Arco 1-1"):ToBlue()end)      
  :SpawnScheduled(3600,0.1)
ARCOTankerRed2 = SPAWN
  :NewWithAlias("B_TANKER_KC135_6","Arco 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  --:InitCleanUp(30)
  :OnSpawnGroup(function(arco_21)
    arco_21:CommandSetCallsign(2, 2)
    MESSAGE:New("Arco 2-1 is on station, contact on channel 143.500 MHz",25,"Arco 2-1"):ToBlue()end)  
  :SpawnScheduled(3600,0.1)
