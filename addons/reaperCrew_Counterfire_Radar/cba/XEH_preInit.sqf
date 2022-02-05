// Init Settings
["reaperCrew_fireSupport_ActivateSystem", "CHECKBOX", ["Activate Counter Battery System", "Tick to enable the counter battery system"], ["Reaper Crew - Counter Battery", "Init Settings"]] call cba_settings_fnc_init;

// Asset Detection
["reaperCrew_fireSupport_enemyAssets", "EDITBOX", ["Enemy Turret Assets", "A comma seperated list of classnames that should be recognised by the counter battery system"], ["Reaper Crew - Counter Battery", "Asset Detection"], "O_Mortar_01_F,O_G_Mortar_01_F"] call cba_settings_fnc_init;

// Debug Settings
["reaperCrew_fireSupport_debugCounterBatteryDetection", "CHECKBOX", ["DEBUG: Log radar detection data", "Output asset detection data to console"], ["Reaper Crew - Counter Battery", "Debug Settings"]] call cba_settings_fnc_init;
["reaperCrew_fireSupport_debugAIAssetDetection", "CHECKBOX", ["DEBUG: Show AI asset detection data", "Output asset detection data to console"], ["Reaper Crew - Counter Battery", "Debug Settings"]] call cba_settings_fnc_init;
["reaperCrew_fireSupport_debugRadarKnowledge", "CHECKBOX", ["DEBUG: Radar knowledge management", "Output asset detection data to console"], ["Reaper Crew - Counter Battery", "Debug Settings"]] call cba_settings_fnc_init;
["reaperCrew_fireSupport_debugKnowledgeMarkers", "CHECKBOX", ["DEBUG: Knowledge markers", "Output asset detection data to console"], ["Reaper Crew - Counter Battery", "Debug Settings"]] call cba_settings_fnc_init;