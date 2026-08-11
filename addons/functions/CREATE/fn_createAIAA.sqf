#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()
if (!isServer and hasInterface) exitWith{};

#define DESPAWN 2
#define DESPAWNAA 5

params ["_markerX"];

if( isNil {ADDON_fnc_createAIAADebug}) then {
  ADDON_fnc_createAIAADebug = false;
  publicVariable "ADDON_fnc_createAIAADebug";
};

//Not sure if that ever happens, but it reduces redundance
if(isNil {spawner getVariable _markerX }) exitWith {
  if( ADDON_fnc_createAIAADebug) then {
    ServerInfo_1("tried to call with %1, but spawner unaware?", _markerX);
  };
};
if(spawner getVariable _markerX == 2) exitWith {};

if( ADDON_fnc_createAIAADebug) then {
  ServerInfo_1("Spawning AA on Base %1", _markerX);
};

private _vehiclesX = [];
private _groups = [];
private _soldiers = [];
private _props = [];
private _dogs = []; //dogs are used in fn_location_createPatrols, removing this variable will break spawn
private _spawnsUsed = [];

private _positionX = getMarkerPos (_markerX);

private _size = [_markerX] call A3A_fnc_sizeMarker;

private _frontierX = [_markerX] call A3A_fnc_isFrontline;
private _busy = false;	//if (dateToNumber date > server getVariable _markerX) then {false} else {true};
private _nVeh = round (_size/60);

private _sideX = sidesX getVariable [_markerX,sideUnknown];
private _faction = Faction(_sideX);

/////////////////////////////
// SPAWNING SAM SITE	  //
////////////////////////////
private _radarType = _faction getOrDefault ["vehicleRadar", ""];
private _samType = _faction getOrDefault ["vehicleSam", ""];

// In case of array
if (_radarType isEqualType [] && {_radarType isNotEqualTo []}) then {_radarType = selectRandom _radarType};
if (_samType isEqualType [] && {_samType isNotEqualTo []}) then {_samType = selectRandom _samType};

// In case of empty array
if (_samType isEqualType [] && {_samType isEqualTo []}) then {_samType = ""};
if (_radarType isEqualType [] && {_radarType isEqualTo []}) then {_radarType = ""};

if (garrison getVariable [_markerX + "_samDestroyedCD", 0] == 0) then
{
	if (_radarType != "" && {_samType != ""}) then
	{
		private _spawnParameter = [_markerX, "Sam"] call A3A_fnc_findSpawnPosition;
		if !(_spawnParameter isEqualType []) exitWith {};
		_spawnsUsed pushBack _spawnParameter#2;

		{
			private _aaVehicle = nil;
			isNil {
				// _aaVehicle = createVehicle [_x, (_spawnParameter select 0), [], 0, "CAN_COLLIDE"];
				// _aaVehicle setDir (_spawnParameter select 1);
				_aaVehicle = [_x, _spawnParameter select 0, 25, 10, true] call A3A_fnc_safeVehicleSpawn;
				_aaVehicle setDir (_spawnParameter select 1);
			};

      if( !isNil { _veh}) then {
        if( ADDON_fnc_createAIAADebug) then {
          ServerInfo_2("[%1]: created SAM %2", _markerX, typeOf _aaVehicle);
        };
      };
			private _aaGroup = [_sideX, _aaVehicle, "aa"] call A3A_fnc_createVehicleCrew;
			[_aaVehicle, _sideX] call A3A_fnc_AIVEHinit;

			_soldiers append (units _aaGroup); //not sure if needed
			_groups pushBack _aaGroup;
			_vehiclesX pushBack _aaVehicle;

			//radar rotation
			if(_x isEqualTo _radarType) then {
				_aaVehicle spawn {
					while {alive _this} do {
						{
							_this lookAt (_this getRelPos [100, _x]);
							sleep 2.45;
						} forEach [120, 240, 0];
					};
				};
				_aaVehicle setVehicleRadar 1;
				_aaVehicle setVehicleReportRemoteTargets true;
			};

			_aaVehicle setVariable ["A3A_samMarker", _markerX];
			_aaVehicle addEventHandler ["Killed", {
				private _marker = _this#0 getVariable ["A3A_samMarker", ""];
				if (_marker isNotEqualTo "") then {
					private _varName = _marker + "_samDestroyedCD";
					private _previousValue = garrison getVariable [_varName, 0];
					garrison setVariable [_varName, (_previousValue + 900), true];
				};
			}];
		} forEach [_radarType, _samType];
	};
};


private _mrk = createMarkerLocal [format ["%1patrolarea", random 100], _positionX];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [(distanceSPWN/2),(distanceSPWN/2)];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_mrk setMarkerDirLocal (markerDir _markerX);
if (!debug) then {_mrk setMarkerAlphaLocal 0};

/////////////////////////////
// Self-propelled AA 	  //
////////////////////////////

