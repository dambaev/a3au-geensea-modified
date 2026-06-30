_name = "ADDON_fnc_autoReloadUnitsCleanDeadAmmoVehicles";

{
  if( not alive _x) then {
    ADDON_fnc_autoReloadUnits_repair_vehicles set [ _forEachIndex, objNull];
  };
} forEach ADDON_fnc_autoReloadUnits_repair_vehicles;

ADDON_fnc_autoReloadUnits_repair_vehicles =
  ADDON_fnc_autoReloadUnits_repair_vehicles - [objNull];

true;
