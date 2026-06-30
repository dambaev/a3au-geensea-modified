if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

["addons\functions\REINF\", "A3A_fnc_", [["controlHCSquad", "fn_controlHCSquad"]], true] call BIS_fnc_loadFunctions;

["A3A_fnc_controlHCSquad"] call BIS_fnc_recompile;
