/*
Author: Barbolani, Wurzel, Jaj22, Michael Phillips, Caleb Serafin
Attempts to sell the vehicle the player is looking at.
Vehicle cannot be sold if owned by another player.

Arguments:
    <OBJECT> Player who is trying to sell a vehicle.
    <OBJECT> cursorObject of the player.

Return Value:
<NIL> nil

Scope: Server/HC, All calls need to be executed on one machine, using an HC is also possible.
Environment: Unscheduled, is used to sell vehicles, execution cannot be stacked and exploited.
Public: No
Dependencies:
<STRING> ownerX found on vehicles, contains UID of player who bought it.
<ARRAY> Template vehicle arrays, see costs = call {}.

Example:
// From a button control:
action = "if (player == theBoss) then {closeDialog 0; nul = [player,cursorObject] remoteExecCall [""A3A_fnc_sellVehicle"",2]} else {["localize "STR_A3A_Base_sellVehicle_header"", ""Only the Commander can sell vehicles.""] call A3A_fnc_customHint;};";

// Testing spam:
for "_i" from 1 to 1000 do {
    [player,cursorObject] remoteExecCall ["A3A_fnc_sellVehicle",2];
};

*/
params [
    ["_player",objNull,[objNull]],
    ["_veh",objNull,[objNull]]
];
#include "\x\A3A\addons\core\script_component.hpp"
FIX_LINE_NUMBERS()

if( !isServer || hasInterface) exitWith {
  [ _player, _veh] remoteExec [ "A3A_fnc_sellVehicle", 2];
};


#define OccAndInv(VAR) (FactionGet(occ, VAR) + FactionGet(inv, VAR))

/*
Blacklisted Assets

The array below contains classnames of assets which are not allowed to be sold within Antistasi.
Reason for this is that those items are one or more of the following:
- can be aquired by means that don't cost anything and the ability to sell those would be an infinite money exploit.
- are no proper "statics" in terms of weaponized statics but for example the ACE spotting scoped
- something else
*/
_blacklistedAssets = [
"ACE_I_SpottingScope","ACE_O_SpottingScope","ACE_O_T_SpottingScope","ACE_B_SpottingScope","ACE_B_T_SpottingScope","ACE_SpottingScopeObject",
"O_Static_Designator_02_F","B_Static_Designator_01_F","B_W_Static_Designator_01_F",
"vn_o_nva_spiderhole_01","vn_o_nva_spiderhole_02","vn_o_nva_spiderhole_03",
"vn_o_pl_spiderhole_01","vn_o_pl_spiderhole_02","vn_o_pl_spiderhole_03",
"vn_o_vc_spiderhole_01","vn_o_vc_spiderhole_02","vn_o_vc_spiderhole_03"];

if (isNull _player) exitWith { Error("_player is null.") };
if (isNull _veh) exitWith {
    [localize "STR_A3A_Base_sellVehicle_header", localize "STR_A3A_reinf_airstrike_not_looking_at_veh"] remoteExecCall ["SCRT_fnc_misc_deniedHint",_player];
};

//private _nearestFriendlyAirfield = (airportsX select {sidesX getVariable _x == teamPlayer && {(getMarkerPos _x distance2D _veh) <= 50}});
private _nearAirfields = airportsX select {
    (sidesX getVariable [_x, sideUnknown] == teamPlayer) &&
    (getMarkerPos _x distance2D _veh <= 50)
};
private _isHQ = _veh distance (getMarkerPos "Synd_HQ") <= 50;
if (!_isHQ && _nearAirfields isEqualTo []) exitWith {

    [localize "STR_A3A_Base_sellVehicle_header", localize "STR_A3A_Base_sellVehicle_err0.1"] remoteExecCall ["SCRT_fnc_misc_deniedHint",_player];
};

if ({isPlayer _x} count crew _veh > 0) exitWith {
    [localize "STR_A3A_Base_sellVehicle_header", localize "STR_A3A_Base_sellVehicle_err1"] remoteExecCall ["SCRT_fnc_misc_deniedHint",_player];
};

_owner = _veh getVariable ["ownerX",""];
if !(_owner isEqualTo "" || {getPlayerUID _player isEqualTo _owner}) exitWith {  // Vehicle cannot be sold if owned by another player.
    [localize "STR_A3A_Base_sellVehicle_header", localize "STR_A3A_Base_sellVehicle_err2"] remoteExecCall ["SCRT_fnc_misc_deniedHint",_player];
};

if (_veh getVariable ["A3A_sellVehicle_inProgress",false]) exitWith {[localize "STR_A3A_Base_sellVehicle_header", localize "STR_A3A_Base_sellVehicle_err3"] remoteExecCall ["SCRT_fnc_misc_deniedHint",_player];};
_veh setVariable ["A3A_sellVehicle_inProgress",true,false];  // Only processed on the server. It is absolutely pointless trying to network this due to race conditions.

