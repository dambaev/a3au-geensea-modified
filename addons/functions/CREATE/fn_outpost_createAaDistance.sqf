#include "\x\A3A\addons\core\script_component.hpp"
#include "\x\A3A\addons\scrt\defines.inc"
FIX_LINE_NUMBERS()

params ["_markerX", "_spawn_distance"];

if (!isServer and hasInterface) exitWith {};

private _positionX = getMarkerPos _markerX;
private _garrison = garrison getVariable [_markerX, []];

private _aaClass = selectRandom (A3A_faction_reb get "staticAA");

private _props = [];

if (isNil "_garrison") then {
    _garrison = A3A_faction_reb get "groupAaEmpl";
    garrison setVariable [_markerX,_garrison,true];
};

{
    private _relativePosition = [_positionX, 4, _x] call BIS_Fnc_relPos;
    private _sandbag = createVehicle ["Land_BagFence_Round_F", _relativePosition, [], 0, "CAN_COLLIDE"];
    _sandbag setDir ([_sandbag, _positionX] call BIS_fnc_dirTo);
    _sandbag setVectorUp surfaceNormal position _sandbag;
    _props pushBack _sandbag;
} forEach [0, 90, 180, 270];

private _veh = objNull;

//overriden static position and direction
private _staticPositionInfo = staticPositions getVariable [_markerX, []];
if (!(_staticPositionInfo isEqualTo [])) then {
    private _staticPosition = _staticPositionInfo select 0;
    private _staticDirection = _staticPositionInfo select 1;
    _veh = createVehicle [_aaClass, _positionX, [], 0, "CAN_COLLIDE"];
    _veh setPosATL _staticPosition;
    _veh setDir _staticDirection;
} else {
    _veh = _aaClass createVehicle _positionX;
};

_veh lock 3;

sleep 1;

[_veh,"Move_Outpost_Static"] remoteExec ["A3A_fnc_flagaction",[teamPlayer,civilian], _veh];

private _groupX = [_positionX, teamPlayer, _garrison,true,false] call A3A_fnc_spawnGroup;
private _groupXUnits = units _groupX;
_groupXUnits apply { [_x,_markerX] spawn A3A_fnc_FIAinitBases; };

private _crewManIndex = _groupXUnits findIf  {(_x getVariable "unitType") == (A3A_faction_reb get "unitRifle")};
if (_crewManIndex != -1) then {
    private _crewMan = _groupXUnits select _crewManIndex;
    _crewMan moveInGunner _veh;
    [_crewMan, EGVAR(core,scanHorizonHeight)] spawn SCRT_fnc_common_scanHorizon;
};

//_groupX setBehaviour "AWARE";
//_groupX setCombatMode "YELLOW";
_groupX setBehaviour "COMBAT";
_groupX setCombatMode "RED";

[_veh, teamPlayer] call A3A_fnc_AIVEHinit;

["locationSpawned", [_markerX, "RebelAaEmpl", true]] call EFUNC(Events,triggerEvent);

_infantry_fire_at_with_aa = {
  params [ "_unit", "_target"];
  _weapon = secondaryWeapon _unit;
  _muzzle = _weapon;
  _muzzles = [];
  _modes = [];
  _mode = "";
  _unit disableAI "FSM";
  _unit disableAI "AUTOTARGET";
  _unit disableAI "TARGET";

  if (_weapon != "") then
  {
    _type = _weapon;
    // check for multiple muzzles (eg: GL)
    _muzzles = getArray (configFile >> "cfgWeapons" >> _type >> "muzzles");
    _modes = getArray (configFile >> "cfgWeapons" >> _type >> "modes");
    if( count _modes > 0) then {
      _mode = _modes select 0;
    };

    if (count _muzzles > 1) then
    {
      _muzzle = (_muzzles select 0);
      _unit selectWeapon _muzzle;
    }
    else
    {
      _unit selectWeapon _type;
    };
  };

  _unit reload [_weapon, ""];
  _unit doTarget _target;
  _unit commandTarget _target;
  _unit forceWeaponFire [ _weapon, _mode];
  _max = 1000;
  _count = 0;
  while { (currentWeapon _unit != _weapon || !(canFire _unit)) && _count < _max} do {
    sleep 0.1;
  };
  _unit fireAtTarget [_target, _muzzle];
  _unit enableAI "FSM";
  _unit enableAI "AUTOTARGET";
  _unit enableAI "TARGET";
};

