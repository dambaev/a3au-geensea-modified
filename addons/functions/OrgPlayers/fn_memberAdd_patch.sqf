if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\OrgPlayers\", "A3A_fnc_", [["memberAdd", "fn_memberAdd"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_memberAdd"] call BIS_fnc_recompile;
