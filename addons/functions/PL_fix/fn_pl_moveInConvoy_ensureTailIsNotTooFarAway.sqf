params [ "_tail", "_leader"];

_leader_unit = driver (vehicle leader _leader);
if( isNull _leader_unit) then {
  _leader_unit = leader _leader;
};
if( not alive _leader_unit) exitWith { false; };

_ideal_distance = _tail getVariable
  [ "ADDON_fnc_pl_moveInConvoy_leader_distanceSqr"
  , -1
  ];

if( _ideal_distance < 0) exitWith { false;};

_tail_units = ((units _tail) select { alive _x});
_leader_units = ((units _leader) select { alive _x});

if( count _tail_units < 1 || count _leader_units < 1) exitWith {
  systemChat( "no alive units in _tail");
  false;
};
if( count _leader_units < 1) exitWith {
  systemChat( "no alive units in _leader");
  false;
};

_tail_unit = driver (vehicle leader _tail);
if( isNull _tail_unit) then {
  _tail_unit = leader _tail;
};

_leader_distance = _tail_unit distanceSqr _leader_unit;

if( _leader_distance <= _ideal_distance ) exitWith {
  if( count waypoints _tail > 0) then {
  	[_tail, currentWaypoint _tail] setWaypointPosition
      [getPosASL _tail_unit, -1];
    sleep 0.1;
    if( count waypoints _tail > currentWaypoint _tail) then {
    	for "_i" from count waypoints _tail - 1 to (currentWaypoint _tail + 1) step -1 do
    	{
    		deleteWaypoint [_tail, _i];
    	};
      systemChat (str _tail + " waypoints deleted");
    };
  };
  true;
};

if (count waypoints _tail == currentWaypoint _tail) then {
  _wp = _tail addWaypoint [ getPosASL _leader_unit, 5 ];
  _wp setWaypointType "MOVE";
  systemChat "waypoints added";
};

true;
