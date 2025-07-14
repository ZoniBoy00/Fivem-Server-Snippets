-- optimizations
local tonumber = tonumber
local CreateThread = Citizen.CreateThread
local Wait = Citizen.Wait
local TriggerEvent = TriggerEvent
local RegisterCommand = RegisterCommand
local PlayerPedId = PlayerPedId
local IsPedInAnyVehicle = IsPedInAnyVehicle
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehiclePedIsIn = GetVehiclePedIsIn
local SetPedIntoVehicle = SetPedIntoVehicle
-- end optimizations

local disabled = false

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local restrictSwitching = false
        
        if IsPedInAnyVehicle(ped, false) and not disabled then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), 0) == ped then
                restrictSwitching = true
            end
        end
        
        SetPedConfigFlag(ped, 184, restrictSwitching)
        Wait(150)
    end
end)

local function switchSeat(_, args)
    local seatIndex = tonumber(args[1]) - 1
    
    if seatIndex < -1 or seatIndex >= 4 then
        SetNotificationTextEntry('STRING')
        AddTextComponentString("~r~Paikkaa ~b~" .. (seatIndex + 1) .. "~r~ ei löydy!")
        DrawNotification(true, true)
    else
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        
        if veh ~= nil and veh > 0 then
            CreateThread(function()
                disabled = true
                SetPedIntoVehicle(PlayerPedId(), veh, seatIndex)
                Wait(50)
                disabled = false
            end)
        end
    end
end

local function shuffleSeat()
    CreateThread(function()
        disabled = true
        Wait(3000)
        disabled = false
    end)
end

RegisterCommand("istu", switchSeat)
RegisterCommand("va", shuffleSeat)

TriggerEvent('chat:addSuggestion', '/va', "Vaihda kuljettajan paikalle")
TriggerEvent('chat:addSuggestion', '/istu', 'Vaihda paikkaa',
  { { name = 'istuin', help = "Vaihda paikkaa ajonevossa. 0 = kuski, 1 = apukuski, 2-3 = takapenkit" } })

AddEventHandler('onClientResourceStop', function(name)
    if name == 'seat-switcher' then
        SetPedConfigFlag(PlayerPedId(), 184, false)
    end
end)