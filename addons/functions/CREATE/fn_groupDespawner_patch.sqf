if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\CREATE\", "A3A_fnc_", [["groupDespawner", "fn_groupDespawner"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_groupDespawner"] call BIS_fnc_recompile;
