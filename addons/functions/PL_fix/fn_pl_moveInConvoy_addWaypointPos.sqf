params [ "_group", "_waypoint_pos"];

_name = "ADDON_pl_moveInConvoy_addWaypointPos";

_wp = _group addWaypoint [ _waypoint_pos, -1 ];
_wp setWaypointType "MOVE";

systemChat (_name + ": waypoint added1");

