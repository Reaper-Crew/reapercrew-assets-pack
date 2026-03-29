/*
 * Author: Xeenenta
 * Initialises the Timed Task module. Waits for a start variable to become true,
 * then runs a timer for the configured duration. Sets in-progress and completed
 * variables as the task progresses. Optionally broadcasts progress via side chat.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_mission_mechanics_fnc_initTimedTask
 *
 * Public: No
 */

private _logic = param [0, objNull, [objNull]];

if (!isServer) exitWith {
	["Server check failed - not running timed task init"] call reapercrew_common_fnc_remoteLog;
};

// Read module attributes
private _startVariable = _logic getVariable ["startVariable", ""];
private _inProgressVariable = _logic getVariable ["inProgressVariable", ""];
private _completedVariable = _logic getVariable ["completedVariable", ""];
private _taskDuration = _logic getVariable ["taskDuration", 300];
private _broadcastProgress = _logic getVariable ["broadcastProgress", true];
private _broadcastMessage = _logic getVariable ["broadcastMessage", "Task progress"];

// Validate — all three variable names are required (check for empty string or 0 from unset Eden attributes)
if (_startVariable isEqualTo "" || _inProgressVariable isEqualTo "" || _completedVariable isEqualTo "" || _startVariable isEqualTo 0 || _inProgressVariable isEqualTo 0 || _completedVariable isEqualTo 0) exitWith {
	[(format ["ERROR: Timed Task module has empty variable names — start: '%1', inProgress: '%2', completed: '%3'", _startVariable, _inProgressVariable, _completedVariable])] call reapercrew_common_fnc_remoteLog;
};

// Initialise in-progress and completed variables to false on all machines
// Start variable is NOT initialised here — it is created externally (e.g. by a trigger or interaction objective)
missionNamespace setVariable [_inProgressVariable, false, true];
missionNamespace setVariable [_completedVariable, false, true];

[(format ["Timed Task initialised — start: %1, inProgress: %2, completed: %3, duration: %4s, broadcast: %5", _startVariable, _inProgressVariable, _completedVariable, _taskDuration, _broadcastProgress])] call reapercrew_common_fnc_remoteLog;

// Wait for the start variable to exist and become true
waitUntil {
	sleep 1;
	!isNil _startVariable && {missionNamespace getVariable [_startVariable, false]}
};

// Task started — broadcast in-progress state to all machines
missionNamespace setVariable [_inProgressVariable, true, true];
[(format ["Timed Task started: %1 (%2s)", _startVariable, _taskDuration])] call reapercrew_common_fnc_remoteLog;

// Notify all players via side chat
if (_broadcastProgress) then {
	(format ["%1: Started", _broadcastMessage]) remoteExec ["systemChat", 0];
};

private _startTime = CBA_missionTime;

// Spawn progress reporter in a separate thread
[_startTime, _taskDuration, _inProgressVariable, _broadcastProgress, _broadcastMessage] spawn {
	params ["_startTime", "_taskDuration", "_inProgressVariable", "_broadcastProgress", "_broadcastMessage"];

	while {missionNamespace getVariable [_inProgressVariable, false]} do {
		sleep 60;

		// Check again after sleep in case task completed during the wait
		if !(missionNamespace getVariable [_inProgressVariable, false]) exitWith {};

		// Calculate elapsed time and derive percentage (capped at 100)
		private _elapsed = CBA_missionTime - _startTime;
		private _percentage = ((_elapsed / _taskDuration) * 100) min 100;
		private _percentageRounded = round _percentage;
		private _message = format ["%1: %2%3 complete", _broadcastMessage, _percentageRounded, "%"];

		[(format ["Timed Task progress: %1", _message])] call reapercrew_common_fnc_remoteLog;

		// Broadcast to all players via side chat
		if (_broadcastProgress) then {
			_message remoteExec ["systemChat", 0];
		};
	};
};

// Main thread — wait for duration to elapse
waitUntil {
	sleep 1;
	(CBA_missionTime - _startTime) >= _taskDuration
};

// Task completed — setting inProgress to false terminates the progress reporter thread
missionNamespace setVariable [_inProgressVariable, false, true];
missionNamespace setVariable [_completedVariable, true, true];

[(format ["Timed Task completed: %1", _completedVariable])] call reapercrew_common_fnc_remoteLog;

// Final broadcast to all players
if (_broadcastProgress) then {
	(format ["%1: Complete", _broadcastMessage]) remoteExec ["systemChat", 0];
};
