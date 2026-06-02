if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\init\", "A3A_fnc_", [["initClient", "fn_initClient"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_initClient"] call BIS_fnc_recompile;
