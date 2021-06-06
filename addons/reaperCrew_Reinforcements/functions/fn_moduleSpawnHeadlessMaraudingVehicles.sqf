// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

if (_activated) then {

	// Don't run if the array isn't available
	while {isNil "activeVehicleTriggers"} do {
		if (reaperCrew_ReinforcementsCheckbox == true) then {
			diag_log "SCENARIO: Vehicle triggers undefined, sleeping";
		};
		sleep 60;
	};

	// Variables
	_unitGroup = reaperCrew_reinforcements_units splitString ",";
	_unitCount = count _unitGroup;
	_randomTrigger = objNull;

	_vehicleCount = _logic getVariable ["vehicleCount",50];
	_vehicleType = _logic getVariable ["vehicleType",0];
	_vehicleFrequencyMin = _logic getVariable ["vehicleFrequencyMin",180];
	_vehicleFrequencyMax = _logic getVariable ["vehicleFrequencyMax",240];
	_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];

	_sleepTimer = [_vehicleFrequencyMin, _vehicleFrequencyMax] call BIS_fnc_randomInt;
	_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];

	// Output debug information if enabled
	if (reaperCrew_ReinforcementsCheckbox == true) then {
		diag_log format ["SCENARIO: Reinforcements logic area is: %1", _logicArea];
		diag_log format ["SCENARIO: Reinforcements logic area 2D is: %1", _logicArea2D];
	};

	// Create a trigger, wait for it to be activated
	_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), true];
	_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, 20];
	_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_activationTrigger setTriggerStatements ["this", "", ""];
	waitUntil { triggerActivated _activationTrigger };

	// Start the reinforcements loop
	while {_vehicleCount > 0} do {

		// If spawn point available, spawn an enemy group
		if (count activeVehicleTriggers > 0 ) then {
			// Select a random spawn point
			_randomTrigger = (selectRandom activeVehicleTriggers);
			_triggerPos = getPos _randomTrigger;

			if (count HeadlessClients > 0) then {
				// If a headless client is available, spawn it with RemoteExec
				_selectedClient = selectRandom HeadlessClients;
    			[_logic, _triggerPos, _vehicleType] remoteExecCall ["reapercrew_reinforcements_fnc_spawnHeadlessVehicle", _selectedClient];
				// Output debug information
				if (reaperCrew_ReinforcementsCheckbox == true) then {
					diag_log format ["SCENARIO: Spawning reinforcements on client %1 at grid %2, %3 vehicles remain", name(_selectedClient), (mapGridPosition _randomTrigger), _vehicleCount];
				};		
			} else {
				// If no HCs are available, spawn it on the server
				[_logic, _triggerPos, _vehicleType] remoteExecCall ["reapercrew_reinforcements_fnc_spawnHeadlessVehicle", 2];
				if (reaperCrew_ReinforcementsCheckbox == true) then {
					diag_log format ["SCENARIO: Spawning reinforcements at grid %1, %2 vehicles remain", (mapGridPosition _randomTrigger), _vehicleCount];
				};
			};
			// Reduce the number of available reinforcements
			_vehicleCount = _vehicleCount - 1;
			sleep _sleepTimer;
		};
	};

};

true