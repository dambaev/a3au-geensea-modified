/*  Handles the despawn and cleanup of dead units
*   Params:
*       _victim : OBJECT : The dead unit
*
*   Returns:
*       Nothing
*/

params ["_victim"];
#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()
private _group = group _victim;

Debug("PostMortem Called");
if (isnull _victim)exitwith{Error("Function failed called with null param.")};

if (isNull _group) then
{
    Debug_1("Group for victim :: %1, no group found! Removing from Statics list.",_victim);

	if (_victim in staticsToSave) then
    {
        staticsToSave = staticsToSave - [_victim];
        publicVariable "staticsToSave";
    };
};

_name_victim = name _victim;
_get_side = {
  params [ "_x"];
  if( isPlayer _x) exitWith {
    if( [ _x] call A3A_fnc_canFight) then {
      side _x;
    } else {
      independent;
    };
  };
  _loadout_side = (_x getVariable ["unitType", ""]) select [0, count "loadouts_reb_"];
  if( _loadout_side == "loadouts_occ_") exitWith { west; };
  if( _loadout_side == "loadouts_inv_") exitWith { east; };
  if( _loadout_side == "loadouts_reb_") exitWith { independent; };
  side _x;
};

_victim_side =  [ _victim ] call _get_side;

_is_enemy = {
  params [ "_veh"];
  _unit = _veh;
  if( vehicle _unit != _unit) then {
    _unit = driver _veh;
    if( isNull _unit) then {
      _unit = gunner _veh;
    };
    if( isNull _unit) then {
      _unit = commander _veh;
    };
  };
  if( isNull _unit ) exitWith { false; };
  _side = [ _unit ] call _get_side;
  _ret = (_side getFriend _victim_side < 0.6);
  if ((!isNil "A3A_fnc_postmortemDebug") && _ret) then {
    Info_4( "A3A_fnc_postmortemDebug: is_enemy: name / side: %1 / %2, %3 / %4" , name _unit, str _side, _name_victim, str _victim_side);
  };
  _ret;
};

_are_enemies_nearby = {
  _all_entities = _victim nearEntities ["AllVehicles", 300];
  _ret = false;
  {
    _canFight = [ _x ] call A3A_fnc_canFight;
    if( ! _canFight) then { continue; };
    _enemy = [_x] call _is_enemy;
    if( ! _enemy) then { continue; };
    _ret = true;
    break;
  } forEach ( _all_entities);
  _ret;
};

_enemies_nearby = call _are_enemies_nearby;

while {(!isNull _victim) && alive _victim && _enemies_nearby} do {
  if( not (isNil "A3A_fnc_postmortemDebug") && _enemies_nearby) then {
    Info_3( "A3A_fnc_postmortemDebug: Pausing for %1 seconds before cleaning victim: %2 and group: %3", 60, _victim, _group);
  };
  sleep 60;
  _enemies_nearby = call _are_enemies_nearby;

  if( not (isNil "A3A_fnc_postmortemDebug") && _enemies_nearby) then {
    Info( "A3A_fnc_postmortemDebug: _enemies_nearby " + str _victim + ", " + _name_victim);
  };
};

if( not (isNil "A3A_fnc_postmortemDebug")) then {
  Info( "A3A_fnc_postmortemDebug: " + str _victim + ", " + _name_victim);
  Info( "A3A_fnc_postmortemDebug: alive " + str (alive _victim));
  Info( "A3A_fnc_postmortemDebug: _enemies_nearby " + str _enemies_nearby);
};
if( not (isNil "A3A_fnc_postmortemDebug") ) then {
  Info_3( "A3A_fnc_postmortemDebug: Pausing for %1 minutes before cleaning victim: %2 and group: %3", round cleantime/60, _victim, _group);
};
if( (!isNull _victim) && alive _victim) then {
  Debug_3("Pausing for %1 minutes before cleaning victim: %2 and group: %3", round cleantime/60, _victim, _group);
  private _checkIterationCountMax = cleantime/60;
  private _checkIterationDelay = 60;
  private _checkIterationCount = 0;
  while { _checkIterationCount < _checkIterationCountMax && (!isNull _victim) && alive _victim} do {
    Info_3("A3A_fnc_postmortemDebug: sleeping %1, iteration: %2 / %3", _checkIterationDelay, _checkIterationCount, _checkIterationCountMax);
    sleep _checkIterationDelay;
    _checkIterationCount = _checkIterationCount + 1;
  };
};

if( not (isNil "A3A_fnc_postmortemDebug") ) then {
  Info_3( "A3A_fnc_postmortemDebug: cleaning victim: %1 / %2 and group: %3", _victim, _name_victim, _group);
};

if (_victim getVariable ["stopPostmortem", false]) exitWith {};

if( (!isNull _victim) && !alive _victim) exitWith { }; // will be cleared by GC

if !(isnull _victim) then
{
    Debug_1("Cleanup complete for %1 victim.", _victim);
    if (_victim isKindOf "CAManBase" and !(isNull (objectParent _victim))) then {
        // Otherwise vehicle seats may remain blocked
        [objectParent _victim, _victim] remoteExec ["deleteVehicleCrew", _victim];
    } else {
        deleteVehicle _victim;
    };
};

if !(isnull _group) then
{
    Debug_1("Cleanup complete for %1 group.", _group);
    deleteGroup _group;
};
