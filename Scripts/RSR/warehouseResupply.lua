-- Name: Warehouse Resupply
-- Author: Wildcat (Chandawg)
-- Date Created: 28 Apr 2020
-- Trying to integrate the Alpha warehouse system from moose into RSR. Initially this will replace base units
-- Ultimately I couldn't integrate this into RSR-Caucuses because of the capture mechanism, but with the new Syria map we revamped the capture mechanism and went with Moose Zone Capture, so now exploring using these with RSR-Syria


local warehouse={}
----function to check if a save warehouse file exist, stole it from pikey's SGS
function file_exists(name) --check if the file already exists for writing
    if lfs.attributes(name) then
    return true
    else
    return false end 
end

----warehouseBatumi=WAREHOUSE:New(STATIC:FindByName("Warehouse Batumi"), "My optional Warehouse Alias")
----Defines the warehouses
--the string is the name in the mission editor
warehouse.BlueNorthernWarehouse=WAREHOUSE:New(STATIC:FindByName("Blue Northern Warehouse"))
warehouse.BlueCentralWarehouse=WAREHOUSE:New(STATIC:FindByName("Blue Central Warehouse"))
warehouse.BlueSouthernWarehouse=WAREHOUSE:New(STATIC:FindByName("Blue Southern Warehouse"))
warehouse.BlueNorthernSAMWarehouse=WAREHOUSE:New(STATIC:FindByName("Blue Northern SAM Warehouse"))
warehouse.BlueSouthernSAMWarehouse=WAREHOUSE:New(STATIC:FindByName("Blue Southern SAM Warehouse"))
warehouse.RedNorthernWarehouse=WAREHOUSE:New(STATIC:FindByName("Red Northern Warehouse"))
warehouse.RedCentralWarehouse=WAREHOUSE:New(STATIC:FindByName("Red Central Warehouse"))
warehouse.RedSouthernWarehouse=WAREHOUSE:New(STATIC:FindByName("Red Southern Warehouse"))
warehouse.RedNorthernSAMWarehouse=WAREHOUSE:New(STATIC:FindByName("Red Northern SAM Warehouse"))
warehouse.RedSouthernSAMWarehouse=WAREHOUSE:New(STATIC:FindByName("Red Southern SAM Warehouse"))


