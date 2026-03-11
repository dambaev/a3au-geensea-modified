private _man=_this select 0;
private _range=_this select 1;
private _targets=_man targets[TRUE,_range];
private _out=[];
private _target=objNull;
private _man_side = side _man;
{
_target=vehicle _x;
_target_side = side _target;
if(!(_target isKindOf "MAN") && (_target_side getFriend _man_side < 0.6))then{
        if(isTouchingGround _target)then{
                _out pushBackUnique _target;
        };
};
}forEach _targets;
_out;



