ADDON_fnc_pl_moveInConvoyIterationPerLeader = {
  params [ "_leader"];
  if( isNull _leader) exitWith { false; };
  if( not alive (leader _leader)) exitWith { false; };
  _tail = _leader getVariable ["ADDON_fnc_pl_moveInConvoy_tail", objNull];
  if (isNull _tail) exitWith { false; };
  if (not alive (leader _tail)) exitWith { false; };
  _tail_leader = _tail getVariable ["ADDON_fnc_pl_moveInConvoy_leader", objNull];
  if( isNull _tail_leader || _tail_leader != _leader) exitWith { false; };

  _isStillLeader =
    [_tail, _leader] call ADDON_fnc_pl_moveInConvoy_ensureTailIsNotTooClose;
  if (not _isStillLeader) exitWith { _isStillLeader; };
  [_tail, _leader] call ADDON_fnc_pl_moveInConvoy_ensureTailHasNextWaypoint;
};

{
  _isStillLeader = [ _x ] call ADDON_fnc_pl_moveInConvoyIterationPerLeader;
  if( not _isStillLeader) then {
    _tail = _x getVariable [ "ADDON_fnc_pl_moveInConvoy_tail", objNull ];
    if (not isNull _tail) then {
      _original_leader = _tail getVariable
        [ "ADDON_fnc_pl_moveInConvoy_original_leader"
        , objNull
        ];
      if( not isNull _original_leader) then {
        (leader _x) hcRemoveGroup _tail;
        _original_leader hcSetGroup [ _tail];
      };
      _tail setVariable
        [ "ADDON_fnc_pl_moveInConvoy_original_leader"
        , objNull
        ];
      _tail setVariable
        [ "ADDON_fnc_pl_moveInConvoy_leader"
        , objNull
        ];
    };
     _x setVariable [ "ADDON_fnc_pl_moveInConvoy_tail", objNull ];
    ADDON_fnc_pl_moveInConvoy_leaders set [ _forEachIndex, objNull];
    systemChat (str _x + " removed from convoy leaders");
  };
} forEach ADDON_fnc_pl_moveInConvoy_leaders;

ADDON_fnc_pl_moveInConvoy_leaders = ADDON_fnc_pl_moveInConvoy_leaders - [objNull];

true;
