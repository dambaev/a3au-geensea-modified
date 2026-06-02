if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\base\", "A3A_fnc_", [["mrkWIN", "fn_mrkWIN"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_mrkWIN"] call BIS_fnc_recompile;

