/*
 * Author: Xeenenta
 * This is a modified version of the BI Cover Map function that can be called directly in a script without referring to a logic unit
 *
 * Arguments:
 * 0: _centerPoint <POSITION>
 * 1: _sizeX <INT>
 * 2: _sizeY <INT>
 * 3: _dir <INT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_centerPoint, _sizeX, _sizeY, _dir] call reapercrew_common_fnc_CoverMap;
 *
 * Public: No
 */

params ["_centerPoint", "_sizeX", "_sizeY", "_dir"];
_pos = _centerPoint;
_posX = _pos select 0;
_posY = _pos select 1;
_sizeOut = 50000;

for "_i" from 0 to 270 step 90 do {
	_size1 = [_sizeX,_sizeY] select (abs cos _i);
	_size2 = [_sizeX,_sizeY] select (abs sin _i);
	_sizeMarker = [_size2,_sizeOut] select (abs sin _i);
	_dirTemp = _dir + _i;
	_markerPos = [
		_posX + (sin _dirTemp * _sizeOut),
		_posY + (cos _dirTemp * _sizeOut)
	];
	[_i,_markerPos,[_sizeMarker,_sizeOut - _size1]] call bis_fnc_log;

	_marker = format ["bis_fnc_moduleCoverMap_%1",_i];
	createMarker [_marker,_markerPos];
	_marker setMarkerPosLocal _markerPos;
	_marker setMarkerSizeLocal [_sizeMarker,_sizeOut - _size1];
	_marker setMarkerDirLocal _dirTemp;
	_marker setMarkerShapeLocal "rectangle";
	_marker setMarkerBrushLocal "solid";
	_marker setMarkerColor "colorBlack";


	_markerPos = [
		_posX + (sin _dirTemp * _size1) + (sin (_dirTemp + 90) * _size2),
		_posY + (cos _dirTemp * _size1) + (cos (_dirTemp + 90) * _size2)
	];
	_marker = format ["bis_fnc_moduleCoverMap_dot_%1",_i];
	createMarker [_marker,_markerPos];
	_marker setMarkerPosLocal _markerPos;
	_marker setMarkerSizeLocal [0.75,0.75];
	_marker setMarkerDirLocal _dir;
	_marker setMarkerTypeLocal "mil_box_noShadow";
	_marker setMarkerColor "colorBlack";
};

//--- Frame
_marker = "bis_fnc_moduleCoverMap_border";
createMarker [_marker,_pos];
_marker setMarkerPosLocal _pos;
_marker setMarkerSizeLocal [_sizeX,_sizeY];
_marker setMarkerDirLocal _dir;
_marker setMarkerShapeLocal "rectangle";
_marker setMarkerBrushLocal "border";
_marker setMarkerColor "colorblack";
