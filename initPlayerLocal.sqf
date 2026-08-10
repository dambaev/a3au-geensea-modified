call ADDON_fnc_A3A_patches;
call ADDON_fnc_kmd_autoUnstuck_patch;
call ADDON_fnc_initClient_patch;

call ADDON_fnc_confirmPlacement_patch;

call ADDON_fnc_flagaction_patch;

call ADDON_fnc_FIAinit_patch;

call ADDON_fnc_mrkWIN_patch;

call ADDON_fnc_addBuildingActions_patch;

_this spawn A3A_fnc_initClient;
call ADDON_fnc_initClient;

waitUntil { sleep 1; !(isNil {A3A_faction_occ})};
waitUntil { sleep 1; !(isNil {A3A_faction_inv})};
if( A3A_faction_occ get "name" == "CDF") then {
  A3A_faction_occ set ["name", "ЧСО", false];
};
if( A3A_faction_inv get "name" == "US Army") then {
  A3A_faction_inv set ["name", "Армия США", false];
};
if( A3A_faction_riv get "name" == "CHDKZ") then {
  A3A_faction_riv set ["name", "РДК", false];
};
A3A_faction_reb set ["name", "ДВ РФ", false];

call ADDON_fnc_getSoftTargets_patch;
call ADDON_fnc_getTargetsAT_patch;

if( not hasInterface) exitWith {
};

if( isServer) exitWith {
};

_is_member = nil;
_is_member_count = 0;
_is_member_count_max = 120;
while { (isNil "_is_member") && _is_member_count < _is_member_count_max} do {
  sleep 1;
  _is_member_count = _is_member_count + 1;
  if(! isNil { player call A3A_fnc_isMember}) then {
    _is_member = player call A3A_fnc_isMember;
  };
};

if ( isNil "_is_member") exitWith {
  systemChat( "failed to get if you are a member within 120 seconds");
  endMission "LOSER";
};
systemChat ("_is_member await retries " + str _is_member_count);



if ( not _is_member) then {
  _user_on_not_allowed_slot = false;
  if ( !isNil "commanderX") then { if( player isEqualTo commanderX) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_1") then { if( player isEqualTo slot_eng_1) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_2") then { if( player isEqualTo slot_eng_2) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_3") then { if( player isEqualTo slot_eng_3) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_4") then { if( player isEqualTo slot_eng_4) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_5") then { if( player isEqualTo slot_eng_5) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_6") then { if( player isEqualTo slot_eng_6) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_7") then { if( player isEqualTo slot_eng_7) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_8") then { if( player isEqualTo slot_eng_8) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_9") then { if( player isEqualTo slot_eng_9) then { _user_on_not_allowed_slot = true; }; };
  if ( !isNil "slot_eng_10") then { if( player isEqualTo slot_eng_10) then { _user_on_not_allowed_slot = true; }; };
  if( _user_on_not_allowed_slot) exitWith {
    systemChat( "Стань УЧАСТНИКОМ сервера, чтобы занимать слот Командира или Инженера! / ONLY MEMBERS can be Commander or Engineer");
    _counter = 0;
    _counter_max = 60;
    while { isNil { [true] call A3A_fnc_customHintDismiss;} && _counter < _counter_max } do {
      sleep 1;
      _counter = _counter + 1;
    };
    if ( _counter == _counter_max) then {
      systemChat "failed to dismiss Hints";
    };
    ["Стань УЧАСТНИКОМ сервера, чтобы занимать слот Командира или Инженера! / ONLY MEMBERS can be Commander or Engineer"] call A3A_fnc_customHint;
    sleep 20;
    endMission "LOSER";
  };
};

call ADDON_fnc_controlunit_patch;
call ADDON_fnc_controlHCSquad_patch;

call ADDON_fnc_kmd_addToHcExecute_patch;
call ADDON_fnc_kmd_addToHc_patch;
call ADDON_fnc_kmd_spawnRemoveFromHC_patch;
call ADDON_fnc_kmd_spawnGetOutVehicle_patch;

call ADDON_fnc_saveLoadVehicleArsenal;

call ADDON_fnc_getCargoConfig_patch;
call ADDON_fnc_sellVehicle_patch;

call ADDON_fnc_postmortem_patch;
call ADDON_fnc_enemyGarrison_patch;
call ADDON_fnc_groupDespawner_patch;
call ADDON_fnc_surrenderAction_patch;


call ADDON_fnc_distance_patch;

call ADDON_fnc_administrationAddAction;
call ADDON_fnc_eligibleCommanderAddAction;
call ADDON_fnc_participantTutorAddAction;
call ADDON_fnc_persistentSaveAddAction;

call ADDON_fnc_trader_sellVehicleAddActionInit;

[] spawn {
  while { true} do {
    _is_commander = false;
    waitUntil {
      sleep 1;
      _is_commander = [ player ] call ADDON_fnc_isEligibleCommander;
      !isNil {_is_commander}
    };
    if( leader group player == player && _is_commander) then {
      (hcLeader (group player)) hcRemoveGroup (group player);
      player hcSetGroup [group player];
    };
    sleep 5;
  };
};

spawn {
  waitUntil {
    sleep 1;
    not (isNull (uiNameSpace getVariable "H8erHUD"))
  }
  ["KEYS", true] call A3A_fnc_disableInfoBar;
};

[]spawn compileFinal(preprocessFile"AFAR\init.sqf");

