private _man=_this select 0;
private _range=_this select 1;
private _targets=_man targets[TRUE,_range];
private _out=[];
private _man_out=[];
private _threshold=missionNamespace getVariable["ddtSoftThreshold",100];
private _man_side = side _man;
DDT_fnc_getSoftTargets_version = 3;

{
  private _v=vehicle _x;
  private _v_side = side _v;
  if(_v_side getFriend _man_side >= 0.6) then {
    continue;
  };
  if(_target isKindOf "MAN") then {
    _out_man pushBackUnique _target;
  } else {
    if (not (isTouchingGround _v)) then {
      continue;
    };
    if ((getNumber(configFile>>"CfgVehicles">>(typeOf _v)>>"armor")) <= _threshold) then {
      continue;
    };
    _out pushBackUnique _v;
  };

}forEach _targets;

if (count _out < 1) then {
  _out = _out_man;
};
_out;

