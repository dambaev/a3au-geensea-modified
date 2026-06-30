if( !isServer) exitWith {};

_hide_unused_markers = {
  _markers_cnt = 0;
  {
    _is_user_defined = _x select [0, 15] == "_USER_DEFINED #";
    if( !_is_user_defined) then {
       _x setMarkerAlpha 0;
    };
    _markers_cnt = _markers_cnt + 1;
  } forEach( allMapMarkers);
  _markers_cnt;
};

[] spawn {
  while { true} do {
    waitUntil {
      sleep 1;
      !isNil {call _hide_unused_markers}
    };
    call ADDON_fnc_restoreUserDefinedMapMarkers;
    sleep 5;
  };
};

