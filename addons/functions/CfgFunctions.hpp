class CfgFunctions
{
    //your own functions should be kept here
    class ADDON
    {
        tag = "ADDON";
        class Missions
        {
          file = "addons\functions\Missions";
          class RIV_ENC_Rivals {};
          class RIV_ENC_Rivals_patch {};
        };
        class Dialogs
        {
            file = "addons\functions\Dialogs";
            class persistentSave {};
            class persistentSaveAddAction {};
        };
        class AI
        {
            file = "addons\functions\AI";
            class enemyGarrison {};
            class enemyGarrison_patch {};
            class surrenderAction {};
            class surrenderAction_patch {};
        };
        class Builder
        {
            file = "addons\functions\Builder";
            class addBuildingActions {};
            class addBuildingActions_patch {};
        };
        class garage
        {
            file = "addons\functions\garage";
            class confirmPlacement {};
            class confirmPlacement_patch {};
        };
        class init
        {
            file = "addons\functions\init";
            class initClient {};
            class initClient_patch {};
        };
        class OrgPlayers
        {
            file = "addons\functions\OrgPlayers";
            class theBossTransfer {};
            class theBossTransfer_patch {};
            class theBossToggleEligibility {};
            class theBossToggleEligibility_patch {};
            class memberAdd {};
            class memberAdd_patch {};
        };
        class CREATE
        {
            file = "addons\functions\CREATE";
            class groupDespawner {};
            class groupDespawner_patch {};
            class createAIAA {};
            class outpost_createAaDistance {};
        };
        class base
        {
            file = "addons\functions\base";
            class sellVehicle {};
            class sellVehicle_patch {};
            class distance {};
            class distance_patch {};
            class createFlag {};
            class isAdministration {};
            class administrationAddAction {};
            class administrationAddUID {};
            class administrationGet {};
            class administrationRemoveUID {};
            class administrationInit {};
            class isEligibleCommander {};
            class isEligibleCommanderByUUID {};
            class eligibleCommanderAddAction {};
            class eligibleCommanderAddUID {};
            class eligibleCommanderGet {};
            class eligibleCommanderRemoveUID {};
            class eligibleCommanderInit {};
            class isParticipantTutor {};
            class participantTutorAddAction {};
            class participantTutorAddUID {};
            class participantTutorGet {};
            class participantTutorRemoveUID {};
            class participantTutorInit {};
            class aggressionUpdateLoop {};
            class aggressionUpdateLoop_patch {};
            class mrkWIN {};
            class mrkWIN_patch {};
            class flagaction {};
            class flagaction_patch {};
            class flagaction_sellVehicleAddAction {};
            class EventHandler_EntityCreatedInit {};
            class EventHandler_EntityCreated {};
            class EventHandler_EntityCreated_Man {};
            class trader_sellVehicle {};
            class trader_sellVehicleAddAction {};
            class trader_sellVehicleAddActionInit {};
            class tierWarMonitorLoop {};
            class tierWarChanged {};
            class server_mapMarkersGetMarkerSide {};
            class server_mapMarkersLoad {};
            class server_mapMarkersMonitor {};
            class server_mapMarkersMonitorSide {};
            class server_mapMarkersSave {};
        };
        class logistics
        {
            file = "addons\functions\logistics";
            class getCargoConfig {};
            class getCargoConfig_patch {};
        };
        class Arsenal
        {
            file = "addons\functions\Arsenal";
            class saveLoadVehicleArsenal { };
            class autoReloadUnits {};
            class autoReloadUnitsInit {};
            class autoReloadUnitsIteration {};
            class autoReloadUnitsIterationVehiclesAmmo {};
            class autoReloadUnitsIterationVehiclesFuel {};
            class autoReloadUnitsIterationVehiclesRepair {};
            class autoReloadUnitsIterationVehiclesMedical {};
            class autoReloadUnitsIsAmmoVehicle {};
            class autoReloadUnitsIsRepairVehicle {};
            class autoReloadUnitsIsRefuelVehicle {};
            class autoReloadUnitsIsMedicalVehicle {};
            class autoReloadUnitsIsReammoNeededVehicle {};
            class autoReloadUnitsCleanDeadVehicles {};
            class autoReloadUnitsCleanDeadAmmoVehicles {};
            class autoReloadUnitsCleanDeadRepairVehicles {};
            class autoReloadUnitsCleanDeadFuelVehicles {};
            class autoReloadUnitsCleanDeadMedicalVehicles {};
            class autoReloadUnits_EntityCreated {};
            class autoReloadUnits_Fired {};
        };
	// not supported on dedicated server?
        //class PL_fix
        //{
        //    file = "addons\functions\PL_fix";
        //    class pl_add_to_hc_execute_patch {  };
        //    class pl_spawn_getOut_vehicle_patch {  };
        //    class pl_moveInConvoy { };
        //    class pl_moveInConvoyInit { };
        //    class pl_moveInConvoyIteration { };
        //    class pl_moveInConvoy_ensureTailIsNotTooClose {};
        //    class pl_moveInConvoy_ensureTailIsNotTooFarAway {};
        //    class pl_moveInConvoy_ensureTailHasNextWaypoint {};
        //    class pl_moveInConvoy_connectTailToLeader {};
        //    class pl_moveInConvoy_setWaypointPos {};
        //    class pl_moveInConvoy_addWaypointPos {};
        //};
        class KMD
        {
            file = "addons\functions\KMD";
            class kmd_addToHcExecute_patch {  };
            class kmd_addToHc_patch {  };
            class kmd_spawnGetOutVehicle_patch {  };
            class kmd_moveInConvoyInit { };
	    class kmd_spawnRemoveFromHC_patch {};
	    class spawnRemoveFromHC {};
            class pl_moveInConvoy { };
            class pl_moveInConvoyIteration { };
            class pl_moveInConvoy_ensureTailIsNotTooClose {};
            class pl_moveInConvoy_ensureTailIsNotTooFarAway {};
            class pl_moveInConvoy_ensureTailHasNextWaypoint {};
            class pl_moveInConvoy_connectTailToLeader {};
            class pl_moveInConvoy_setWaypointPos {};
            class pl_moveInConvoy_addWaypointPos {};
            class autoUnstuck {};
            class kmd_autoUnstuck_patch {};
        };
        class DDT_fix
        {
            file = "addons\functions\DDT_fix";
            class getTargetsAT {};
            class getTargetsAT_patch { };
            class getSoftTargets {};
            class getSoftTargets_patch { };
            class autoEquipDronesGroup { };
            class autoEquipDronesIteration { };
            class autoEquipDrones { };
        };
        class REINF
        {
            file = "addons\functions\REINF";
            class controlHCSquad {};
            class controlHCSquad_player_HandleDamage {};
            class controlHCUnit {};
            class controlHCSquad_patch { };
            class controlunit {};
            class controlunit_patch { };
            class postmortem {};
            class postmortem_patch { };
            class FIAinit {};
            class FIAinit_patch {};
        };
        class Events
        { //these two functions are used to demonstrate use of events
            file = "addons\functions\Events";
            class addExampleEventListener { };
            class AIVehInit {};
        };
    };
};

