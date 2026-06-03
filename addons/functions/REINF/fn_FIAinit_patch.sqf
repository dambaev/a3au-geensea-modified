if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\REINF\", "A3A_fnc_", [["FIAinit", "fn_FIAinit"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_FIAinit"] call BIS_fnc_recompile;
