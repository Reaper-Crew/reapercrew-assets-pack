// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

if (_activated) then {

	// Don't run if the array isn't available
	while {isNil "activeAircraftTriggers"} do {
		if (reaperCrew_ReinforcementsCheckbox == true) then {
			diag_log "SCENARIO: Aircraft triggers undefined, sleeping";
		};
		sleep 60;
	};

	// Variables
	_randomTrigger = objNull;

	_AircraftCount = _logic getVariable ["AircraftCount",50];
	_AircraftType = _logic getVariable ["AircraftType",0];
	_AircraftFrequencyMin = _logic getVariable ["AircraftFrequencyMin",180];
	_AircraftFrequencyMax = _logic getVariable ["AircraftFrequencyMax",240];
	_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];

	_sleepTimer = [_AircraftFrequencyMin, _AircraftFrequencyMax] call BIS_fnc_randomInt;
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
	while {_AircraftCount > 0} do {

		if (reaperCrew_pauseAircraftReinforcements == false) then {
			// If spawn point available, spawn an enemy group
			if (count activeAircraftTriggers > 0 ) then {
				// Select a random spawn point
				_randomTrigger = (selectRandom activeAircraftTriggers);
				_triggerPos = getPos _randomTrigger;

				if (count HeadlessClients > 0) then {
					// If a headless client is available, spawn it with RemoteExec
					_selectedClient = selectRandom HeadlessClients;
    				[_logic, _triggerPos, _AircraftType] remoteExecCall ["reapercrew_reinforcements_fnc_spawnHeadlessAircraft", _selectedClient];
					// Output debug information
					if (reaperCrew_ReinforcementsCheckbox == true) then {
						diag_log format ["SCENARIO: Spawning reinforcements on client %1 at grid %2, %3 Aircrafts remain", name(_selectedClient), (mapGridPosition _randomTrigger), _AircraftCount];
					};		
				} else {
					// If no HCs are available, spawn it on the server
					[_logic, _triggerPos, _AircraftType] remoteExecCall ["reapercrew_reinforcements_fnc_spawnHeadlessAircraft", 2];
					if (reaperCrew_ReinforcementsCheckbox == true) then {
						diag_log format ["SCENARIO: Spawning reinforcements at grid %1, %2 Aircrafts remain", (mapGridPosition _randomTrigger), _AircraftCount];
					};
				};
				// Reduce the number of available reinforcements
				_AircraftCount = _AircraftCount - 1;
				sleep _sleepTimer;
			};
		} else {
			diag_log "SCENARIO: Aircraft Spawning is currently paused, sleeping for 1 min";
			sleep 60;
		};
	};

};

true