if (isNil "KMD_fnc_spawnGetOutVehicle") exitWith {};
if (not isServer) exitWith {};

ADDON_fnc_pl_moveInConvoy_iterations_count = 0;
ADDON_fnc_pl_moveInConvoy_iteration_delay = 5;
ADDON_fnc_pl_moveInConvoy_loop_continue = true;

ADDON_fnc_pl_moveInConvoy_leaders = [];

[] spawn {
  while {ADDON_fnc_pl_moveInConvoy_loop_continue} do {
    ADDON_fnc_pl_moveInConvoy_iterations_count =
      ADDON_fnc_pl_moveInConvoy_iterations_count + 1;

    call ADDON_fnc_pl_moveInConvoyIteration;

    sleep ADDON_fnc_pl_moveInConvoy_iteration_delay;
  };
};

