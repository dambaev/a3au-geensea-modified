_supply_distance_meters = 500;
_resupply_tick = 1;
_resupply_tick_to_rearm = 18; // 180 secs, 3 minutes

{
  _vehicle = _x;
  _vehicle_supply_distance = _vehicle getVariable [ "ADDON_autoReloadUnits_supply_distance", []];
  if( count _vehicle_supply_distance > 1) then {
    _supply = _vehicle_supply_distance select 0;
    _supply_crew = driver _supply;
    if ( not alive _supply || isNull _supply_crew ) then {
      _vehicle setVariable ["ADDON_autoReloadUnits_supply_distance", []];
    }else {
      _vehicle setVariable ["ADDON_autoReloadUnits_supply_distance"
                           , [ _supply, _vehicle distanceSqr _supply, side _supply_crew]
                           ];
    };
  };

  {
    _supply_vehicle = _x;
    _supply_vehicle_side = side _supply_vehicle;
    _vehicle_to_current_supply_distance = _vehicle distanceSqr _supply_vehicle;

    _supply_distance = getVariable [ "ADDON_autoReloadUnits_supply_distance", []];
    if( count _supply_distance < 3) then {
      _vehicle setVariable ["ADDON_autoReloadUnits_supply_distance"
                           , [ _supply_vehicle
                             , _vehicle_to_current_supply_distance
                             , _supply_vehicle_side
                             ]
                           ];
    } else {
      _vehicle_supply = _supply_distance select 0;
      _vehicle_supply_distance = _supply_distance select 1;
      _vehicle_supply_side = _supply_distance select 2;

      if ( _vehicle_supply_side == _supply_vehicle_side
         && _vehicle_to_current_supply_distance < _vehicle_supply_distance
         ) then {
        _vehicle setVariable [ "ADDON_autoReloadUnits_supply_distance"
                             , [ _supply_vehicle
                               , _vehicle_to_current_supply_distance
                               , _supply_vehicle_side
                               ]
                             ];
      };
    };
  } forEach ADDON_fnc_autoReloadUnits_ammo_vehicles;

  _is_vehicle_needs_rearm = [ _vehicle] call ADDON_autoReloadUnitsIsReammoNeededVehicle;
  if( not _is_vehicle_needs_rearm) then {
    _vehicle setVariable [ "ADDON_autoReloadUnits_resupply_tick" , 0 ];
  }else {
    _vehicle_resupply_tick = _vehicle getVariable ["ADDON_autoReloadUnits_resupply_tick", 0];
    _supply_distance = getVariable [ "ADDON_autoReloadUnits_supply_distance", []];
    if( count _supply_distance > 2) then {
      _vehicle_supply_distance = _supply_distance select 1;
      _vehicle_supply_distance_coef = 1 -
        _vehicle_supply_distance / _supply_distance_meters;
      _new_vehicle_resupply_tick = _vehicle_resupply_tick
        + _resupply_tick * _vehicle_supply_distance_coef;

      if( _new_vehicle_resupply_tick > _resupply_tick_to_rearm) then {
        _vehicle setVehicleAmmo 1;
        _new_vehicle_resupply_tick = 0;
      };
      _vehicle setVariable
        [ "ADDON_autoReloadUnits_resupply_tick"
        , _new_vehicle_resupply_tick
        ];
    };
  };
} forEach ADDON_fnc_autoReloadUnits_vehicles;