private _typeX = typeOf _veh;
if( not (isNil "A3A_fnc_sellVehicleDebug")) then {
  Error( "A3A_fnc_sellVehicleDebug: _typeX = " + str _typeX);
};
private _hr = 0;
private _costs = call {
    if (_typeX in _blacklistedAssets) exitWith {0};
    if (_veh isKindOf "StaticWeapon") exitWith {100};			// in case rebel static is same as enemy statics
    if (_typeX in (FactionGet(all,"vehiclesReb") + FactionGet(reb,"vehiclesCivCar") + FactionGet(reb,"vehiclesCivTruck"))) exitWith { ([_typeX] call A3A_fnc_vehiclePrice) / 2 };

    private _rebAa = FactionGet(reb, "vehiclesAA");
    if (_rebAa isNotEqualTo [] && {_typeX isEqualTo _rebAa}) exitWith {([_typeX] call A3A_fnc_vehiclePrice) / 2};

    if (
        (_typeX in arrayCivVeh)
        or (_typeX in civBoats)
        or (_typeX in (FactionGet(reb,"vehiclesCivBoat") + FactionGet(reb,"vehiclesCivCar") + FactionGet(reb,"vehiclesCivTruck")))
    ) exitWith {100};
    if (
        (_typeX in FactionGet(all,"vehiclesLight"))
        or (_typeX in OccAndInv("vehiclesTrucks"))
        or (_typeX in OccAndInv("vehiclesCargoTrucks"))
        or (_typeX in OccAndInv("vehiclesMilitiaTrucks"))
        or (_typeX in FactionGet(reb,"vehiclesTruck"))
    ) exitWith {750};
    if (
        (_typeX in FactionGet(all,"vehiclesBoats"))
        or (_typeX in FactionGet(all,"vehiclesLightAPCs"))
        or (_typeX in OccAndInv("vehiclesAmmoTrucks"))
        or (_typeX in OccAndInv("vehiclesRepairTrucks"))
        or (_typeX in OccAndInv("vehiclesFuelTrucks"))
        or (_typeX in OccAndInv("vehiclesMedical"))
    ) exitWith {1500};
    if (_typeX in [FactionGet(reb,"vehiclesCivHeli")]) exitWith {([_typeX] call A3A_fnc_vehiclePrice) / 2};
    if (_typeX in (FactionGet(all,"vehiclesHelisLight"))) exitWith {3000};
    if (
        (_typeX in FactionGet(all,"vehiclesAPCs"))
        || (_typeX in FactionGet(all,"vehiclesIFVs"))
        || (_typeX in FactionGet(all,"vehiclesHelisLightAttack"))
        || (_typeX in FactionGet(all,"vehiclesTransportAir"))
        || (_typeX in FactionGet(all,"vehiclesUAVs"))
    ) exitWith {2500};
    if (_typeX in FactionGet(all,"vehiclesLightTanks")) exitWith {3500};
    if (
        (_typeX in FactionGet(all,"vehiclesHelisAttack"))
        or (_typeX in FactionGet(all,"vehiclesTanks"))
        or (_typeX in FactionGet(all,"vehiclesAA"))
        or (_typeX in FactionGet(all,"vehiclesArtillery"))
    ) exitWith {6500};
    if (_typeX in (FactionGet(all,"vehiclesPlanesCAS") + FactionGet(all,"vehiclesPlanesAA") + FactionGet(all,"vehiclesPlanesLargeAA") + FactionGet(all,"vehiclesPlanesLargeCAS"))) exitWith {7500};
    if (_typeX in (FactionGet(all,"vehiclesPlanesGunship"))) exitWith {10000};

    _is_man = _veh isKindOf "Man";
    _is_alive = alive _veh;
    _loadout_side = (_veh getVariable ["unitType", ""]) select [0, count "loadouts_reb_"];
    _side = call {
      if( _loadout_side == "loadouts_occ_") exitWith { west; };
      if( _loadout_side == "loadouts_inv_") exitWith { east; };
      if( _loadout_side == "loadouts_reb_") exitWith { independent; };
      civilian;
    };
    _is_enemy = _side == west || _side == east;
    _is_danger = side _veh != civilian;
    _is_pow = _is_man && _is_alive && _is_enemy && not _is_danger;
    if( not (isNil "A3A_fnc_sellVehicleDebug")) then {
      Info( "A3A_fnc_sellVehicleDebug: _is_man = " + str _is_man);
      Info( "A3A_fnc_sellVehicleDebug: _is_alive = " + str _is_alive);
      Info( "A3A_fnc_sellVehicleDebug: _is_enemy = " + str _is_enemy);
      Info( "A3A_fnc_sellVehicleDebug: _loadout_side = " + str _loadout_side);
      Info( "A3A_fnc_sellVehicleDebug: _is_danger = " + str _is_danger);
      Info( "A3A_fnc_sellVehicleDebug: _is_pow = " + str _is_pow);
      Info( "A3A_fnc_sellVehicleDebug: _side = " + str _side);
    };
    if (_is_pow)  exitWith {
      _hr = 1;
      10000 * (1 + tierWar / 10);
    };
    0;
};

if (_costs == 0) exitWith {
    _veh setVariable ["A3A_sellVehicle_inProgress",false,false];
    [localize "STR_A3A_Base_sellVehicle_header", localize "STR_A3A_Base_sellVehicle_err4"] remoteExecCall ["SCRT_fnc_misc_deniedHint",_player];
};

_costs = round (_costs * (1-damage _veh));

if( _player == theBoss) then {
  [ _hr, _costs] call A3A_fnc_resourcesFIA;
} else {
  [ _costs / 2 ] remoteExec [ "A3A_fnc_resourcesPlayer", _player];
  [ _hr, _costs / 2] call A3A_fnc_resourcesFIA;
};

if (_veh in staticsToSave) then {staticsToSave = staticsToSave - [_veh]; publicVariable "staticsToSave"};

[_veh,true] call A3A_fnc_empty;

if (_veh isKindOf "StaticWeapon") then {deleteVehicle _veh};

[localize "STR_A3A_Base_sellVehicle_header", localize "STR_A3A_Base_sellVehicle_success"] remoteExecCall ["A3A_fnc_customHint",_player];
nil;
