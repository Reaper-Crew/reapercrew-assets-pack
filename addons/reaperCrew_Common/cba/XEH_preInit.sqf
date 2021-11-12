// Headless Client settings
["reaperCrew_detectHeadlessClients", "CHECKBOX", ["Detect headless clients", "Tick scan for headless clients"], ["Reaper Crew - Headless Clients", "Headless Client Settings"]] call cba_settings_fnc_init;

["reaperCrew_detectHeadlessTimer", "TIME", ["60", "How long should the system wait between runs of HC detection"], ["Reaper Crew - Headless Clients", "Headless Client Settings"], [60, 600, 60]] call cba_settings_fnc_init;

["reaperCrew_detectHeadlessClientsDebug", "CHECKBOX", ["DEBUG: Show headless detection output to console", "Tick to output debug info to logs"], ["Reaper Crew - Headless Clients", "Headless Client Settings"]] call cba_settings_fnc_init;