if (random 10 < (tierWar + difficultyCoef)) then {
	private _max = if (_frontierX) then {2} else {1};
	for "_i" from 1 to _max do {
		private _spawnParameter = [_markerX, "Vehicle"] call A3A_fnc_findSpawnPosition;

		if !(_spawnParameter isEqualType []) exitWith {};
		_spawnsUsed pushBack _spawnParameter#2;

		private _veh = nil;
		isNil {
			_veh = createVehicle [selectRandom (_faction get "vehiclesAA"), (_spawnParameter select 0), [], 0, "CAN_COLLIDE"];
			_veh setDir (_spawnParameter select 1);
		};
    if( !isNil { _veh}) then {
      if( ADDON_fnc_createAIAADebug) then {
        ServerInfo_2("[%1]: created AA %2", _markerX, typeOf _veh);
      };
    };

		_groupVeh = [_sideX, _veh, "aa"] call A3A_fnc_createVehicleCrew;
		{[_x,_markerX] call A3A_fnc_NATOinit} forEach units _groupVeh;
		[_veh, _sideX] call A3A_fnc_AIVEHinit;
		_soldiers append units _groupVeh;
		_groups pushBack _groupVeh;
		[_groupVeh, "Patrol_Area", 25, 100, 250, true, _positionX, false] call A3A_fnc_patrolLoop;
		_vehiclesX pushBack _veh;

		sleep 1;
		[gunner _veh] spawn SCRT_fnc_common_scanHorizon;

		_veh setVariable ["originalPos", getPosATL _veh];
	};
};

{
  if (_x isKindOf "Static" || _x isKindOf "StaticWeapon") then {continue};
  [_x, true] call A3U_fnc_setLock;
} forEach _vehiclesX;

if( ADDON_fnc_createAIAADebug) then {
  ServerInfo_1("[%1]: DESPAWNAA wait loop", _markerX);
};
_timeKey = _markerX + "_AA_reload_after_time";
if( count (_vehiclesX ) < 1 ) then {
  if( ADDON_fnc_createAIAADebug) then {
    ServerInfo_1("[%1]: unable to spawn AA units, delay next call", _markerX);
  };
  spawner setVariable [_timeKey, time + 300, true];
  spawner setVariable [ _markerX, DESPAWNAA, true];
} else {
  spawner setVariable [_timeKey, 0, true];
};
waitUntil {
  sleep 10;
  private _spawned_vehicles_count = count _vehiclesX;
  private _alive_vehicles_count = count (_vehiclesX select { alive _x});
  private _damaged_vehicles_count = count (_vehiclesX select {
        count (((getAllHitPointsDamage _x) select 2) select { _x >= 1}) > 0
      }
    );
  private _next_reload_time = spawner getVariable [_timeKey, 0];
  private _next_reload_time_reached = _next_reload_time > 0 && {
      _next_reload_time <= time
    };
  if( _damaged_vehicles_count > 0 && _next_reload_time == 0) then {
      if( ADDON_fnc_createAIAADebug) then {
        ServerInfo_1("[%1]: some AA vehicles had been damaged, set resupply delay", _markerX);
      };
    spawner setVariable [_timeKey, time + 300, true];
  };
  if( _next_reload_time_reached || _alive_vehicles_count < 1 ) then {
    spawner setVariable [ _markerX, DESPAWNAA, true];
  };
  ( (isNil {spawner getVariable _markerX})
  || spawner getVariable _markerX == DESPAWNAA
  )
};
if( ADDON_fnc_createAIAADebug) then {
  ServerInfo_1("[%1]: DESPAWN", _markerX);
};

if(isNil {spawner getVariable _markerX}) then {
  if( ADDON_fnc_createAIAADebug) then {
    ServerInfo_1("[%1]: spawner getVariable _markerX = nil ", _markerX);
  };
};
_spawnsUsed call A3A_fnc_freeSpawnPositions;

deleteMarker _mrk;
{ if (alive _x) then { deleteVehicle _x } } forEach _soldiers;
{ deleteVehicle _x } forEach _dogs;
{ deleteGroup _x }forEach _groups;
{ deleteVehicle _x } forEach _props;
_alive_vehicles_count = count (_vehiclesX select { alive _x});
_vehicles_count = count _vehiclesX;
_dead_vehicles_coef = 0;
if( _vehicles_count > 0) then {
  _dead_vehicles_coef = 1 - (_alive_vehicles_count /  _vehicles_count);
};
if( _dead_vehicles_coef > 0) then {
  spawner setVariable [_timeKey, time + 1200 * _dead_vehicles_coef, true];
};
{ deleteVehicle _x; } forEach _vehiclesX;


if( ADDON_fnc_createAIAADebug) then {
  ServerInfo_2("[%1]: DESPAWNED, dead vehicles coef %2", _markerX, _dead_vehicles_coef);
};
spawner setVariable [ _markerX, DESPAWN, true];

