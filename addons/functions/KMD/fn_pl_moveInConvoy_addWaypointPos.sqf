params [ "_group", "_waypoint_pos", "_behaviour"];

_name = "ADDON_pl_moveInConvoy_addWaypointPos";

_wp = _group addWaypoint [ _waypoint_pos, 1 ];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour _behaviour;
_group setCombatBehaviour _behaviour;

if( !isNil {KMD_moveInConvoyDebug}) then {
  systemChat (_name + ": " + str _group + " waypoint added");
};

