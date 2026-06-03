_is_commander = [ player ] call ADDON_fnc_isEligibleCommander;
if( leader group player == player && _is_commander) then {
  (hcLeader (group player)) hcRemoveGroup (group player);
  player hcSetGroup [group player];
};
_this call A3A_fnc_onPlayerRespawn;

