--[[
    FiveM Discord Rich Presence Server Script
    Purpose: Provides the current active player count to clients upon request.
    This keeps the client-side script lightweight by offloading player count retrieval.
]]--

-- Event handler: Responds to client requests for the current player count.
RegisterServerEvent('FiveMDiscordRPC:RequestPlayerCount')
AddEventHandler('FiveMDiscordRPC:RequestPlayerCount', function()
    -- Get the total number of active player indices.
    -- This is an efficient way to get the current player count on the server.
    local count = GetNumPlayerIndices()

    -- Trigger a client event to send the player count back to the requesting client.
    -- 'source' refers to the player who triggered this server event.
    TriggerClientEvent('FiveMDiscordRPC:UpdatePlayerCount', source, count)
end)
