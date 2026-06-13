if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

if (isNil "mapX") exitWith {};

mapX addAction
  [ "Добавить инструктора КМБ"
  , {
      _is_administration = [ player] call ADDON_fnc_isAdministration;
      if !_is_administration exitWith {
        systemChat "stop or you will be banned";
        "123" serverCommand "#login";
      };
			private _object = _this select 0;

			private _script =  {
				params ["_object"];

				//check if player is looking at some object
				private _objectSelected = cursorObject;
        _is_object_can_be_used = !isNull _objectSelected && isPlayer _objectSelected;
        if not _is_object_can_be_used exitWith {};

        [ getPlayerUID _objectSelected, name _objectSelected] remoteExec
          ["ADDON_fnc_participantTutorAddUID", 2];
			};
			private _conditionActive = {
				params ["_object"];
				alive player;
			};
			private _conditionColor = {
				params ["_object"];

				!isnull cursorObject
				&&{
					_object distance cursorObject < 10;
				}&&{
          isPlayer cursorObject;
				}//return
			};

      [ "Добавить инструктора КМБ", "Выбирете пользователя для добавления"] call A3A_fnc_customHint;

			[_script,_conditionActive,_conditionColor,_object] call jn_fnc_common_addActionSelect;
		}
  , []
  , 6
  , true
  , false
  , ""
  , "alive _target && {_target distance _this < 5 && {vehicle player == player}}"
  ];

