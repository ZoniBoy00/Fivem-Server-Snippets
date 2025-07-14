function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

local id = PlayerId()
local serverID = GetPlayerServerId(PlayerId())
players = {}
for i = 0, 255 do
    if NetworkIsPlayerActive( i ) then
        table.insert( players, i )
    end
end

Citizen.CreateThread(function()
	AddTextEntry('FE_THDR_GTAO', '~p~ProjektiRP ~b~| ~p~ ID:~w~ ' .. GetPlayerServerId(PlayerId()).. '~b~ | ~p~ Pelaaja:~w~ ' .. GetPlayerName(PlayerId()))
end)