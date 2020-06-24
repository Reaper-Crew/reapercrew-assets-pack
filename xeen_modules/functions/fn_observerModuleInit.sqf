params ["_logic"];

diag_log "FORWARD OBSERVER (INIT): Initialising";

_units = [];
_supportType = _logic getVariable ["SupportType","82mm"];
_retryTime = _logic getVariable ["retryTime",240];

diag_log "FORWARD OBSERVER (INIT): Checking for attached units";
// Check to see if the module was attached
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	_units pushBack _attachedObject;
};

diag_log "FORWARD OBSERVER (INIT): Checking for synchronised units";
// Check to see if the module has syncronised units
_syncObjects = synchronizedObjects _logic;
// Check if the array is empty
if (count _syncObjects > 0) then {
	// If not empty, push all of the sync units into the _units array
	{
		_units pushBack _x;
	} forEach _syncObjects;
};

diag_log "FORWARD OBSERVER (INIT): Checking _units array element count";
// Check that the array of units isn't empty
if (count _units == 0) exitWith {
	diag_log "FORWARD OBSERVER (INIT): No units assigned, exiting";
};

diag_log format ["FORWARD OBSERVER (INIT): Affected Units: %1", _units ];

// Assign the event handler to each affected unit
{
	diag_log format ["FORWARD OBSERVER (INIT): Processing unit: %1", _x ];

	// Assign unit variables
	_x setVariable ["_unitSupportType", _supportType];
	_x setVariable ["_unitRetryTime", _retryTime];
	_x setVariable ["acex_headless_blacklist", true];

	_x addEventHandler ["FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		// Get variables from unit
		_unitSupportType = _unit getVariable ["_unitSupportType", "82mm"];
		_unitRetryTime = _unit getVariable ["_unitRetryTime", 30];

		[_unitSupportType, _unit, _unitRetryTime] call xeen_fnc_observerModuleBehavior;
		_unit removeEventHandler ["FiredNear", 0];
	}];

	diag_log format ["FORWARD OBSERVER (INIT): Added event handler to: %1", _x ];

} forEach _units;

// Delete the logic
deleteVehicle _logic;

true