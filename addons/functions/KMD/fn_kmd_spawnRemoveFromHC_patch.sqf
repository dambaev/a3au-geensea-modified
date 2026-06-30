if (isNil "KMD_fnc_spawnRemoveFromHC") exitWith {};

["addons\functions\KMD\", "KMD_fnc_", [["spawnRemoveFromHC", "fn_spawnRemoveFromHC"]], true] call BIS_fnc_loadFunctions;

["KMD_fnc_spawnRemoveFromHC"] call BIS_fnc_recompile;

