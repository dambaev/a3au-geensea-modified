if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\AI\", "A3A_fnc_", [["surrenderAction", "fn_surrenderAction"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_surrenderAction"] call BIS_fnc_recompile;
