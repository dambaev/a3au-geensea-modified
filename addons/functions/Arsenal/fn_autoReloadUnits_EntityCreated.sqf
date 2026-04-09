params [ "_entity"];
_name = "ADDON_fnc_autoReloadUnits_EntityCreated";

_is_vehicle = _entity isKindOf "AllVehicles";

if( not _is_vehicle) exitWith {
  systemChat ( _name + ": not a vehicle");
  false;
};

if( not alive _entity) exitWith {
  systemChat( _name + ": not alive");
  false;
};

_is_ammo = [_entity ] call ADDON_fnc_autoReloadUnitsIsAmmoVehicle;

if( not _is_ammo) exitWith {
  systemChat( _name + ": not an ammo vehicle");
  false;
};

ADDON_fnc_autoReloadUnits_ammo_vehicles pushBackUnique _entity;
true;
