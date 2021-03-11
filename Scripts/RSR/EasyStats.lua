ES_Settings = {} --DO NOT REMOVE

--************************************************************************--
--*********************  USER CONFIGURATION ******************************--
--************************************************************************--

-- StatsFolderName: Name of Folder to store data. (Use a different name to 
-- store separate data for each of your missions/campaigns
-- ex: ES_Settings.GameName = "Syria At War" or "SyriaAtWar"
ES_Settings.GameName = "RSR-Caucuses" 

-- FlightTimeIncrement: By default fight time is logged in 20 sec increments.
-- ex: ES_Settings.FlightTimeIncrement = 20 --flight time logged every 20 seconds
ES_Settings.FlightTimeIncrement = 30

-- PilotKillNotification: Display message/notification to player when kill is made
ES_Settings.PilotKillNotification = false


--[[
--*********************  END USER CONFIGURATION ******************************--
--*********************  DO NOT EDIT BELOW LINE ******************************--
--*********************   UNLESS YOU KNOW LUA   ******************************--
--]]

Class = {}
Class.__index = Class
 
function Class:New()
end

function Class:derive(type)
  local cls = {}
  cls.type = type
  cls.__index = cls
  cls.super = self
  setmetatable(cls,self)
  return cls
end

function Class:__call(...)
  local inst = setmetatable({}, self)
  inst:New(...)
  return inst
end

function Class:get_type()
  return self.type
end


EasyStats = Class:derive("EasyStats")
EasyStats.ver = "1.2"
EasyStats.JSON = loadfile("Scripts\\JSON.lua")()
EasyStatsClientSet = SET_CLIENT:New():FilterActive():FilterStart() --DCS Client Set
EasyStats.Settings = {} --DO NOT REMOVE
EasyStatsClientSet:ForEachClient(
  function( MooseClient )
      local function setupPlayer( MooseClient )
        EasyStats:New(MooseClient:GetClientGroupUnit())
      end
      MooseClient:Alive( setupPlayer ) 
  end
)

function EasyStats:New(PlayerUnit,UID)
  if UID == nil then
      UID = nil
  end
  
  if PlayerUnit:GetCoalition() == 1 then
    EasyStatsEnemyGroup= SET_GROUP:New():FilterCoalitions('blue'):FilterActive(true):FilterStart()
  else
    
    EasyStatsEnemyGroup = SET_GROUP:New():FilterCoalitions('red'):FilterActive(true):FilterStart()
  end
  
  --MESSAGE:New(tostring(PlayerUnit:GetCoalition()),4):ToGroup(PlayerUnit:GetGroup())
  --EasyStatsCoilition = SET_GROUP:New():FilterCoalitions():FilterStart()
  
  if EasyStats.MissionScripting() then
    local StatsFile = ""
    local player_name = ""
    local player_unit = PlayerUnit
    local playerGroup = player_unit:GetGroup()
    local playerName = player_unit:GetPlayerName()
            
    --Create Stats file if not already created
    if UID == nil then
      --create with playername
      player_name = EasyStats.sanitise( playerName ) --Sanaitised Player Name
      EasyStats.CreateStatsFile(player_name)
    else
      --create with uid
      player_name = UID --Sanaitised Player Name
      EasyStats.CreateStatsFile(UID)
    end
    
    
    if UID == nil then
      --create with playername
      StatsFile = EasyStats.GetDataFile(player_name) --data file
    else
      StatsFile = EasyStats.GetDataFile(UID) --data file
    end

    --Set ucid in Moose ClientData
    EasyStats.SetMooseClientStateData(playerGroup,"ucid", player_name)
    
    --Update Last Visit
    EasyStats.UpdateLastVisit(os.time(os.date("!*t")),StatsFile,player_name)
    
    --Update Recent Module
    EasyStats.UpdateRecentModule(player_unit:GetTypeName(),StatsFile,player_name)
      
    --Setup Stats Menus
    EasyStats.setStatsMenu(playerGroup,player_name)--basic stats
    EasyStats.setKillMenu(playerGroup,player_name)--kill stats
    
    --Add to Visit Count
    EasyStats.UpdateVisitCount(StatsFile.visit_count,StatsFile,player_name)
    
    --LogFlightTime
    local flightTimeScheduler = EasyStats.LogFlightTime(player_unit,player_name,StatsFile)
    
    --Player EVENTS
    player_unit:HandleEvent(EVENTS.Takeoff)
    function player_unit:OnEventTakeoff(EventData)
      local PlayerUnit = EventData.IniUnit
      EasyStats.UpdateTakeOffCount(StatsFile.takeoffs,StatsFile,player_name)
    end
    
    player_unit:HandleEvent(EVENTS.Land)
    function player_unit:OnEventLand(EventData)
      local PlayerUnit = EventData.IniUnit
      EasyStats.UpdateLandingCount(StatsFile.landings,StatsFile,player_name)
    end
    
    
    player_unit:HandleEvent(EVENTS.Crash)
    function player_unit:OnEventCrash(EventData)
      local PlayerUnit = EventData.IniUnit
      flightTimeScheduler:Stop()
      EasyStats.UpdateCrashCount(StatsFile.crashes,StatsFile,player_name)
    end
    
    player_unit:HandleEvent(EVENTS.Ejection)
    function player_unit:OnEventEjection(EventData)
      local PlayerUnit = EventData.IniUnit
      flightTimeScheduler:Stop()
      EasyStats.UpdateEjectionCount(StatsFile.ejections,StatsFile,player_name)
      
    end
    
    player_unit:HandleEvent(EVENTS.PilotDead)
    function player_unit:OnEventPilotDead(EventData)
      local PlayerUnit = EventData.IniUnit
      flightTimeScheduler:Stop()
      EasyStats.UpdateDeathCount(StatsFile.deaths,StatsFile,player_name)
    end
    
    
    function player_unit:OnEventPlayerLeaveUnit(EventData)
      local PlayerUnit = EventData.IniUnit
      flightTimeScheduler:Stop()
    end
    
    
    EasyStatsEnemyGroup:HandleEvent(EVENTS.Kill)
    function EasyStatsEnemyGroup:OnEventKill(EventData)
      local KillDataTable = {}
      local PlayerUnit = EventData.IniUnit
      local PlayerGroup= EventData.IniGroup
      local TargetUnit = EventData.TgtDCSUnit
      if PlayerGroup:GetName() == playerGroup:GetName() then
        
          --data
          KillDataTable.player_name = playerName
          KillDataTable.player_module = PlayerUnit:GetTypeName()--player module used
          KillDataTable.player_coalition = EventData.IniCoalition
          if type(EventData.TgtTypeName) == "number" then
              KillDataTable.target_name = "Scenery Object"
            else
              KillDataTable.target_name = EventData.TgtTypeName
          end
          KillDataTable.target_unit_name = EventData.TgtUnitName
          KillDataTable.target_coalition= EventData.TgtCoalition
          KillDataTable.timestamp = os.time(os.date("!*t"))
          
          EasyStats.LogKill(player_name,StatsFile,KillDataTable)
          
        end
    
      --show kill message
      if ES_Settings.PilotKillNotification == true then
        MESSAGE:New(KillDataTable.target_name.." destroyed",5):ToGroup(PlayerGroup)
      end
    end

  else
    --Mission Scrpting Not Setup
    SCHEDULER:New( nil,
    function()
      MESSAGE:New("Error Accessing Data: Your flight data will not be saved.",30):ToGroup(PlayerUnit:GetGroup())
    end, {}, 15)
    
  end
 
end

--
--Functions
--
function EasyStats:GetPlayerData(playerName)--Returns TABLE with player data, return nil if no player file
  if EasyStats.GetDataFile(playerName) ~= nil then
    return EasyStats.GetDataFile(playerName)
  else
    return nil
  end
  
end

do
  function EasyStats.SetupDirs()--Setup Data Directories
    if EasyStats.MissionScripting() then
      
      --check for stats dir
      if EasyStats.FolderExists(lfs.writedir()..'EasyStats\\'..EasyStats.sanitise(ES_Settings.GameName)) == true then
        --BASE:E( "** Stats Directory Already Exists **")
      else
        --setup dirs
        EasyStats.CreateDir(lfs.writedir()..'EasyStats\\'..EasyStats.sanitise(ES_Settings.GameName))
        EasyStats.CreateDir(lfs.writedir()..'EasyStats\\'..EasyStats.sanitise(ES_Settings.GameName).."\Kills")
        BASE:E( "** EasyStats Now Setup - Player Stats are now being logged  **")
        MESSAGE:New("** EasyStats Now Setup - Player Stats are now being logged **",15):ToAll()
      end
      
    else
      MESSAGE:New("Error Accessing Data: Your flight data will not be saved.",45,"EasyStats"):ToAll()
    end
  end
  
  function EasyStats.setStatsMenu(PlayerGroup,ucid)
    local function showStats()
      --get data file
      local data = EasyStats.GetDataFile(ucid)
      
      local playerName = PlayerGroup:GetPlayerName()
      
      --show player stats/report
      local newReport = REPORT:New("Basic Stats Report: "..playerName)
      newReport:Add("=====================")
      newReport:Add("Joined Mission: "..os.date('%m-%d-%Y', data.joinDate))
      newReport:Add("Visits to Mission: "..data.visit_count)
      newReport:Add("Total Flight Time: "..UTILS.SecondsToClock(data.flight_time,true))
      newReport:Add("=====================")
      newReport:Add("Takeoffs: "..data.takeoffs)
      newReport:Add("Landings: "..data.landings)
      newReport:Add("Crashes: "..data.crashes)
      newReport:Add("Ejections: "..data.ejections)
      newReport:Add("Deaths: "..data.deaths)
      newReport:Add("Kill Count: "..data.kill_count)
      newReport:Add("=====================")
      
      --EasyStats.PlaySoundToGroup("radioscratch.ogg",PlayerGroup)
      MESSAGE:New(newReport:Text(),30,"",true):ToGroup(PlayerGroup)
      
    end
    
    local playerName = PlayerGroup:GetPlayerName()
    local StatsMenu = MENU_GROUP:New( PlayerGroup, playerName.." Stats" )
    local BasicMenuCommand = MENU_GROUP_COMMAND:New( PlayerGroup, "*Basic Stats", StatsMenu, showStats , PlayerGroup )

  end
  
  function EasyStats.setKillMenu(PlayerGroup,ucid)
    
    local function showKillStats()
      --get data file
      local data = EasyStats.GetDataFile(ucid)
      --show player stats
      --MESSAGE:New("["..killdatajson:sub(1, -3).."]",20):ToAll()
      
      local playerName = PlayerGroup:GetPlayerName()
  
      local msg = 
      "Pilot Kill Data \n"..
      "=====================\n"..
      "Pilot: "..playerName.." \n"..
      "Total Kills: "..tostring(data.kill_count).." \n"..
      "=====================\n"..
      "Your Last 10 Kills: \n"
      
      --EasyStats.PlaySoundToGroup("radioscratch.ogg",PlayerGroup)
      MESSAGE:New(msg,30,"",true):ToGroup(PlayerGroup)
      --kills
      if EasyStats.read_file(EasyStats.Settings.StatsKillDataDir..ucid..".json") ~= nil then
        local killdatajson = EasyStats.read_file(EasyStats.Settings.StatsKillDataDir..ucid..".json")
        --remove last comma
        local killdata = EasyStats.JSON:decode("["..killdatajson:sub(1, -3).."]")
        for i = 1, #killdata do
         local timeSince = os.time(os.date("!*t")) - tonumber(killdata[i].timestamp)
         MESSAGE:New(EasyStats.SecondsFormat(timeSince).." Killed Target: "..killdata[i].target_name,30):ToGroup(PlayerGroup)
        end
      else
        MESSAGE:New("No recent kills at this time.",30):ToGroup(PlayerGroup)
      end
    end
    
    local playerName = PlayerGroup:GetPlayerName()
    local Menu = MENU_GROUP:New( PlayerGroup, playerName.." Stats" )
    local MenuCommand = MENU_GROUP_COMMAND:New( PlayerGroup, "*Kill Stats", Menu, showKillStats , PlayerGroup )
  end
  
  function EasyStats.sanitise( str )
      str = str:gsub('%W','')
      return str
  end
  
  function EasyStats.read_file(path)
      local open = io.open
      local file = open(path, "rb") -- r read mode and b binary mode
      if not file then return nil end
      local content = file:read "*a" -- *a or *all reads the whole file
      file:close()
      return content
  end
  
  function EasyStats.FolderExists(strtoFolder)
    if lfs.attributes(strtoFolder:gsub("\\$",""),"mode") == "directory" then
      return true
    else
      return false
    end
  end
  
  function EasyStats.CreateDir(dir)
    lfs.mkdir(dir)  
  end
  
  function EasyStats.GetDataFile(playerid)
    if EasyStats.read_file(EasyStats.Settings.StatsDataDir..playerid..".json") ~= nil then
       local json = EasyStats.read_file(EasyStats.Settings.StatsDataDir..playerid..".json")
       local data = EasyStats.JSON:decode(json)
       return data 
    else
        --error or no file found
        BASE:E( "++ Error Reading Data File ++")
        return nil
    end
  end
  
  function EasyStats.SecondsFormat(seconds)
      local hours = math.floor(seconds/3600)
      local mins = math.floor(seconds/60)
      local secs = math.floor(seconds - hours*3600 - mins *60)
      --return hours..":"..mins..":"..secs
      --MESSAGE:New(hours.."/"..mins.."/"..secs):ToAll()
      
      if seconds <= 60 then
        return secs.." secs ago"
      end
      
      if seconds > 60 and mins < 60 then
        return mins.." mins ago"
      end
      
      if seconds > 3600 and seconds < 86400 then
        --show hours
        return hours.." hrs ago"
      end
      
      if seconds > 86400 then
        --show days
        return math.floor(seconds/86400).." days ago"
      end
      
  end
  
  function EasyStats.WriteToJsonFile(data,Dir,JsonFileName)
    local jsonFile = Dir..JsonFileName..".json"
    local file2 = io.open(jsonFile, "w+")
    file2:write('{') 
      
      for key, value in pairs(data) do
          file2:write('"'..key..'":' ..'"'..value.."\",")
      end
      
      file2:close()
      local f = assert(io.open(jsonFile, "rb"))
      local content = f:read("*all")
      f:close()

      content = content:sub(1, -2)
      
      if content ~= "{" and content ~= nil then

        local f2 = assert(io.open(jsonFile, "w+"))
        f2:write(content)
        f2:write("}")
        f2:close()
      end
  end
  
  function EasyStats.WriteKillToJsonFile(dataTable,Dir,JsonFileName,maxNumber)
    if maxNumber == nil then
      maxNumber = 10
    end
    
    local jsonFile = Dir..JsonFileName..".json"
    local old = EasyStats.read_file(jsonFile) 
    local file2 = io.open(jsonFile, "w+")
    file2:write(EasyStats.JSON:encode(dataTable)..',\n')
    file2:write(old)
    file2:close()
    
    if EasyStats.CountLinesInTextFile(jsonFile) > maxNumber then
      EasyStats.removeLines( jsonFile, maxNumber + 1, 1 )
    end
  
    
  end
  
  function EasyStats.UpdateTransportJsonFile(ucid,csar_missions,insertion_missions,extraction_missions,num_troops)--Create new stats file
    
    if EasyStats.read_file(EasyStats.Settings.StatsTranportDataDir..ucid..".json") == nil then
      local data = {}
      --create file
      if csar_missions == nil then
          data.csar_missions = 0
      else
        data.csar_missions = csar_missions
      end
      if insertion_missions == nil then
        data.insertion_missions = 0
      else
        data.insertion_missions = insertion_missions
      end
      if extraction_missions == nil then
        data.extraction_missions = 0
      else
        data.extraction_missions = extraction_missions
      end
      if num_troops == nil then
        data.num_troops = 0
      else
        data.num_troops = num_troops
      end
      
      EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsTranportDataDir,ucid)
    else
      --Get current data
      local dataFile = EasyStats.read_file(EasyStats.Settings.StatsTranportDataDir..ucid..".json")
      local jsonData = EasyStats.JSON:decode(dataFile)
      --update
      if csar_missions == nil then
        
      else
        jsonData.csar_missions = jsonData.csar_missions + csar_missions
      end
      if insertion_missions == nil then
        
      else
        jsonData.insertion_missions = jsonData.insertion_missions + insertion_missions
      end
      if extraction_missions == nil then
        
      else
        jsonData.extraction_missions = jsonData.extraction_missions + extraction_missions
      end
      if num_troops == nil then
        
      else
        jsonData.num_troops = jsonData.num_troops + num_troops
      end
      
      EasyStats.WriteToJsonFile(jsonData,EasyStats.Settings.StatsTranportDataDir,ucid)
    end
    
  end
  
  function EasyStats.CreateStatsFile(ucid)--Create new stats file
    if EasyStats.read_file(EasyStats.Settings.StatsDataDir..ucid..".json") == nil then
      --create file
      local time = os.time(os.date("!*t"))
      local data = {}
  
      data.joinDate = time
      data.recentModule = ""
      data.teamKills = 0
      data.banned = 0
      data.last_visit = time
      data.visit_count = 0
      data.kill_count = 0
      data.flight_time = 0
      data.takeoffs = 0
      data.landings = 0
      data.ejections = 0
      data.crashes = 0
      data.deaths = 0
      data.station = ""
      
      EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
    end
  end
  
  function EasyStats.UpdateTakeOffCount(currentCount,data,ucid)
    local newCount = tonumber(currentCount) + 1
    data.takeoffs = newCount
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.UpdateLandingCount(currentCount,data,ucid)
    local newCount = tonumber(currentCount) + 1
    data.landings = newCount
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.UpdateCrashCount(currentCount,data,ucid)
    local newCount = tonumber(currentCount) + 1
    data.crashes = newCount
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.UpdateEjectionCount(currentCount,data,ucid)
    local newCount = tonumber(currentCount) + 1
    data.ejections = newCount
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.UpdateDeathCount(currentCount,data,ucid)
    local newCount = tonumber(currentCount) + 1
    data.deaths = newCount
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.UpdateVisitCount(currentCount,data,ucid)
    local visitCount = tonumber(currentCount) + 1
    data.visit_count = visitCount
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.UpdateRecentModule(module,data,ucid)
    data.recentModule = module
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.UpdateLastVisit(lastvisit,data,ucid)
    data.last_visit = lastvisit
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
  end
  
  function EasyStats.LogFlightTime(unit,ucid,data)
     local timer = SCHEDULER:New( nil,
      function()
        if unit:InAir() ~= nil and unit:InAir() == true then
           local curFlightTime = data.flight_time
           --update flight time
           data.flight_time = curFlightTime + ES_Settings.FlightTimeIncrement
           EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
           --MESSAGE:New("flightime logged",3):ToAll()
        end
      end, {}, ES_Settings.FlightTimeIncrement,ES_Settings.FlightTimeIncrement)
    return timer
  end
  
  function EasyStats.LogKill(ucid,data,killDataTable)
    
    data.kill_count = data.kill_count + 1
    EasyStats.WriteToJsonFile(data,EasyStats.Settings.StatsDataDir,ucid)
    
    --write kill to file
    EasyStats.WriteKillToJsonFile(killDataTable,EasyStats.Settings.StatsKillDataDir,ucid)
    BASE:E(killDataTable.player_name.." made a kill: "..killDataTable.target_unit_name)
  end
  
  function EasyStats.MissionScripting()
    if os == nil or io == nil or lfs == nil then
      return false
    else 
      return true
    end
  end
  
  function EasyStats.CountLinesInTextFile(file)
    local contents = EasyStats.read_file(file)
    local _, count = contents:gsub('\n', '\n')
    return count
  end
  
  function EasyStats.removeLines( filename, starting_line, num_lines )
      local fp = io.open( filename, "r" )
      if fp == nil then return nil end
   
      content = {}
      i = 1;
      for line in fp:lines() do
          if i < starting_line or i >= starting_line + num_lines then
        content[#content+1] = line
    end
    i = i + 1
      end
   
      if i > starting_line and i < starting_line + num_lines then
    print( "Warning: Tried to remove lines after EOF." )
      end
   
      fp:close()
      fp = io.open( filename, "w+" )
   
      for i = 1, #content do
    fp:write( string.format( "%s\n", content[i] ) )
      end
   
      fp:close()
  end
  
  function EasyStats.SetMooseClientStateData(PlayerGroup,SetData, Data)
    local unitName = EasyStats.GetUnitFromPlayer(PlayerGroup:GetPlayerUnits())
    local Client = SET_CLIENT:New():AddClientsByName(unitName)
      Client:ForEachClient(
        function(MooseClient)
          MooseClient:SetState( MooseClient, SetData, Data )
        end
      )
    Client = nil
  end
  
  function EasyStats.GetMooseClientStateData(PlayerGroup,StateData)
    local data = ""
    local unitName = EasyStats.GetUnitFromPlayer(PlayerGroup:GetPlayerUnits())
    local Client = SET_CLIENT:New():AddClientsByName(unitName)
      Client:ForEachClient(
        function(MooseClient)
          --MESSAGE:New('Your UCID '..MooseClient:GetState( MooseClient, "UCID" ),10):ToClient(MooseClient)
          data = MooseClient:GetState( MooseClient, StateData )
        end
      )
    Client = nil
    return data
  end
  
  function EasyStats.PlaySoundToGroup(soundfile,group)
    local PlayAudioFile = USERSOUND:New( soundfile )
    PlayAudioFile:ToGroup(group)
  end
  
  function EasyStats.PlaySoundToUnit(soundfile,unit)
    local PlayAudioFile = USERSOUND:New( soundfile )
    local group = unit:GetGroup()
    PlayAudioFile:ToGroup(group)
  end
  
  function EasyStats.PlaySoundTAll(soundfile)
    local PlayToAll = USERSOUND:New( soundfile )
    PlayToAll:ToAll()
  end
  
  function EasyStats.GetUnitFromPlayer(GetPlayerUnitsTable)
    local unitsTables = GetPlayerUnitsTable
    for UnitId, UnitData in pairs( unitsTables ) do
        local UnitAction = UnitData -- Wrapper.Unit#UNIT
        return UnitAction:Name()
      end
  end

end

if EasyStats.MissionScripting() then
--Data Dir
EasyStats.Settings.StatsDataDir = lfs.writedir() .. '\\EasyStats\\'..EasyStats.sanitise(ES_Settings.GameName).."\\"
EasyStats.Settings.StatsKillDataDir = lfs.writedir() .. '\\EasyStats\\'..EasyStats.sanitise(ES_Settings.GameName).."\\Kills\\"
end

--Setup Stats Dirs
EasyStats.SetupDirs()

BASE:E( "** EasyStats by Element Ver "..EasyStats.ver.." Loaded **")