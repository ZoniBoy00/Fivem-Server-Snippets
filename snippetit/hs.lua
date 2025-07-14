Citizen.CreateThread(function()

    local ragdoll_chance = 0.6

    while true do

        Citizen.Wait(100)

        local ped = PlayerPedId()

        if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not
IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then

            local chance_result = math.random()

            if chance_result < ragdoll_chance then

                Citizen.Wait(600)

                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)

                SetPedToRagdoll(ped, 200, 200, 2, false, false, false)
            else

                Citizen.Wait(2000)
            end
        end
    end
end)