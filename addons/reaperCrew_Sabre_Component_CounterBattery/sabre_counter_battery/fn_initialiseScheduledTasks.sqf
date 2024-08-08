/*
* Author: Xeenenta
* TODO
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_sabre_counterBattery_fnc_initialiseScheduledTasks
*
* Public: No
*/

if (!isServer) exitWith {["Server checked failed - not starting scheduled task launcher"] call reapercrew_common_fnc_remoteLog;};

while {isNil "DataLinkSystemStarted"} do {
	// if (reaperCrew_sabreCounterBattery_DebugTasks) then {
		["System not started, pausing scheduled task init"] call reapercrew_common_fnc_remoteLog;
	// };
	sleep 15;
};

// TASK: 
[] spawn {
	while { reaperCrew_sabreCounterBattery_ActivateSystem } do {
		// ["TASK: Running garbage collection"] call reapercrew_common_fnc_remoteLog;
		[] call reapercrew_sabre_counterBattery_fnc_taskGarbageCollect;
		sleep 300; // Run every 5 mins
	};
};

[] spawn {
	while { reaperCrew_sabreCounterBattery_ActivateSystem } do {
		// ["TASK: Removing stale markers"] call reapercrew_common_fnc_remoteLog;
		[] call reapercrew_sabre_counterBattery_fnc_taskRemoveStaleMarkers;
		sleep 600; // Run every 10 mins
	};
};

[] spawn {
	while { reaperCrew_sabreCounterBattery_ActivateSystem } do {
		// ["TASK: Removing stale markers"] call reapercrew_common_fnc_remoteLog;
		[] call reapercrew_sabre_counterBattery_fnc_taskGatherFires;
		sleep 300; // Run every 5 mins
	};
};