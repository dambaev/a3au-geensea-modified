call ADDON_fnc_kmd_autoUnstuck_patch;
call ADDON_fnc_distance_patch;

call ADDON_fnc_FIAinit_patch;


call ADDON_fnc_initClient_patch;

call ADDON_fnc_aggressionUpdateLoop_patch;
call ADDON_fnc_EventHandler_EntityCreatedInit;

call ADDON_fnc_addBuildingActions_patch;

A3A_occupantPermanentSAMTierWar = 6;
publicVariable "A3A_occupantPermanentSAMTierWar";
A3A_invaderPermanentSAMTierWar = 7;
publicVariable "A3A_invaderPermanentSAMTierWar";
A3A_invaderAttackTierWar = 8;
publicVariable "A3A_invaderAttackTierWar";

call A3A_fnc_initServer;

// C-130J is unlockable by any AA. So don't use it
waitUntil { sleep 1; !(isNil {A3A_faction_occ})};
waitUntil { sleep 1; !(isNil {A3A_faction_inv})};
if( A3A_faction_occ get "name" == "CDF") then {
  A3A_faction_occ set ["vehiclesPlanesTransport", [ "rhsgref_cdf_reg_Mi8amt"], false];
  publicVariable "A3A_faction_occ";
};
if( A3A_faction_inv get "name" == "US Army") then {
  A3A_faction_inv set ["vehiclesPlanesTransport", ["RHS_CH_47F_10"], false];
  publicVariable "A3A_faction_inv";
};


call ADDON_fnc_getSoftTargets_patch;
call ADDON_fnc_getTargetsAT_patch;
call ADDON_fnc_autoEquipDrones;
call ADDON_fnc_autoReloadUnits;

call ADDON_fnc_kmd_moveInConvoyInit;
call ADDON_fnc_kmd_addToHcExecute_patch;
call ADDON_fnc_kmd_addToHc_patch;
call ADDON_fnc_kmd_spawnGetOutVehicle_patch;

call ADDON_fnc_getCargoConfig_patch;

call ADDON_fnc_sellVehicle_patch;

call ADDON_fnc_postmortem_patch;
call ADDON_fnc_enemyGarrison_patch;
call ADDON_fnc_groupDespawner_patch;
call ADDON_fnc_surrenderAction_patch;

call ADDON_fnc_eligibleCommanderInit;
call ADDON_fnc_participantTutorInit;
call ADDON_fnc_administrationInit;


call ADDON_fnc_theBossTransfer_patch;
call ADDON_fnc_theBossToggleEligibility_patch;
call ADDON_fnc_mrkWIN_patch;
