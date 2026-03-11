if (isNil "DDT_fnc_getTargetsAT") exitWith {};//safeguard to block running on none DDT missions

ADDON_fix_autoEquipDronesIterationsCount = 0;
ADDON_fix_autoEquipDronesLoopContinue = true;
[] spawn {
  while {ADDON_fix_autoEquipDronesLoopContinue} do {
    ADDON_fix_autoEquipDronesIterationsCount = ADDON_fix_autoEquipDronesIterationsCount + 1;
    call ADDON_fnc_autoEquipDronesIteration;
    sleep 60;
  };
};



