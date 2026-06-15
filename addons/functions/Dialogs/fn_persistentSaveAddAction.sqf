mapX addAction
  [ "Постоянное сохранение"
  , {
      [] call ADDON_fnc_persistentSave;
		}
  , []
  , 6
  , true
  , false
  , ""
  , "alive _target && {_target distance _this < 5 && {vehicle player == player}}"
  ];

