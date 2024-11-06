// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Variables
_AircraftCount = _logic getVariable ["AircraftCount",50];
_AircraftFrequencyMin = _logic getVariable ["AircraftFrequencyMin",180];
_AircraftFrequencyMax = _logic getVariable ["AircraftFrequencyMax",240];
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];


_usefixedWingBombers = _logic getVariable ["fixedWingBombers",true];
_usefixedWingFighters = _logic getVariable ["fixedWingFighters",true];
_userotaryCASHeavy = _logic getVariable ["rotaryCASHeavy",true];
_userotaryCASLight = _logic getVariable ["rotaryCASLight",true];

// Build an array of available Aircrafts
_AircraftsArray = [];
if (_usefixedWingBombers) then {
	_AircraftsArray append (reaperCrew_reinforcements_fireSupportFixedWingBombers splitString ",");
};
if (_usefixedWingFighters) then {
	_AircraftsArray append (reaperCrew_reinforcements_fireSupportFixedWingFighters splitString ",");
};
if (_userotaryCASHeavy) then {
	_AircraftsArray append (reaperCrew_reinforcements_fireSupportHeavyRotary splitString ",");
};
if (_userotaryCASLight) then {
	_AircraftsArray append (reaperCrew_reinforcements_fireSupportLightRotary splitString ",");
};


// Create trigger
_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, -1];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_activationTrigger setTriggerStatements ["this && {isTouchingGround _x} count thisList > 0", "[thisTrigger] call reapercrew_reinforcements_fnc_activateMaraudingAircraft;", ""];
_activationTrigger setTriggerInterval 5;

// Set trigger variables
_activationTrigger setVariable ["AircraftCount",_AircraftCount];
_activationTrigger setVariable ["AircraftFrequencyMin",_AircraftFrequencyMin];
_activationTrigger setVariable ["AircraftFrequencyMax",_AircraftFrequencyMax];
_activationTrigger setVariable ["AircraftsArray",_AircraftsArray];
_activationTrigger setVariable ["moduleObject", _logic];