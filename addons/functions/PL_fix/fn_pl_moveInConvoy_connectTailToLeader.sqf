params [ "_tail", "_leader"];

_tail_units = ((units _tail) select { alive _x});
_leader_units = ((units _leader) select { alive _x});

if( count _tail_units < 1 || count _leader_units < 1) exitWith {
  systemChat( "no alive units in _tail");
  false;
};
if( count _leader_units < 1) exitWith {
  systemChat( "no alive units in _leader");
  false;
};

_tail_unit = _tail_units select 0;
_leader_unit = _leader_units select 0;

_leader setVariable [ "ADDON_fnc_pl_moveInConvoy_tail", _tail];
_tail setVariable [ "ADDON_fnc_pl_moveInConvoy_leader", _leader];
_tail setVariable [ "ADDON_fnc_pl_moveInConvoy_leader_distanceSqr"
                  , _tail_unit distanceSqr _leader_unit
                  ];
_tail setVariable [ "ADDON_fnc_pl_moveInConvoy_original_leader"
                  , player
                  ];
(hcLeader _tail) hcRemoveGroup _tail;
(leader _leader) hcSetGroup [ _tail];

ADDON_fnc_pl_moveInConvoy_leaders = missionNamespace getVariable
  [ "ADDON_fnc_pl_moveInConvoy_leaders", []];
ADDON_fnc_pl_moveInConvoy_leaders pushBack _leader;
missionNamespace setVariable [ "ADDON_fnc_pl_moveInConvoy_leaders",
  ADDON_fnc_pl_moveInConvoy_leaders];
