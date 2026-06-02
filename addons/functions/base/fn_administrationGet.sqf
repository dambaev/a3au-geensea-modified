if( isServer) then {
  if( isNil "ADDON_fnc_administrationGet_administration_uids") then {
    ADDON_fnc_administrationGet_administration_uids = profileNamespace
      getVariable [ "administration_uids", [] ]; // load from profile
    publicVariable "ADDON_fnc_administrationGet_administration_uids";
  };
  ADDON_fnc_administrationGet_administration_uids;
} else {
  ADDON_fnc_administrationGet_administration_uids;
};

