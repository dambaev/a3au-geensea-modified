if (isNil "KMD_fnc_spawnGetOutVehicle") exitWith {};

["addons\functions\KMD\", "KMD_fnc_", [["spawnGetOutVehicle", "fn_spawnGetOutVehicle"]], true] call BIS_fnc_loadFunctions;

["KMD_fnc_spawnGetOutVehicle"] call BIS_fnc_recompile;

