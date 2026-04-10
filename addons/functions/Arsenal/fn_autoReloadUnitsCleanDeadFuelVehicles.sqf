_name = "ADDON_fnc_autoReloadUnitsCleanDeadAmmoVehicles";

{
  if( not alive _x) then {
    ADDON_fnc_autoReloadUnits_fuel_vehicles set [ _forEachIndex, objNull];
  };
} forEach ADDON_fnc_autoReloadUnits_fuel_vehicles;

ADDON_fnc_autoReloadUnits_fuel_vehicles =
  ADDON_fnc_autoReloadUnits_fuel_vehicles - [objNull];

