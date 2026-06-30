if( isServer || !hasInterface) exitWith {};

_hide_unused_markers = {
  _markers_cnt = 0;
  {
    _side = sidesX getVariable [_x, sideUnknown];
    //if( _side == sideUnknown) then {continue};
    if( _side == independent) then {
      if( _x in markersX) then {
      switch(true) do {
        case ( _x in watchpostsFIA);
        case (_x in roadblocksFIA);
        case (_x in aapostsFIA);
        case (_x in hmgpostsFIA): {
          _x setMarkerAlpha 1;
        };
        default {
          _x setMarkerAlpha 0;
        };
      };
      };
    } else {
      if( _side != sideUnknown) then {
        _x setMarkerAlpha 0;
      };
    };
    _markers_cnt = _markers_cnt + 1;
  } forEach( allMapMarkers);
  _markers_cnt;
};

[] spawn {
  while { true} do {
    _is_commander = false;
    waitUntil {
      sleep 1;
      _is_commander = [ player ] call ADDON_fnc_isEligibleCommander;
      !isNil {_is_commander}
    };
    if( leader group player == player && _is_commander) then {
      (hcLeader (group player)) hcRemoveGroup (group player);
      player hcSetGroup [group player];
    };
    call _hide_unused_markers;
    sleep 5;
  };
};

