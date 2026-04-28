#include "\x\A3A\addons\logistics\script_component.hpp"
params [["_class","",["",objNull]]];
if (_class isEqualType objNull) then {_class = typeOf _class};

#define cgVehicle (configFile/"CfgVehicles"/_class)
#define VehicleNodes (configFile/"CfgVehicles"/_class/QGVAR(Cargo))
#define CfgNodes (configFile/"A3A"/QGVAR(Cargo))
#define MissionNodes (missionConfigFile/"A3A"/QGVAR(Cargo))

if( not (isNil "A3A_Logistics_fnc_getCargoConfigDebug")) then {
  systemChat( "A3A_Logistics_fnc_getCargoConfigDebug: _class " + str _class);
};

if !(isClass cgVehicle) exitWith { configNull };
if (isClass (MissionNodes/_class)) exitWith { (MissionNodes/_class) };
if (isClass VehicleNodes) exitWith { VehicleNodes };
if (isClass (CfgNodes/_class)) exitWith { (CfgNodes/_class) };

private _model = modelOfClass(_class);
if( not (isNil "A3A_Logistics_fnc_getCargoConfigDebug")) then {
  systemChat( "A3A_Logistics_fnc_getCargoConfigDebug: model " + str _model);
};

if (isClass (MissionNodes/_model)) exitWith { (MissionNodes/_model) };
if (isClass (CfgNodes/_model)) exitWith { (CfgNodes/_model) };
configNull;
