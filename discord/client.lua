--[[
    FiveM Discord Rich Presence Client Script
    Purpose: Manages the Discord Rich Presence for individual players.
    Optimized for low resource usage and easy configuration.
]]--

-- Configuration: Customize these values to match your server's details.
local Config = {
    -- Your Discord Application ID.
    -- You can find this in your Discord Developer Portal under your application's "General Information".
    AppId = '987384516719042701',

    -- The main name of your server that will be displayed in the Discord Rich Presence.
    ServerName = 'FiveM Roleplay',

    -- The maximum number of player slots your server has.
    MaxPlayerSlots = 64,

    -- How often the Discord Rich Presence should update (in milliseconds).
    -- A value of 10000 (10 seconds) is generally good to avoid Discord API rate limits
    -- while providing reasonably fresh information.
    UpdateInterval = 10000,

    -- Large Image Configuration:
    -- 'LargeImageName': The name of the large image asset uploaded to your Discord Application.
    --                   This is the main image displayed in the RPC.
    -- 'LargeImageText': The text that appears when a user hovers over the large image.
    LargeImageName = 'logo',
    LargeImageText = 'FiveM Server',

    -- Small Image Configuration (Optional):
    -- 'SmallImageName': The name of a small image asset. It appears in the bottom-right corner
    --                   of the large image. Leave empty ('') if you don't want to use a small image.
    -- 'SmallImageText': The text that appears when a user hovers over the small image.
    --                   Only applies if 'SmallImageName' is set.
    SmallImageName = '',
    SmallImageText = 'FiveM',

    -- Buttons Configuration (Optional):
    -- You can add up to 2 buttons that link to URLs.
    -- Uncomment the examples below and replace 'label' and 'url' with your desired text and links.
    -- If you don't want buttons, leave this table empty or commented out.
    Buttons = {
        -- { label = 'Connect to Server', url = 'fivem://connect/yourserverip' }, -- Example: Replace 'yourserverip'
        -- { label = 'Visit Website', url = 'https://yourwebsite.com' }          -- Example: Replace 'https://yourwebsite.com'
    }
}

-- Internal variables (do not modify)
local playerCount = 0
local startTime = os.time() -- Records the time when the script starts, for "time elapsed" in RPC

-- Event handler: Receives the updated player count from the server.
-- This event is triggered by the server script.
RegisterNetEvent('FiveMDiscordRPC:UpdatePlayerCount')
AddEventHandler('FiveMDiscordRPC:UpdatePlayerCount', function(count)
    playerCount = count
end)

-- Main thread for Discord Rich Presence updates.
Citizen.CreateThread(function()
    -- Set the Discord Application ID once when the script starts.
    -- This is a one-time setup.
    SetDiscordAppId(Config.AppId)

    -- Loop indefinitely to periodically update the Discord Rich Presence.
    while true do
        -- Request the current player count from the server.
        -- This ensures the player count is always up-to-date.
        TriggerServerEvent('FiveMDiscordRPC:RequestPlayerCount')

        -- Construct the Discord Rich Presence payload.
        -- This table contains all the details to be sent to Discord.
        local presence = {
            details = Config.ServerName, -- Main line of text (e.g., "JZDev Roleplay")
            state = string.format("Players: %s/%s", playerCount, Config.MaxPlayerSlots), -- Second line of text (e.g., "Players: 10/64")
            largeImageKey = Config.LargeImageName,     -- Key for the large image asset
            largeImageText = Config.LargeImageText,   -- Hover text for the large image
            startTimestamp = startTime,               -- Unix timestamp for "time elapsed"

            -- Conditionally include small image details if a name is provided in the config.
            smallImageKey = Config.SmallImageName ~= '' and Config.SmallImageName or nil,
            smallImageText = Config.SmallImageName ~= '' and Config.SmallImageText or nil,

            -- Conditionally include buttons if they are defined in the config.
            buttons = #Config.Buttons > 0 and Config.Buttons or nil
        }

        -- Set the Discord Rich Presence.
        -- This sends the constructed 'presence' table to Discord.
        SetDiscordRichPresence(presence)

        -- Wait for the configured interval before updating again.
        -- This prevents excessive updates and reduces resource usage.
        Citizen.Wait(Config.UpdateInterval)
    end
end)
