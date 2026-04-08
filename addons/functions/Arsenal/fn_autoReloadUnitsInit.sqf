ADDON_fnc_autoReloadUnits_ammo_vehicles = [];
ADDON_fnc_autoReloadUnits_vehicles = [];

addMissionEventHandler ["EntityCreated", {
	params ["_entity"];
  [ _entity ] call ADDON_fnc_autoReloadUnits_EntityCreated;
}];

{
  [ _x ] call ADDON_fnc_autoReloadUnits_EntityCreated;
} forEach allVehicles;

