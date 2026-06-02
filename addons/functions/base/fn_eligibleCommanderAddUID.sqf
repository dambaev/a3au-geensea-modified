params [ "_new_uid", "_name"];


if( !isServer) exitWith {
  [ _new_uid, _name] remoteExec [ "ADDON_fnc_eligibleCommanderAddUID", 2];
};

_commanders = call ADDON_fnc_eligibleCommanderGet;

_exist = 0 < count ( _commanders select
               { _uid = _x select 0;
               _uid == _new_uid;
               }
         );

if( _exist) exitWith { 1;};

_commanders pushBack [ _new_uid, _name];

profileNamespace setVariable [ "eligible_commanders_uids", _commanders];
saveProfileNamespace;
ADDON_fnc_eligibleCommanderGet_eligible_commanders_uids = _commanders;
publicVariable "ADDON_fnc_eligibleCommanderGet_eligible_commanders_uids";

0;

