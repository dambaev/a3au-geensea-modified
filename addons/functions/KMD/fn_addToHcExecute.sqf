/*
Original name: pl_add_to_hc_execute
New name:      KMD_fnc_addToHcExecute
Original url: "Plmod\pl_group_fnc.sqf"
*/
    params ["_group"];

    if( count pl_add_group_to_hc_selected < 1) then {
      _group setVariable ["onTask", false];
      sleep 0.25;

      (hcLeader _group) hcRemoveGroup _group;
      player hcSetGroup [_group];
      _group setVariable [ "ADDON_fnc_pl_moveInConvoy_leader", objNull];
      [_group] spawn KMD_fnc_setupAi;
    } else {
      {
        (hcLeader _x) hcRemoveGroup _x;
        (leader _group) hcSetGroup [_x];
        _x setVariable [ "ADDON_fnc_pl_moveInConvoy_leader", objNull];
      } forEach pl_add_group_to_hc_selected;
      pl_add_group_to_hc_selected = [];
    };
    pl_add_group_to_hc = false;

