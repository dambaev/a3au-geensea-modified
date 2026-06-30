if (isNil "DDT_fnc_getTargetsAT") exitWith {};//safeguard to block running on none DDT missions

["addons\functions\DDT_fix\", "DDT_fnc_", [["getTargetsAT", "fn_getTargetsAT"]], true] call BIS_fnc_loadFunctions;

["DDT_fnc_getTargetsAT"] call BIS_fnc_recompile;

