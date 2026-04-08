ADDON_fix_autoReloadUnitsIterationSleepSecs = 10;
ADDON_fix_autoReloadUnitsIterationsCount = 0;
ADDON_fix_autoReloadUnitsLoopContinue = true;
[] spawn {
  while {ADDON_fix_autoReloadUnitsLoopContinue} do {
    ADDON_fix_autoReloadUnitsIterationsCount =
      ADDON_fix_autoReloadUnitsIterationsCount + 1;

    call ADDON_fnc_autoReloadUnitsIteration;

    sleep ADDON_fix_autoReloadUnitsIterationSleepSecs;
  };
};


