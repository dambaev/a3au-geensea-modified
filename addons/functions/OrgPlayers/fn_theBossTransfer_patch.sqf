if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\OrgPlayers\", "A3A_fnc_", [["theBossTransfer", "fn_theBossTransfer"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_theBossTransfer"] call BIS_fnc_recompile;
