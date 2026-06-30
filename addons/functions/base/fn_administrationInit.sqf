if( !isServer) exitWith {};

if( isNil "ADDON_fnc_administrationGet_administration_uids") then {
  ADDON_fnc_administrationGet_administration_uids = profileNamespace
    getVariable [ "administration_uids", [] ]; // load from profile
  publicVariable "ADDON_fnc_administrationGet_administration_uids";
};

