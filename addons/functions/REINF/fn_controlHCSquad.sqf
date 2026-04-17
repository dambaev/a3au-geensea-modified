params ["_groups"];

// if (captive player) exitWith {[localize "STR_A3A_reinf_control_squad", localize "STR_A3A_reinf_control_squad_no_undercover"] call A3A_fnc_customHint;};
if (!isNil "A3A_FFPun_Jailed" && {(getPlayerUID player) in A3A_FFPun_Jailed}) exitWith {[localize "STR_A3A_reinf_control_squad", localize "STR_A3A_reinf_control_squad_punishment"] call A3A_fnc_customHint;};

_groupX = _groups select 0;
_unit = leader _groupX;

if !([_unit] call A3A_fnc_canFight) exitWith {[localize "STR_A3A_reinf_control_squad", localize "STR_A3A_reinf_control_no_dead"] call A3A_fnc_customHint;};

// not sure if I like it
// while {(count (waypoints _groupX)) > 0} do
// {
// deleteWaypoint ((waypoints _groupX) select 0);
// };

_wp = _groupX addwaypoint [getpos _unit,0];

hcShowBar false;
hcShowBar true;

{
  _original_player = player getVariable [ "owner", player];
  _player_is_doll_already = player != _original_player;

  if _player_is_doll_already then {
    [_player_is_doll_already] call ADDON_fnc_controlHCSquad_player_HandleDamage;
  };
};

_unit setVariable ["owner", player,true];
player setVariable ["owns",_unit,true];

_eh1 = player addEventHandler ["HandleDamage" , {
    params [ "_unit"];
    [ _unit ] call ADDON_fnc_controlHCSquad_player_HandleDamage;
    [ localize "STR_A3A_reinf_control_squad"
    , localize "STR_A3A_reinf_control_return_damage_1"
    ] call A3A_fnc_customHint;
  }];
player setVariable ["HandleDamage_eh", _eh1,true];
_eh2 = _unit addEventHandler ["Killed", {
    params [ "_unit"];
    [ _unit] call ADDON_fnc_controlHCSquad_player_HandleDamage;
    [localize "STR_A3A_reinf_control_squad"
    , localize "STR_A3A_reinf_control_return_damage_1"
    ] call A3A_fnc_customHint;
  }];
_unit setVariable ["Killed_eh", _eh2, true];
_eh3 = _unit addEventHandler ["HandleDamage", {
    params [ "_unit"];
    _canFight = [_unit] call A3A_fnc_canFight;
    if (_canFight) exitWith {};
    [ _unit ] call ADDON_fnc_controlHCSquad_player_HandleDamage;
    [localize "STR_A3A_reinf_control_squad"
    , localize "STR_A3A_reinf_control_return_damage_1"
    ] call A3A_fnc_customHint;
  }];
_unit setVariable ["HandleDamage_eh", _eh3, true];

{
  (hcLeader _x) hcRemoveGroup _x;
  _unit hcSetGroup [_x];
} forEach (hcAllGroups player);
selectPlayer _unit;
group _unit selectLeader _unit;

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

_return_control_id = _unit addAction
  [localize "STR_antistasi_actions_return_control_to_ai" , {
    params ["_unit", "_caller", "_actionId", "_arguments"];
    if (_unit != _caller) exitWith {
      [ localize "STR_A3A_reinf_control_squad"
      , localize "STR_A3A_reinf_control_squad_punishment"
      ] call A3A_fnc_customHint;
    };
    [ _unit ] call ADDON_fnc_controlHCSquad_player_HandleDamage;
  }];
_unit setVariable [ "ADDON_return_control_action_id", _return_control_id, true];

_control_unit_id = _unit addAction [localize "STR_control_unit_hint_header",
  ADDON_fnc_controlHCUnit];
_unit setVariable [ "ADDON_control_unit_action_id", _control_unit_id, true];

