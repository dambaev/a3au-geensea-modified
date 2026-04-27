if (isNil "KMD_fnc_addToHc") exitWith {};

["addons\functions\KMD\", "KMD_fnc_", [["addToHc", "fn_addToHc"]], true] call BIS_fnc_loadFunctions;

["KMD_fnc_addToHc"] call BIS_fnc_recompile;

