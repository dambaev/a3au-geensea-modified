if (isNil "KMD_fnc_autoUnstuck") exitWith {};

["addons\functions\KMD\", "KMD_fnc_", [["autoUnstuck", "fn_autoUnstuck"]], true] call BIS_fnc_loadFunctions;

["KMD_fnc_autoUnstuck"] call BIS_fnc_recompile;

