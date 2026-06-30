if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\Missions\", "A3A_fnc_", [["RIV_ENC_Rivals", "fn_RIV_ENC_Rivals"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_RIV_ENC_Rivals"] call BIS_fnc_recompile;
