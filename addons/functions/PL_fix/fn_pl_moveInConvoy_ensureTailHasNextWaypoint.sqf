params [ "_tail", "_leader"];

_name = "ADDON_fnc_pl_moveInConvoy_ensureTailHasNextWaypoint";

_leader_unit = driver (vehicle leader _leader);
if( isNull _leader_unit) then {
  _leader_unit = leader _leader;
};
if( not alive _leader_unit) exitWith { false; };

_tail = _leader getVariable ["ADDON_fnc_pl_moveInConvoy_tail", objNull];
if (isNull _tail) exitWith { false; };

_tail_leader = _tail getVariable ["ADDON_fnc_pl_moveInConvoy_leader", objNull];
if( _tail_leader != _leader) exitWith { false; };

if (currentWaypoint _leader < 2) exitWith { true; };

_prev_waypoint = currentWaypoint _leader - 2;

_prev_waypoint_pos = waypointPosition [ _leader, _prev_waypoint];

_is_prev_waypoint_outside_map = [ 0, 0, 0] distanceSqr _prev_waypoint_pos <= 100;

if ( _is_prev_waypoint_outside_map) then {
  systemChat (_name + ": " + str _leader + " waypoint" + str _prev_waypoint
    + " is at " + str _prev_waypoint_pos + ", won't be added for " + str _tail);
};

_tail_latest_waypoint_leader_idx = _tail getVariable
  [ "ADDON_fnc_pl_moveInConvoy_leader_waypoint_idx"
  , -1
  ];

if ( _tail_latest_waypoint_leader_idx != _prev_waypoint
     && not _is_prev_waypoint_outside_map
     ) then {
  _target = hcLeader _tail;
  if( isNull _target) then {
    _target = _tail;
  };
  [_tail, _prev_waypoint_pos] remoteExec
    [ "ADDON_fnc_pl_moveInConvoy_addWaypointPos", _target];
  // _wp = _tail addWaypoint [ _prev_waypoint_pos, -1 ];
  // _wp setWaypointType "MOVE";
  _tail setVariable
    [ "ADDON_fnc_pl_moveInConvoy_leader_waypoint_idx"
    , _prev_waypoint
    ];
  systemChat (_name + ": " + str _tail + " waypoints added");
};


true;

