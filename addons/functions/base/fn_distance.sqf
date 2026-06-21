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
#define COUNT_CYCLES 5
#define ENABLED 0
#define DISABLED 1
#define DESPAWN 2
#define ENABLEDAA 3
#define ENABLEDPLAYER 4
#define DESPAWNAA 5
#define DESPAWNPLAYER 6

A3A_processOccupantMarkerDebug = false;
A3A_distanceDebug = false;

/* -------------------------------------------------------------------------- */
/*                                 procedures                                 */
/* -------------------------------------------------------------------------- */

private _processOccupantMarker = {

    switch (spawner getVariable _marker)
    do
    {
        case ENABLEDAA:
        {
            // if somebody green is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_fia_slow) exitWith {
              // DESPAWN this marker and then will trigger full spawn
              spawner setVariable [_marker, DESPAWNAA, true];
            };
            // or somebody opfor is inside distanceSPWN2
            _spawn_by_inv_slow = (gameMode == 1) && _invaders inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            if( _spawn_by_inv_slow) exitWith {
              // DESPAWN this marker and then will trigger full spawn
              spawner setVariable [_marker, DESPAWNAA, true];
            };
            // or this marker is forced spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;
            if( _is_forced) exitWith {
              // DESPAWN this marker and then will trigger full spawn
              spawner setVariable [_marker, DESPAWNAA, true];
            };

            // if somebody green fast target is inside _AA_despawn_distance
            _spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _AA_despawn_distance, _AA_despawn_distance] isNotEqualTo [];
            if( _spawn_by_fia_fast) exitWith {};
            // if somebody opfor fast target is inside _AA_despawn_distance
            _spawn_by_inv_fast = (gameMode == 1) && _invaders_planes inAreaArray
                [_position, _AA_despawn_distance, _AA_despawn_distance] isNotEqualTo [];
            if( _spawn_by_inv_fast) exitWith {};

            // DESPAWNAA this marker and then will trigger full spawn
            spawner setVariable [_marker, DESPAWNAA, true];
        };
        case ENABLED:
        {
            // if somebody green is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_fia_slow) exitWith {
              if( A3A_processOccupantMarkerDebug) then { Info_1("[%1] ENABLED by _spawn_by_fia_slow", _marker);};
            };
            // or somebody opfor is inside distanceSPWN2
            _spawn_by_inv_slow = (gameMode == 1) && _invaders inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            if( _spawn_by_inv_slow) exitWith {
              if( A3A_processOccupantMarkerDebug) then { Info_1("[%1] ENABLED by _spawn_by_inv_slow", _marker);};
            };
            // or this marker is forced spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;
            if( _is_forced) exitWith {
              if( A3A_processOccupantMarkerDebug) then { Info_1("[%1] ENABLED by _is_forced", _marker);};
            };

            // if somebody green fast target is inside _Fast_full_despawn_distance
            _spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _Fast_full_despawn_distance, _Fast_full_despawn_distance] isNotEqualTo [];
            if( _spawn_by_fia_fast) exitWith {
              if( A3A_processOccupantMarkerDebug) then { Info_1("[%1] ENABLED by _spawn_by_fia_fast", _marker);};
            };
            // if somebody opfor fast target is inside _Fast_full_despawn_distance
            _spawn_by_inv_fast = (gameMode == 1) && _invaders_planes inAreaArray
                [_position, _Fast_full_despawn_distance, _Fast_full_despawn_distance] isNotEqualTo [];
            if( _spawn_by_inv_fast) exitWith {
              if( A3A_processOccupantMarkerDebug) then { Info_1("[%1] ENABLED by _spawn_by_inv_fast", _marker);};
            };

            // DISABLE this marker
            spawner setVariable [_marker, DISABLED, true];

            // disable simulation for all marker units
            {
                if (_x getVariable ["markerX", ""] == _marker
                    && { vehicle _x == _x })
                then { _x enableSimulationGlobal false; };
            } forEach allUnits;
        };

        case DISABLED:
        {
            // if somebody green is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            // or somebody opfor is inside distanceSPWN2
            _spawn_by_inv_slow = (gameMode == 1) && _invaders inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            // or this marker is forced spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;

            // if somebody green fast target is inside _Fast_full_despawn_distance
            _spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _Fast_full_despawn_distance, _Fast_full_despawn_distance] isNotEqualTo [];
            // if somebody opfor fast target is inside _Fast_full_despawn_distance
            _spawn_by_inv_fast = (gameMode == 1) && _invaders_planes inAreaArray
                [_position, _Fast_full_despawn_distance, _Fast_full_despawn_distance] isNotEqualTo [];
            // if somebody green is inside distanceSPWN
            // or somebody opfor is inside distanceSPWN2
            // or this marker is forced to spawn than ENABLE marker
            _is_should_be_enabled = _spawn_by_fia_slow
              || _spawn_by_inv_slow
              || _is_forced
              || _spawn_by_fia_fast
              || _spawn_by_inv_fast
              ;
            if (_is_should_be_enabled)
            then
            {
                if( A3A_processOccupantMarkerDebug) then {
                  Info_6("[%6] DISABLED-> ENABLED: _spawn_by_fia_slow %1, _spawn_by_inv_slow %2, _is_forced %3, _spawn_by_fia_fast %4, _spawn_by_inv_fast %5"
                    , _spawn_by_fia_slow, _spawn_by_inv_slow, _is_forced
                    , _spawn_by_fia_fast, _spawn_by_inv_fast
                    , _marker
                    );
                };
                // ENABLE this marker
                spawner setVariable [_marker, ENABLED, true];

                // enable simulation for all marker units
                {
                    if (_x getVariable ["markerX", ""] == _marker
                        && { vehicle _x == _x })
                    then { _x enableSimulationGlobal true; };
                } forEach allunits;
            }
            else
            {
                // DESPAWN this marker
                spawner setVariable [_marker, DESPAWN, true];
            };
        };

        case DESPAWN:
        {
            // if somebody green is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            // or somebody opfor is inside distanceSPWN2
            _spawn_by_inv_slow = (gameMode == 1) && _invaders inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            // or this marker is forced spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;

            // if somebody green fast target is inside _AA_spawn_distance
            _spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _AA_spawn_distance, _AA_spawn_distance] isNotEqualTo [];
            // if somebody opfor fast target is inside _AA_spawn_distance
            _spawn_by_inv_fast = (gameMode == 1) && _invaders_planes inAreaArray
                [_position, _AA_spawn_distance, _AA_spawn_distance] isNotEqualTo [];
            // if somebody green is inside distanceSPWN
            // or somebody opfor is inside distanceSPWN2
            // or this marker is forced to spawn than ENABLE marker
            _should_be_full_spawn = _spawn_by_fia_slow
              || _spawn_by_inv_slow
              || _is_forced
              ;
            _should_be_aa_spawn = _spawn_by_fia_fast
              || _spawn_by_inv_fast
              ;
            _should_be_only_aa_spawn = !_should_be_full_spawn
              && _should_be_aa_spawn
              ;
            _is_should_be_enabled = _should_be_full_spawn
              || _should_be_aa_spawn
              ;

            // if nobody green is inside distanceSPWN
            // and nobody opfor is inside distanceSPWN2
            // and marker is not forced to spawn than exit (marker still DESPAWN)
            if( !_is_should_be_enabled) exitWith {};
            if( A3A_processOccupantMarkerDebug) then {
              Info_6("[%1] DESPAWN-> ENABLED*: _spawn_by_fia_slow %2, _spawn_by_inv_slow %3, _is_forced %4, _spawn_by_fia_fast %5, _spawn_by_inv_fast %6"
                , _marker
                , _spawn_by_fia_slow, _spawn_by_inv_slow, _is_forced
                , _spawn_by_fia_fast, _spawn_by_inv_fast
                );
            };

            switch(true) do
            {
              case (_should_be_full_spawn):
              {
                // ENABLE this marker
                spawner setVariable [_marker, ENABLED, true];

                // TODO: if only spawned by fast targets, then spawn only markers with AA
                // and only SAMs
                switch (true)
                do
                {
                    case (_marker in citiesX):
                    {
                        [[_marker], "A3A_fnc_createAICities"] call A3A_fnc_scheduler;
                    };

                    case (_marker in controlsX):
                    {
                        [[_marker], "A3A_fnc_createAIcontrols"] call A3A_fnc_scheduler;
                    };

                    // Prevent other routines taking spawn places
                    [_marker, 1] call A3A_fnc_addTimeForIdle;

                    case (_marker in airportsX):
                    {
                        [[_marker], "A3A_fnc_createAIAirplane"] call A3A_fnc_scheduler;
                    };

                    case (_marker in resourcesX);
                    case (_marker in factories):
                    {
                        [[_marker], "A3A_fnc_createAIresources"] call A3A_fnc_scheduler;
                    };

                    case (_marker in outposts);
                    case (_marker in seaports):
                    {
                        [[_marker], "A3A_fnc_createAIOutposts"] call A3A_fnc_scheduler;
                    };

                    case(_marker in milbases):
                    {
                        [[_marker],"A3A_fnc_createAIMilbase"] call A3A_fnc_scheduler;
                    };

                    case (_marker in milAdministrationsX):
                    {
                        [[_marker], "A3A_fnc_createAIMilAdmin"] call A3A_fnc_scheduler;
                    };
                };
              };
              case (_should_be_only_aa_spawn):
              {
                switch (true)
                do
                {
                    case (_marker in airportsX);
                    case (_marker in milbases);
                    case (_marker in resourcesX);
                    case (_marker in factories);
                    case (_marker in seaports):
                    {
                      // ENABLE this marker
                      spawner setVariable [_marker, ENABLEDAA, true];
                      // Prevent other routines taking spawn places
                      [_marker, 1] call A3A_fnc_addTimeForIdle;
                      [[_marker],"ADDON_fnc_createAIAA"] call A3A_fnc_scheduler;
                    };
                    default { };
                };
              };
              default {};
            };


        };
    };
};

