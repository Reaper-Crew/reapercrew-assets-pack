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
* [] call reapercrew_sabre_counterBattery_fnc_taskGatherFires
*
* Public: No
*/



// Gather list of entities
_totalEntitiesList = [];
{
	_totalEntitiesList append (entities _x);
} forEach (reaperCrew_sabreCounterBattery_LauncherClassnames splitString ",");

_totalExistingRegisters = DatalinkBluForFiresElements + DatalinkOpForFiresElements + DatalinkIndForFiresElements;
if (reaperCrew_sabreCounterBattery_DebugTasks) then {
	[(format ["Classnames to register: %1", _totalEntitiesList])] call reapercrew_common_fnc_remoteLog;
};

// Register each unit
{
	// If not already registered, register
	if !(_x in _totalExistingRegisters) then {
		// Add event handler
		_x addEventHandler ["fired", {
			[_this select 0] call reapercrew_sabre_counterBattery_fnc_componentLCMREventFired;
		}];
		// Register unit in variable
		_unitSide = side _x;
		switch (_unitSide) do {
			case west: { 
				DatalinkBluForFiresElements pushBack _x;
			};
			case east: { 
				DatalinkOpForFiresElements pushBack _x;
			};
			case independent: { 
				DatalinkIndForFiresElements pushBack _x;
			};
			default {  };
		};
		[(format ["Registered fires %1 for side %2", _x, _unitSide])] call reapercrew_common_fnc_remoteLog;
	} else {
		[(format ["Skipping register of %1 - already registered", _x])] call reapercrew_common_fnc_remoteLog;
	};
} ForEach _totalEntitiesList;
