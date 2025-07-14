function RemoveItemsAfterRPDeath()
    TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

    Citizen.CreateThread(function()
        DoScreenFadeOut(800)

        Citizen.Wait(250)

        local mies = GetHashKey("mp_m_freemode_01")

        TriggerEvent('skinchanger:getSkin', function(skin)
            if GetHashKey(GetEntityModel(PlayerPedId())) == mies then
                local clothesSkin = {
                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                    ['torso_1'] = 144, ['torso_2'] = 0,
                    ['arms'] = 6,
                    ['pants_1'] = 65, ['pants_2'] = 0,
                    ['shoes_1'] = 34, ['shoes_2'] = 0,
                    ['helmet_1'] = -1,  ['helmet_2'] = 0,
                    ['ears_1'] = -1,     ['ears_2'] = 0
                }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            else
                local clothesSkin = {
                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                    ['torso_1'] = 144, ['torso_2'] = 0,
                    ['arms'] = 6,
                    ['pants_1'] = 65, ['pants_2'] = 0,
                    ['shoes_1'] = 34, ['shoes_2'] = 0,
                    ['chain_1'] = 0,    ['chain_2'] = 0,
                    ['ears_1'] = -1,     ['ears_2'] = 0
                }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
        end)
    end)
end