private _processFIAMarker = {

    switch (spawner getVariable _marker)
    do
    {
        case ENABLEDPLAYER:
        {
            // if somebody blufor is inside distanceSPWN
            _spawn_by_occ_slow = _occupants inAreaArray
              [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_occ_slow) exitWith {
              // DESPAWN marker
              spawner setVariable [_marker, DESPAWNPLAYER, true];
            };
            // or somebody opfor is inside distanceSPWN
            _spawn_by_inv_slow = _invaders inAreaArray
              [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_inv_slow) exitWith {
              // DESPAWN marker
              spawner setVariable [_marker, DESPAWNPLAYER, true];
            };
            // or marker is forced to spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;
            if( _is_forced) exitWith {
              // DESPAWN marker
              spawner setVariable [_marker, DESPAWNPLAYER, true];
            };
            // if somebody opfor fast target is inside _AA_fia_despawn_distance
            _spawn_by_inv_fast = _invaders_planes inAreaArray
                [_position, _AA_fia_despawn_distance, _AA_fia_despawn_distance] isNotEqualTo [];
            if( _spawn_by_inv_fast) exitWith {
              // DESPAWN marker
              spawner setVariable [_marker, DESPAWNPLAYER, true];
            };
            // if somebody opfor fast target is inside _AA_fia_despawn_distance
            _spawn_by_occ_fast = _occupants_planes inAreaArray
                [_position, _AA_fia_despawn_distance, _AA_fia_despawn_distance] isNotEqualTo [];
            if( _spawn_by_occ_fast) exitWith {
              // DESPAWN marker
              spawner setVariable [_marker, DESPAWNPLAYER, true];
            };
            // or somebody green is control unit and is inside distanceSPWN2
            _spawn_by_player_slow = _players inAreaArray
              [_position, distanceSPWN1, distanceSPWN1] isNotEqualTo [];
            if( _spawn_by_player_slow) exitWith {};


            // DESPAWNPLAYER marker
            spawner setVariable [_marker, DESPAWNPLAYER, true];
        };
        case ENABLED:
        {
            // if somebody blufor is inside distanceSPWN
            _spawn_by_occ_slow = _occupants inAreaArray
              [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_occ_slow) exitWith {};
            // or somebody opfor is inside distanceSPWN
            _spawn_by_inv_slow = _invaders inAreaArray
              [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_inv_slow) exitWith {};
            // or marker is forced to spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;
            if( _is_forced) exitWith {};

            _is_aa_post = _marker in aapostsFIA;
            // if somebody opfor fast target is inside _AA_fia_spawn_distance
            _spawn_by_inv_fast = _is_aa_post && _invaders_planes inAreaArray
                [_position, _AA_fia_spawn_distance, _AA_fia_spawn_distance] isNotEqualTo [];
            if( _spawn_by_inv_fast) exitWith {};
            // if somebody opfor fast target is inside _AA_fia_spawn_distance
            _spawn_by_occ_fast = _is_aa_post && _occupants_planes inAreaArray
                [_position, _AA_fia_spawn_distance, _AA_fia_spawn_distance] isNotEqualTo [];
            if( _spawn_by_occ_fast) exitWith {};

            // DISABLE marker
            spawner setVariable [_marker, DISABLED, true];

            // disable simulation for all marker units
            {
                if (_x getVariable ["markerX", ""] == _marker
                    && { vehicle _x == _x }) then { _x enableSimulationGlobal false; };
            } forEach allUnits;
        };

        case DISABLED:
        {
            // if somebody blufor is inside distanceSPWN
            _spawn_by_occ_slow = _occupants inAreaArray
              [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            // or sombody opfor is inside distanceSPWN
            _spawn_by_inv_slow = _invaders inAreaArray
              [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            // or marker is forced to spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;

            _is_should_spawn = _spawn_by_occ_slow
              || _spawn_by_inv_slow
              || _is_forced
              ;

            if (_is_should_spawn)
            then
            {
                // ENABLE this marker
                spawner setVariable [_marker, ENABLED, true];

                // enable simulation for all marker units
                {
                    if (_x getVariable ["markerX", ""] == _marker && {
                        vehicle _x == _x }) then { _x enableSimulationGlobal true; };
                } forEach allunits;
            }
            else
            {
                // DESPAWN this marker
                spawner setVariable [_marker, DESPAWN, true];
            };
        };

        case DESPAWN:
        {
            // if somebody opfor fast target is inside _AA_spawn_distance
            _spawn_by_inv_slow = _invaders inAreaArray
                  [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            _spawn_by_inv_fast =
              if( _spawn_by_inv_slow) then {
                true;
              }else {
                _invaders_planes inAreaArray
                  [_position, _AA_fia_spawn_distance, _AA_fia_spawn_distance] isNotEqualTo [];
              };
            // if somebody west fast target is inside _AA_spawn_distance
            _spawn_by_occ_slow = _occupants inAreaArray
                  [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            _spawn_by_occ_fast =
              if( _spawn_by_occ_slow) then {
                true;
              }else{
                _occupants_planes inAreaArray
                  [_position, _AA_fia_spawn_distance, _AA_fia_spawn_distance] isNotEqualTo [];
              };
            _is_should_be_full_spawn = _spawn_by_occ_slow
              || _spawn_by_inv_slow
              || _marker in forcedSpawn
              ;
            _is_should_spawn_by_fast = _spawn_by_inv_fast
              || _spawn_by_occ_fast
              ;
            _is_should_spawn_by_players = _players inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            _is_should_spawn_by_enemies = _is_should_be_full_spawn
              || _is_should_spawn_by_fast
              ;
            _is_should_spawn_only_by_players = !_is_should_spawn_by_enemies
              && _is_should_spawn_by_players;
            _is_should_spawn = _is_should_spawn_by_enemies
              || _is_should_spawn_by_players;
            // if nobody blufor is inside distanceSPWN
            // and nobody opfor is inside distanceSPWN
            // and nobody green player is inside distanceSPWN2
            // and marker is not forced spawn then exit (marker still DESPAWN)
            if (!_is_should_spawn) exitWith {};

            // run spawn procedures
            switch (true) do {
                case (_marker in watchpostsFIA): {
                  if( _is_should_be_full_spawn) then {
                    // ENABLED this marker
                    spawner setVariable [_marker, ENABLED, true];
                    [[_marker],"SCRT_fnc_outpost_createWatchpostDistance"] call A3A_fnc_scheduler;
                  };
                };
                case (_marker in roadblocksFIA): {
                  if( _is_should_be_full_spawn) then {
                    // ENABLED this marker
                    spawner setVariable [_marker, ENABLED, true];
                    [[_marker],"SCRT_fnc_outpost_createRoadblockDistance"] call A3A_fnc_scheduler;
                  };
                };
                case (_marker in aapostsFIA): {
                  switch(true) do {
                    case( _is_should_be_full_spawn): {
                      if( A3A_distanceDebug) then {
                        Info_1("[%1]: full spawn", _marker);
                      };
                      // ENABLED this marker
                      spawner setVariable [_marker, ENABLED, true];
                      [[_marker, _AA_fia_spawn_distance],"ADDON_fnc_outpost_createAaDistance"] call A3A_fnc_scheduler;
                    };
                    case( _is_should_spawn_by_fast): {
                      if( A3A_distanceDebug) then {
                        Info_1("[%1]: spawn by planes", _marker);
                      };
                      // ENABLED this marker
                      spawner setVariable [_marker, ENABLED, true];
                      [[_marker, _AA_fia_spawn_distance],"ADDON_fnc_outpost_createAaDistance"] call A3A_fnc_scheduler;
                    };
                  };
                };
                case (_marker in atpostsFIA): {
                  if( _is_should_be_full_spawn) then {
                    // ENABLED this marker
                    spawner setVariable [_marker, ENABLED, true];
                    [[_marker],"SCRT_fnc_outpost_createAtDistance"] call A3A_fnc_scheduler;
                  };
                };
                case (_marker in hmgpostsFIA): {
                  if( _is_should_be_full_spawn) then {
                    // ENABLED this marker
                    spawner setVariable [_marker, ENABLED, true];
                    [[_marker],"SCRT_fnc_outpost_createHmgDistance"] call A3A_fnc_scheduler;
                  };
                };
                case !(_marker in controlsX): {
                  switch(true) do {
                    case ( _is_should_be_full_spawn): {
                      // ENABLED this marker
                      spawner setVariable [_marker, ENABLED, true];
                      [[_marker], "A3A_fnc_createSDKGarrisons"] call A3A_fnc_scheduler;
                    };
                    case ( _is_should_spawn_only_by_players): {
                      // ENABLEDPLAYER this marker
                      spawner setVariable [_marker, ENABLEDPLAYER, true];
                      [[_marker], "ADDON_fnc_createFlag"] call A3A_fnc_scheduler;
                    };
                  };
                };
            };
        };
    };
};

private _processInvaderMarker = {

    switch (spawner getVariable _marker)
    do
    {
        case ENABLEDAA:
        {
            // if somebody green is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_fia_slow) exitWith {
              // DESPAWN this marker and then will trigger full spawn
              spawner setVariable [_marker, DESPAWNAA, true];
            };
            // or somebody opfor is inside distanceSPWN2
            _spawn_by_occ_slow = (gameMode == 1) && _occupants inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            if( _spawn_by_occ_slow) exitWith {
              // DESPAWN this marker and then will trigger full spawn
              spawner setVariable [_marker, DESPAWNAA, true];
            };
            // or this marker is forced spawn than exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;
            if( _is_forced) exitWith {
              // DESPAWN this marker and then will trigger full spawn
              spawner setVariable [_marker, DESPAWNAA, true];
            };

            // if somebody green fast target is inside _AA_despawn_distance
            _spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _AA_despawn_distance, _AA_despawn_distance] isNotEqualTo [];
            if( _spawn_by_fia_fast) exitWith {};
            // if somebody west fast target is inside _AA_despawn_distance
            _spawn_by_occ_fast = (gameMode == 1) && _occupants_planes inAreaArray
                [_position, _AA_despawn_distance, _AA_despawn_distance] isNotEqualTo [];
            if( _spawn_by_occ_fast) exitWith {};

            // DESPAWN this marker and then will trigger full spawn
            spawner setVariable [_marker, DESPAWNAA, true];
        };
        case ENABLED:
        {
            // if somebody green is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            if( _spawn_by_fia_slow) exitWith {};
            // or somebody blufor is inside distanceSPWN2
            _spawn_by_occ_slow = (gameMode == 1) && _occupants inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            if( _spawn_by_occ_slow) exitWith {};
            // or marker is forced spawn then exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;
            if( _is_forced) exitWith {};

            // if somebody green fast target is inside _Fast_full_despawn_distance
            _full_spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _Fast_full_despawn_distance, _Fast_full_despawn_distance] isNotEqualTo [];
            if( _full_spawn_by_fia_fast) exitWith { };
            // if somebody west fast target is inside _Fast_full_despawn_distance
            _full_spawn_by_occ_fast = (gameMode == 1) && _occupants_planes inAreaArray
                [_position, _Fast_full_despawn_distance, _Fast_full_despawn_distance] isNotEqualTo [];
            if( _full_spawn_by_occ_fast) exitWith { };

            // DISABLE this marker
            spawner setVariable [_marker, DISABLED, true];

            // disable simulation for all marker units
            {
                if (_x getVariable ["markerX", ""] == _marker
                    && { vehicle _x == _x }) then { _x enableSimulationGlobal false; };
            } forEach allUnits;
        };

        case DISABLED:
        {
            // if somebody green is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            // or somebody blufor is inside distanceSPWN2
            _spawn_by_occ_slow = (gameMode == 1) && _occupants inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            // or marker is forced spawn then exit (marker still ENABLED)
            _is_forced = _marker in forcedSpawn;

            // if somebody green fast target is inside _Fast_full_spawn_distance
            _full_spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _Fast_full_spawn_distance, _Fast_full_spawn_distance] isNotEqualTo [];
            // if somebody west fast target is inside _Fast_full_spawn_distance
            _full_spawn_by_occ_fast = (gameMode == 1) && _occupants_planes inAreaArray
                [_position, _Fast_full_spawn_distance, _Fast_full_spawn_distance] isNotEqualTo [];

            // if somebody green is inside distanceSPWN
            // or somebody bluefor is inside distanceSPWN2
            // or marker is forced spawn then ENABLED this marker
            _is_should_spawn = _spawn_by_fia_slow
              || _spawn_by_occ_slow
              || _is_forced
              || _full_spawn_by_fia_fast
              || _full_spawn_by_occ_fast
              ;
            if (_is_should_spawn)
            then
            {
                // ENABLE this marker
                spawner setVariable [_marker, ENABLED, true];

                // enable simulation for all marker units
                {
                    if (_x getVariable ["markerX", ""] == _marker
                        && { vehicle _x == _x }) then { _x enableSimulationGlobal true; };
                } forEach allunits;
            }
            else
            {
                // DESPAWN this marker
                spawner setVariable [_marker, DESPAWN, true];
            };
        };

        case DESPAWN:
        {
            // if nobody is inside distanceSPWN
            _spawn_by_fia_slow = _teamplayer inAreaArray
                [_position, distanceSPWN, distanceSPWN] isNotEqualTo [];
            // and nobody is inside distanceSPWN2
            _spawn_by_occ_slow = (gameMode == 1) && _occupants inAreaArray
              [_position, distanceSPWN2, distanceSPWN2] isNotEqualTo [];
            // and marker is not forced to spawn then exit (marker still DESPAWN)
            _is_forced = _marker in forcedSpawn;

            // if somebody green fast target is inside _AA_spawn_distance
            _spawn_by_fia_fast = _teamplayer_planes inAreaArray
                [_position, _AA_spawn_distance, _AA_spawn_distance] isNotEqualTo [];
            // if somebody opfor fast target is inside _AA_spawn_distance
            _spawn_by_occ_fast = (gameMode == 1) && _occupants_planes inAreaArray
                [_position, _AA_spawn_distance, _AA_spawn_distance] isNotEqualTo [];

            _should_be_full_spawn = _spawn_by_fia_slow
              || _spawn_by_occ_slow
              || _is_forced
              ;
            _should_be_aa_spawn = _spawn_by_fia_fast
              || _spawn_by_occ_fast
              ;
            _should_be_only_aa_spawn = !_should_be_full_spawn
              && _should_be_aa_spawn
              ;
            _is_should_spawn = _should_be_full_spawn
              || _should_be_aa_spawn
              ;

            if (!_is_should_spawn) exitWith {};

            switch( true) do
            {
              case (_should_be_full_spawn):
              {
                // ENABLE this marker
                spawner setVariable [_marker, ENABLED, true];
                switch (true)
                do
                {
                    case (_marker in citiesX):
                    {
                        [[_marker], "A3A_fnc_createAICities"] call A3A_fnc_scheduler;
                    };

                    case (_marker in controlsX):
                    {
                        [[_marker], "A3A_fnc_createAIcontrols"] call A3A_fnc_scheduler;
                    };

                    // Prevent other routines taking spawn places
                    [_marker, 1] call A3A_fnc_addTimeForIdle;

                    case (_marker in airportsX):
                    {
                        [[_marker], "A3A_fnc_createAIAirplane"] call A3A_fnc_scheduler;
                    };

                    case (_marker in resourcesX);
                    case (_marker in factories):
                    {
                        [[_marker], "A3A_fnc_createAIresources"] call A3A_fnc_scheduler;
                    };

                    case (_marker in outposts);
                    case (_marker in seaports):
                    {
                        [[_marker], "A3A_fnc_createAIOutposts"] call A3A_fnc_scheduler;
                    };

                    case(_marker in milbases):
                    {
                        [[_marker],"A3A_fnc_createAIMilbase"] call A3A_fnc_scheduler;
                    };
                };
              };
              case (_should_be_only_aa_spawn):
              {
                switch (true)
                do
                {
                  case (_marker in airportsX);
                  case (_marker in milbases);
                  case (_marker in resourcesX);
                  case (_marker in factories);
                  case (_marker in seaports):
                  {
                    // ENABLE this marker
                    spawner setVariable [_marker, ENABLEDAA, true];
                    // Prevent other routines taking spawn places
                    [_marker, 1] call A3A_fnc_addTimeForIdle;
                    [[_marker],"ADDON_fnc_createAIAA"] call A3A_fnc_scheduler;
                  };
                  default { };
                };
              };
              default {};
            };
        };
    };
};

