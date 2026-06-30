_repair_distance_meters = 500;
_repair_tick = 1;
_repair_tick_to_repair = 2; // 20 secs

ADDON_fnc_autoReloadUnits_update_vehicle_repair_status = {
  params [ "_vehicle"];

  _new_repair_distance = [];
  _vehicle_crew = driver _vehicle;
  if( isNull _vehicle_crew) then {
    _vehicle_crew = gunner _vehicle;
  };
  if( isNull _vehicle_crew) then {
    _vehicle_crew = commander _vehicle;
  };
  if( isNull _vehicle_crew) exitWith {
    _vehicle setVariable ["ADDON_autoReloadUnits_repair_distance", _new_repair_distance];
  };
  _vehicle_side = side _vehicle_crew;

  _vehicle_repair_distance = _vehicle getVariable
    [ "ADDON_autoReloadUnits_repair_distance", []];
  if( count _vehicle_repair_distance > 2) then {
    _repair = _vehicle_repair_distance select 0;
    _repair_crew = driver _repair;
    _distance = _vehicle distanceSqr _repair;
    if ( alive _repair
       && not isNull _repair_crew
       && side _repair_crew == _vehicle_side
       && _distance <= _repair_distance_meters * _repair_distance_meters
       ) then {
      _new_repair_distance = [ _repair
                             , _distance
                             , side _repair_crew
                             ];
    };
  };
  _vehicle setVariable ["ADDON_autoReloadUnits_repair_distance", _new_repair_distance];
  true;
};

ADDON_fnc_autoReloadUnits_search_vehicle_repair = {
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
    _repair = _x;
    _repair_crew = driver _repair;
    if( isNull _repair_crew) then {
      continue;
    };
    _repair_side = side _repair_crew;
    _vehicle_to_current_repair_distance = _vehicle distanceSqr _repair;

    _repair_distance = _vehicle getVariable
      [ "ADDON_autoReloadUnits_repair_distance", []];
    if( count _repair_distance < 3) then {
      _vehicle setVariable ["ADDON_autoReloadUnits_repair_distance"
                           , [ _repair
                             , _vehicle_to_current_repair_distance
                             , _repair_side
                             ]
                           ];
    } else {
      _vehicle_repair = _repair_distance select 0;
      _vehicle_repair_distance = _repair_distance select 1;

      if ( _vehicle_side == _repair_side
         && _vehicle_to_current_repair_distance < _vehicle_repair_distance
         ) then {
        _vehicle setVariable [ "ADDON_autoReloadUnits_repair_distance"
                             , [ _repair
                               , _vehicle_to_current_repair_distance
                               , _repair_side
                               ]
                             ];
      };
    };
  } forEach ADDON_fnc_autoReloadUnits_repair_vehicles;
  true;
};

ADDON_fnc_autoReloadUnits_update_vehicle_repair_tick = {
  params [ "_vehicle"];
  _is_vehicle_needs_repair = true;
  if( not _is_vehicle_needs_repair) then {
    _vehicle setVariable [ "ADDON_autoReloadUnits_repair_tick" , 0 ];
  }else {
    _vehicle_repair_tick = _vehicle getVariable
      ["ADDON_autoReloadUnits_repair_tick", 0];
    _repair_distance = _vehicle getVariable
      [ "ADDON_autoReloadUnits_repair_distance", []];
    if( count _repair_distance > 2) then {
      _vehicle_repair_distance = _repair_distance select 1;
      _vehicle_repair_distance_coef = 1 -
        _vehicle_repair_distance / (_repair_distance_meters * _repair_distance_meters);
      _new_vehicle_repair_tick = _vehicle_repair_tick
        + _repair_tick * _vehicle_repair_distance_coef;

      if( _new_vehicle_repair_tick < _vehicle_repair_tick) then {
        _new_vehicle_repair_tick = _vehicle_repair_tick;
      };
      if( _new_vehicle_repair_tick > _repair_tick_to_repair) then {
        [ _vehicle, 0] remoteExec [ "setDamage", _vehicle];
        _new_vehicle_repair_tick = 0;
      };
      _vehicle setVariable
        [ "ADDON_autoReloadUnits_repair_tick"
        , _new_vehicle_repair_tick
        ];
    };
  };
  true;
};

{
  _vehicle = _x;

  [ _vehicle] call ADDON_fnc_autoReloadUnits_update_vehicle_repair_status;
  [ _vehicle] call ADDON_fnc_autoReloadUnits_search_vehicle_repair;
  [ _vehicle] call ADDON_fnc_autoReloadUnits_update_vehicle_repair_tick;

} forEach ADDON_fnc_autoReloadUnits_vehicles;

true;
