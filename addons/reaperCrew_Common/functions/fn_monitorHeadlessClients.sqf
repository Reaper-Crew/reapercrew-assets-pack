// Only run on the server

if (!isServer) exitWith {["Server checked failed - skipping headless client system"] call reapercrew_common_fnc_remoteLog};

[] spawn {
	while { true } do {
		// Reset list of headless clients
		HeadlessClients = entities "HeadlessClient_F";
		if (reaperCrew_detectHeadlessClientsDebug) then {
			[(format ["Found the following headless clients: %1", HeadlessClients])] call reapercrew_common_fnc_remoteLog;
		};
		sleep reaperCrew_detectHeadlessTimer;
	};
};
