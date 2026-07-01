if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()

Info("patching A3A functions");

["A3A\addons\core\functions\Base\", "A3A_fnc_", [["localizar", "fn_localizar"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_localizar"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Base\", "A3A_fnc_", [["localize_format_taskSetDescription", "fn_localize_format_taskSetDescription"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_localize_format_taskSetDescription"] call BIS_fnc_recompile;

["A3A\addons\core\functions\CREATE\", "A3A_fnc_", [["attackHQ", "fn_attackHQ"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_attackHQ"] call BIS_fnc_recompile;

["A3A\addons\core\functions\CREATE\", "A3A_fnc_", [["invaderPunish", "fn_invaderPunish"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_invaderPunish"] call BIS_fnc_recompile;

["A3A\addons\core\functions\CREATE\", "A3A_fnc_", [["wavedAttack", "fn_wavedAttack"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_wavedAttack"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["AS_Ambush", "fn_AS_Ambush"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_AS_Ambush"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["AS_Official", "fn_AS_Official"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_AS_Official"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["AS_Smasher", "fn_AS_Smasher"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_AS_Smasher"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["AS_Traitor", "fn_AS_Traitor"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_AS_Traitor"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["AS_Zombies", "fn_AS_Zombies"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_AS_Zombies"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["AS_specOP", "fn_AS_specOP"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_AS_specOP"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["CON_MilAdmin", "fn_CON_MilAdmin"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_CON_MilAdmin"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["CON_Outpost", "fn_CON_Outpost"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_CON_Outpost"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["CON_Outpost_Compet", "fn_CON_Outpost_Compet"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_CON_Outpost_Compet"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["CON_Outpost_Zombies", "fn_CON_Outpost_Zombies"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_CON_Outpost_Zombies"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["DES_Antenna", "fn_DES_Antenna"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_DES_Antenna"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["DES_Artillery", "fn_DES_Artillery"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_DES_Artillery"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["DES_Heli", "fn_DES_Heli"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_DES_Heli"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["DES_Vehicle", "fn_DES_Vehicle"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_DES_Vehicle"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["ENC_Trader", "fn_ENC_Trader"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_ENC_Trader"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["LOG_Airdrop", "fn_LOG_Airdrop"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_LOG_Airdrop"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["LOG_Ammo", "fn_LOG_Ammo"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_LOG_Ammo"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["LOG_Bank", "fn_LOG_Bank"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_LOG_Bank"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["LOG_Crashsite", "fn_LOG_Crashsite"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_LOG_Crashsite"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["LOG_Helicrash", "fn_LOG_Helicrash"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_LOG_Helicrash"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["LOG_Salvage", "fn_LOG_Salvage"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_LOG_Salvage"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["REP_Antenna", "fn_REP_Antenna"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_REP_Antenna"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RES_Deserters", "fn_RES_Deserters"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RES_Deserters"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RES_Informer", "fn_RES_Informer"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RES_Informer"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RES_Prisoners", "fn_RES_Prisoners"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RES_Prisoners"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RES_Refugees", "fn_RES_Refugees"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RES_Refugees"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RES_Shipwreck", "fn_RES_Shipwreck"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RES_Shipwreck"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RIV_AS_Traitor", "fn_RIV_AS_Traitor"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RIV_AS_Traitor"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RIV_ATT_Cell", "fn_RIV_ATT_Cell"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RIV_ATT_Cell"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RIV_ATT_Hideout", "fn_RIV_ATT_Hideout"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RIV_ATT_Hideout"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RIV_ATT_Transfer", "fn_RIV_ATT_Transfer"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RIV_ATT_Transfer"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RIV_ENC_Rivals", "fn_RIV_ENC_Rivals"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RIV_ENC_Rivals"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RIV_RES_Prisoners", "fn_RIV_RES_Prisoners"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RIV_RES_Prisoners"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["RIV_SUPP_Salvage", "fn_RIV_SUPP_Salvage"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_RIV_SUPP_Salvage"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["SUPP_Supplies", "fn_SUPP_Supplies"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_SUPP_Supplies"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["convoy", "fn_convoy"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_convoy"] call BIS_fnc_recompile;

["A3A\addons\core\functions\Missions\", "A3A_fnc_", [["underAttack", "fn_underAttack"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_underAttack"] call BIS_fnc_recompile;

["A3A\addons\core\functions\REINF\", "A3A_fnc_", [["buildMinefield", "fn_buildMinefield"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_buildMinefield"] call BIS_fnc_recompile;

["A3A\addons\scrt\Outpost\", "A3A_fnc_", [["outpost_createAa", "fn_outpost_createAa"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_outpost_createAa"] call BIS_fnc_recompile;

["A3A\addons\scrt\Outpost\", "A3A_fnc_", [["outpost_createAt", "fn_outpost_createAt"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_outpost_createAt"] call BIS_fnc_recompile;

["A3A\addons\scrt\Outpost\", "A3A_fnc_", [["outpost_createHmg", "fn_outpost_createHmg"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_outpost_createHmg"] call BIS_fnc_recompile;

["A3A\addons\scrt\Outpost\", "A3A_fnc_", [["outpost_createRoadblock", "fn_outpost_createRoadblock"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_outpost_createRoadblock"] call BIS_fnc_recompile;

["A3A\addons\scrt\Outpost\", "A3A_fnc_", [["outpost_createWatchpost", "fn_outpost_createWatchpost"]], true] call BIS_fnc_loadFunctions;
["A3A_fnc_outpost_createWatchpost"] call BIS_fnc_recompile;

