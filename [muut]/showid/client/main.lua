--[[
*
*  Displays Player Server IDs on top of the players when scoreboard is open. 
*  Remember to change IsControlPressed to match your scoreboard key.
*  
]]--
local ninjas = {
	"Jonne" -- Jonne
}

function isNinja(name)
	for i = 1, #ninjas, 1 do
		if string.lower(name) == string.lower(ninjas[i]) then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait( 1 )
		local headIds = { }
		if IsControlPressed(0, 121) then
			for id = 0, 255, 1 do
				if NetworkIsPlayerActive( id ) then 
					local ped = GetPlayerPed( id )
					if ped ~= nil and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped)) < Config.drawDistance) and HasEntityClearLosToEntity(GetPlayerPed(-1),  ped,  17) then
						if GetPlayerServerId(id) ~= nil and not isNinja(GetPlayerName(id)) then
						 headIds[id] = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, tostring(GetPlayerServerId(id)), false, false, "", false )
						 N_0x63bb75abedc1f6a0(headIds[id], false, true)
						end
					end
				end
			end
			while IsControlPressed(0, 121) do
				Citizen.Wait(20)
			end
			
			for id = 0, 255, 1 do
				if NetworkIsPlayerActive( id ) then
					N_0x63bb75abedc1f6a0(headIds[id], false, false)
				end
			end
		end
	end
end) 
