
if( not isServer && not isDedicated) exitWith {
};

ADDON_fnc_autoReloadUnits_ammo_vehicles = [];
ADDON_fnc_autoReloadUnits_fuel_vehicles = [];
ADDON_fnc_autoReloadUnits_repair_vehicles = [];
ADDON_fnc_autoReloadUnits_medical_vehicles = [];
ADDON_fnc_autoReloadUnits_vehicles = [];

addMissionEventHandler ["EntityCreated", {
	params ["_entity"];
  [ _entity ] call ADDON_fnc_autoReloadUnits_EntityCreated;
}];

{
  [ _x ] call ADDON_fnc_autoReloadUnits_EntityCreated;
} forEach vehicles;