----If previous file exists it will load last saved warehouse
if file_exists("BlueNorthernWarehouse") then --Script has been run before, so we need to load the save
  env.info("Existing warehouse, loading from File.")
  warehouse.BlueNorthernWarehouse:Load(nil,"BlueNorthernWarehouse")
  warehouse.BlueCentralWarehouse:Load(nil,"BlueCentralWarehouse")
  warehouse.BlueSouthernWarehouse:Load(nil,"BlueSouthernWarehouse")
  warehouse.BlueNorthernSAMWarehouse:Load(nil,"BlueNorthernSAMWarehouse")
  warehouse.BlueSouthernSAMWarehouse:Load(nil,"BlueSouthernSAMWarehouse")
  warehouse.RedNorthernWarehouse:Load(nil,"RedNorthernWarehouse")
  warehouse.RedCentralWarehouse:Load(nil,"RedCentralWarehouse")
  warehouse.RedSouthernWarehouse:Load(nil,"RedSouthernWarehouse")
  warehouse.RedNorthernSAMWarehouse:Load(nil,"RedNorthernSAMWarehouse")
  warehouse.RedSouthernSAMWarehouse:Load(nil,"RedSouthernSAMWarehouse")
  --Starts the warehouses after load
  warehouse.BlueNorthernWarehouse:Start()
  warehouse.BlueNorthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueCentralWarehouse:Start()
  warehouse.BlueCentralWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueSouthernWarehouse:Start()
  warehouse.BlueSouthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueNorthernSAMWarehouse:Start()
  warehouse.BlueNorthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueSouthernSAMWarehouse:Start()
  warehouse.BlueSouthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedNorthernWarehouse:Start()
  warehouse.RedNorthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedCentralWarehouse:Start()
  warehouse.RedCentralWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedSouthernWarehouse:Start()
  warehouse.RedSouthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedNorthernSAMWarehouse:Start()
  warehouse.RedNorthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedSouthernSAMWarehouse:Start()
  warehouse.RedSouthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  else  
  --Fresh Campaign starts warehouses, and loads assets
  warehouse.BlueNorthernWarehouse:Start()
  warehouse.BlueNorthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueCentralWarehouse:Start()
  warehouse.BlueCentralWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueSouthernWarehouse:Start()
  warehouse.BlueSouthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueNorthernSAMWarehouse:Start()
  warehouse.BlueNorthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.BlueSouthernSAMWarehouse:Start()
  warehouse.BlueSouthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedNorthernWarehouse:Start()
  warehouse.RedNorthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedCentralWarehouse:Start()
  warehouse.RedCentralWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedSouthernWarehouse:Start()
  warehouse.RedSouthernWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedNorthernSAMWarehouse:Start()
  warehouse.RedNorthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  warehouse.RedSouthernSAMWarehouse:Start()
  warehouse.RedSouthernSAMWarehouse:SetRespawnAfterDestroyed(3600)
  ----Add Assets to the warehouses on new campaign
    --EXAMPLE*** WAREHOUSE:AddAsset(group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, skill, liveries,    assignment) 
  warehouse.BlueNorthernWarehouse:AddAsset("Resupply MBT Merkava", 30) --Counted as tank  in stock
  warehouse.BlueNorthernWarehouse:AddAsset("Resupply IFV M2A1", 20)    --Counted as APC in stock
  warehouse.BlueNorthernWarehouse:AddAsset("Resupply AAA Vulcan", 40)  --counted as AAA in stock
  warehouse.BlueNorthernWarehouse:AddAsset("Resupply SAM Avenger", 40) --Counted as SAM in stock
  --warehouse.BlueNorthernWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)  
  warehouse.BlueCentralWarehouse:AddAsset("Resupply MBT Merkava", 30) --Counted as tank  in stock
  warehouse.BlueCentralWarehouse:AddAsset("Resupply IFV M2A1", 20)    --Counted as APC in stock
  warehouse.BlueCentralWarehouse:AddAsset("Resupply AAA Vulcan", 40)  --counted as AAA in stock
  warehouse.BlueCentralWarehouse:AddAsset("Resupply SAM Avenger", 40) --Counted as SAM in stock
  --warehouse.BlueCentralWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)  
  warehouse.BlueSouthernWarehouse:AddAsset("Resupply MBT Merkava", 30) --Counted as tank  in stock
  warehouse.BlueSouthernWarehouse:AddAsset("Resupply IFV M2A1", 20)    --Counted as APC in stock
  warehouse.BlueSouthernWarehouse:AddAsset("Resupply AAA Vulcan", 40)  --counted as AAA in stock
  warehouse.BlueSouthernWarehouse:AddAsset("Resupply SAM Avenger", 40) --Counted as SAM in stock
  --warehouse.BlueSouthernWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
  warehouse.BlueNorthernSAMWarehouse:AddAsset("Resupply SAM Hawk", 20)    --Counted as SAM in stock
--  warehouse.BlueNorthernSAMWarehouse:AddAsset("Resupply IFV M2A1", 5)    --Counted as APC in stock
  --warehouse.BlueNorthernSAMWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
  warehouse.BlueSouthernSAMWarehouse:AddAsset("Resupply SAM Hawk", 20)    --Counted as SAM in stock
--  warehouse.BlueSouthernSAMWarehouse:AddAsset("Resupply IFV M2A1", 5)    --Counted as APC in stock
  --warehouse.BlueSouthernSAMWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
  warehouse.RedNorthernWarehouse:AddAsset("Resupply MBT T72B", 30)    --counted as tank  in stock
  warehouse.RedNorthernWarehouse:AddAsset("Resupply IFV BMP-3", 20)   --counted as APC in stock
  warehouse.RedNorthernWarehouse:AddAsset("Resupply AAA Shilka", 40)  --counted as AAA in stock
  warehouse.RedNorthernWarehouse:AddAsset("Resupply SAM SA-13", 40)   --Counted as SAM in stock
  --warehouse.RedNorthernWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
  warehouse.RedCentralWarehouse:AddAsset("Resupply MBT T72B", 30)    --counted as tank  in stock
  warehouse.RedCentralWarehouse:AddAsset("Resupply IFV BMP-3", 20)   --counted as APC in stock
  warehouse.RedCentralWarehouse:AddAsset("Resupply AAA Shilka", 40)  --counted as AAA in stock
  warehouse.RedCentralWarehouse:AddAsset("Resupply SAM SA-13", 40)   --Counted as SAM in stock
  --warehouse.RedCentralWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
  warehouse.RedSouthernWarehouse:AddAsset("Resupply MBT T72B", 30)    --counted as tank  in stock
  warehouse.RedSouthernWarehouse:AddAsset("Resupply IFV BMP-3", 20)   --counted as APC in stock
  warehouse.RedSouthernWarehouse:AddAsset("Resupply AAA Shilka", 40)  --counted as AAA in stock
  warehouse.RedSouthernWarehouse:AddAsset("Resupply SAM SA-13", 40)   --Counted as SAM in stock
  --warehouse.RedSouthernWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
  warehouse.RedNorthernSAMWarehouse:AddAsset("Resupply SAM SA-11", 20)   --Counted as SAM in stock
  warehouse.RedNorthernSAMWarehouse:AddAsset("Resupply IFV BMP-3", 5)   --counted as APC in stock
  --warehouse.RedNorthernSAMWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
  warehouse.RedSouthernSAMWarehouse:AddAsset("Resupply SAM SA-11", 20)   --Counted as SAM in stock
  warehouse.RedSouthernSAMWarehouse:AddAsset("Resupply IFV BMP-3", 5)   --counted as APC in stock
  --warehouse.RedSouthernSAMWarehouse:AddAsset("Red C-130", 2, nil, 1777000, nil, 10000)