_vehicle_fire_at_with_aa = {
  params [ "_unit", "_target"];
  _weapon = currentWeapon _unit;
  _muzzle = _weapon;
  _muzzles = [];
  _modes = [];
  _mode = "";
  _unit disableAI "FSM";
  _unit disableAI "AUTOTARGET";
  _unit disableAI "TARGET";

  if (_weapon != "") then
  {
    _type = _weapon;
    // check for multiple muzzles (eg: GL)
    _muzzles = getArray (configFile >> "cfgWeapons" >> _type >> "muzzles");
    _modes = getArray (configFile >> "cfgWeapons" >> _type >> "modes");
    if( count _modes > 0) then {
      _mode = _modes select 0;
    };

    if (count _muzzles > 1) then
    {
      _muzzle = (_muzzles select 0);
      _unit selectWeapon _muzzle;
    }
    else
    {
      _unit selectWeapon _type;
    };
  };

  _unit reload [_weapon, ""];
  _unit doTarget _target;
  _unit commandTarget _target;
  _unit forceWeaponFire [ _weapon, _mode];
  _max = 1000;
  _count = 0;
  while { (currentWeapon _unit != _weapon || !(canFire _unit)) && _count < _max} do {
    sleep 0.1;
  };
  _unit fireAtTarget [_target, _muzzle];
  _unit enableAI "FSM";
  _unit enableAI "AUTOTARGET";
  _unit enableAI "TARGET";
};

ServerInfo_1("[%1] searching for a target", _markerX);
_counter = 0;

waitUntil {
	sleep 1;
  _counter = _counter + 1;
  if( _counter > 20) then {
    _counter = 0;
    _target = objNull;
    _target_distance = _spawn_distance * _spawn_distance;
    {
      _vehicle = _x;
      if( !(_vehicle isKindOf "Air")) then { continue; };
      _height = (getPosASL _target) select 2;
      _height_atl = (getPosATL _target) select 2;
      if( isNil {_height} || _height_atl > _height) then {  _height = _height_atl;};
      if( _height >= 100) then { continue; }; // TODO: height?
      _side = side (effectiveCommander _vehicle);
      if( _side != Occupants && _side != Invaders) then { continue; };
      _dist = (leader _groupX) distanceSqr _vehicle;
      if( _dist < _target_distance) then {
        _target = _vehicle;
        _target_distance = _dist;
      };
    } forEach( vehicles);
    if( !isNull _target) then {
      if( _groupX knowsAbout _target < 4) then {
        _groupX reveal [ _target, 4.0];
      };
      _height = (getPosASL _target) select 2;
      _height_atl = (getPosATL _target) select 2;
      if( isNil {_height} || _height < _height_atl) then { _height = _height_atl; };
      if( _height > 500) then {
        _target flyInHeight [500, true];
      };
      _groupX setBehaviour "COMBAT";
      _groupX setCombatMode "RED";
      ServerInfo_3("[%1] targetting at %2, height: %3", _markerX , typeOf _target, _height);
      {
        _unit reload [_weapon, ""];
        _unit doTarget _target;
        _unit commandTarget _target;
      } forEach (units _groupX);
    };
  };
	((spawner getVariable _markerX == 2)) or
	({alive _x} count units _groupX == 0) or (!(_markerX in aapostsFIA))
};

if ({alive _x} count units _groupX == 0) then {
	aapostsFIA = aapostsFIA - [_markerX]; publicVariable "aapostsFIA";
	markersX = markersX - [_markerX]; publicVariable "markersX";
	sidesX setVariable [_markerX,nil,true];
	_nul = [5,-5,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
	deleteMarker _markerX;
	["TaskFailed", ["", (localize "STR_notifiers_emplacement_lost")]] remoteExec ["BIS_fnc_showNotification", 0];
};

waitUntil {
  sleep 1;
  (spawner getVariable _markerX == 2)
    or (!(_markerX in aapostsFIA))
};

if (!isNull _veh) then {
    deleteVehicle _veh;
};

{
    deleteVehicle _x
} forEach units _groupX;
deleteGroup _groupX;

{
	deleteVehicle _x;
} forEach _props;

["locationSpawned", [_markerX, "RebelAaEmpl", false]] call EFUNC(Events,triggerEvent);
