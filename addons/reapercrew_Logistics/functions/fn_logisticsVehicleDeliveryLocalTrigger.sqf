_position = [0,0,0];

openMap true;
hint "Select delivery position";
onMapSingleClick {
	player setVariable ["logistics_requestedPosition", _pos];
	openMap false;
	onMapSingleClick "";
	["Spawning Vehicle...",
	2,
	{true},
	{
		// Determine spawn
		_vehicleSpawners = entities "reaperCrew_moduleResupplyVehicleSpawnpoint";
		_spawnPositionObject=([_vehicleSpawners,[],{player distance _x},"ASCEND"]call BIS_fnc_sortBy) select 0;
		_spawnPosition = getPos _spawnPositionObject;

		_vehicleClassname = player getVariable ["logistics_requestedVehicle", ""];

		// Get Delivery Point
		_deliveryPoint = player getVariable ["logistics_requestedPosition", ""];

		// Call server-side spawn
		[_vehicleClassname, _spawnPosition, _deliveryPoint] remoteExec ["reapercrew_logistics_fnc_logisticsVehicleDeliveryServer", 2];

		hint "Vehicle requested";
	},{}, []] call CBA_fnc_progressBar;
};