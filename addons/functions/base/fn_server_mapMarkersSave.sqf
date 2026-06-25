if( !isServer) exitWith {
  [] remoteExec [ "ADDON_fnc_server_mapMarkersSave",2];
};

_check_if_user_is_commander = {
  params [ "_playerID"];
  false;
};

ADDON_fnc_serialize_marker = {
  params [ "_marker"];
  _markerAlpha = markerAlpha _marker;
  _markerBrush = markerBrush _marker;
  _markerColor = markerColor _marker;
  _markerDir = markerDir _marker;
  _markerDrawPriority = markerDrawPriority _marker;
  _markerPolyline = markerPolyline _marker;
  _markerPos = markerPos _marker;
  _markerShadow = markerShadow _marker;
  _markerShape = markerShape _marker;
  _markerSize = markerSize _marker;
  _markerText = markerText _marker;
  _markerType = markerType _marker;
  _markerChannel = markerChannel _marker;
  _markerSide = sideUnknown;
  _markerPlayerUID = "";
  _sideUID = [ _marker] call ADDON_fnc_mapMarkersGetMarkerSide;
  if( _sideUID != []) then {
    _markerSide = _sideUID select 0;
    _markerPlayerUID = _sideUID select 1;
  };
  if( _markerSide == sideUnknown) exitWith { [] };
  _serialized =
    [ 1
    , _marker
    , _markerSide
    , _markerPlayerUID
    , _markerChannel
    , _markerAlpha
    , _markerBrush
    , _markerColor
    , _markerDir
    , _markerDrawPriority
    , _markerPolyline
    , _markerPos
    , _markerShadow
    , _markerShape
    , _markerSize
    , _markerText
    , _markerType
    ];
  _serialized;
};

ADDON_fnc_player_id_to_uuid = {
  params [ "_player_id"];
  _player_info = getUserInfo _player_id;
  _player_info select 10;
};

ADDON_fnc_server_mapMarkersGetSerializedUserDefined = {
  _user_defined_markers = [];
  {
    _marker = _x;
    _is_user_defined = (_x select [0, 15]) == "_USER_DEFINED #";
    if( !_is_user_defined) then { continue;};
    _marker_channel = markerChannel _marker;
    if( _marker_channel != 1) then { continue; };
    _serialized_marker = [ _marker, _player_uuid ] call ADDON_fnc_serialize_marker;
    if( _serialized_marker == []) then { continue; };
    _player_uuid = _serialized_marker select 2;
    _marker_owner_is_commander = [_player_uuid] call ADDON_fnc_isEligibleCommanderByUUID;
    if( !_marker_owner_is_commander) then { continue; };
    _markerText = _serialized_marker select 15;
    if( _markerText select [0, 1] != "+") then {
      _markerText = "+" + _markerText;
      _serialized_marker set [15, _markerText];
    };
    _user_defined_markers pushBack _serialized_marker;
  } forEach( allMapMarkers);
  _user_defined_markers;
};

_user_defined_map_markers = [] call ADDON_fnc_server_mapMarkersGetSerializedUserDefined;

[ "ADDON_server_mapMarkers", _user_defined_map_markers] call A3A_fnc_setStatVariable;

ADDON_server_mapMarkers = _user_defined_map_markers;
