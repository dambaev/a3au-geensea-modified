params [ "_new_uid", "_name"];
if( !isServer) exitWith {
  [ _new_uid, _name] remoteExec [ "ADDON_fnc_administrationAddUID", 2];
};

_users = call ADDON_fnc_administrationGet;

_exist = 0 < count ( _users select
               { _uid = _x select 0;
               _uid == _new_uid;
               }
         );

if( _exist) exitWith { 1;};

_users pushBack [ _new_uid, _name];

profileNamespace setVariable [ "administration_uids", _users];
saveProfileNamespace;
ADDON_fnc_administrationGet_administration_uids = _users;
publicVariable "ADDON_fnc_administrationGet_administration_uids";
0;

