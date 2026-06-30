if (isNil "DDT_fnc_getSoftTargets") exitWith {};//safeguard to block running on none DDT missions

["addons\functions\DDT_fix\", "DDT_fnc_", [["getSoftTargets", "fn_getSoftTargets"]], true] call BIS_fnc_loadFunctions;

["DDT_fnc_getSoftTargets"] call BIS_fnc_recompile;

