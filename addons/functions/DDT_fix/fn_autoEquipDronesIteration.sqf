{
  //_drone_already_added = _x getVariable [ "_drone_already_added", false];
  //if( _drone_already_added) then {
  //  continue;
  //};
  [_x] call ADDON_fnc_autoEquipDronesGroup;
  _x setVariable [ "_drone_already_added", true];
} forEach allGroups;


