params ["_unit"];

_original_player = player getVariable [ "owner", nil];
if ( isNil {_original_player;}) exitWith {
  [ localize "STR_A3A_reinf_control_squad"
  , "_original_player = null"
  ] call A3A_fnc_customHint;
};
player setVariable [ "owner", nil, true];

_HandleDamage_eh = _original_player getVariable [ "HandleDamage_eh", nil];
if (not (isNil {_HandleDamage_eh;})) then {
  _original_player removeEventHandler ["HandleDamage",_HandleDamage_eh];
  _original_player setVariable [ "HandleDamage_eh", nil, true];
};

selectPlayer _original_player;
(units group _original_player) joinsilent group _original_player;
group _original_player selectLeader _original_player;

_doll = _original_player getVariable [ "owns", nil];
if ( isNil { _doll;}) exitWith {
  [localize "STR_A3A_reinf_control_squad", "_doll = nil"] call A3A_fnc_customHint;
};
_original_player setVariable [ "owns", nil, true];

{
  (hcLeader _x) hcRemoveGroup _x;
  _original_player hcSetGroup [_x];
} forEach (hcAllGroups _doll);

_killed_eh = _doll getVariable [ "Killed_eh", nil];
if (not (isNil { _killed_eh; })) then {
  _doll removeEventHandler ["Killed",_killed_eh];
  _doll setVariable [ "Killed_eh", nil, true];
};
_action_id = _doll getVariable [ "ADDON_return_control_action_id", nil];
if (not (isNil {_action_id; })) then {
  _doll removeAction _action_id;
  _doll setVariable ["ADDON_return_control_action_id", nil, true];
};
_action_id = _doll getVariable [ "ADDON_control_unit_action_id", nil];
if (not (isNil {_action_id;})) then {
  _doll removeAction _action_id;
  _doll setVariable ["ADDON_control_unit_action_id", nil, true];
};

