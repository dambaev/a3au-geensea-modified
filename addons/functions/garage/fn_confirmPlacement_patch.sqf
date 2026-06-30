if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\garage\", "HR_GRG_fnc_", [["confirmPlacement", "fn_confirmPlacement"]], true] call BIS_fnc_loadFunctions;

["HR_GRG_fnc_confirmPlacement"] call BIS_fnc_recompile;

