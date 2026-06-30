/*
Original name: pl_spawn_getOut_vehicle
New name:      KMD_fnc_spawnGetOutVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params [["_moveInConvoy", false]];
    if ( _moveInConvoy ) exitWith {
      [] spawn ADDON_fnc_pl_moveInConvoy;
    };
    playSound "beep";
    private _convoyArray = [];
    {
        if (vehicle (leader _x) != leader _x) then {
            _vic = vehicle (leader _x);
            _group = group (driver _vic);
            _convoyArray pushBack _group;
        };
    } forEach hcSelected player;

    _convoyArray = _convoyArray arrayIntersect _convoyArray;
    if (_moveInConvoy and ((count _convoyArray) < 2)) exitWith {

        (leader (hcSelected player select 0)) sidechat "Not enough Vehicle to form a Convoy";
    };
    _convoyId = str (random 2);
    c_test_id = _convoyId;
    missionNamespace setVariable [_convoyId, _convoyArray];
    missionNamespace setVariable [_convoyId + "pos", 0];
    missionNamespace setVariable [_convoyId + "time", 0];
    {
        [_x, _convoyId, _moveInConvoy] spawn KMD_fnc_getOutVehicle;
        // sleep 0.1;
    } forEach hcSelected player;
