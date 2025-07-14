ESX = nil

local Vehicles = {}

ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("virit", function()
	TriggerEvent("katsotuunaukset")
end)

RegisterNetEvent('katsotuunaukset')
AddEventHandler('katsotuunaukset', function()
local ped = GetPlayerPed(-1)

	local vehicle = GetVehiclePedIsIn(ped)
	local vehProps = ESX.Game.GetVehicleProperties(vehicle)
	local model       = GetEntityModel(vehicle)
	local modelName 	= GetDisplayNameFromVehicleModel(model)
	local modCount = GetNumVehicleMods(vehicle, modType)

	vehProps.modEngine = vehProps.modEngine + 1
	vehProps.modBrakes = vehProps.modBrakes + 1
	vehProps.modArmor = vehProps.modArmor + 1
	vehProps.modSuspension = vehProps.modSuspension + 1
	vehProps.modTransmission = vehProps.modTransmission + 1
	
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 30000, text = 'Auton malli: ' ..modelName })
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 30000, text = 'Jarrut: ' .. tostring(vehProps.modBrakes).. '/' .. GetNumVehicleMods(vehicle, 12) })
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 30000, text = 'Moottori: ' .. tostring(vehProps.modEngine).. '/' .. GetNumVehicleMods(vehicle,11) })
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 30000, text = 'Panssarit: ' .. tostring(vehProps.modArmor).. '/' .. GetNumVehicleMods(vehicle, 16) })
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 30000, text = 'Alusta: ' .. tostring(vehProps.modSuspension).. '/' .. GetNumVehicleMods(vehicle,15)})
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 30000, text = 'Vaihteisto: ' .. tostring(vehProps.modTransmission).. '/' .. GetNumVehicleMods(vehicle,13)})
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 30000, text = 'Turbo: ' .. tostring(vehProps.modTurbo)})
		
end)
