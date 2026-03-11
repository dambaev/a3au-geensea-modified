if (isNil "pl_add_to_hc_execute") exitWith {};

pl_add_group_to_hc_selected = [];


pl_add_to_hc = {
    if !(pl_add_group_to_hc) then {
        pl_add_group_to_hc = true;
        pl_add_group_to_hc_selected = hcSelected player;
        while {pl_add_group_to_hc} do {
            hintSilent "SELECT GROUP TO ADD";
            sleep 1;
        };
        hintSilent "";
    }
    else
    {
        pl_add_group_to_hc_selected = [];
        pl_add_group_to_hc = false;
    };
};

pl_add_to_hc_execute = {
    params ["_group"];

    if( count pl_add_group_to_hc_selected < 1) then {
      _group setVariable ["onTask", false];
      sleep 0.25;

      (hcLeader _group) hcRemoveGroup _group;
      player hcSetGroup [_group];
      [_group] spawn pl_set_up_ai;
    } else {
      {
        (hcLeader _x) hcRemoveGroup _x;
        (leader _group) hcSetGroup [_x];
      } forEach pl_add_group_to_hc_selected;
      pl_add_group_to_hc_selected = [];
    };
    pl_add_group_to_hc = false;
};


