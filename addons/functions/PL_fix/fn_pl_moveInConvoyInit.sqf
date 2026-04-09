if (isNil "pl_spawn_getOut_vehicle") exitWith {};
if (not isServer) exitWith {};

ADDON_fnc_pl_moveInConvoy_iterations_count = 0;
ADDON_fnc_pl_moveInConvoy_iteration_delay = 1;
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

