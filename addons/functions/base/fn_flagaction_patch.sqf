if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\base\", "A3A_fnc_", [["flagaction", "fn_flagaction"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_flagaction"] call BIS_fnc_recompile;
