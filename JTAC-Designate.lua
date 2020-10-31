

BlueRecceSetGroup = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes{ "JTAC", "_Hummer_" }:FilterStart()

RedRecceSetGroup = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes{ "JTAC", "_Tigr_" }:FilterStart()

BlueHQ = GROUP:FindByName( "Blue HQ" )
RedHQ = GROUP:FindByName( "Red HQ" )
BlueCommandCenter = COMMANDCENTER
  :New( BlueHQ, "Allied Command" )
RedCommandCenter = COMMANDCENTER
  :New( RedHQ, "Allied Command" )

--HQ = GROUP:FindByName("Blue HQ")

--CC = COMMANDCENTER:New( HQ, "JTAC" )
--CC = COMMANDCENTER:New( HQ, "Leopard 1A3 (Recon)" )

BLUE_CAS_Set = SET_GROUP:New():FilterPrefixes( {" Blue AF", " Blue Cargo"} ):FilterStart()
RED_CAS_Set = SET_GROUP:New():FilterPrefixes( {" Red AF", " Red Cargo"} ):FilterStart()

BlueRecceDetection = DETECTION_AREAS:New(BlueRecceSetGroup, 10000)
  :SetAcceptRange(10000)
  :FilterCategories( { Unit.Category.GROUND_UNIT, Unit.Category.STRUCTURE } )
  :SetAlphaAngleProbability( 0.9 )

RedRecceDetection = DETECTION_AREAS:New(RedRecceSetGroup, 10000)
  :SetAcceptRange(10000)
  :FilterCategories( { Unit.Category.GROUND_UNIT, Unit.Category.STRUCTURE } )
  :SetAlphaAngleProbability( 0.9 )

BlueReconDesignation = DESIGNATE:New( BlueCommandCenter, BlueRecceDetection, BLUE_CAS_Set)
  :SetThreatLevelPrioritization( true )
  :SetMaximumDistanceAirDesignation(10000)
  :SetMaximumDistanceDesignations(10000)
  :SetMaximumDesignations(4)
  :SetLaserCodes( 1688 )
  :SetDesignateName( "JTAC" )
  :SetLaseDuration( 300 )
  :AddMenuLaserCode( 1113, "Lase with %d for Su-25T" )
  :AddMenuLaserCode( 1680, "Lase with %d for A-10A" )
  :Detect()
--  :__Detect(-1)

RedReconDesignation = DESIGNATE:New( RedCommandCenter, RedRecceDetection, RED_CAS_Set)
  :SetThreatLevelPrioritization( true )
  :SetMaximumDistanceAirDesignation(10000)
  :SetMaximumDistanceDesignations(10000)
  :SetMaximumDesignations(4)
  :SetLaserCodes( 1687 )
  :SetDesignateName( "JTAC" )
  :SetLaseDuration( 300 )
  :AddMenuLaserCode( 1113, "Lase with %d for Su-25T" )
  :AddMenuLaserCode( 1680, "Lase with %d for A-10A" )
  :Detect()
--  :__Detect(-1)

--RecceSetGroup = SET_GROUP:New():FilterPrefixes( "jtac" ):FilterStart()
--
--HQ = GROUP:FindByName("[SUP] HQ")
--
--CC = COMMANDCENTER:New( HQ, "JTAC" )
--
-- Let the RecceSetGroup vehicles in the collection detect targets and group them in AREAS of 1000 meters.
--RecceDetection = DETECTION_AREAS:New( RecceSetGroup, 1500 )
--RecceDetection:SetAcceptRange(7000)
--RecceDetection:FilterCategories( { Unit.Category.GROUND_UNIT, Unit.Category.STRUCTURE } )
--RecceDetection:SetAlphaAngleProbability(1)
--
---- Create a Attack Set, which contains the human player client slots and CA vehicles.
--AttackSet = SET_GROUP:New():FilterPrefixes("[J]"):FilterStart()
--
--RecceDesignation = DESIGNATE:New( CC, RecceDetection, AttackSet )
--RecceDesignation:SetThreatLevelPrioritization( true )
--RecceDesignation:SetMaximumDistanceAirDesignation(7000)
--RecceDesignation:SetMaximumDistanceDesignations(7000)
--RecceDesignation:SetMaximumDesignations(4)
--RecceDesignation:SetLaserCodes( 1688 )
--RecceDesignation:SetDesignateName( "JTAC" )
--RecceDesignation:SetLaseDuration( 9999 )
--RecceDesignation:AddMenuLaserCode( 1113, "Lase with %d for Su-25T" )
--RecceDesignation:AddMenuLaserCode( 1680, "Lase with %d for A-10A" )
--
---- Start the detection process in 1 seconds.
--RecceDesignation:__Detect( -1 )