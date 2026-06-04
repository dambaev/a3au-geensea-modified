if( isServer || !hasInterface) exitWith {};

[] spawn {
  while { true } do {
    if( !isNil "traderX") then {
      if(traderX getVariable [ "ADDON_fnc_trader_sellVehicleAddAction", -1 ] < 0) then {
        [ traderX] call ADDON_fnc_trader_sellVehicleAddAction;
      }
    };
    if( !isNil "flagX") then {
      if(flagX getVariable [ "ADDON_fnc_flagaction_sellVehicleAddAction", -1 ] < 0) then {
        [ flagX] call ADDON_fnc_flagaction_sellVehicleAddAction;
      }
    };
    sleep 10;
  };
};
