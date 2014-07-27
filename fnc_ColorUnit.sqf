private
[
    "_unit"
];

_unit = _this;
_txt = "";

if(_unit in (units  player)) then {
	_team = assignedTeam _unit;
	switch(_team) do {
		case("MAIN"): {
			_txt = format["<t color='#FFFFFF'>%1</t>", name _unit];
		};
		case("RED"): {
			_txt = format["<t color='#f8abb1'>%1</t>", name _unit];
		};
		case("GREEN"): {
			_txt = format["<t color='#a8ffb9'>%1</t>", name _unit];
		};
		case("BLUE"): {
			_txt = format["<t color='#aeacf5'>%1</t>", name _unit];
		};
		case("YELLOW"): {
			_txt = format["<t color='#fbff97'>%1</t>", name _unit];
		};
	};
}
else {
	_txt = format["<t color='#8C8C8C'>%1</t>", name _unit];
};

_txt