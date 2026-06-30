_medical_distance_meters = 500;
_medical_tick = 1;
_medical_tick_to_medical = 2; // 20 secs

ADDON_fnc_autoReloadUnits_update_vehicle_medical_status = {
  params [ "_group"];

  _new_medical_distance = [];
  _group_alive = (units _group) select { alive _x; };
  if( count _group_alive < 1) exitWith {
    false;
  };
  _group_crew = _group_alive select 0;
  _group_side = side _group_crew;

  _group_medical_distance = _group getVariable
    [ "ADDON_autoReloadUnits_medical_distance", []];
  if( count _group_medical_distance > 2) then {
    _medical = _group_medical_distance select 0;
    if( not isNull _medical) then {
      _medical_crew = driver _medical;
      _distance = _group_crew distanceSqr _medical;
      if ( alive _medical
         && not isNull _medical_crew
         && side _medical_crew == _group_side
         && _distance <= _medical_distance_meters * _medical_distance_meters
         ) then {
        _new_medical_distance = [ _medical
                               , _distance
                               , side _medical_crew
                               ];
      };
    };
  };
  _group setVariable ["ADDON_autoReloadUnits_medical_distance", _new_medical_distance];
  true;
};

ADDON_fnc_autoReloadUnits_search_vehicle_medical = {
  params [ "_group"];
  _group_alive = (units _group) select { alive _x; };
  if( count _group_alive < 1) exitWith {
    false;
  };
  _group_crew = _group_alive select 0;
  _group_side = side _group_crew;
  {
    _medical = _x;
    _medical_crew = driver _medical;
    if( isNull _medical_crew) then {
      continue;
    };
    _medical_side = side _medical_crew;
    _group_to_current_medical_distance = _group_crew distanceSqr _medical;

    _medical_distance = _group getVariable
      [ "ADDON_autoReloadUnits_medical_distance", []];
    if( count _medical_distance < 3) then {
      _group setVariable ["ADDON_autoReloadUnits_medical_distance"
                           , [ _medical
                             , _group_to_current_medical_distance
                             , _medical_side
                             ]
                           ];
    } else {
      _group_medical = _medical_distance select 0;
      _group_medical_distance = _medical_distance select 1;

      if ( _group_side == _medical_side
         && _group_to_current_medical_distance < _group_medical_distance
         ) then {
        _group setVariable [ "ADDON_autoReloadUnits_medical_distance"
                             , [ _medical
                               , _group_to_current_medical_distance
                               , _medical_side
                               ]
                             ];
      };
    };
  } forEach ADDON_fnc_autoReloadUnits_medical_vehicles;
  true;
};

ADDON_fnc_autoReloadUnits_update_vehicle_medical_tick = {
  params [ "_group"];
  _is_group_needs_medical = true;
  if( not _is_group_needs_medical) then {
    _group setVariable [ "ADDON_autoReloadUnits_medical_tick" , 0 ];
  }else {
    _group_medical_tick = _group getVariable
      ["ADDON_autoReloadUnits_medical_tick", 0];
    _medical_distance = _group getVariable
      [ "ADDON_autoReloadUnits_medical_distance", []];
    if( count _medical_distance > 2) then {
      _medical = _medical_distance select 0;
      _medical_crew = driver _medical;
      _group_medical_distance = _medical_distance select 1;
      _group_medical_distance_coef = 1 -
        _group_medical_distance / (_medical_distance_meters * _medical_distance_meters);
      _new_group_medical_tick = _group_medical_tick
        + _medical_tick * _group_medical_distance_coef;

      if( _new_group_medical_tick < _group_medical_tick) then {
        _new_group_medical_tick = _group_medical_tick;
      };
      if( _new_group_medical_tick > _medical_tick_to_medical) then {
        {
          [ _x, 0] remoteExec [ "setDamage", _x];
          if( not (isNil "ace_medical_treatment_fnc_fullHeal")) then {
            [ leader _medical_crew, _x] remoteExec
              [ "ace_medical_treatment_fnc_fullHeal", _x];
          };
        }forEach (units _group);
        _new_group_medical_tick = 0;
      };
      _group setVariable
        [ "ADDON_autoReloadUnits_medical_tick"
        , _new_group_medical_tick
        ];
    };
  };
  true;
};

{
  _group = _x;

  [ _group] call ADDON_fnc_autoReloadUnits_update_vehicle_medical_status;
  [ _group] call ADDON_fnc_autoReloadUnits_search_vehicle_medical;
  [ _group] call ADDON_fnc_autoReloadUnits_update_vehicle_medical_tick;

} forEach allGroups;

true;
