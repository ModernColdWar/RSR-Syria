cfg = 
{
    ["current"] = 2,
    ["description"] = "Red Storm Rising (RSR) Syria - Slot load times vary by client setup, we have seen it take upwards of a couple of minutes for the client to load into the mission. ONCE YOU SELECT A SLOT YOU WILL BE SIDE LOCKED UNTIL MISSION RESTART (every 8 Hours). At campaign start - Red starts with all bases in Syria, Blue starts with Bases in Turkey, Jordan, and Lebanon. The objective of the campaign is for one side to capture all the other sides bases. Communication is critical and Discord or SRS is highly encouraged. Ask where you are needed and those currently on will tell you where you can join the fight.\
\
Change Log:\
*DCS 2.5.6.58125 Open Beta\
*Miz 1.0.8\
*Fixed patriot bug, well fixed where all units will spawn either NE/SE/SW/NW dependent on the heading of the spawning helo. \
*Recon Menu name changed from MQ-9 to MQ-1. \
*Respawn time of warehouses changed from 1800 seconds to 3600 seconds should alloww more time to strike it if lost, extending time to retake it. \
*Changed the JTAC and Logistics/FOB crate to say internal in F10 menu. \
*More M2000 spawns added. \
*Reduced number of IR sams on resupply\
*Added messages stating who spawned in the spawnable assets\
\
RSR-East is hosted in North Carolina and RSR-West is hosted in California. Currently RSR-East is the primary server and RSR-West is the Test, Development, and Evaluation server. Please join us on the RSR Discord https://discord.gg/NRvtGax.",
    ["require_pure_textures"] = true,
    ["advanced"] = 
    {
        ["allow_change_tailno"] = true,
        ["disable_events"] = false,
        ["allow_ownship_export"] = false,
        ["allow_object_export"] = false,
        ["pause_on_load"] = false,
        ["allow_sensor_export"] = false,
        ["event_Takeoff"] = false,
        ["pause_without_clients"] = false,
        ["client_outbound_limit"] = 0,
        ["client_inbound_limit"] = 0,
        ["server_can_screenshot"] = false,
        ["voice_chat_server"] = false,
        ["allow_change_skin"] = true,
        ["event_Connect"] = true,
        ["event_Ejecting"] = false,
        ["event_Kill"] = false,
        ["event_Crash"] = false,
        ["resume_mode"] = 1,
        ["maxPing"] = 400,
        ["event_Role"] = false,
    }, -- end of ["advanced"]
    ["port"] = 10308,
    ["mode"] = 0,
    ["bind_address"] = "",
    ["isPublic"] = true,
    ["uri"] = "startServer",
    ["password"] = "",
    ["missionList"] = 
    {
        [1] = "C:\\Users\\RSRAdmin\\Saved Games\\DCS.openbeta_server\\Missions\\RSR_Dynamic_PvP_SYRIA-1.0.8.miz",
    }, -- end of ["missionList"]
    ["name"] = "Red Storm Rising - | RSR |",
    ["listShuffle"] = false,
    ["listLoop"] = true,
    ["require_pure_clients"] = true,
    ["require_pure_models"] = true,
    ["maxPlayers"] = "64",
} -- end of cfg
