params [ "_unit"];

waitUntil {
  sleep 1;

};

_is_current_admin = (call BIS_fnc_admin) == 2;
// comment to test
//if( _is_current_admin) exitWith { true; };

_eligible_users = nil;
waitUntil {
  sleep 1;
  _eligible_users = call ADDON_fnc_participantTutorGet;
  !isNil {_eligible_users};
};

if !( isPlayer _unit) exitWith { false; };

_unit_uid = getPlayerUID _unit;

_is_eligible_user = 0 < count (_eligible_users select {
    _uid = _x select 0;
    _uid == _unit_uid;
  });

_is_eligible_user;
