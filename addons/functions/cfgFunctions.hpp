class CfgFunctions
{
    //your own functions should be kept here
    class ADDON
    {
        tag = "ADDON";
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
        };
        class Events
        { //these two functions are used to demonstrate use of events
            file = "addons\functions\Events";
            class addExampleEventListener { postInit = 1; };
            class AIVehInit {};
        };
    };
};
