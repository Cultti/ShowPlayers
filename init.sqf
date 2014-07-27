sleep 5;  //wait for start

waitUntil {!isNil "ace_sys_interaction_key_self"};  //wait for start
waitUntil {!isNil "ace_sys_interaction_key"};  //wait for start

["AllVehicles", [ace_sys_interaction_key], -20, ["\CULTTI_ShowPlayers\fnc_menu.sqf", "main"]] call CBA_ui_fnc_add;