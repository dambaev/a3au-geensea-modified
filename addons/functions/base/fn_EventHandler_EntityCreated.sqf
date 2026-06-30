params [ "_entity"];

if ( _entity isKindOf "Man") then {
  [ _entity] call ADDON_fnc_EventHandler_EntityCreated_Man;
};
