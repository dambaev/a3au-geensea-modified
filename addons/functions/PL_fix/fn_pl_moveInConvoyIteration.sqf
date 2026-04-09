ADDON_fnc_pl_moveInConvoyIterationPerLeader = {
  params [ "_leader"];
  if( isNull _leader) exitWith { false; };
  _tail = _leader getVariable ["ADDON_fnc_pl_moveInConvoy_tail", objNull];
  if (isNull _tail) exitWith { false; };
  _tail_leader = _tail getVariable ["ADDON_fnc_pl_moveInConvoy_leader", objNull];
  if( _tail_leader != _leader) exitWith { false; };
  if( not isNull hcLeader _tail && (hcLeader _tail) != (leader _leader)) then {
    (hcLeader _tail) hcRemoveGroup _tail;
    (leader _leader) hcSetGroup [ _tail];
  };

  _leader_waypoints = waypoints _leader;
  _tail_waypoints = waypoints _tail;
  if( count _leader_waypoints == currentWaypoint _leader) then {
    if( count _tail_waypoints == currentWaypoint _tail) then {
      [_tail, _leader] call ADDON_fnc_pl_moveInConvoy_ensureTailIsNotTooFarAway;
    }else{
      true;
    };
  } else {
    [_tail, _leader] call ADDON_fnc_pl_moveInConvoy_ensureTailHasNextWaypoint;
  };
};

_ADDON_fnc_pl_moveInConvoy_leaders = missionNamespace getVariable
  [ "ADDON_fnc_pl_moveInConvoy_leaders", []];
{
  _isStillLeader = [ _x ] call ADDON_fnc_pl_moveInConvoyIterationPerLeader;
  if( not _isStillLeader) then {
    _tail = _x getVariable [ "ADDON_fnc_pl_moveInConvoy_tail", objNull ];
    if (not isNull _tail) then {
      _original_leader = _tail getVariable
        [ "ADDON_fnc_pl_moveInConvoy_original_leader"
        , objNull
        ];
      if( not isNull _original_leader) then {
        (leader _x) hcRemoveGroup _tail;
        _original_leader hcSetGroup [ _tail];
      };
      _tail setVariable
        [ "ADDON_fnc_pl_moveInConvoy_original_leader"
        , objNull
        ];
      _tail setVariable
        [ "ADDON_fnc_pl_moveInConvoy_leader"
        , objNull
        ];
    };
     _x setVariable [ "ADDON_fnc_pl_moveInConvoy_tail", objNull ];
    _ADDON_fnc_pl_moveInConvoy_leaders set [ _forEachIndex, objNull];
    systemChat (str _x + " removed from convoy leaders");
  };
} forEach _ADDON_fnc_pl_moveInConvoy_leaders;

_ADDON_fnc_pl_moveInConvoy_leaders = _ADDON_fnc_pl_moveInConvoy_leaders - [objNull];
missionNamespace setVariable [ "ADDON_fnc_pl_moveInConvoy_leaders"
  , _ADDON_fnc_pl_moveInConvoy_leaders];

