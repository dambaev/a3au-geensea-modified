if !(isClass (missionConfigFile/"A3A")) exitWith {};//safeguard to block running on none antistasi missions

if (isNil "boxX") exitWith {};

ADDON_fnc_object_cargo_can_be_used = {
  params ["_object"];

  //check if player is looking at some object
  private _objectSelected = cursorObject;
  if(isnull _objectSelected) exitWith {
    hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR1";
    false;
  };

  //check if object is in range
  if(_object distance cursorObject > 50) exitWith {
    hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR2";
    false;
  };

  //check if object has inventory
  private _className = typeOf _objectSelected;
  private _tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
  private _tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
  private _tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
  if !(_tb > 0  || _tm > 0 || _tw > 0) exitWith{
    hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR3";
    false;
  };
  true;
};

ADDON_fnc_getItemCargo = {
  params [ "_object"];
  getItemCargo _object;
};
ADDON_fnc_getWeaponCargo = {
  params [ "_object"];
  getWeaponCargo _object;
};
ADDON_fnc_getMagazineCargo = {
  params [ "_object"];
  getMagazineCargo _object;
};
ADDON_fnc_getBackpackCargo = {
  params [ "_object"];
  getBackpackCargo _object;
};

ADDON_fnc_clearItemCargoGlobal = {
  params [ "_object"];
  clearItemCargoGlobal _object;
};
ADDON_fnc_clearWeaponCargoGlobal = {
  params [ "_object"];
  clearWeaponCargoGlobal _object;
};
ADDON_fnc_clearMagazineCargoGlobal = {
  params [ "_object"];
  clearMagazineCargoGlobal _object;
};
ADDON_fnc_clearBackpackCargoGlobal = {
  params [ "_object"];
  clearBackpackCargoGlobal _object;
};

ADDON_fnc_addItemCargoGlobal = {
  params [ "_object", "_item", "_count"];
  _object addItemCargoGlobal [_item, _count];
};
ADDON_fnc_addWeaponCargoGlobal = {
  params [ "_object", "_item", "_count"];
  _object addWeaponCargoGlobal [_item, _count];
};
ADDON_fnc_addMagazineCargoGlobal = {
  params [ "_object", "_item", "_count"];
  _object addMagazineCargoGlobal [_item, _count];
};
ADDON_fnc_addBackpackCargoGlobal = {
  params [ "_object", "_item", "_count"];
  _object addBackpackCargoGlobal [_item, _count];
};

ADDON_items_cargos =
  [ [ "items", ADDON_fnc_getItemCargo, ADDON_fnc_addItemCargoGlobal, ADDON_fnc_clearItemCargoGlobal]
  , [ "weapons", ADDON_fnc_getWeaponCargo, ADDON_fnc_addWeaponCargoGlobal, ADDON_fnc_clearWeaponCargoGlobal]
  , [ "magazine", ADDON_fnc_getMagazineCargo, ADDON_fnc_addMagazineCargoGlobal, ADDON_fnc_clearMagazineCargoGlobal]
  , [ "backpack", ADDON_fnc_getBackpackCargo, ADDON_fnc_addBackpackCargoGlobal, ADDON_fnc_clearBackpackCargoGlobal]
  ];

ADDON_fnc_store_object_cargo_in_object = {
  params [ "_src", "_dst"];
  _all_items_counts = [];
  {
    _class = _x select 0;
    _get_cargo = _x select 1;
    _add_item_to_cargo = _x select 2;
    _clear_cargo = _x select 3;

    _items_counts = [_src] call _get_cargo;
    _all_items_counts pushBack [_class, _items_counts];
  } forEach ( ADDON_items_cargos);
  _dst setVariable [ "ADDON_fnc_saveLoadVehicleArsenal", _all_items_counts];
  hint "cargo preset saved";
};

ADDON_fnc_set_object_cargo_from_object = {
  params [ "_dst", "_src"];
  _all_items_counts = _src getVariable [ "ADDON_fnc_saveLoadVehicleArsenal" , []];
  {
    _class = _x select 0;
    _items_counts = _x select 1;

    {
      _name = _x select 0;
      _get_cargo = _x select 1;
      _add_item_to_cargo = _x select 2;
      _clear_cargo = _x select 3;

      if !( _name == _class) then {
        continue;
      };

      [ _dst] call _clear_cargo;

      {
        _item_name = _x;
        _item_count = (_items_counts select 1) select _forEachIndex;

        [ _dst, _item_name, _item_count] call _add_item_to_cargo;

      } forEach ( _items_counts select 0);
    } forEach ( ADDON_items_cargos);

  } forEach ( _all_items_counts);
  hint "cargo preset loaded"
};

boxX addAction
  [ "save cargo preset"
  , {
			private _object = _this select 0;

			private _script =  {
				params ["_object"];

				//check if player is looking at some object
				private _objectSelected = cursorObject;
        _is_object_can_be_used = [ _object] call ADDON_fnc_object_cargo_can_be_used;
        if not _is_object_can_be_used exitWith {};

        // save arsenal
        [ _objectSelected, profileNamespace] call ADDON_fnc_store_object_cargo_in_object;
        saveProfileNamespace;
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
					//check if object has inventory
					private _className = typeOf cursorObject;
					private _tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
					private _tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
					private _tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
					if (_tb > 0  || _tm > 0 || _tw > 0) then {true;} else {false;};

				}//return
			};

      [localize "STR_A3AP_vehArsenal_header", localize "STR_A3AP_vehArsenal_desc"] call A3A_fnc_customHint;

			[_script,_conditionActive,_conditionColor,_object] call jn_fnc_common_addActionSelect;
		}
  , []
  , 6
  , true
  , false
  , ""
  , "alive _target && {_target distance _this < 5 && {vehicle player == player}}"
  ];

boxX addAction
  [ "load cargo from preset"
  , {
			private _object = _this select 0;

			private _script =  {
				params ["_object"];

				//check if player is looking at some object
				private _objectSelected = cursorObject;
        _is_object_can_be_used = [ _object] call ADDON_fnc_object_cargo_can_be_used;
        if not _is_object_can_be_used exitWith {};

        // save arsenal
        [ _objectSelected, profileNamespace] call ADDON_fnc_set_object_cargo_from_object;
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
					//check if object has inventory
					private _className = typeOf cursorObject;
					private _tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
					private _tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
					private _tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
					if (_tb > 0  || _tm > 0 || _tw > 0) then {true;} else {false;};

				}//return
			};

      [localize "STR_A3AP_vehArsenal_header", localize "STR_A3AP_vehArsenal_desc"] call A3A_fnc_customHint;

			[_script,_conditionActive,_conditionColor,_object] call jn_fnc_common_addActionSelect;
		}
  , []
  , 6
  , true
  , false
  , ""
  , "alive _target && {_target distance _this < 5 && {vehicle player == player}}"
  ];

