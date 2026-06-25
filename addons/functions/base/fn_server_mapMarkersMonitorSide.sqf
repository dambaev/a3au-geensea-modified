if( !isServer) exitWith {};

ADDON_server_mapMarkersSideMonitorDelay = 10;
ADDON_server_mapMarkersSide = createHashMap;

ADDON_server_mapMarkersSideMonitorEnabled = true;

[] spawn {
  _iteration = {
    {
      _is_user_defined = (_x select [0, 15]) == "_USER_DEFINED #";
      if( !_is_user_defined) then { continue; };
      _player = objNull;
      _player_uuid = "";
      _player_info = getUserInfo (getPlayerId _marker);
      if ( _player_info != [] ) then {
        _player_uuid = _player_info select 2;
        _player = _player_info select 10;
      };
      if( !(isNull _player)) then {
        _player_side = side _player;
        ADDON_server_mapMarkersSide set [ _x, [ _player_side, _player_uuid ] ];
      };
    } forEach (allMapMarkers);
    {
      if( _x in allMapMarkers) then { continue; };
      ADDON_server_mapMarkersSide deleteAt _x;
    } forEach (ADDON_server_mapMarkersSide);
  };
  while { ADDON_server_mapMarkersSideMonitorEnabled } do {
    call _iteration;
    sleep ADDON_server_mapMarkersSideMonitorDelay;
  };
};
