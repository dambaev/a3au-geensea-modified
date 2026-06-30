params [ "_uid_to_remove"];

if( !isServer) exitWith {
  [ _uid_to_remove] remoteExec [ "ADDON_fnc_administrationRemoveUID", 2 ];
};
_users = call ADDON_fnc_administrationGet;

_exist = 0 < count ( _commanders select
               { _uid = _x select 0;
               _uid == _uid_to_remove;
               }
         );

if !( _exist) exitWith { 1;};

_found = false;

{
  _uid = _x select 0;
  if( _uid == _uid_to_remove) then {
    _users set [_forEachIndex, objNull];
    _found = true;
  };
} forEach( _users);

if !_found exitWith { 2; };

_users = _users - [ objNull];

profileNamespace setVariable [ "administration_uids", _users];
saveProfileNamespace;
ADDON_fnc_administrationGet_administration_uids = _users;
publicVariable "ADDON_fnc_administrationGet_administration_uids";

0;

