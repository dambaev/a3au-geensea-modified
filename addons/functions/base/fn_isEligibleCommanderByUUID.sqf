params [ "_unit_uid"];

_commander_uids = call ADDON_fnc_eligibleCommanderGet;

_is_commander = 0 < count (_commander_uids select {
    _uid = _x select 0;
    _uid == _unit_uid;
  });

_is_commander;
