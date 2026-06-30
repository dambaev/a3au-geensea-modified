if (isNil "KMD_fnc_addToHcExecute") exitWith {};

["addons\functions\KMD\", "KMD_fnc_", [["addToHcExecute", "fn_addToHcExecute"]], true] call BIS_fnc_loadFunctions;

["KMD_fnc_addToHcExecute"] call BIS_fnc_recompile;

