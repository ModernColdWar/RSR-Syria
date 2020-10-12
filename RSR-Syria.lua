--- Red Storm Rising DCS mission LUA code

-- Add this dir and external paths (socket for calling n0xy's bot, luarocks systree for other dependencies)
-- note default path does not end with ; but the cpath does
--package.path = package.path .. ";" .. lfs.writedir() .. [[Scripts\RSR\?.lua;.\LuaSocket\?.lua]]
--package.cpath = package.cpath .. [[C:\dev\luarocks\lib\lua\5.1\?.dll]]

env.info("RSR STARTUP: RSR.LUA INIT")

require("mist_4_4_90")
require("Moose")
require("CTLD")
require("CSAR")


--local hitEventHandler = require("hitEventHandler")
--local birthEventHandler = require("birthEventHandler")
--local deadEventHandler = require("deadEventHandler")
--local restartInfo = require("restartInfo")
--local mist_4_4_90 = require("mist_4_4_90")
--local Moose = require("Moose")
--local CTLD = require("CTLD")
--local CSAR = require("CSAR")
local Capture_zones = require("Capture_zones") --base capture mechanism
local SGS_RSR = require("SGS_RSR") --Group Saves
local weaponManager = require("weaponManager")

--local SCUD_EventHandler = require("SCUD_EventHandler")
--require("weaponManager")

--mist_4_4_90.onMissionStart()
--Moose.onMissionStart()
--CTLD.onMissionStart()
--CSAR.onMissionStart()
Capture_zones.onMissionStart()
SGS_RSR.onMissionStart()
weaponManager.onMissionStart()
--slotBlocker.onMissionStart()
--baseCapturedHandler.register()
--persistence.onMissionStart(rsrConfig)
--awacs.onMissionStart(rsrConfig.awacsBases, rsrConfig.awacsSpawnLimit)
--hitEventHandler.onMissionStart(rsrConfig.hitMessageDelay)
--birthEventHandler.onMissionStart(rsrConfig.restartHours)
--deadEventHandler.register()
--restartInfo.onMissionStart(rsrConfig.restartHours, rsrConfig.restartWarningMinutes)
--SSS_RSR.onMissionStart() --Turning off for now
--disables MOOSE player setting radio menu item that allows player to set own coordinate and measurement system (not yet integrated)
-- _SETTINGS:SetPlayerMenuOff() not SETTINGS:SetPlayerMenuOff()
--_SETTINGS:SetPlayerMenuOff()

trigger.action.outText("RSR.LUA LOADED", 10)
env.info("RSR STARTUP: RSR.LUA LOADED")
