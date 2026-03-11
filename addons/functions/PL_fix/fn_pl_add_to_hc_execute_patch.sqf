if (isNil "pl_add_to_hc_execute") exitWith {};

pl_add_to_hc_execute = {
    params ["_group"];

    _group setVariable ["onTask", false];
    sleep 0.25;

    (hcLeader _group) hcRemoveGroup _group;
    player hcSetGroup [_group];
    [_group] spawn pl_set_up_ai;
    pl_add_group_to_hc = false;
};


