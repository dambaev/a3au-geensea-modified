if( !isServer) exitWith {};

params [ "_marker"];

_MAX_WAIT_CNT=10;
_WAIT_CNT=0;

if( isNil {ADDON_server_mapMarkersSide}) then {
  waitUntil {
    sleep 1;
    _WAIT_CNT = _WAIT_CNT + 1;
    (!isNil { ADDON_server_mapMarkersSide}) || (_MAX_WAIT_CNT <= _WAIT_CNT)
  };
  if( isNil { ADDON_server_mapMarkersSide}) exitWith {[]};
};

ADDON_server_mapMarkersSide getOrDefault [ _marker, []];
