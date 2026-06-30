/*
Original name: pl_add_to_hc
New name:      KMD_fnc_addToHc
Original url: "Plmod\pl_group_fnc.sqf"
*/
    pl_add_group_to_hc_selected = [];

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

