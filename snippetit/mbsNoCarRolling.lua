local mbsNoCarRolling = {}


function mbsNoCarRolling.drawText()
    
end


function mbsNoCarRolling.init()
	
end


function mbsNoCarRolling.tick()
	local playerPedID = PLAYER.PLAYER_PED_ID()
	if ENTITY.DOES_ENTITY_EXIST(playerPedID) then
		if PED.IS_PED_IN_ANY_VEHICLE(playerPedID, false) then
			local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPedID, false)
			if not PED.IS_PED_IN_FLYING_VEHICLE(playerPedID) then
				playerVehicleHash = VEHICLE.GET_VEHICLE_LAYOUT_HASH(playerVehicle)
				if not PED.IS_PED_ON_ANY_BIKE(playerPedID) then
					local rollEntitiy = ENTITY.GET_ENTITY_ROLL(playerPedID)
					if rollEntitiy > 90.9 or rollEntitiy < (-90.9) then
						VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(playerVehicle, false, false)
					end
				end
			end
		end
	end
end


function mbsNoCarRolling.unload()
end


return mbsNoCarRolling