_is_commander = [ player ] call ADDON_fnc_isEligibleCommander;
_is_commander_count = 0;
_is_commander_max = 120;
while { (isNil "_is_commander") && _is_commander_count < _is_commander_max} do {
  sleep 1;
  _is_commander = [ player ] call ADDON_fnc_isEligibleCommander;
  _is_commander_count = _is_commander_count + 1;
};
if( leader group player == player && _is_commander) then {
  (hcLeader (group player)) hcRemoveGroup (group player);
  player hcSetGroup [group player];
};
_this call A3A_fnc_onPlayerRespawn;

