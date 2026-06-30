params [ "_new_uid", "_name"];


if( !isServer) exitWith {
  [ _new_uid, _name] remoteExec [ "ADDON_fnc_participantTutorAddUID", 2];
};

_eligible_users = call ADDON_fnc_participantTutorGet;

_exist = 0 < count ( _eligible_users select
               { _uid = _x select 0;
               _uid == _new_uid;
               }
         );

if( _exist) exitWith { 1;};

_eligible_users pushBack [ _new_uid, _name];

profileNamespace setVariable [ "participant_tutors_uids",
_eligible_users];
saveProfileNamespace;
ADDON_fnc_participantTutorGet_participant_tutors_uids = _eligible_users;
publicVariable "ADDON_fnc_participantTutorGet_participant_tutors_uids";

0;

