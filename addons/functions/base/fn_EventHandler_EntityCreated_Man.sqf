#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()

params [ "_entity"];

if( isPlayer _entity) exitWith { };

_group_leader = leader group _entity;

if( leader group _entity == _entity) exitWith{ };

_leader_dist_sqr = _entity distanceSqr _group_leader;

if( _leader_dist_sqr < 500 * 500) exitWith {};

Info_4("cleaning up entity of group %1, group leader %1(isPlayer = %3), distanceSqr = %4"
      , str (group _entity)
      , name (_group_leader)
      , str (isPlayer _group_leader)
      , str _leader_dist_sqr
      );

deleteVehicle _entity;

