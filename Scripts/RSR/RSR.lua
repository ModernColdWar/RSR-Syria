--- Red Storm Rising DCS mission LUA code

-- Add this dir and external paths (socket for calling n0xy's bot, luarocks systree for other dependencies)
-- note default path does not end with ; but the cpath does
package.path = package.path .. ";" .. lfs.writedir() .. [[Scripts\RSR\?.lua;.\LuaSocket\?.lua]]
package.cpath = package.cpath .. [[C:\dev\luarocks\lib\lua\5.1\?.dll]]

env.info("RSR STARTUP: RSR.LUA INIT")

require("mist_4_4_90")
require("Moose")
require("CTLD")
require("CSAR")
local logging = require("logging")

local log = logging.Logger:new("RSR")

local rsrConfig = require("RSR_config")
if rsrConfig.devMode then
    log:warn("Running in developer mode - should not be used for 'real' servers")
    ctld.debug = true
    ctld.buildTimeFARP = 5
    ctld.crateWaitTime = 1
end

--log:info("Setting csar.maxLives to $1", rsrConfig.maxLives)

local persistence = require("persistence")
local slotBlocker = require("slotBlocker")
local baseCapturedHandler = require("baseCapturedHandler")
local hitEventHandler = require("hitEventHandler")
local birthEventHandler = require("birthEventHandler")
local deadEventHandler = require("deadEventHandler")
local restartInfo = require("restartInfo")
local SGS_RSR = require("SGS_RSR") --Group Saves
local SCUD_EventHandler = require("SCUD_EventHandler")
local UAV_Designate = require("UAV_Designate")
local warehouseResupply = require("warehouseResupply")
local UAV_Recon = require("UAV_Recon")
local botBases = require("botBases")
--local AWACS_Tankers_Escorts_Auftrag = require("AWACS_Tankers_Escorts_Auftrag")
--local EasyStats = require("EasyStats")
local AWACS_Tankers = require("AWACS_Tankers")
local CONVOY_MENU = require("CONVOY_Menu")
local AI_CAP = require("AI_CAP")
require("weaponManager")
require("EWRS_OPM")

slotBlocker.onMissionStart()
baseCapturedHandler.register()
persistence.onMissionStart(rsrConfig)
hitEventHandler.onMissionStart(rsrConfig.hitMessageDelay)
birthEventHandler.onMissionStart(rsrConfig.restartHours)
deadEventHandler.register()
restartInfo.onMissionStart(rsrConfig.restartHours, rsrConfig.restartWarningMinutes)
--disables MOOSE player setting radio menu item that allows player to set own coordinate and measurement system (not yet integrated)
-- _SETTINGS:SetPlayerMenuOff() not SETTINGS:SetPlayerMenuOff()
_SETTINGS:SetPlayerMenuOff()

trigger.action.outText("RSR.LUA LOADED", 10)
env.info("RSR STARTUP: RSR.LUA LOADED")
