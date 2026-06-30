if( !isServer) exitWith {};

ADDON_server_mapMarkersMonitorDelay = 10;
ADDON_server_mapMarkers = [];
ADDON_server_mapMarkersRestoreEnabled = true;

_restore_marker = {
  params [ "_markerArr"];
  _markerArr params
    [ "_version"
    , "_marker"
    , "_markerSide"
    , "_markerPlayerUID"
    , "_markerChannel"
    , "_markerAlpha"
    , "_markerBrush"
    , "_markerColor"
    , "_markerDir"
    , "_markerDrawPriority"
    , "_markerPolyline"
    , "_markerPos"
    , "_markerShadow"
    , "_markerShape"
    , "_markerSize"
    , "_markerText"
    , "_markerType"
    ];
  _marker setMarkerAlpha 1;
  _marker setMarkerBrush _markerBrush;
  _marker setMarkerColor _markerColor;
  _marker setMarkerDir _markerDir;
  _marker setMarkerDrawPriority _markerDrawPriority;
  _marker setMarkerPolyline _markerPolyline;
  _marker setMarkerPos _markerPos;
  _marker setMarkerShadow _markerShadow;
  _marker setMarkerShape _markerShape;
  _marker setMarkerSize _markerSize;
  _marker setMarkerText _markerText;
  _marker setMarkerType _markerType;
};

_get_marker_changed = {
  params [ "_markerArr"];
  _markerArr params
    [ "_version"
    , "_marker"
    , "_markerSide"
    , "_markerPlayerUID"
    , "_markerChannel"
    , "_markerAlpha"
    , "_markerBrush"
    , "_markerColor"
    , "_markerDir"
    , "_markerDrawPriority"
    , "_markerPolyline"
    , "_markerPos"
    , "_markerShadow"
    , "_markerShape"
    , "_markerSize"
    , "_markerText"
    , "_markerType"
    ];
  _cur_markerChannel = markerChannel _marker;
  _cur_markerAlpha = markerAlpha _marker;
  _cur_markerBrush = markerBrush _marker;
  _cur_markerColor = markerColor _marker;
  _cur_markerDir = markerDir _marker;
  _cur_markerDrawPriority = markerDrawPriority _marker;
  _cur_markerPolyline = markerPolyline _marker;
  _cur_markerPos = markerPos _marker;
  _cur_markerShadow = markerShadow _marker;
  _cur_markerShape = markerShape _marker;
  _cur_markerSize = markerSize _marker;
  _cur_markerText = markerText _marker;
  _cur_markerType = markerType _marker;
  if( _cur_markerChannel != _markerChannel) exitWith {true;};
  if( _cur_markerAlpha != _markerAlpha) exitWith {true;};
  if( _cur_markerBrush != _markerBrush) exitWith {true;};
  if( _cur_markerColor != _markerColor) exitWith {true;};
  if( _cur_markerDir != _markerDir) exitWith {true;};
  if( _cur_markerDrawPriority != _markerDrawPriority) exitWith {true;};
  if( _cur_markerPolyline != _markerPolyline) exitWith {true;};
  if( _cur_markerPos != _markerPos) exitWith {true;};
  if( _cur_markerShadow != _markerShadow) exitWith {true;};
  if( _cur_markerShape != _markerShape) exitWith {true;};
  if( _cur_markerSize != _markerSize) exitWith {true;};
  if( _cur_markerText != _markerText) exitWith {true;};
  if( _cur_markerType != _markerType) exitWith {true;};
  false;
};

_find_first_player_by_side = {
  param [ "_side"];
  {
    if( side _x == _side) exitWith {
      _x;
    }
  }forEach(allUnits);
  objNull;
};

ADDON_server_mapMarkersMonitorEnabled = true;
[] spawn {
  _restore_saved_markers = {
    {
      _marker = _x select 1;
      if( !(_marker in allMapMarkers)) then {
        _owner = [ _x select 2] call _find_first_player_by_side ;
        createMarker
          [ _marker
          , _x select 11
          , _x select 4
          , _owner
          ];
        [ _x ] call _restore_marker;
        continue;
      };
      _is_marker_changed = [ _marker ] call _get_marker_changed;
      if( _is_marker_changed) then {
        [ _x ] call _restore_marker;
      };

    } forEach (ADDON_server_mapMarkers);
  };
  _clear_non_user_map_markers = {
    {
      _is_user_defined = _x select [0, 15] == "_USER_DEFINED #";
      if( _is_user_defined) then { continue;};
      _x setMarkerAlpha 0;
    } forEach (allMapMarkers);
  };

  while { ADDON_server_mapMarkersMonitorEnabled } do {
    call _clear_non_user_map_markers;
    if( ADDON_server_mapMarkersRestoreEnabled) then {
      call _restore_saved_markers;
    };
    sleep ADDON_server_mapMarkersMonitorDelay;
  };
};
