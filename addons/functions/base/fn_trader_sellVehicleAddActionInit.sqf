if( isServer || !hasInterface) exitWith {};

[] spawn {
  while { true } do {
    if( !isNil "traderX") then {
      if(traderX getVariabale [ "ADDON_fnc_trader_sellVehicleAddAction", -1 ] < 0) then {
        [ traderX] call ADDON_fnc_trader_sellVehicleAddAction;
      }
    };
    sleep 10;
  };
};
