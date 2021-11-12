// Create variables
activeInfantryTriggers = [];

// Output debug information

// Infantry Spawns
while { true } do {
	if (reaperCrew_InfantrySpawnCheckbox == true) then {
		diag_log format ["SCENARIO: Found the following active infantry triggers: %1", activeInfantryTriggers];
	};
	sleep 15;
};