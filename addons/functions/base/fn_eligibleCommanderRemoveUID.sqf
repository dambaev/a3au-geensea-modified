params [ "_uid_to_remove"];

if( !isServer) exitWith {
  [ _uid_to_remove] remoteExec [ "ADDON_fnc_eligibleCommanderRemoveUID", 2];
};

_commanders = call ADDON_fnc_eligibleCommanderGet;

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
    _commanders set [_forEachIndex, objNull];
    _found = true;
  };
} forEach( _commanders);

if !_found exitWith { 2; };

_commanders = _commanders - [ objNull];

profileNamespace setVariable [ "eligible_commanders_uids", _commanders];
saveProfileNamespace;
ADDON_fnc_eligibleCommanderGet_eligible_commanders_uids = _commanders;
publicVariable "ADDON_fnc_eligibleCommanderGet_eligible_commanders_uids";

0;

