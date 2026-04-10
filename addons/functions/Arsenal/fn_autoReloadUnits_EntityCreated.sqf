params [ "_entity"];
_name = "ADDON_fnc_autoReloadUnits_EntityCreated";

if( isNull _entity) exitWith {
  3;
};

_is_vehicle = _entity isKindOf "AllVehicles";

if( not _is_vehicle) exitWith {
  1;
};

if( not alive _entity) exitWith {
  2;
};

_is_ammo = [_entity ] call ADDON_fnc_autoReloadUnitsIsAmmoVehicle;
_is_repair = [_entity ] call ADDON_fnc_autoReloadUnitsIsRepairVehicle;
_is_fuel = [_entity ] call ADDON_fnc_autoReloadUnitsIsRefuelVehicle;
_is_medical = [_entity ] call ADDON_fnc_autoReloadUnitsIsMedicalVehicle;

_entity addEventHandler ["Fired", {
  params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
  [_unit, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile, _gunner]
    call ADDON_fnc_autoReloadUnits_Fired;
}];

ADDON_fnc_autoReloadUnits_vehicles pushBackUnique _entity;

if( _is_fuel) exitWith {
  ADDON_fnc_autoReloadUnits_fuel_vehicles pushBackUnique _entity;
};

if( _is_repair) exitWith {
  ADDON_fnc_autoReloadUnits_repair_vehicles pushBackUnique _entity;
};

if( _is_medical) exitWith {
  ADDON_fnc_autoReloadUnits_medical_vehicles pushBackUnique _entity;
};

if( _is_ammo) exitWith {
  ADDON_fnc_autoReloadUnits_ammo_vehicles pushBackUnique _entity;
};

0;
