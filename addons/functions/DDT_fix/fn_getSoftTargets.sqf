private _man=_this select 0;
private _range=_this select 1;
private _targets=_man targets[TRUE,_range];
private _out=[];
private _threshold=missionNamespace getVariable["ddtSoftThreshold",100];
private _man_side = side _man;
{
private _v=vehicle _x;
private _v_side = side _v;
if(( _man_side getFriend _v_side < 0.6) && _v isKindOf"MAN")then{_out pushBackUnique _v}else{
        if(( _man_side getFriend _v_side < 0.6) && isTouchingGround _v)then{
                if((getNumber(configFile>>"CfgVehicles">>(typeOf _v)>>"armor"))>_threshold)exitWith{};
                _out pushBackUnique _v;
        };
};
}forEach _targets;
_out;

