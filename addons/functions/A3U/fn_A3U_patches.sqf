if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()

Info("patching A3U functions");

["A3A\addons\ultimate\functions\blackmarket\", "A3U_fnc_", [["hasRequirements", "fn_hasRequirements"]], true] call BIS_fnc_loadFunctions;
["A3U_fnc_hasRequirements"] call BIS_fnc_recompile;

