#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()

if( !isServer) exitWith {};

if (isNil {tierWar}) then {
  waitUntil { sleep 1; !(isNil {tierWar})};
};

_old_tierWar = 0;

while {true} do
{
  if( _old_tierWar != tierWar) then {
    Info_2("detected tierWar change from %1 to %2", _old_tierWar, tierWar);
    [ _old_tierWar] call ADDON_fnc_tierWarChanged;
    _old_tierWar = tierWar;
  };
  sleep 20;
};
