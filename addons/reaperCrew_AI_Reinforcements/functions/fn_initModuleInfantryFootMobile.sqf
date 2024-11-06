// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Don't run if the array isn't available
while {isNil "activeInfantryTriggers"} do {
	if (reaperCrew_ReinforcementsCheckbox == true) then {
		["Infantry triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 60;
};

// Get variables
_reinforcementsCount = _logic getVariable ["reinforcementCount",50];
_zoneThreshold = _logic getVariable ["zoneThreshold",20];
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];
_useRegularTroops = _logic getVariable ["regularTroops",true];
_useEliteTroops = _logic getVariable ["eliteTroops",false];
_useSpecialForces = _logic getVariable ["specialTroops",false];
_rushMode = _logic getVariable ["rushMode",false];
_codeOnSpawnGroup = _logic getVariable ["codeOnSpawnGroup",""];
_waveDelay = _logic getVariable ["waveDelay",60];

// Build array of available squads
_troopsArrays = [];
if (_useRegularTroops) then {
	_troopsArrays pushBack [(reaperCrew_reinforcements_regularTroops splitString ","), reaperCrew_reinforcements_regularTroopsDifficulty];
};
if (_useEliteTroops) then {
	_troopsArrays pushBack [(reaperCrew_reinforcements_eliteTroops splitString ","), reaperCrew_reinforcements_eliteTroopsDifficulty];
};
if (_useSpecialForces) then {
	_troopsArrays pushBack [(reaperCrew_reinforcements_specialForces splitString ","), reaperCrew_reinforcements_specialForcesDifficulty];
};

// Create trigger
_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, -1];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_activationTrigger setTriggerStatements ["this && {isTouchingGround _x} count thisList > 0", "[thisTrigger] call reapercrew_reinforcements_fnc_activateInfantryModuleFootMobile;", ""];
_activationTrigger setTriggerInterval 5;

// Set trigger variables
_activationTrigger setVariable ["troopArrays", _troopsArrays];
_activationTrigger setVariable ["reinforcementCount", _reinforcementsCount];
_activationTrigger setVariable ["zoneThreshold", _zoneThreshold];
_activationTrigger setVariable ["logicArea2D", _logicArea2D];
_activationTrigger setVariable ["rushMode", _rushMode];
_activationTrigger setVariable ["codeOnSpawnGroup", _codeOnSpawnGroup];
_activationTrigger setVariable ["waveDelay", _waveDelay];
_activationTrigger setVariable ["moduleObject", _logic];

["Initialised foot mobile infantry module"] call reapercrew_common_fnc_remoteLog;