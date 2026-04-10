_name = "ADDON_fnc_autoReloadUnitsCleanDeadAmmoVehicles";

{
  if( not alive _x) then {
    ADDON_fnc_autoReloadUnits_medical_vehicles set [ _forEachIndex, objNull];
  };
} forEach ADDON_fnc_autoReloadUnits_medical_vehicles;

ADDON_fnc_autoReloadUnits_medical_vehicles =
  ADDON_fnc_autoReloadUnits_medical_vehicles - [objNull];

