// Only run on the server

if (!isServer) exitWith {diag_log "SCENARIO: Server checked failed - skipping headless client system"};

[] spawn {
	while { true } do {
		// Reset list of headless clients
		HeadlessClients = entities "HeadlessClient_F";
		if (reaperCrew_detectHeadlessClientsDebug == true) then {
			diag_log format ["SCENARIO: Found the following headless clients: %1", HeadlessClients];
		};
		sleep reaperCrew_detectHeadlessTimer;
	};
};