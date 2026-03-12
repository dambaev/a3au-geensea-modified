params ["_doll", "_caller", "_actionId", "_arguments"];

if ( _doll != _caller ) exitWith {[localize "STR_A3A_reinf_control_squad", localize "STR_A3A_reinf_control_squad_punishment"] call A3A_fnc_customHint;};
if ( leader (group _doll) != _doll ) exitWith {[localize "STR_A3A_reinf_control_squad", localize "STR_A3A_reinf_control_squad_punishment"] call A3A_fnc_customHint;};
if (!isNil "A3A_FFPun_Jailed" && {(getPlayerUID player) in A3A_FFPun_Jailed}) exitWith {[localize "STR_A3A_reinf_control_squad", localize "STR_A3A_reinf_control_squad_punishment"] call A3A_fnc_customHint;};

_original_player = _doll getVariable [ "owner", nil];
if (isNil { _original_player; }) exitWith {
  [ localize "STR_A3A_reinf_control_squad"
  , "_original_player = nil"
  ] call A3A_fnc_customHint;
};

[ localize "STR_A3A_reinf_control_squad"
, "select unit within 10 seconds"
] call A3A_fnc_customHint;

_selected_units = (groupSelectedUnits player) select
  {[_x] call A3A_fnc_canFight; };
_iterations = 0;
while { _iterations < 10 && count _selected_units < 1} do {
  if (count (groupSelectedUnits player) > 0 ) then {
    _selected_units = (groupSelectedUnits player) select
      {[_x] call A3A_fnc_canFight; };
  };
  if (count (hcSelected player) > 0 ) then {
    {
      {
        if ([_x] call A3A_fnc_canFight) then {
          _selected_units pushBack _x;
        };
      } forEach (units _x);
    } forEach (hcSelected player);
  };

  _iterations = _iterations + 1;
  sleep 1;
};

if (count _selected_units < 1) exitWith {
  [ localize "STR_A3A_reinf_control_squad"
  , localize "STR_A3A_reinf_control_no_dead"
  ] call A3A_fnc_customHint;
};
_doll_next = _selected_units select 0;
_doll_group = group _doll_next;

if (_doll_next == Petros) exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_petros"] call A3A_fnc_customHint;};
if (isPlayer _doll_next) exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_no_player"] call A3A_fnc_customHint;};
if (!(alive _doll_next) or (_doll getVariable ["incapacitated",false]))  exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_alive_only"] call A3A_fnc_customHint;};
if (side _doll_next != teamPlayer) exitWith {[localize "STR_control_unit_hint_header", format [localize "STR_control_unit_error_rebel_only",A3A_faction_reb get "name"]] call A3A_fnc_customHint;};

_killed_eh = _doll getVariable [ "Killed_eh", nil];
if (not (isNil { _killed_eh;}) ) then {
  _doll removeEventHandler ["Killed",_killed_eh];
  _doll setVariable [ "Killed_eh", nil, true];
};
_doll setVariable ["owner",nil,true];
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

_doll_next setVariable [ "owner", _original_player, true];
_original_player setVariable [ "owns", _doll_next, true];

_eh2 = _doll_next addEventHandler ["Killed", {
    call ADDON_fnc_controlHCSquad_player_HandleDamage;
    [localize "STR_A3A_reinf_control_squad"
    , localize "STR_A3A_reinf_control_return_damage_1"
    ] call A3A_fnc_customHint;
  }];
_doll_next setVariable ["Killed_eh", _eh2, true];

_return_control_id = _doll_next addAction
  [localize "STR_antistasi_actions_return_control_to_ai" , {
    params ["_unit", "_caller", "_actionId", "_arguments"];
    if (_unit != _caller) exitWith {
      [ localize "STR_A3A_reinf_control_squad"
      , localize "STR_A3A_reinf_control_squad_punishment"
      ] call A3A_fnc_customHint;
    };
    call ADDON_fnc_controlHCSquad_player_HandleDamage;
  }];
_doll_next setVariable [ "ADDON_return_control_action_id", _return_control_id, true];
_control_unit_id = _doll_next addAction [localize "STR_control_unit_hint_header",
    ADDON_fnc_controlHCUnit];
_doll_next setVariable [ "ADDON_control_unit_action_id", _control_unit_id, true];

{
  (hcLeader _x) hcRemoveGroup _x;
  _doll_next hcSetGroup [_x];
} forEach (hcAllGroups _doll);
selectPlayer _doll_next;
group _doll_next selectLeader _doll_next;

//otherwise unit will lose his identity
[_unit, createHashMapFromArray [["face", _face], ["speaker", _speaker]]] call A3A_fnc_setIdentity;

if (fatigueEnabled isEqualTo false) then {
	_unit enableFatigue false;
};

if (staminaEnabled isEqualTo false) then {
	_unit enableStamina false;
};

private _newWeaponSway = swayEnabled / 100;
_unit setCustomAimCoef _newWeaponSway;


