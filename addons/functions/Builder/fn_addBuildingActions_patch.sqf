if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\Builder\", "A3A_fnc_", [["addBuildingActions", "fn_addBuildingActions"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_addBuildingActions"] call BIS_fnc_recompile;

