-- Name: AWACS-Tankers-Auftrag
-- Author: Wildcat (Chandawg)
-- Date Created: 02 Mar 2021
-- Date Modified: 04 Mar 2021
--Succefully used auftrag to create two AirWings, and have them launch an AWACS with Escorts.

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Below is not part of Auftrag, but is something I run to set all units to red on restart
WakeUpSet = SET_GROUP:New():FilterPrefixes( {"Red Start","Blue Start", "Resupply ", " Convoy", "Dropped Group ","CTLD"} ):FilterStart()

SCHEDULER:New( nil, function()
   WakeUpSet:ForEachGroup(
   function( MooseGroup )
    local chance = math.random(1,99)
     if chance > 1 then
        MooseGroup:OptionAlarmStateRed()
        MooseGroup:CommandEPLRS(true, 3)
     else
        MooseGroup: OptionAlarmStateGreen()
     end
    end)

end, {}, 40)
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RedSqd = {}
BlueSqd = {}

RedSqd.kraket=SQUADRON:New("Red C130", 4, "708ATR")
RedSqd.kraket:SetCallsign(CALLSIGN.Aircraft.Uzi,2)
RedSqd.kraket:AddMissionCapability({AUFTRAG.Type.TROOPTRANSPORT}, 100)
RedSqd.kraket:SetMissionRange(500)

RedSqd.MiG31=SQUADRON:New("Red MiG31", 12, "MiG-31 Sqd.") --Ops.Squadron#SQUADRON
RedSqd.MiG31:SetSkill(AI.Skill.HIGH)
RedSqd.MiG31:SetMissionRange(300)
RedSqd.MiG31:AddMissionCapability({AUFTRAG.Type.ESCORT}, 100)

RedSqd.Darkstar=SQUADRON:New("AWACS Red", 2, "Darkstar AWACS")
RedSqd.Darkstar:SetCallsign(CALLSIGN.AWACS.Darkstar, 5)
RedSqd.Darkstar:AddMissionCapability({AUFTRAG.Type.AWACS}, 100) 
RedSqd.Darkstar:SetMissionRange(500)

RedSqd.Shell=SQUADRON:New("Tanker Basket Red", 2, "566ARR")
RedSqd.Shell:SetCallsign(CALLSIGN.Tanker.Shell,2)
RedSqd.Shell:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
RedSqd.Shell:SetMissionRange(500)

RedSqd.Texaco=SQUADRON:New("Tanker Boom Red", 2, "546ARR")
RedSqd.Texaco:SetCallsign(CALLSIGN.Tanker.Texaco,2)
RedSqd.Texaco:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
RedSqd.Texaco:SetMissionRange(500)

Krasnodar_Pashkovsky=AIRWING:New("Krasnodar_Pashkovsky Warehouse", "Krasnodar_Pashkovsky Airwing") --Ops.AirWing#AIRWING
Krasnodar_Pashkovsky:SetNumberTankerProbe(1)
Krasnodar_Pashkovsky:SetNumberTankerBoom(1)
Krasnodar_Pashkovsky:SetNumberAWACS(1)
Krasnodar_Pashkovsky:AddPatrolPointTANKER(ZONE:New("Red Basket Tanker Zone"):GetCoordinate(), 16000, 235, 15, 25)
Krasnodar_Pashkovsky:AddPatrolPointTANKER(ZONE:New("Red Boom Tanker Zone"):GetCoordinate(), 16000, 235, 15, 25)
Krasnodar_Pashkovsky:AddPatrolPointAWACS(ZONE:New("Red AWACs Zone"):GetCoordinate(), 25000, 250, 15, 25)
Krasnodar_Pashkovsky:SetAirbase(AIRBASE:FindByName("Krasnodar_Pashkovsky"))
Krasnodar_Pashkovsky:Start()
Krasnodar_Pashkovsky:AddSquadron(RedSqd.kraket)
Krasnodar_Pashkovsky:NewPayload("Red C130",-1,{AUFTRAG.Type.TROOPTRANSPORT},100)
Krasnodar_Pashkovsky:AddSquadron(RedSqd.Darkstar)
Krasnodar_Pashkovsky:NewPayload("AWACS Red",-1,{AUFTRAG.Type.AWACS},100)
Krasnodar_Pashkovsky:AddSquadron(RedSqd.MiG31)
Krasnodar_Pashkovsky:NewPayload("Red MiG31",-1,{AUFTRAG.Type.ESCORT},100)
Krasnodar_Pashkovsky:AddSquadron(RedSqd.Shell)
Krasnodar_Pashkovsky:NewPayload("Tanker Basket Red",-1,{AUFTRAG.Type.TANKER},100)
Krasnodar_Pashkovsky:AddSquadron(RedSqd.Texaco)
Krasnodar_Pashkovsky:NewPayload("Tanker Boom Red",-1,{AUFTRAG.Type.TANKER},100)
Krasnodar_Pashkovsky:SetVerbosity(20)

function Krasnodar_Pashkovsky:OnAfterFlightOnMission(From, Event, To, FlightGroup, Mission)
    if Mission:GetType()==AUFTRAG.Type.AWACS then -- If the mission type is an AWACS then the aircraft must be one. Request an escort group
      local flightgroup = FlightGroup --Ops.FlightGroup#FLIGHTGROUP
      BASE:E("+++++++++++++ MISSION TYPE IS AWACS, REQUESTING ESCORTS... +++++++++++++")
      local escortMission = AUFTRAG:NewESCORT(flightgroup:GetGroup(), nil, 30)
      local escortMission2 = AUFTRAG:NewESCORT(flightgroup:GetGroup(), nil, 30)
      Krasnodar_Pashkovsky:AddMission(escortMission)    
      Krasnodar_Pashkovsky:AddMission(escortMission2)    
    end
    if Mission:GetType()==AUFTRAG.Type.TANKER then
      local flightGroup = FlightGroup
      BASE:E("+++++++++++++ MISSION TYPE IS TANKER, REQUESTING ESCORTS... +++++++++++++")
      local escortMission3 = AUFTRAG:NewESCORT(flightGroup:GetGroup(), nil, 30)
      Krasnodar_Pashkovsky:AddMission(escortMission3)    
    end
