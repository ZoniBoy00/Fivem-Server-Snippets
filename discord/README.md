# FiveM Discord Rich Presence Script

A lightweight, optimized, and easy-to-configure FiveM script to display your server's status and player count on Discord via Rich Presence.

## ✨ Features

*   **Dynamic Player Count**: Shows the current number of players online.
*   **Configurable Server Name**: Display your server's name prominently.
*   **Customizable Images**: Use your own large and small images with hover text.
*   **Time Elapsed**: Shows how long a player has been in-game.
*   **Optional Buttons**: Add up to two clickable buttons (e.g., "Connect to Server", "Website").
*   **Low Resource Usage**: Optimized for minimal impact on server and client performance (low resmon).
*   **Easy to Configure**: All settings are in one clear configuration table.
*   **Clean Codebase**: Well-commented and structured for easy maintenance.

## 🚀 Installation

Follow these steps to get the Discord Rich Presence script running on your FiveM server.

### 1. Download the Script

*   Download this resource.

### 2. Place the Resource

*   Extract the `discord` folder (or whatever you named it) into your FiveM server's `resources` directory.
    \`\`\`
    your-fivem-server/
    └── resources/
        └── [your-resources]/
            └── discord/  <-- Place the folder here
                ├── client.lua
                ├── fxmanifest.lua
                └── server.lua
                └── README.md
    \`\`\`

### 3. Configure Your Discord Application (Crucial!)

For the Rich Presence to work, you need to set up a Discord Application and upload assets.

1.  **Create a Discord Application**:
    *   Go to the [Discord Developer Portal](https://discord.com/developers/applications).
    *   Click "New Application".
    *   Give it a meaningful name (e.g., "Your FiveM Server RPC").
    *   Once created, navigate to the "General Information" page.
    *   Copy the **Application ID** and paste it into the `AppId` field in `discord/client.lua`.

2.  **Upload Rich Presence Assets**:
    *   In your Discord Application settings, navigate to "Rich Presence" -> "Art Assets".
    *   Upload your desired images for the large and small icons.
    *   **Important**: Note the **NAME** you give to each uploaded image. This is the name you will use for `LargeImageName` and `SmallImageName` in your `discord/client.lua` config (e.g., if you upload an image and name it `logo`, then `LargeImageName = 'logo'`).
    *   Ensure the image names in your `client.lua` configuration exactly match the asset names in the Discord Developer Portal.

### 4. Configure the Script

*   Open `discord/client.lua` with a text editor.
*   Modify the `Config` table at the top of the file to match your server's details and preferences:

    \`\`\`lua
    local Config = {
        AppId = 'YOUR_DISCORD_APPLICATION_ID', -- **REQUIRED**: Replace with your application ID
        ServerName = 'Your Awesome Server',    -- The name of your server
        MaxPlayerSlots = 64,                   -- Max player slots on your server
        UpdateInterval = 10000,                -- How often to update RPC (in milliseconds, 10000 = 10 seconds)

        LargeImageName = 'logo',               -- Name of the large image asset (must match Discord asset name)
        LargeImageText = 'Your Server Description', -- Hover text for large image

        SmallImageName = '',                   -- Name of the small image asset (leave empty if not used)
        SmallImageText = 'FiveM',              -- Hover text for small image (only applies if SmallImageName is set)

        Buttons = {                            -- Optional: up to 2 buttons
            -- { label = 'Connect', url = 'fivem://connect/yourserverip' }, -- Uncomment and fill in
            -- { label = 'Website', url = 'https://yourwebsite.com' }       -- Uncomment and fill in
        }
    }
    \`\`\`

### 5. Start the Resource

*   Add `ensure discord` (or `start discord` if you're using an older `server.cfg`) to your `server.cfg` file.
    \`\`\`cfg
    # ... other resources
    ensure discord
    # ...
    \`\`\`

*   Restart your FiveM server.

## 🎮 Usage

Once installed and configured, players connected to your server will automatically display the configured Rich Presence on their Discord profile, showing:

*   Your server's name.
*   The current player count out of the maximum slots.
*   How long they've been playing on your server.
*   Your custom large and small images with hover text.
*   Any configured buttons (e.g., "Connect", "Website").

## 📂 File Structure

\`\`\`
discord/
├── client.lua      # Client-side script: Handles Discord RPC updates and configuration.
├── fxmanifest.lua  # Resource manifest file.
└── server.lua      # Server-side script: Provides player count to clients.
└── README.md       # This file.
\`\`\`

##  troubleshooting

### Rich Presence Not Showing Up

*   **Is Discord Running?** Ensure Discord is open and running on the player's computer.
*   **Game Activity Enabled?** In Discord settings, go to "Activity Privacy" and ensure "Display current activity as a status message" is enabled. Also, check "Registered Games" to make sure FiveM is detected and activity is allowed.
*   **Correct Application ID?** Double-check that the `AppId` in `client.lua` exactly matches the Application ID from your Discord Developer Portal.
*   **Resource Started?** Verify that `ensure discord` (or `start discord`) is in your `server.cfg` and the resource started successfully in your server console.
*   **Firewall/Antivirus?** Ensure no firewall or antivirus software is blocking FiveM's connection to Discord.

### Images Not Appearing

*   **Asset Names Match?** The `LargeImageName` and `SmallImageName` in `client.lua` **must** exactly match the names you gave the assets when uploading them in the Discord Developer Portal under "Rich Presence" -> "Art Assets". Names are case-sensitive.
*   **Assets Uploaded?** Confirm that the images are actually uploaded to your Discord Application's assets.

### Player Count Incorrect

*   The server-side script (`server.lua`) handles the player count. Ensure it's loading correctly.
*   The `MaxPlayerSlots` in `client.lua` is a static configuration value; ensure it's set correctly to your server's actual maximum.

## 🤝 Contributing

Feel free to fork this repository, make improvements, and submit pull requests. Any contributions are welcome!

## 📄 License

This project is open-source and available under the MIT License.
