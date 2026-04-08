
params [ "_vehicle"];

_is_reammo_needed = false;
{
  _count = _x select 2;
  if( _count < 1) then {
    _is_reammo_needed = true;
  };
}forEach (magazinesAllTurrets _vehicle);
_is_reammo_needed;

