if hasInterface then 
{
	sleep 5;  //wait for start
	
	if (isNil "ace_sys_interaction_key") then { // If ace interaction key is not avail
		#include "\x\cba\addons\ui_helper\script_dikCodes.hpp"
		["AllVehicles", [DIK_RWIN], -20, ["\x\cultti\addons\cultti_showplayers\fnc_menu.sqf", "main"]] call CBA_ui_fnc_add;
    } else {
        ["AllVehicles", [ace_sys_interaction_key], -20, ["\x\cultti\addons\cultti_showplayers\fnc_menu.sqf", "main"]] call CBA_ui_fnc_add;
    };

}