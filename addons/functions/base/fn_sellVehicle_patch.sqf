if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\base\", "A3A_fnc_", [["sellVehicle", "fn_sellVehicle"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_sellVehicle"] call BIS_fnc_recompile;

