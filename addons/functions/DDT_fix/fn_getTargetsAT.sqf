private _man=_this select 0;
private _range=_this select 1;
private _targets=_man targets[TRUE,_range];
private _out=[];
private _out_man=[];
private _target=objNull;
private _man_side = side _man;
DDT_fnc_getTargetsAT_version = 3;

{
  _target=vehicle _x;
  _target_side = side _target;
  if(_target_side getFriend _man_side >= 0.6) then {
    continue;
  };
  if(_target isKindOf "MAN") then {
    _out_man pushBackUnique _target;
  } else {
    if (count (fullCrew _target) < 1) then {
      continue;
    };
    _crew = driver _target;
    if (isNull _crew) then {
      _crew = gunner _target;
    };
    if (isNull _crew) then {
      _crew = commander _target;
    };
    if (isNull _crew) then {
      continue;
    };
    if ((side _crew) getFriend _man_side >= 0.6) then {
      continue;
    };
    if (!(isTouchingGround _target))then{
      continue;
    };
    _out pushBackUnique _target;
  };
}forEach _targets;

if (count _out < 1) then {
  _out = _out_man;
};
_out;



