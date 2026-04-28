_this spawn A3A_fnc_initClient;
call ADDON_fnc_getSoftTargets_patch;
call ADDON_fnc_getTargetsAT_patch;

if( not hasInterface) exitWith {
}

call ADDON_fnc_controlunit_patch;
call ADDON_fnc_controlHCSquad_patch;

call ADDON_fnc_kmd_addToHcExecute_patch;
call ADDON_fnc_kmd_addToHc_patch;
call ADDON_fnc_kmd_spawnRemoveFromHC_patch;
call ADDON_fnc_kmd_spawnGetOutVehicle_patch;

call ADDON_fnc_saveLoadVehicleArsenal;

call ADDON_fnc_getCargoConfig_patch;
call ADDON_fnc_sellVehicle_patch;
