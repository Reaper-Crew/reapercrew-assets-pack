// Init Settings
["reaperCrew_sabreCounterBattery_ActivateSystem", "CHECKBOX", ["Activate Counter Battery System", "Tick to enable the counter battery system"], ["Reaper Crew - SABRE (Counter Battery)", "Init Settings"]] call cba_settings_fnc_init;

// Asset Detection
["reaperCrew_sabreCounterBattery_LauncherClassnames", "EDITBOX", ["Detectable Artillery Systems", "A comma seperated list of classnames that should be recognised by the counter battery system"], ["Reaper Crew - SABRE (Counter Battery)", "Asset Detection"], "B_MBT_01_arty_F,O_MBT_02_arty_F"] call cba_settings_fnc_init;

// Debug
["reaperCrew_sabreCounterBattery_DebugEvents", "CHECKBOX", ["Debug Event Handlers", "Tick to debug"], ["Reaper Crew - SABRE (Counter Battery)", "Debugging"]] call cba_settings_fnc_init;
["reaperCrew_sabreCounterBattery_DebugTasks", "CHECKBOX", ["Debug Tasks", "Tick to debug"], ["Reaper Crew - SABRE (Counter Battery)", "Debugging"]] call cba_settings_fnc_init
// ["reaperCrew_sabreCounterBattery_DebugGathering", "CHECKBOX", ["Debug Event Handlers", "Tick to debug"], ["Reaper Crew - SABRE (Counter Battery)", "Debugging"]] call cba_settings_fnc_init;


 