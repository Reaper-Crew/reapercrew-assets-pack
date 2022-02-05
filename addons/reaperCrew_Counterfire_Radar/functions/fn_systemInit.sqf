/*
* Author: Xeenenta
* This init function runs and starts the counter battery system
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_systemInit
*
* Public: No
*/

if (!isServer) exitWith {diag_log "[COUNTER BATTERY]: Server checked failed - skipping counter battery system"};

// Check that the system is enabled
if !(reaperCrew_fireSupport_ActivateSystem) exitWith { diag_log "[COUNTER BATTERY]: System disabled - skipping counter battery system"; };

// System Variables
// Player Variables
playerCounterBatterySystems = [];

// AI Variables
AIArtilleryPlatforms = [];

// Spawn tasks
[] call reapercrew_counterBattery_fnc_systemScheduledTasks;

true;