params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

_name = "ADDON_fnc_autoReloadUnits_Fired";

(vehicle _unit) setVariable [ "ADDON_fnc_autoReloadUnits_needs_reammo", true];

