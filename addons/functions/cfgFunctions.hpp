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
        };
        class PL_fix
        {
            file = "addons\functions\PL_fix";
            class pl_add_to_hc_execute_patch { postInit = 1; };
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
