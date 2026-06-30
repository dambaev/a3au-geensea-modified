if(! isServer) exitWith { };

if( isNil "ADDON_fnc_participantTutorGet_participant_tutors_uids") then {
  ADDON_fnc_participantTutorGet_participant_tutors_uids = profileNamespace
    getVariable [ "participant_tutors_uids", [] ]; // load from profile
  publicVariable "ADDON_fnc_participantTutorGet_participant_tutors_uids";
};

