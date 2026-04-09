params [ "_tail", "_leader"];

_name = "ADDON_fnc_pl_moveInConvoy_ensureTailHasNextWaypoint";

_leader_unit = driver (vehicle leader _leader);
if( isNull _leader_unit) then {
  _leader_unit = leader _leader;
};
if( not alive _leader_unit) exitWith { false; };

if( currentWaypoint _leader >= count waypoints _leader ) exitWith { true; };
if( currentWaypoint _leader < 1 ) exitWith { true; };

_tail = _leader getVariable ["ADDON_fnc_pl_moveInConvoy_tail", objNull];
if (isNull _tail) exitWith { false; };

_tail_leader = _tail getVariable ["ADDON_fnc_pl_moveInConvoy_leader", objNull];
if( _tail_leader != _leader) exitWith { false; };
if( not isNull hcLeader _tail && (hcLeader _tail) != (leader _leader)) exitWith {
  false;
};

_prev_waypoint = currentWaypoint _leader - 1;

_prev_waypoint_pos = waypointPosition [ _leader, _prev_waypoint];

_tail_latest_waypoint_leader_idx = _tail getVariable
  [ "ADDON_fnc_pl_moveInConvoy_leader_waypoint_idx"
  , -1
  ];

if ( _tail_latest_waypoint_leader_idx != _prev_waypoint) then {
  _wp = _tail addWaypoint [ _prev_waypoint_pos, -1 ];
  _wp setWaypointType "MOVE";
  _tail setVariable
    [ "ADDON_fnc_pl_moveInConvoy_leader_waypoint_idx"
    , _prev_waypoint
    ];
  systemChat (_name + ": " + str _tail + " waypoints added");
};


true;

