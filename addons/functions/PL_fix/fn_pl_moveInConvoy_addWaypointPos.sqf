params [ "_group", "_waypoint_pos", "_behaviour"];

_name = "ADDON_pl_moveInConvoy_addWaypointPos";

_wp = _group addWaypoint [ _waypoint_pos, 1 ];
_wp setWaypointType "MOVE";
_group setCombatBehaviour _behaviour;

systemChat (_name + ": " + str _group + " waypoint added");

