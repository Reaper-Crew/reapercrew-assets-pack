/*
* Author: Xeenenta
* Start long-running SABRE tasks
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_sabre_main_fnc_initialiseScheduledTasks
*
* Public: No
*/

if (!isServer) exitWith {["SABRE", "MAIN", "Server checked failed - not starting scheduled task launcher"] call reapercrew_common_fnc_remoteLog;};

while {isNil "DataLinkSystemStarted"} do {
	// if (reaperCrew_sabreCounterBattery_DebugTasks) then {
		["SABRE", "SCHEDULE", "System not started, pausing scheduled task init"] call reapercrew_common_fnc_remoteLog;
	// };
	sleep 15;
};

// TASK: SABRE network sync
[] spawn {
	while { reaperCrew_sabreCore_ActivateSystem } do {
		[] remoteExec ["reapercrew_sabre_network_fnc_networkSync", -2];	
		sleep 15;
	};
};

true;