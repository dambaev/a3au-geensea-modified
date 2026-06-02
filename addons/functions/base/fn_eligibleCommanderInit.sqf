if(! isServer) exitWith { };

if( isNil "ADDON_fnc_eligibleCommanderGet_eligible_commanders_uids") then {
  ADDON_fnc_eligibleCommanderGet_eligible_commanders_uids = profileNamespace
    getVariable [ "eligible_commanders_uids", [] ]; // load from profile
  publicVariable "ADDON_fnc_eligibleCommanderGet_eligible_commanders_uids";
};

