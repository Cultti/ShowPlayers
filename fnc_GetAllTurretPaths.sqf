/*******************************************************************************
* Project:          Mushi
* Module:           fnc_GetAllTurretPaths.sqf
* Project version:  [1.0.0] 20.03.2014
* Module version:   [1]     20.03.2014
* Author:           RAB, Prodavec, Marbot, DumbkRat, SPESNAZ
* Function:         fnc_GetAllTurretPaths
* Comments:         --//--
*******************************************************************************/

/*
INPUT:
  vehicle : OBJECT

OUTPUT:
  paths_array : ARRAY

EXAMPLE:
  _allPaths = MyTank call fnc_GetAllTurretPaths;
// _allPaths: [[0], [0,0], [0,1]]
*/

private
[
    "_result",
    "_vehicle",
    "_currentNode",
    "_depth",
    "_currentConfig",
    "_cfgTurrets"
];

_result = [];

if ((!isNil "_this") && {(typeName _this) in ["ARRAY", "OBJECT"]}) then
{
    _vehicle = objNull;
    _currentNode = [];
    _depth = -1;
    _currentConfig = objNull;

    switch (typeName _this) do
    {
        case "ARRAY":
        {
            if ((count _this) == 5) then
            {
                _vehicle = _this select 0;
                _currentConfig = _this select 1;
                _currentNode = _this select 2;
                _depth = _this select 3;
                _result = _this select 4;
            };
        };
        case "OBJECT":
        {
            _vehicle = _this;
            _currentConfig = configFile >> "CfgVehicles" >> (typeOf _vehicle);
            _depth = 0;
        };
    };

    if ((!isNil "_vehicle") && (!isNil "_currentNode") && (!isNil "_depth") && (!isNil "_result") && (!isNil "_currentConfig") && {((typeName _vehicle) == "OBJECT") && ((typeName _currentNode) == "ARRAY") && ((typeName _depth) == "SCALAR") && ((typeName _result) == "ARRAY") && ((typeName _currentConfig) == "CONFIG")} && {!isNull _vehicle}) then
    {
        _cfgTurrets = _currentConfig >> "Turrets";

        if (isClass _cfgTurrets) then
        {
            for "_i" from 0 to ((count _cfgTurrets) - 1) step 1 do
            {
                _currentNode set [_depth, _i];
                _result set [count _result, +_currentNode];
                [_vehicle, _cfgTurrets select _i, _currentNode, _depth + 1, _result] call fnc_GetAllTurretPaths;
            };
        };
    };
};

_result;