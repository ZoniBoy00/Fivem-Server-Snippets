-- /die To Make Yourself Die Along With A Ragdoll
Citizen.CreateThread(function()
	RegisterCommand('die', function() -- change die to whatever you want 
		SetEntityHealth(PlayerPedId(), 0) -- Kills The Ped
		TriggerEvent('chatMessage', "[Palvelin] | ", {139,0,199}, "Tapoit itsesi!")
		SetPedToRagdoll(PlayerPedId(), 50000, 50000, 0, 0, 0, 0) -- Makes The Ped Ragdoll Apon Death
		Citizen.Wait(0)
	end)
end)

-- Just A Way To Stop The DeathEffects
Citizen.CreateThread(function()
	RegisterCommand('stopeffect', function() 
		StopScreenEffect("DeathFailOut", 0,0)
	end)
end)

-- Stops Auto Respawn
AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer() -- Makes Sure Player Spawn Alive
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
end)