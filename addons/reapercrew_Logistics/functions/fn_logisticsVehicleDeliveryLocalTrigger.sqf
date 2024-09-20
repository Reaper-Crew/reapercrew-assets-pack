params ["_vehicleClassname"];

_vehicleSpawners = entities "reaperCrew_moduleResupplyVehicleSpawnpoint";

_spawnPositionObject=([_vehicleSpawners,[],{player distance _x},"ASCEND"]call BIS_fnc_sortBy) select 0;  
_spawnPosition = getPos _spawnPositionObject;

_deliveryPoint = (getPos player);

[_vehicleClassname, _spawnPosition, _deliveryPoint] remoteExec ["reapercrew_logistics_fnc_logisticsVehicleDeliveryServer", 2];