params [ "_unit"];

if !( isPlayer _unit) exitWith { false; };

_is_current_admin = (call BIS_fnc_admin) == 2;
if( _is_current_admin) exitWith { true; };

_administration_uids = call ADDON_fnc_administrationGet;

_unit_uid = getPlayerUID _unit;

_is_administration = 0 < count (_administration_uids select {
    _uid = _x select 0;
    _uid == _unit_uid;
  });

_is_administration;
