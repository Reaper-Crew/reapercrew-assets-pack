// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Variables
_vehicleCount = _logic getVariable ["vehicleCount",50];
_vehicleFrequencyMin = _logic getVariable ["vehicleFrequencyMin",180];
_vehicleFrequencyMax = _logic getVariable ["vehicleFrequencyMax",240];
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_concurrentVehicles = _logic getVariable ["concurrentVehicles",2];
_useheavyArmour = _logic getVariable ["heavyArmour",true];
_uselightArmour = _logic getVariable ["lightArmour",true];
_usetechnicals = _logic getVariable ["technicals",true];

// Build an array of available vehicles
_vehiclesArray = [];
if (_useheavyArmour) then {
	_vehiclesArray append (reaperCrew_reinforcements_fireSupportHeavyArmour splitString ",");
};
if (_uselightArmour) then {
	_vehiclesArray append (reaperCrew_reinforcements_fireSupportLightArmour splitString ",");
};
if (_usetechnicals) then {
	_vehiclesArray append (reaperCrew_reinforcements_fireSupportTechnicals splitString ",");
};

// Create trigger
_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, -1];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_activationTrigger setTriggerStatements ["this && {isTouchingGround _x} count thisList > 0", "[thisTrigger] call reapercrew_reinforcements_fnc_activatemaraudingvehicles;", ""];

// Set trigger variables
_activationTrigger setVariable ["vehicleCount",_vehicleCount];
_activationTrigger setVariable ["vehicleFrequencyMin",_vehicleFrequencyMin];
_activationTrigger setVariable ["vehicleFrequencyMax",_vehicleFrequencyMax];
_activationTrigger setVariable ["concurrentVehicles",_concurrentVehicles];
_activationTrigger setVariable ["vehiclesArray",_vehiclesArray];