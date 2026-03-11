params [ "_group"];
if (isNil "DDT_fnc_getTargetsAT") exitWith {};//safeguard to block running on none DDT missions

_opfor_drones =
  [ "O_Crocus_AP_Bag"
  , "O_Crocus_AT_Bag"
  , "O_KVN_AP_Bag"
  , "O_KVN_AT_Bag"
  ];
_ind_drones =
  [ "I_Crocus_AP_Bag"
  , "I_Crocus_AT_Bag"
  , "I_KVN_AP_Bag"
  , "I_KVN_AT_Bag"
  ];
_bluefor_drones =
  [ "B_Crocus_AP_Bag"
  , "B_Crocus_AT_Bag"
  , "B_KVN_AP_Bag"
  , "B_KVN_AT_Bag"
  ];
_no_drones = true;
_no_vehicle = true;
_side = side _group;
_units_count = count (units _group);
_is_allowed = true;
_side_drones = switch (_side) do
  {
    case bluefor: { _bluefor_drones };
    case opfor: { _opfor_drones };
    default { _ind_drones };
  };
_chosen_unit = _group getVariable [ "_chosen_dron_operator", objNull];
if( isNull _chosen_unit) then {
  // checks
  _is_allowed = switch (_side) do
    { case civilian: {
        false
      };
    };
  if (_units_count < 4) then {
    _is_allowed = false;
  };
  if ( _is_allowed == false ) exitWith {
    // systemChat "not allowed";
  };

  _units_without_backpack = [];
  {
    _unit = _x;
    _unit_backpack = backpack _x;
    if (isPlayer _x) then {
      continue;
    };
    if (vehicle _x != _x) then {
      _vehicle = vehicle _x;
      _crew = crew _vehicle;
      if (_unit in _crew) then {
        _no_vehicle = false;
        continue;
      };
    };
    if ( _unit_backpack == "") then {
      _units_without_backpack pushBack _x;
      continue;
    };
    _is_drone = 0 < count (_side_drones select { _unit_backpack == _x; });
    if (_is_drone) then {
      _no_drones = false;
      continue;
    };
  } forEach (units _group);
  if( _no_drones == false) exitWith {
    // systemChat "units with drone exist";
  };
  if( _no_vehicle == false) exitWith {
    // systemChat "units with vehicle exist";
  };
  _units_without_backpack_sz = count _units_without_backpack;
  if (_units_without_backpack_sz < 1) exitWith {
    // systemChat "no units without backpacks";
  };
  _unit_idx = random (_units_without_backpack_sz - 1);
  _chosen_unit = (_units_without_backpack select _unit_idx);
  _group setVariable [ "_chosen_dron_operator", _chosen_unit];
};
_backpacks_sz = count _side_drones;
_drone_idx = random (_backpacks_sz - 1);
_chosen_drone = (_side_drones select _drone_idx);
if (alive _chosen_unit && backpack _chosen_unit == "") then {
  _chosen_unit addBackpack _chosen_drone;
};
[_chosen_unit, _chosen_drone];



