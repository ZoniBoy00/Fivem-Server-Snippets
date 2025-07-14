playerMoving = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedArmed(GetPlayerPed(-1), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

local aivittukunsattuu = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(GetPlayerPed(-1)) <= 150 then -- kuinka helposti tulee injured
            setHurt()
        elseif aivittukunsattuu and GetEntityHealth(GetPlayerPed(-1)) > 199 then
            setNotHurt()
        end
    end
end)

function setHurt()
    aivittukunsattuu = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    aivittukunsattuu = true
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end

-- /turpaantuli
local sh1 = -1
local sh2 = -1
local sl1 = -1
local sl2 = -1
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local p = PlayerPedId()
        local h1 = GetPedPropIndex(p, 0)
        local h2 = GetPedPropTextureIndex(p, 0)
        local l1 = GetPedPropIndex(p, 1)
        local l2 = GetPedPropTextureIndex(p, 1)
        if h1 ~= -1 then
            sh1 = h1
            sh2 = h2
        end
        if l1 ~= -1 then
            sl1 = l1
            sl2 = l2
        end
    end
end)

RegisterCommand('turpaantuli', function()
    local p = PlayerPedId()
    SetPedPropIndex(p,0,sh1,sh2,2)
    SetPedPropIndex(p,1,sl1,sl2,2)
end)