end

----Set Spawn Zones for the warehouses
warehouse.BlueNorthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Blue Northern Warehouse Spawn Zone #001", GROUP:FindByName("Blue Northern Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.BlueCentralWarehouse:SetSpawnZone(ZONE_POLYGON:New("Blue Central Warehouse Spawn Zone #001", GROUP:FindByName("Blue Central Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.BlueSouthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Blue Southern Warehouse Spawn Zone #001", GROUP:FindByName("Blue Southern Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.BlueNorthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Blue Northern SAM Warehouse Spawn Zone #001", GROUP:FindByName("Blue Northern SAM Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.BlueSouthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Blue Southern SAM Warehouse Spawn Zone #001", GROUP:FindByName("Blue Southern SAM Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.RedNorthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Red Northern Warehouse Spawn Zone #001", GROUP:FindByName("Red Northern Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.RedCentralWarehouse:SetSpawnZone(ZONE_POLYGON:New("Red Central Warehouse Spawn Zone #001", GROUP:FindByName("Red Central Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.RedSouthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Red Southern Warehouse Spawn Zone #001", GROUP:FindByName("Red Southern Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.RedNorthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Red Northern SAM Warehouse Spawn Zone #001", GROUP:FindByName("Red Northern SAM Warehouse Spawn Zone #001"))):SetReportOff()
warehouse.RedSouthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Red Southern SAM Warehouse Spawn Zone #001", GROUP:FindByName("Red Southern SAM Warehouse Spawn Zone #001"))):SetReportOff()

