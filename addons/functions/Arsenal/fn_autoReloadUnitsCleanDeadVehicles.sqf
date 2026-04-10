_name = "ADDON_fnc_autoReloadUnitsCleanDeadVehicles";

{
  if( not alive _x) then {
    ADDON_fnc_autoReloadUnits_vehicles set [ _forEachIndex, objNull];
  };
} forEach ADDON_fnc_autoReloadUnits_vehicles;

ADDON_fnc_autoReloadUnits_vehicles =
  ADDON_fnc_autoReloadUnits_vehicles - [objNull];

true;
