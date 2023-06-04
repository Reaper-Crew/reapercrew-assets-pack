// Check if the unit has the required item
_itemResult = [player, "DataLinkTablet"] call BIS_fnc_hasItem;

if (_itemResult) then {
	true;
} else {
	false;
};