--[[
warehouse.BlueNorthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Abu al-Duhur Warehouse Spawn Zone #001", GROUP:FindByName("Abu al-Duhur Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone1Zone)
warehouse.BlueCentralWarehouse:SetSpawnZone(ZONE_POLYGON:New("Adana Sakirpasa Warehouse Spawn Zone #001", GROUP:FindByName("Adana Sakirpasa Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone2Zone)
warehouse.BlueSouthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Al-Dumayr Warehouse Spawn Zone #001", GROUP:FindByName("Al-Dumayr Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone3Zone)
warehouse.BlueNorthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Aleppo Warehouse Spawn Zone #001", GROUP:FindByName("Aleppo Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone4Zone)
warehouse.BlueSouthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Al Qusayr Warehouse Spawn Zone #001", GROUP:FindByName("Al Qusayr Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone5Zone)
warehouse.RedNorthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("An Nasiriyah Warehouse Spawn Zone #001", GROUP:FindByName("An Nasiriyah Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone6Zone)
warehouse.RedCentralWarehouse:SetSpawnZone(ZONE_POLYGON:New("Bassel Al-Assad Warehouse Spawn Zone #001", GROUP:FindByName("Bassel Al-Assad Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone7Zone)
warehouse.RedSouthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Beirut-Rafic Hariri Warehouse Spawn Zone #001", GROUP:FindByName("Beirut-Rafic Hariri Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone8Zone)
warehouse.RedNorthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Damascus Warehouse Spawn Zone #001", GROUP:FindByName("Damascus Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone9Zone)
warehouse.RedSouthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Eyn Shemer Warehouse Spawn Zone #001", GROUP:FindByName("Eyn Shemer Warehouse Spawn Zone #001"))):SetWarehouseZone(Zone10Zone)
--]]
--[[
warehouse.BlueNorthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Abu al-Duhur Warehouse Spawn Zone #001", GROUP:FindByName("Abu al-Duhur Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Abu_al_Duhur)
warehouse.BlueCentralWarehouse:SetSpawnZone(ZONE_POLYGON:New("Adana Sakirpasa Warehouse Spawn Zone #001", GROUP:FindByName("Adana Sakirpasa Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Adana_Sakirpasa)
warehouse.BlueSouthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Al-Dumayr Warehouse Spawn Zone #001", GROUP:FindByName("Al-Dumayr Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Al_Dumayr)
warehouse.BlueNorthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Aleppo Warehouse Spawn Zone #001", GROUP:FindByName("Aleppo Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Aleppo)
warehouse.BlueSouthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Al Qusayr Warehouse Spawn Zone #001", GROUP:FindByName("Al Qusayr Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Al_Qusayr)
warehouse.RedNorthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("An Nasiriyah Warehouse Spawn Zone #001", GROUP:FindByName("An Nasiriyah Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.An_Nasiriyah)
warehouse.RedCentralWarehouse:SetSpawnZone(ZONE_POLYGON:New("Bassel Al-Assad Warehouse Spawn Zone #001", GROUP:FindByName("Bassel Al-Assad Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Bassel_Al_Assad)
warehouse.RedSouthernWarehouse:SetSpawnZone(ZONE_POLYGON:New("Beirut-Rafic Hariri Warehouse Spawn Zone #001", GROUP:FindByName("Beirut-Rafic Hariri Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Beirut_Rafic_Hariri)
warehouse.RedNorthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Damascus Warehouse Spawn Zone #001", GROUP:FindByName("Damascus Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Damascus)
warehouse.RedSouthernSAMWarehouse:SetSpawnZone(ZONE_POLYGON:New("Eyn Shemer Warehouse Spawn Zone #001", GROUP:FindByName("Eyn Shemer Warehouse Spawn Zone #001"))):SetAirbase(AIRBASE.Syria.Eyn_Shemer)
--]]
----Spawn Units after Capture
function warehouse.BlueNorthernWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function warehouse.BlueNorthernWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.BLUE then
    MESSAGE:New("The Northern Warehouse is running at full capacity.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueNorthernWarehouse:__Save(15,nil,"BlueNorthernWarehouse")
    warehouse.BlueNorthernWarehouse:__AddRequest(10,warehouse.BlueNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply MBT Merkava", 3,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueNorthernWarehouse:__AddRequest(10,warehouse.BlueNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply IFV M2A1", 6,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueNorthernWarehouse:__AddRequest(10,warehouse.BlueNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply AAA Vulcan", 4,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueNorthernWarehouse:__AddRequest(10,warehouse.BlueNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM Avenger", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.RED then
    MESSAGE:New("We have captured Blue Team's Northern Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToRed()
    MESSAGE:New("We have lost the Northern Warehouse and no longer able to re-enforce the front.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueNorthernWarehouse:__Save(15,nil,"BlueNorthernWarehouse")
    end
end

function  warehouse.BlueCentralWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function  warehouse.BlueCentralWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.BLUE then
    MESSAGE:New("The Central Warehouse is running at full capacity.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueCentralWarehouse:__Save(15,nil,"BlueCentralWarehouse")
    warehouse.BlueCentralWarehouse:__AddRequest(10,warehouse.BlueCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply MBT Merkava", 3,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueCentralWarehouse:__AddRequest(10,warehouse.BlueCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply IFV M2A1", 6,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueCentralWarehouse:__AddRequest(10,warehouse.BlueCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply AAA Vulcan", 4,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueCentralWarehouse:__AddRequest(10,warehouse.BlueCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM Avenger", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.RED then
    MESSAGE:New("We have captured Blue Team's Central Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToRed()
    MESSAGE:New("We have lost the Central Warehouse and no longer able to re-enforce the front.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueCentralWarehouse:__Save(15,nil,"BlueCentralWarehouse")
    end
end

function  warehouse.BlueSouthernWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function  warehouse.BlueSouthernWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.BLUE then
    MESSAGE:New("The Central Warehouse is running at full capacity.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueSouthernWarehouse:__Save(15,nil,"BlueSouthernWarehouse")
    warehouse.BlueSouthernWarehouse:__AddRequest(10,warehouse.BlueSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply MBT Merkava", 3,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueSouthernWarehouse:__AddRequest(10,warehouse.BlueSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply IFV M2A1", 6,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueSouthernWarehouse:__AddRequest(10,warehouse.BlueSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply AAA Vulcan", 4,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.BlueSouthernWarehouse:__AddRequest(10,warehouse.BlueSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM Avenger", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.RED then
    MESSAGE:New("We have captured Blue Team's Southern Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToRed()
    MESSAGE:New("We have lost the Southern Warehouse and no longer able to re-enforce the front.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueSouthernWarehouse:__Save(15,nil,"BlueSouthernWarehouse")
    end
end

function  warehouse.BlueNorthernSAMWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function  warehouse.BlueNorthernSAMWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.BLUE then
    MESSAGE:New("The Northern SAM Warehouse is running at full capacity.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueNorthernSAMWarehouse:__Save(15,nil,"BlueNorthernSAMWarehouse")
    warehouse.BlueNorthernSAMWarehouse:__AddRequest(10,warehouse.BlueNorthernSAMWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM Hawk", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.RED then
    MESSAGE:New("We have captured Blue Team's Northern SAM Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToRed()
    MESSAGE:New("We have lost the Northern SAM Warehouse and no longer able to secure the airspace.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueNorthernSAMWarehouse:__Save(15,nil,"BlueNorthernSAMWarehouse")
    end
end

function  warehouse.BlueSouthernSAMWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function warehouse.BlueSouthernSAMWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.BLUE then
    MESSAGE:New("The Southern SAM Warehouse is running at full capacity.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueSouthernSAMWarehouse:__Save(15,nil,"BlueSouthernSAMWarehouse")
    warehouse.BlueSouthernSAMWarehouse:__AddRequest(10,warehouse.BlueSouthernSAMWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM Hawk", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.RED then
    MESSAGE:New("We have captured Blue Team's Southern SAM Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToRed()
    MESSAGE:New("We have lost the Southern SAM Warehouse and no longer able to secure the airspace.",25,"[TEAM]:"):ToBlue()
    warehouse.BlueSouthernSAMWarehouse:__Save(10,nil,"BlueSouthernSAMWarehouse")
    end
end

function  warehouse.RedNorthernWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function warehouse.RedNorthernWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.RED then
    MESSAGE:New("The Northern Warehouse is running at full capacity.",25,"[TEAM]:"):ToRed()
    warehouse.RedNorthernWarehouse:__Save(15,nil,"RedNorthernWarehouse")
    warehouse.RedNorthernWarehouse:__AddRequest(10,warehouse.RedNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply MBT T72B", 3,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedNorthernWarehouse:__AddRequest(10,warehouse.RedNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply IFV BMP-3", 6,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedNorthernWarehouse:__AddRequest(10,warehouse.RedNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply AAA Shilka", 4,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedNorthernWarehouse:__AddRequest(10,warehouse.RedNorthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM SA-13", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.BLUE then
    MESSAGE:New("We have captured Red Team's Northern Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToBlue()
    MESSAGE:New("We have lost the Northern Warehouse and no longer able to re-enforce the front.",25,"[TEAM]:"):ToRed()
    warehouse.RedNorthernWarehouse:__Save(15,nil,"RedNorthernWarehouse")
    end
end
function  warehouse.RedCentralWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function warehouse.RedCentralWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.RED then
    MESSAGE:New("The Central Warehouse is running at full capacity.",25,"[TEAM]:"):ToRed()
    warehouse.RedCentralWarehouse:__Save(15,nil,"RedCentralWarehouse")
    warehouse.RedCentralWarehouse:__AddRequest(10,warehouse.RedCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply MBT T72B", 3,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedCentralWarehouse:__AddRequest(10,warehouse.RedCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply IFV BMP-3", 6,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedCentralWarehouse:__AddRequest(10,warehouse.RedCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply AAA Shilka", 4,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedCentralWarehouse:__AddRequest(10,warehouse.RedCentralWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM SA-13", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.BLUE then
    MESSAGE:New("We have captured Red Team's Northern Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToBlue()
    MESSAGE:New("We have lost the Northern Warehouse and no longer are to re-enforce the front.",25,"[TEAM]:"):ToRed()
    warehouse.RedCentralWarehouse:__Save(15,nil,"RedCentralWarehouse")
    end
end

function  warehouse.RedSouthernWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function warehouse.RedSouthernWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.RED then
    MESSAGE:New("The Central Warehouse is running at full capacity.",25,"[TEAM]:"):ToRed()
    warehouse.RedSouthernWarehouse:__Save(15,nil,"RedSouthernWarehouse")
    warehouse.RedSouthernWarehouse:__AddRequest(10,warehouse.RedSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply MBT T72B", 3,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedSouthernWarehouse:__AddRequest(10,warehouse.RedSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply IFV BMP-3", 6,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedSouthernWarehouse:__AddRequest(10,warehouse.RedSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply AAA Shilka", 4,
    WAREHOUSE.TransportType.SELFPROPELLED)
    warehouse.RedSouthernWarehouse:__AddRequest(10,warehouse.RedSouthernWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM SA-13", 2,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.BLUE then
    MESSAGE:New("We have captured Red Team's Southern Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToBlue()
    MESSAGE:New("We have lost the Southern Warehouse and no longer able to re-enforce the front.",25,"[TEAM]:"):ToRed()
    warehouse.RedSouthernWarehouse:__Save(15,nil,"RedSouthernWarehouse")
    end
end

function  warehouse.RedNorthernSAMWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function warehouse.RedNorthernSAMWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.RED then
    MESSAGE:New("The Northern SAM Warehouse is running at full capacity.",25,"[TEAM]:"):ToRed()
    warehouse.RedNorthernSAMWarehouse:__Save(15,nil,"RedNorthernSAMWarehouse")
    warehouse.RedNorthernSAMWarehouse:__AddRequest(10,warehouse.RedNorthernSAMWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM SA-11", 1,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.BLUE then
    MESSAGE:New("We have captured Red Team's Northern SAM Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToRed()
    MESSAGE:New("We have lost the Northern SAM Warehouse and no longer able to secure the airspace.",25,"[TEAM]:"):ToBlue()
    warehouse.RedNorthernSAMWarehouse:__Save(15,nil,"RedNorthernSAMWarehouse")    
    end
end

function  warehouse.RedSouthernSAMWarehouse:OnAfterCaptured(From, Event, To, Coalition, Country)
--function warehouse.RedSouthernSAMWarehouse:OnAfterAirbaseCaptured(From,Event,To,Coalition)
  if Coalition==coalition.side.RED then
    MESSAGE:New("The Northern SAM Warehouse is running at full capacity.",25,"[TEAM]:"):ToRed()
    warehouse.RedSouthernSAMWarehouse:__Save(15,nil,"RedSouthernSAMWarehouse")
    warehouse.RedSouthernSAMWarehouse:__AddRequest(10,warehouse.RedSouthernSAMWarehouse,
    WAREHOUSE.Descriptor.GROUPNAME, "Resupply SAM SA-11", 1,
    WAREHOUSE.TransportType.SELFPROPELLED)
  elseif Coalition==coalition.side.BLUE then
    MESSAGE:New("We have captured Red Team's Southern SAM Warehouse, they will no longer receive re-enforcements.",25,"[TEAM]:"):ToRed()
    MESSAGE:New("We have lost the Southern SAM Warehouse and no longer able to secure the airspace.",25,"[TEAM]:"):ToBlue()
    warehouse.RedSouthernSAMWarehouse:__Save(15,nil,"RedSouthernSAMWarehouse")
    end
end


----Save Warehouses outside of the capture
--WAREHOUSE.Save(self,path,filename)
--warehouse.Minakh:Save(path,filename)
--warehouse.Minakh:__Save(delay,path,filename)

warehouse.BlueNorthernWarehouse:__Save(3600,nil,"WarehouseAbualDuhur")
warehouse.BlueCentralWarehouse:__Save(3620,nil,"WarehouseAdanaSakirpasa")
warehouse.BlueSouthernWarehouse:__Save(3640,nil,"BlueSouthernWarehouse")
warehouse.BlueNorthernSAMWarehouse:__Save(3680,nil,"BlueNorthernSAMWarehouse")
warehouse.BlueSouthernSAMWarehouse:__Save(3700,nil,"BlueSouthernSAMWarehouse")
warehouse.BlueSouthernSAMWarehouse:__Save(3720,nil,"BlueSouthernSAMWarehouse")
warehouse.RedNorthernWarehouse:__Save(3740,nil,"RedNorthernWarehouse")
warehouse.RedCentralWarehouse:__Save(3760,nil,"RedCentralWarehouse")
warehouse.RedSouthernWarehouse:__Save(3780,nil,"RedSouthernWarehouse")
warehouse.RedNorthernSAMWarehouse:__Save(3800,nil,"RedNorthernSAMWarehouse")
warehouse.RedSouthernSAMWarehouse:__Save(3820,nil,"RedSouthernSAMWarehouse")