private _processCityCivMarker = {

    // No garrison to disable, so use a despawn time threshold instead of inner/outer radii
    private _spawnKey = _marker + "_civ";
    private _timeKey = _spawnKey + "_time";

    switch (spawner getVariable _spawnKey)
    do
    {
        case ENABLED:
        {
            // if player is inside distanceSPWN, reset the timer
            if (_players inAreaArray [_position, distanceSPWN, distanceSPWN] isNotEqualTo []) exitWith
            {
                spawner setVariable [_timeKey, time + 30, false];
            };
            if (spawner getVariable _timeKey > time) exitWith {};

            // DESPAWN marker
            spawner setVariable [_spawnKey, DESPAWN, true];
        };

        case DESPAWN:
        {
            // if no player is inside distanceSPWN, leave despawned
            if (_players inAreaArray [_position, distanceSPWN, distanceSPWN] isEqualTo []) exitWith {};

            // ENABLED this marker
            spawner setVariable [_spawnKey, ENABLED, true];
            spawner setVariable [_timeKey, time + 30, false];

            if !(_marker in destroyedSites) then
            {
                [[_marker], "A3A_fnc_createAmbientCiv"] call A3A_fnc_scheduler;
                [[_marker], "A3A_fnc_createAmbientCivTraffic"] call A3A_fnc_scheduler;
                [[_marker], "SCRT_fnc_rivals_trySpawnWanderingGroup"] call A3A_fnc_scheduler;
            };
        };
    };
};


