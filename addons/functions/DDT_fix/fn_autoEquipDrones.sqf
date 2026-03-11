if (isNil "DDT_fnc_getTargetsAT") exitWith {};//safeguard to block running on none DDT missions

ADDON_fix_autoEqipDronesIterationsCount = 0;
ADDON_fix_autoEqipDronesLoopContinue = true;
[] spawn {
  while {ADDON_fix_autoEqipDronesLoopContinue} do {
    ADDON_fix_autoEqipDronesIterationsCount = ADDON_fix_autoEqipDronesIterationsCount + 1;
    call ADDON_fnc_autoEquipDronesIteration;
    sleep 60;
  };
};



