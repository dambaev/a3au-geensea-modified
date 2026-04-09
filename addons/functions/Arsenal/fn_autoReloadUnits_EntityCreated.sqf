params [ "_entity"];
_name = "ADDON_fnc_autoReloadUnits_EntityCreated";

_is_vehicle = _entity isKindOf "AllVehicles";

if( not _is_vehicle) exitWith {
  1;
};

if( not alive _entity) exitWith {
  2;
};

_is_ammo = [_entity ] call ADDON_fnc_autoReloadUnitsIsAmmoVehicle;

ADDON_fnc_autoReloadUnits_vehicles pushBackUnique _entity;

if( _is_ammo) exitWith {
  ADDON_fnc_autoReloadUnits_ammo_vehicles pushBackUnique _entity;
};

0;
