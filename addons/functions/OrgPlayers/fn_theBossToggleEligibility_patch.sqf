if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\OrgPlayers\", "A3A_fnc_", [["theBossToggleEligibility", "fn_theBossToggleEligibility"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_theBossToggleEligibility"] call BIS_fnc_recompile;
