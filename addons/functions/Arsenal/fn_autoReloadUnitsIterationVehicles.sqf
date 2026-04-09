_supply_distance_meters = 500;
_resupply_tick = 1;
_resupply_tick_to_rearm = 6; // 60 secs, 1 minute

ADDON_fnc_autoReloadUnits_update_vehicle_supply_status = {
  params [ "_vehicle"];

  _new_supply_distance = [];
  _vehicle_crew = driver _vehicle;
  if( isNull _vehicle_crew) then {
    _vehicle_crew = gunner _vehicle;
  };
  if( isNull _vehicle_crew) then {
    _vehicle_crew = commander _vehicle;
  };
  if( isNull _vehicle_crew) exitWith {
    _vehicle setVariable ["ADDON_autoReloadUnits_supply_distance", _new_supply_distance];
  };
  _vehicle_side = side _vehicle_crew;

  _vehicle_supply_distance = _vehicle getVariable
    [ "ADDON_autoReloadUnits_supply_distance", []];
  if( count _vehicle_supply_distance > 2) then {
    _supply = _vehicle_supply_distance select 0;
    _supply_crew = driver _supply;
    _distance = _vehicle distanceSqr _supply;
    if ( alive _supply
       && not isNull _supply_crew
       && side _supply_crew == _vehicle_side
       && _distance <= _supply_distance_meters * _supply_distance_meters
       ) then {
      _new_supply_distance = [ _supply
                             , _distance
                             , side _supply_crew
                             ];
    };
  };
  _vehicle setVariable ["ADDON_autoReloadUnits_supply_distance", _new_supply_distance];
};

ADDON_fnc_autoReloadUnits_search_vehicle_supply = {
  params [ "_vehicle"];
  _vehicle_crew = driver _vehicle;
  if( isNull _vehicle_crew) then {
    _vehicle_crew = gunner _vehicle;
  };
  if( isNull _vehicle_crew) then {
    _vehicle_crew = commander _vehicle;
  };
  if( isNull _vehicle_crew) exitWith {
    false;
  };
  _vehicle_side = side _vehicle_crew;
  {
    _supply = _x;
    _supply_crew = driver _supply;
    if( isNull _supply_crew) then {
      continue;
    };
    _supply_side = side _supply_crew;
    _vehicle_to_current_supply_distance = _vehicle distanceSqr _supply;

    _supply_distance = _vehicle getVariable
      [ "ADDON_autoReloadUnits_supply_distance", []];
    if( count _supply_distance < 3) then {
      _vehicle setVariable ["ADDON_autoReloadUnits_supply_distance"
                           , [ _supply
                             , _vehicle_to_current_supply_distance
                             , _supply_side
                             ]
                           ];
    } else {
      _vehicle_supply = _supply_distance select 0;
      _vehicle_supply_distance = _supply_distance select 1;

      if ( _vehicle_side == _supply_side
         && _vehicle_to_current_supply_distance < _vehicle_supply_distance
         ) then {
        _vehicle setVariable [ "ADDON_autoReloadUnits_supply_distance"
                             , [ _supply
                               , _vehicle_to_current_supply_distance
                               , _supply_side
                               ]
                             ];
      };
    };
  } forEach ADDON_fnc_autoReloadUnits_ammo_vehicles;
  true;
};

ADDON_fnc_autoReloadUnits_update_vehicle_supply_tick = {
  params [ "_vehicle"];
  _is_vehicle_needs_rearm =
    [ _vehicle] call ADDON_fnc_autoReloadUnitsIsReammoNeededVehicle;
  if( not _is_vehicle_needs_rearm) then {
    _vehicle setVariable [ "ADDON_autoReloadUnits_resupply_tick" , 0 ];
  }else {
    _vehicle_resupply_tick = _vehicle getVariable
      ["ADDON_autoReloadUnits_resupply_tick", 0];
    _supply_distance = _vehicle getVariable
      [ "ADDON_autoReloadUnits_supply_distance", []];
    if( count _supply_distance > 2) then {
      _vehicle_supply_distance = _supply_distance select 1;
      _vehicle_supply_distance_coef = 1 -
        _vehicle_supply_distance / (_supply_distance_meters * _supply_distance_meters);
      _new_vehicle_resupply_tick = _vehicle_resupply_tick
        + _resupply_tick * _vehicle_supply_distance_coef;

      if( _new_vehicle_resupply_tick < _vehicle_resupply_tick) then {
        _new_vehicle_resupply_tick = _vehicle_resupply_tick;
      };
      if( _new_vehicle_resupply_tick > _resupply_tick_to_rearm) then {
        _vehicle setVehicleAmmo 1;
        _vehicle setVariable [ "ADDON_fnc_autoReloadUnits_needs_reammo", false];
        _new_vehicle_resupply_tick = 0;
      };
      _vehicle setVariable
        [ "ADDON_autoReloadUnits_resupply_tick"
        , _new_vehicle_resupply_tick
        ];
    };
  };
};

{
  _vehicle = _x;
  _vehicle_crew = driver _vehicle;
  if( isNull _vehicle_crew) then {
    _vehicle_crew = gunner _vehicle;
  };
  if( isNull _vehicle_crew) then {
    _vehicle_crew = commander _vehicle;
  };
  if( isNull _vehicle_crew) then {
    continue;
  };

  [ _vehicle] call ADDON_fnc_autoReloadUnits_update_vehicle_supply_status;
  [ _vehicle] call ADDON_fnc_autoReloadUnits_search_vehicle_supply;
  [ _vehicle] call ADDON_fnc_autoReloadUnits_update_vehicle_supply_tick;

} forEach ADDON_fnc_autoReloadUnits_vehicles;

