_name = "ADDON_fnc_autoReloadUnitsCleanDeadAmmoVehicles";

{
  if( not alive _x) then {
    ADDON_fnc_autoReloadUnits_ammo_vehicles set [ _forEachIndex, objNull];
  };
} forEach ADDON_fnc_autoReloadUnits_ammo_vehicles;

ADDON_fnc_autoReloadUnits_ammo_vehicles =
  ADDON_fnc_autoReloadUnits_ammo_vehicles - [objNull];

true;
