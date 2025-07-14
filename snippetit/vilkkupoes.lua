Citizen.CreateThread(function()
    while true do
        DistantCopCarSirens(false)
        Citizen.Wait(400)
    end
end)

Citizen.CreateThread(function()
    SetCreateRandomCops(false)
    SetCreateRandomCopsNotOnScenarios(false)
    SetCreateRandomCopsOnScenarios(false) 
    SetScenarioTypeEnabled("WORLD_HUMAN_COP_IDLES", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR", false)
    SetScenarioTypeEnabled("CODE_HUMAN_POLICE_CROWD_CONTROL", false)
    SetScenarioTypeEnabled("CODE_HUMAN_POLICE_INVESTIGATE", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_AMBULANCE", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_FIRE_TRUCK", false)
end)

Citizen.CreateThread(function()
    for dispatchService=1, 25 do
        EnableDispatchService(dispatchService, false)
        Citizen.Wait(10)
    end
end)