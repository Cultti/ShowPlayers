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


/*
_players = "Players inside vehicle:";
_txt = "";
{
	if( _x == player) then {
	}
	else {
		if(_x in (units  player)) then {
			//_txt = format["<t color='#FF0000'>%1</t>", name _x];
			_team = assignedTeam _x;
			switch(_team) do {
				case("MAIN"): {
					_txt = format["<t color='#FFFFFF'>%1</t>", name _x];
				};
				case("RED"): {
					_txt = format["<t color='#f8abb1'>%1</t>", name _x];
				};
				case("GREEN"): {
					_txt = format["<t color='#a8ffb9'>%1</t>", name _x];
				};
				case("BLUE"): {
					_txt = format["<t color='#aeacf5'>%1</t>", name _x];
				};
				case("YELLOW"): {
					_txt = format["<t color='#fbff97'>%1</t>", name _x];
				};
			};
		}
		else {
			_txt = format["<t color='#8C8C8C'>%1</t>", name _x];
		};
		_role = assignedVehicleRole _x select 0;
		if(_role != "CARGO") then {
			_txt = format["%1(%2)", _txt, _role];
		};
		_players = format["%1 <br/> %2", _players, _txt];
	};
} forEach crew _target;
*/

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