if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

params [ "_flag"];

_flag addAction
  [ localize "STR_antistasi_dialogs_main_sell_vehicle"
  , {
			private _object = _this select 0;
      _is_member = player call A3A_fnc_isMember;
      if( !_is_member) exitWith {
        [ localize "STR_antistasi_dialogs_main_sell_vehicle"
          , localize "STR_A3A_OrgPlayers_membership_success_remove_target"
          ] call SCRT_fnc_misc_deniedHint;
      };

			private _script =  {
				params ["_object"];

				//check if player is looking at some object
				private _objectSelected = cursorObject;
        _is_commander = [ player] call ADDON_fnc_isEligibleCommander;
        _is_vehicle_from_garage = _objectSelected getVariable ["HR_GRG_fnc_confirmPlacement",false];
        _is_object_can_be_used = !isNull _objectSelected
          && _objectSelected isKindOf "AllVehicles"
          && ( !_is_vehicle_from_garage || _is_commander);
        if not _is_object_can_be_used exitWith {
          if (_is_vehicle_from_garage && !_is_commander) then {
            [ localize "STR_antistasi_dialogs_main_sell_vehicle"
              , localize "STR_HR_GRG_Feedback_sellVehicle_comOnly"
              ] call SCRT_fnc_misc_deniedHint;
          };
        };

        [ player, _objectSelected] remoteExec ["A3A_fnc_sellVehicle", 2];
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
          cursorObject isKindOf "AllVehicles";
				}//return
			};

      [ localize "STR_antistasi_dialogs_main_sell_vehicle"
        , localize "STR_HR_GRG_Feedback_addVehicle_Null"
        ] call A3A_fnc_customHint;

			[_script,_conditionActive,_conditionColor,_object] call jn_fnc_common_addActionSelect;
		}
  , []
  , 6
  , true
  , false
  , ""
  , "alive _target && {_target distance _this < 5 && {vehicle player == player}}"
  ];

