
_hc_selected = hcSelected player;

if (count _hc_selected != 1) exitWith {
  systemChat "THERE SHOULD BE EXACTLY 1 CONVOY TAIL";
};

_convoy_tail = _hc_selected select 0;

hcShowBar false;
hcShowBar true;
sleep 1;

systemChat "SELECT ONLY 1 CONVOY LEADER WITHIN 10 SECONDS";

_hc_selected = [];
_iterations = 0;
while { _iterations < 10 && count _hc_selected != 1} do {
  _iterations = _iterations + 1;
  sleep 1;

  _hc_selected = hcSelected player;
};

if (count _hc_selected != 1) exitWith {
  systemChat "THERE SHOULD BE EXACTLY 1 CONVOY LEADER";
};

_convoy_leader = _hc_selected select 0;

systemChat ("convoy leader: " + str _convoy_leader + ", convoy tail: " + str _convoy_tail);

[ _convoy_tail, _convoy_leader] remoteExec
  [ "ADDON_fnc_pl_moveInConvoy_connectTailToLeader"
  , 2
  ];
