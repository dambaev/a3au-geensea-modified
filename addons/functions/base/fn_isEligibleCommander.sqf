params [ "_unit"];

_is_current_admin = (call BIS_fnc_admin) == 2;
// comment to test
//if( _is_current_admin) exitWith { true; };

_commander_uids = call ADDON_fnc_eligibleCommanderGet;

if !( isPlayer _unit) exitWith { false; };

_unit_uid = getPlayerUID _unit;

_is_commander = 0 < count (_commander_uids select {
    _uid = _x select 0;
    _uid == _unit_uid;
  });

_is_commander;