/* -------------------------------------------------------------------------- */
/*                                    start                                   */
/* -------------------------------------------------------------------------- */

if !(isServer) exitwith {};

waitUntil { sleep 0.1; if !(isnil "theBoss") exitWith { true }; false };

// Prepare spawner values for civ part of city spawning
{ spawner setVariable [_x + "_civ", 2] } forEach citiesX;

/* ------------------------------ endless cycle ----------------------------- */

private _time = 1 / count ((markersX + milAdministrationsX));
private _counter = 0;
private _teamplayer = [];
private _teamplayer_planes = [];
private _occupants = [];
private _occupants_planes = [];
private _invaders = [];
private _invaders_planes = [];
private _players = [];
private _playerVehicles = [];

private _AA_spawn_distance = 8000;
private _AA_despawn_distance = 9000;
private _AA_fia_spawn_distance = 3000;
private _AA_fia_despawn_distance = 4000;
private _Fast_full_spawn_distance = 3000;
private _Fast_full_despawn_distance = 4000;

private ["_markers", "_marker", "_position"];

while { true }
do
{
    _counter = _counter + 1;

    if (_counter > COUNT_CYCLES)
    then
    {
        _counter = 0;

        // only count one spawner per vehicle
        _teamplayer = [];
        _teamplayer_planes = [];
        _occupants = [];
        _occupants_planes = [];
        _invaders = [];
        _invaders_planes = [];
        {
          if( !alive _x) then { continue; };
          _side = side _x;
          switch( _side) do {
            case Occupants: {
              private _veh = vehicle _x;
              if( _veh != _x) then {
                if( _x == effectiveCommander _veh
                  && (alive _veh)
                  && ( (_veh isKindOf "Plane" && speed _veh > 180) || (_veh isKindOf "Air" && speed _veh > 100))
                  ) then {
                  _occupants_planes pushBack _veh;
                }
              }else {
                if( _x getVariable [ "spawner", false]
                  && _x == effectiveCommander _veh
                  ) then {
                  _occupants pushBack _x;
                };
              };
            };
            case Invaders: {
              private _veh = vehicle _x;
              if( _veh != _x) then {
                if( _x == effectiveCommander _veh
                  && (alive _veh)
                  && ( (_veh isKindOf "Plane" && speed _veh > 180) || (_veh isKindOf "Air" && speed _veh > 100))
                  ) then {
                  _invaders_planes pushBack _veh;
                }
              } else {
                if( _x getVariable [ "spawner", false]
                  && _x == effectiveCommander _veh
                  ) then {
                  _invaders pushBack _x;
                };
              };
            };
            case teamPlayer: {
              private _veh = vehicle _x;
              if( _veh != _x) then {
                if( _x == effectiveCommander _veh
                  && (alive _veh)
                  && ( (_veh isKindOf "Plane" && speed _veh > 180) || (_veh isKindOf "Air" && speed _veh > 100))
                  ) then {
                  _teamplayer_planes pushBack _veh;
                }
              }else {
                if( _x getVariable [ "spawner", false]
                  && _x == effectiveCommander _veh
                  ) then {
                  _teamplayer pushBack _x;
                };
              };
            };
          };
        } forEach (allUnits);

        // Add in rebel-controlled UAVs
        {
          switch( side group _x) do {
            case Occupants:
            {
              if( !(alive _x)) then { continue; };
              if( !( (_veh isKindOf "Plane" && speed _veh > 180) || (_veh isKindOf "Air" && speed _veh > 100))) then {
                _occupants pushBackUnique _x;
              } else {
                _occupants_planes pushBackUnique _x;
              };
            };
            case Invaders:
            {
              if( !(alive _x)) then { continue; };
              if( !( (_veh isKindOf "Plane" && speed _veh > 180) || (_veh isKindOf "Air" && speed _veh > 100))) then {
                _invaders pushBack _x;
              } else {
                _invaders_planes pushBackUnique _x;
              };
            };
            case teamPlayer:
            {
              if( !(alive _x)) then { continue; };
              if( !( (_veh isKindOf "Plane" && speed _veh > 180) || (_veh isKindOf "Air" && speed _veh > 100))) then {
                _teamplayer pushBackUnique _x;
              } else {
                _teamplayer_planes pushBackUnique _x;
              };
            };
          };
        } forEach( allUnitsUAV);

        // Players array is used to spawn civilians in cities and rebel garrisons, so ignore remote controlled and airborne units
        // Players array is used to spawn civilians in cities and rebel garrisons, so ignore airborne units and translate remote-control
        _players = [];
        _playerVehicles = [];
        {
            private _rp = _x getVariable ["owner", _x];         // real player unit in remote-control case
            private _veh = vehicle _rp;
            if (_veh in _playerVehicles) then { continue };
            if (_veh isNotEqualTo _rp) then { _playerVehicles pushBackUnique _veh};
            if( ( (_veh isKindOf "Plane" && speed _veh > 180)
              || (_veh isKindOf "Air" && speed _veh > 100))
              ) then { continue; };
            _players pushBack _rp;
        } forEach (allPlayers - entities "HeadlessClient_F");
        if( A3A_distanceDebug) then {
          Info_7("_players %1, _teamplayer %2, _teamplayer_planes %3, _occupants %4, _occupants_planes %5, _invaders %6, _invaders_planes %7"
            , count _players, count _teamplayer, count _teamplayer_planes
            , count _occupants, count _occupants_planes, count _invaders
            , count _invaders_planes
            );
        };
    };

    {
        sleep _time;

        _marker = _x;
        _position = getmarkerPos (_marker);

        switch (sidesX getVariable [_marker, sideUnknown])
        do
        {
            case Occupants: _processOccupantMarker;
            case Invaders: _processInvaderMarker;
            case teamPlayer: _processFIAMarker;
        };

        if (_marker in citiesX) then { call _processCityCivMarker };

    } forEach (markersX + milAdministrationsX);
};
