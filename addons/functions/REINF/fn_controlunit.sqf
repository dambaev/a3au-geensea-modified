#include "..\script_component.hpp"
FIX_LINE_NUMBERS()
params ["_units"];

private _unit = _units select 0;

if (_unit == Petros) exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_petros"] call A3A_fnc_customHint;};
if (player != leader group player) exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_no_squad_leader"] call A3A_fnc_customHint;};
if (isPlayer _unit) exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_no_player"] call A3A_fnc_customHint;};
if (!(alive _unit) or (_unit getVariable ["incapacitated",false]))  exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_alive_only"] call A3A_fnc_customHint;};
if (side _unit != teamPlayer) exitWith {[localize "STR_control_unit_hint_header", format [localize "STR_control_unit_error_rebel_only",A3A_faction_reb get "name"]] call A3A_fnc_customHint;};
if (!isNil "A3A_FFPun_Jailed" && {(getPlayerUID player) in A3A_FFPun_Jailed}) exitWith {[localize "STR_control_unit_hint_header", localize "STR_control_unit_error_punish"] call A3A_fnc_customHint;};

{
  _original_player = player getVariable [ "owner", player];
  _player_is_doll_already = player != _original_player;

  if _player_is_doll_already then {
    call ADDON_fnc_controlHCSquad_player_HandleDamage;
  };
};

private _face = face _unit;
private _speaker = speaker _unit;

_unit setVariable ["owner",player,true];
player setVariable ["owns",_unit,true];

_eh1 = player addEventHandler ["HandleDamage" , {
    call ADDON_fnc_controlHCSquad_player_HandleDamage;
    [ localize "STR_A3A_reinf_control_squad"
    , localize "STR_A3A_reinf_control_return_damage_1"
    ] call A3A_fnc_customHint;
  }];
player setVariable ["HandleDamage_eh", _eh1,true];
_eh2 = _unit addEventHandler ["Killed", {
    call ADDON_fnc_controlHCSquad_player_HandleDamage;
    [localize "STR_A3A_reinf_control_squad"
    , localize "STR_A3A_reinf_control_return_damage_1"
    ] call A3A_fnc_customHint;
  }];
_unit setVariable ["Killed_eh", _eh2, true];

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
    call ADDON_fnc_controlHCSquad_player_HandleDamage;
  }];
_unit setVariable [ "ADDON_return_control_action_id", _return_control_id, true];

_control_unit_id = _unit addAction [localize "STR_control_unit_hint_header",
  ADDON_fnc_controlHCUnit];
_unit setVariable [ "ADDON_control_unit_action_id", _control_unit_id, true];



