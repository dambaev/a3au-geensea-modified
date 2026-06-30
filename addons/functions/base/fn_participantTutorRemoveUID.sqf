params [ "_uid_to_remove"];

if( !isServer) exitWith {
  [ _uid_to_remove] remoteExec [ "ADDON_fnc_participantTutorRemoveUID", 2];
};

_eligible_users = call ADDON_fnc_participantTutorGet;

_exist = 0 < count ( _eligible_users select
               { _uid = _x select 0;
               _uid == _uid_to_remove;
               }
         );

if !( _exist) exitWith { 1;};

_found = false;

{
  _uid = _x select 0;
  if( _uid == _uid_to_remove) then {
    _eligible_users set [_forEachIndex, objNull];
    _found = true;
  };
} forEach( _eligible_users);

if !_found exitWith { 2; };

_eligible_users = _eligible_users - [ objNull];

profileNamespace setVariable [ "participant_tutors_uids", _eligible_users];
saveProfileNamespace;
ADDON_fnc_participantTutorGet_participant_tutors_uids = _eligible_users;
publicVariable "ADDON_fnc_participantTutorGet_participant_tutors_uids";

0;

