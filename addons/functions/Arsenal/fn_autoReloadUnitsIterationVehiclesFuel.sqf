_fuel_distance_meters = 500;
_refuel_tick = 1;
_refuel_tick_to_refuel = 2; // 20 secs

ADDON_fnc_autoReloadUnits_update_vehicle_fuel_status = {
  params [ "_vehicle"];

  _new_fuel_distance = [];
  _vehicle_crew = driver _vehicle;
  if( isNull _vehicle_crew) then {
    _vehicle_crew = gunner _vehicle;
  };
  if( isNull _vehicle_crew) then {
    _vehicle_crew = commander _vehicle;
  };
  if( isNull _vehicle_crew) exitWith {
    _vehicle setVariable ["ADDON_autoReloadUnits_fuel_distance", _new_fuel_distance];
  };
  _vehicle_side = side _vehicle_crew;

  _vehicle_fuel_distance = _vehicle getVariable
    [ "ADDON_autoReloadUnits_fuel_distance", []];
  if( count _vehicle_fuel_distance > 2) then {
    _fuel = _vehicle_fuel_distance select 0;
    _fuel_crew = driver _fuel;
    _distance = _vehicle distanceSqr _fuel;
    if ( alive _fuel
       && not isNull _fuel_crew
       && side _fuel_crew == _vehicle_side
       && _distance <= _fuel_distance_meters * _fuel_distance_meters
       ) then {
      _new_fuel_distance = [ _fuel
                             , _distance
                             , side _fuel_crew
                             ];
    };
  };
  _vehicle setVariable ["ADDON_autoReloadUnits_fuel_distance", _new_fuel_distance];
};

ADDON_fnc_autoReloadUnits_search_vehicle_fuel = {
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
    _fuel = _x;
    _fuel_crew = driver _fuel;
    if( isNull _fuel_crew) then {
      continue;
    };
    _fuel_side = side _fuel_crew;
    _vehicle_to_current_fuel_distance = _vehicle distanceSqr _fuel;

    _fuel_distance = _vehicle getVariable
      [ "ADDON_autoReloadUnits_fuel_distance", []];
    if( count _fuel_distance < 3) then {
      _vehicle setVariable ["ADDON_autoReloadUnits_fuel_distance"
                           , [ _fuel
                             , _vehicle_to_current_fuel_distance
                             , _fuel_side
                             ]
                           ];
    } else {
      _vehicle_fuel = _fuel_distance select 0;
      _vehicle_fuel_distance = _fuel_distance select 1;

      if ( _vehicle_side == _fuel_side
         && _vehicle_to_current_fuel_distance < _vehicle_fuel_distance
         ) then {
        _vehicle setVariable [ "ADDON_autoReloadUnits_fuel_distance"
                             , [ _fuel
                               , _vehicle_to_current_fuel_distance
                               , _fuel_side
                               ]
                             ];
      };
    };
  } forEach ADDON_fnc_autoReloadUnits_fuel_vehicles;
  true;
};

ADDON_fnc_autoReloadUnits_update_vehicle_fuel_tick = {
  params [ "_vehicle"];
  _is_vehicle_needs_refuel =
    fuel _vehicle < 1;
  if( not _is_vehicle_needs_refuel) then {
    _vehicle setVariable [ "ADDON_autoReloadUnits_refuel_tick" , 0 ];
  }else {
    _vehicle_refuel_tick = _vehicle getVariable
      ["ADDON_autoReloadUnits_refuel_tick", 0];
    _fuel_distance = _vehicle getVariable
      [ "ADDON_autoReloadUnits_fuel_distance", []];
    if( count _fuel_distance > 2) then {
      _vehicle_fuel_distance = _fuel_distance select 1;
      _vehicle_fuel_distance_coef = 1 -
        _vehicle_fuel_distance / (_fuel_distance_meters * _fuel_distance_meters);
      _new_vehicle_refuel_tick = _vehicle_refuel_tick
        + _refuel_tick * _vehicle_fuel_distance_coef;

      if( _new_vehicle_refuel_tick < _vehicle_refuel_tick) then {
        _new_vehicle_refuel_tick = _vehicle_refuel_tick;
      };
      if( _new_vehicle_refuel_tick > _refuel_tick_to_refuel) then {
        [ _vehicle, 1] remoteExec [ "setFuel", _vehicle];
        _new_vehicle_refuel_tick = 0;
      };
      _vehicle setVariable
        [ "ADDON_autoReloadUnits_refuel_tick"
        , _new_vehicle_refuel_tick
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

  [ _vehicle] call ADDON_fnc_autoReloadUnits_update_vehicle_fuel_status;
  [ _vehicle] call ADDON_fnc_autoReloadUnits_search_vehicle_fuel;
  [ _vehicle] call ADDON_fnc_autoReloadUnits_update_vehicle_fuel_tick;

} forEach ADDON_fnc_autoReloadUnits_vehicles;

