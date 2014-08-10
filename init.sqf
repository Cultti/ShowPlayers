if hasInterface then
{
	sleep 5;  //wait for start

	_types = ["LandVehicle", "Air", "Ship"]; // Use for only for these types

	if (isNil "ace_sys_interaction_key") then { // If ace interaction key is not avail
		#include "\x\cba\addons\ui_helper\script_dikCodes.hpp"
		[_types, [DIK_RWIN], -20, ["\x\cultti\addons\cultti_showplayers\fnc_menu.sqf", "main"]] call CBA_ui_fnc_add;
    } else {
        [_types, [ace_sys_interaction_key], -20, ["\x\cultti\addons\cultti_showplayers\fnc_menu.sqf", "main"]] call CBA_ui_fnc_add;
    };

}