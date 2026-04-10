class CfgFunctions
{
    //your own functions should be kept here
    class ADDON
    {
        tag = "ADDON";
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
        class PL_fix
        {
            file = "addons\functions\PL_fix";
            class pl_add_to_hc_execute_patch { postInit = 1; };
            class pl_spawn_getOut_vehicle_patch { postInit = 1; };
            class pl_moveInConvoy { };
            class pl_moveInConvoyInit { };
            class pl_moveInConvoyIteration { };
            class pl_moveInConvoy_ensureTailIsNotTooClose {};
            class pl_moveInConvoy_ensureTailIsNotTooFarAway {};
            class pl_moveInConvoy_ensureTailHasNextWaypoint {};
            class pl_moveInConvoy_connectTailToLeader {};
            class pl_moveInConvoy_setWaypointPos {};
            class pl_moveInConvoy_addWaypointPos {};
        };
        class DDT_fix
        {
            file = "addons\functions\DDT_fix";
            class getTargetsAT {};
            class getTargetsAT_patch { postInit = 1; };
            class getSoftTargets {};
            class getSoftTargets_patch { postInit = 1; };
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
            class controlHCSquad_patch { postInit = 1; };
            class controlunit {};
            class controlunit_patch { postInit = 1; };
        };
        class Events
        { //these two functions are used to demonstrate use of events
            file = "addons\functions\Events";
            class addExampleEventListener { postInit = 1; };
            class AIVehInit {};
        };
    };
};

