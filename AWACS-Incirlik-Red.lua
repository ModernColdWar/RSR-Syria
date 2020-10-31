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

RedDetectionSetGroup = SET_GROUP:New()
RedDetectionSetGroup:FilterCoalitions("red")
RedDetectionSetGroup:FilterPrefixes( { "EWR", "AWACS " } )
RedDetectionSetGroup:FilterStart()
RedDetection = DETECTION_AREAS:New( RedDetectionSetGroup, 50000 )
RedA2ADispatcher = AI_A2A_DISPATCHER:New( RedDetection )

RedA2ADispatcher:SetSquadron( "22nd Fighter Aviation Regiment", AIRBASE.Syria.Incirlik, { "22nd Fighter Aviation Regiment" }, 12 ) --Mig31 Squadron
RedA2ADispatcher:SetSquadronCap( "22nd Fighter Aviation Regiment", Incirlik_NorthCAPZone, 1000, 12000, 600, 800, 800, 1200, "BARO" )
RedA2ADispatcher:SetSquadronCapInterval( "22nd Fighter Aviation Regiment", 2, 180, 540, 1 )
RedA2ADispatcher:SetDefaultTakeoffInAir()
RedA2ADispatcher:SetDefaultLandingAtEngineShutdown()  

AWACS_Red_Incirlik = SPAWN
  :NewWithAlias("AWACS Red Incirlik", "Magic 1-1")
  :InitKeepUnitNames(true)
  :InitLimit( 1, 4 )
  --  :InitCleanUp(30)
  :OnSpawnGroup(function(magic_11)
    magic_11:CommandSetCallsign(1, 1)
    MESSAGE:New("MAGIC 1-1 is on station contact on channel 121.000 MHz",25,"Magic 1-1"):ToRed()end)  
  :SpawnScheduled(3600, 0.1)
TEXACOTankerRed = SPAWN
  :NewWithAlias("B_TANKER_KC135MPRS_2","Texaco 1-1")
  :InitKeepUnitNames(true)
  --  :InitCleanUp(30)
  :OnSpawnGroup(function(texaco_11)
    texaco_11:CommandSetCallsign(1, 1)
    MESSAGE:New("Texaco 1-1 is on station contact on channel 141.000 MHz",25,"Texaco 1-1"):ToRed()end)      
  :SpawnScheduled(3600,0.1)
SHELLTankerRed = SPAWN
  :NewWithAlias("B_TANKER_KC135_2","Texaco 2-1")
  :InitKeepUnitNames(true)
  :InitLimit(1,4)
  --:InitCleanUp(30)
  :OnSpawnGroup(function(texaco_21)
    texaco_21:CommandSetCallsign(1, 2)
    MESSAGE:New("Texaco 2-1 is on station, contact on channel 141.500 MHz",25,"Texaco 2-1"):ToRed()end)           
  :SpawnScheduled(3600,0.1)

