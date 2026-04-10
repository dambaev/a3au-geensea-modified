_name = "ADDON_fnc_autoReloadUnitsCleanDeadAmmoVehicles";

{
  if( isNull _x || not alive _x) then {
    ADDON_fnc_autoReloadUnits_medical_vehicles set [ _forEachIndex, objNull];
  };
} forEach ADDON_fnc_autoReloadUnits_medical_vehicles;

ADDON_fnc_autoReloadUnits_medical_vehicles =
  ADDON_fnc_autoReloadUnits_medical_vehicles - [objNull];

true;
