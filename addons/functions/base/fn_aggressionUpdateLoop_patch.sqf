if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\base\", "A3A_fnc_", [["aggresssionUpdateLoop", "fn_aggresssionUpdateLoop"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_aggresssionUpdateLoop"] call BIS_fnc_recompile;