end

BlueSqd.rebel=SQUADRON:New("Blue C130", 4, "62AS")
BlueSqd.rebel:SetCallsign(CALLSIGN.Aircraft.Uzi,2)
BlueSqd.rebel:AddMissionCapability({AUFTRAG.Type.TROOPTRANSPORT}, 100)
BlueSqd.rebel:SetMissionRange(500)

BlueSqd.F14B=SQUADRON:New("Blue F14B", 12, "F-14B Sqd.") --Ops.Squadron#SQUADRON
BlueSqd.F14B:SetSkill(AI.Skill.HIGH)
BlueSqd.F14B:SetMissionRange(300)
BlueSqd.F14B:AddMissionCapability({AUFTRAG.Type.ESCORT}, 100)

BlueSqd.Magic=SQUADRON:New("AWACS Blue", 2, "Magic AWACS")
BlueSqd.Magic:SetCallsign(CALLSIGN.AWACS.Magic, 5)
BlueSqd.Magic:AddMissionCapability({AUFTRAG.Type.AWACS}, 100) 
BlueSqd.Magic:SetMissionRange(500)

BlueSqd.Shell=SQUADRON:New("Tanker Basket Blue", 2, "121ARS")
BlueSqd.Shell:SetCallsign(CALLSIGN.Tanker.Shell,2)
BlueSqd.Shell:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
BlueSqd.Shell:SetMissionRange(500)

BlueSqd.Texaco=SQUADRON:New("Tanker Boom Blue", 2, "123ARS")
BlueSqd.Texaco:SetCallsign(CALLSIGN.Tanker.Texaco,2)
BlueSqd.Texaco:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
BlueSqd.Texaco:SetMissionRange(500)

Kutaisi=AIRWING:New("Kutaisi Warehouse", "Kutaisi Airwing") --Ops.AirWing#AIRWING
Kutaisi:SetNumberTankerProbe(1)
Kutaisi:SetNumberTankerBoom(1)
Kutaisi:SetNumberAWACS(1)
Kutaisi:AddPatrolPointTANKER(ZONE:New("Blue Basket Tanker Zone"):GetCoordinate(), 16000, 235, 15, 25)
Kutaisi:AddPatrolPointTANKER(ZONE:New("Blue Boom Tanker Zone"):GetCoordinate(), 16000, 235, 15, 25)
Kutaisi:AddPatrolPointAWACS(ZONE:New("Blue AWACs Zone"):GetCoordinate(), 25000, 250, 15, 25)
Kutaisi:SetAirbase(AIRBASE:FindByName("Kutaisi"))
Kutaisi:Start()
Kutaisi:AddSquadron(BlueSqd.rebel)
Kutaisi:NewPayload("Blue C130",-1,{AUFTRAG.Type.TROOPTRANSPORT},100)
Kutaisi:AddSquadron(BlueSqd.Magic)
Kutaisi:NewPayload("AWACS Blue",-1,{AUFTRAG.Type.AWACS},100)
Kutaisi:AddSquadron(BlueSqd.F14B)
Kutaisi:NewPayload("Blue F14B",-1,{AUFTRAG.Type.ESCORT},100)
Kutaisi:AddSquadron(BlueSqd.Shell)
Kutaisi:NewPayload("Tanker Basket Blue",-1,{AUFTRAG.Type.TANKER},100)
Kutaisi:AddSquadron(BlueSqd.Texaco)
Kutaisi:NewPayload("Tanker Boom Blue",-1,{AUFTRAG.Type.TANKER},100)
Kutaisi:SetVerbosity(20)

function Kutaisi:OnAfterFlightOnMission(From, Event, To, FlightGroup, Mission)
    if Mission:GetType()==AUFTRAG.Type.AWACS then -- If the mission type is an AWACS then the aircraft must be one. Request an escort group
      local flightgroup = FlightGroup --Ops.FlightGroup#FLIGHTGROUP
      BASE:E("+++++++++++++ MISSION TYPE IS AWACS, REQUESTING ESCORTS... +++++++++++++")
      local escortMission = AUFTRAG:NewESCORT(flightgroup:GetGroup(), nil, 30)
      local escortMission2 = AUFTRAG:NewESCORT(flightgroup:GetGroup(), nil, 30)
      --local escortMission = AUFTRAG:NewESCORT(EscortGroup, OffsetVector, EngageMaxDistance, TargetTypes)
      Kutaisi:AddMission(escortMission)    
      Kutaisi:AddMission(escortMission2)    
    end  
    if Mission:GetType()==AUFTRAG.Type.TANKER then
      local flightGroup = FlightGroup
      BASE:E("+++++++++++++ MISSION TYPE IS TANKER, REQUESTING ESCORTS... +++++++++++++")
      local escortMission3 = AUFTRAG:NewESCORT(flightGroup:GetGroup(), nil, 30)
      Kutaisi:AddMission(escortMission3)    
    end
end

--[[Awacs and Tankers is working with Escorts, really good. Next on the list is a fixed sam site, resupplied with Helos, and when the units are dead in the zone, a resupply will be requested and deliverd with a Helo.]]--

