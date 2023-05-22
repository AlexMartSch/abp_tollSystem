Config = {}

--[[

           ____  _____        _____                 _                                  _       
     /\   |  _ \|  __ \      |  __ \               | |                                | |      
    /  \  | |_) | |__) |_____| |  | | _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ ___ 
   / /\ \ |  _ <|  ___/______| |  | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __/ __|
  / ____ \| |_) | |          | |__| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_\__ \
 /_/    \_\____/|_|          |_____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|___/
                                                           | |                                 
                                                           |_|                                 

    Supported version May 2023
    Support Discord: https://discord.gg/GQA39ee3

]]

-----------------------
--- GENERAL SETTINGS ---
-----------------------

-- Note: Use the name of the file as language.
Config.Language = 'en'

Config.UseCustomNotifications = false
Config.UseCustomAdvancedNotifications = false

-- Enabled just if custom notifications are disabled
Config.UseLibNotifications = true

-----------------------

-----------------------
--- TOLLS SETTINGS ---
-----------------------
Config.DebugMode = true

Config.TimeToGo = 3
Config.EmergencyVehiclesNoPayWhenSirenOn = true
Config.FineWhenEscaping = true


Config.Tolls = {
    {
        name = "Test Toll",
        stations = {
            vector3(-75.2294, -819.4701, 326.1752)
        },
        price = 100,
        fine = 150
    }
}
