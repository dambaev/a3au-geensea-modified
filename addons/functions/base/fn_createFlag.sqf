/*
Author: Barbolani, Bob-Murphy, Wurzel0701, Triada

Description:
    Handles the spawned state of locations, scheduling spawning,
    handling simulation state of garrisons, and marking for de-spawning
    (de-spawning handled in the spawning code).

Arguments: <nil>
Return Value: <nil>
Scope: Server
Environment: Scheduled
Public: No
Dependencies:
    Occupants, Invaders, teamPlayer, markersX, forcedSpawn, spawner,
    controlsX, airportsX, milbases, resourcesX, factories, outposts, seports,
    A3A_fnc_createAICities, A3A_fnc_createAIcontrols,
    A3A_fnc_createAIAirplane, A3A_fnc_createAIresources, A3A_fnc_createAIOutposts,
    A3A_fnc_createSDKGarrisons

Example: [] spawn A3A_fnc_distance;
*/
#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()

/* -------------------------------------------------------------------------- */
/*                                   defines                                  */
/* -------------------------------------------------------------------------- */

// the spawn units array will update ones at this count cycles
#define DESPAWN 2
#define DESPAWNPLAYER 6

/* -------------------------------------------------------------------------- */
/*                                 procedures                                 */
/* -------------------------------------------------------------------------- */

params [ "_markerX"];
_positionX = getMarkerPos (_markerX);
_vehiclesX = [];
if (_markerX != "Synd_HQ" && {!(_markerX in milAdministrationsX)}) then {  ///maaaaaaybe we should save vehicles near ANY friendly marker?
  if (!(_markerX in citiesX)) then {
    private _veh = nil;
    _spawnParameter = [_markerX, "flag"] call A3A_fnc_findSpawnPosition;
    if (_spawnParameter isEqualType []) then {
      _veh = createVehicle [FactionGet(reb,"flag"), (_spawnParameter select 0), [], 0, "NONE"];
      _veh setDir (_spawnParameter select 1); // this probably doesn't matter, but eh why not?
    } else {
      Warning_1("Could not find flag placement marker for garrison %1; falling back to marker center.", _markerX);
      _veh = createVehicle [FactionGet(reb,"flag"), _positionX, [],0, "NONE"];
    };
    _veh setFlagTexture FactionGet(reb,"flagTexture");
    _veh allowDamage false;
    _vehiclesX pushBack _veh;
    [_veh,"SDKFlag"] remoteExec ["A3A_fnc_flagaction",0,_veh];

    if (_markerX in seaports) then {
      [_veh,"seaport"] remoteExec ["A3A_fnc_flagaction",[teamPlayer,civilian],_veh];
    };
  };
  Info_1("flag had been created for %1", _markerX);
};

Info_1("wait loop for %1", _markerX);
waitUntil {
  sleep 1;
  ( isNil {spawner getVariable _markerX}
  || spawner getVariable _markerX == DESPAWNPLAYER
  )
};

{if (!(_x in staticsToSave)) then {deleteVehicle _x}} forEach _vehiclesX;
Info_1("flag had been deleted for %1", _markerX);
spawner setVariable [ _markerX, DESPAWN, true];

