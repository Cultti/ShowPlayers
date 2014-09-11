private
[
	"_temp",
	"_target",
	"_cargo",
	"_driver",
	"_commander",
	"_turretPaths",
	"_turret",
	"_txt",
	"_fnc_GetAllTurretPaths",
	"_fnc_ColorUnit"
];

_target = _this select 0;

if( isNull _target or vehicle player != player ) then {
	_target = vehicle player;
};

_fnc_GetAllTurretPaths = compile preprocessFile "\x\cultti\addons\cultti_showplayers\fnc_GetAllTurretPaths.sqf";
_fnc_ColorUnit = compile preprocessFile "\x\cultti\addons\cultti_showplayers\fnc_ColorUnit.sqf";
_temp = "";
_max = getNumber(configFile >> "CfgVehicles" >> TypeOf _target  >> "transportSoldier");

if(getNumber(configFile >> "CfgVehicles" >> TypeOf _target  >> "hasCommander") == 1) then {
	_max = _max + 1;
};
if(getNumber(configFile >> "CfgVehicles" >> TypeOf _target  >> "hasDriver") == 1) then {
	_max = _max + 1;
};

_txt = "Players:";

_cargo = crew _target;
_driver = driver _target;
_commander = commander _target;
_turretPaths = _target call _fnc_GetAllTurretPaths;

_max = _max + count _turretPaths;

_turret = [];
{
	_temp = _target turretUnit _x;
	if( !isNull _temp ) then {
		_turret = _turret + [_temp];
	};
} forEach _turretPaths;
_turret = _turret - [_commander];

_cargo = _cargo - [_driver, _commander] - _turret;

_current = 0;

if( !isNull _driver ) then {
	_current = _current + 1;
};
if( !isNull _commander ) then {
	_current = _current + 1;
};

_current = _current + count _turret + count _cargo;

_txt = format["%1 %2/%3", _txt, _current, _max];

if( !isNull _driver ) then {
	_txt = format["%1<br/>%2(Driver)", _txt, _driver call _fnc_ColorUnit];
};

if( !isNull _commander ) then {
	_txt = format["%1<br/>%2(Commander)", _txt,  _commander call _fnc_ColorUnit];
};
if ( !(count _turret == 0)) then {
	{
		_txt = format["%1<br/>%2(Turret)", _txt,  _x call _fnc_ColorUnit];
	} forEach _turret;
};
if( !(count _cargo == 0)) then {
	{
		_txt = format["%1<br/>%2", _txt,  _x call _fnc_ColorUnit];
	} forEach _cargo;
};

hintSilent parseText format["%1", _txt];