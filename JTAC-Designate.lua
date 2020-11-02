BlueRecceSetGroup = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes( {"JTAC Test ", "_M1128 Stryker MGS_"} ):FilterStart()

RedRecceSetGroup = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes( {"JTAC Test ", "_BMP-2_"} ):FilterStart()

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
  :SetAlphaAngleProbability(0.9)

RedRecceDetection = DETECTION_AREAS:New(RedRecceSetGroup, 10000)
  :SetAcceptRange(10000)
  :FilterCategories( { Unit.Category.GROUND_UNIT, Unit.Category.STRUCTURE } )
  :SetAlphaAngleProbability(0.9)

BlueReconDesignation = DESIGNATE:New( BlueCommandCenter, BlueRecceDetection, BLUE_CAS_Set)
  :SetThreatLevelPrioritization(true)
  :SetMaximumDistanceAirDesignation(10000)
  :SetMaximumDistanceDesignations(25000)
  :SetMaximumDesignations(4)
  :SetLaserCodes({1682, 1683, 1684, 1685})
  :SetDesignateName("JTAC")
  :SetLaseDuration(900)
  :AddMenuLaserCode(1113, "Lase with %d for Su-25T")
  :AddMenuLaserCode(1680, "Lase with %d for A-10A")
  :Detect()
--  :__Detect(-1)

RedReconDesignation = DESIGNATE:New( RedCommandCenter, RedRecceDetection, RED_CAS_Set)
  :SetThreatLevelPrioritization(true)
  :SetMaximumDistanceAirDesignation(10000)
  :SetMaximumDistanceDesignations(25000)
  :SetMaximumDesignations(4)
  :SetLaserCodes({1686, 1687, 1688, 1689 })
  :SetDesignateName("JTAC")
  :SetLaseDuration(900)
  :AddMenuLaserCode(1113, "Lase with %d for Su-25T")
  :AddMenuLaserCode(1680, "Lase with %d for A-10A")
  :Detect()
--  :__Detect(-1)