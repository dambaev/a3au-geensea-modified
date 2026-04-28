if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\logistics\", "A3A_Logistics_fnc_", [["getCargoConfig", "fn_getCargoConfig"]], true] call BIS_fnc_loadFunctions;

["A3A_getCargoConfig_fnc_getCargoConfig"] call BIS_fnc_recompile;

