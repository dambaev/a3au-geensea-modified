params [ "_tail", "_leader"];

_name = "ADDON_fnc_pl_moveInConvoy_ensureTailIsNotTooClose";

_leader_unit = driver (vehicle leader _leader);
if( isNull _leader_unit) then {
  _leader_unit = leader _leader;
};
if( not alive _leader_unit) exitWith {
  systemChat( _name + ": " + str _leader_unit + " not alive");
  false;
};

_tail_units = ((units _tail) select { alive _x});
_leader_units = ((units _leader) select { alive _x});

if( count _tail_units < 1 || count _leader_units < 1) exitWith {
  systemChat( _name + ": " + str _tail + " no alive units");
  false;
};
if( count _leader_units < 1) exitWith {
  systemChat( _name + ": " + str _leader + " no alive units");
  false;
};

_tail_unit = driver (vehicle leader _tail);
if( isNull _tail_unit) then {
  _tail_unit = leader _tail;
};

_leader_distance = _tail_unit distanceSqr _leader_unit;

_ideal_distance = _tail getVariable
  [ "ADDON_fnc_pl_moveInConvoy_leader_distanceSqr"
  , -1
  ];

_tail_stopping_waypoint = _tail getVariable
  [ "ADDON_fnc_pl_moveInConvoy_stopping_waypoint"
  , -1
  ];

if( _leader_distance < (_ideal_distance * 0.5) ) then {
  if( count waypoints _tail > 0
      && currentWaypoint _tail != _tail_stopping_waypoint
      ) then {
    _target = hcLeader _tail;
    if( isNull _target) then {
      _target = _tail;
    };
    [_tail, currentWaypoint _tail, getPosASL _tail_unit] remoteExec
      [ "ADDON_fnc_pl_moveInConvoy_setWaypointPos", _target];
    _tail setVariable
      [ "ADDON_fnc_pl_moveInConvoy_stopping_waypoint"
      , _tail_stoping_waypoint
      ];
    systemChat (_name + ": " + str _tail + " stopping");
  };
};

true;
