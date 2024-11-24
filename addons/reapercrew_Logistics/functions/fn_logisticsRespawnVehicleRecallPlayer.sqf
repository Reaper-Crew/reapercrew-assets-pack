_position = [0,0,0];

openMap true;
hint "Select delivery position";
onMapSingleClick {
	player setVariable ["logistics_requestedPosition", _pos];
	openMap false;
	onMapSingleClick "";
	["Calling Vehicle...",
	2,
	{true},
	{

		// Get Delivery Point
		_deliveryPoint = player getVariable ["logistics_requestedPosition", ""];

		// Call server-side spawn
		[_deliveryPoint] remoteExec ["reapercrew_logistics_fnc_logisticsRespawnVehicleRecallServer", 2];

		hint "Move requested";
	},{}, []] call CBA_fnc_progressBar;
};