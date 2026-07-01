if( isServer || !hasInterface) exitWith {};

params ["_taskId", "_description"];

_description params [ "_textRaw", "_taskTitleRaw", "_mrkDest"];

_recursive_localize_format = {
  params [ "_arr"];
  private _ret = [];
  {
    _localized = _x;
    switch (true) do
    {
      case (_localized isEqualType []):
      {
        _localized = [_x] call _recursive_localize_format;
      };
      case (_localized isEqualType "string"):
      {
        switch(true) do
        {
          case( (_x select [0,9]) == "STR_CITY_"):
          {
            _x_sz = count _x;
            _marker = _x select [ 9, _x_sz - 9];
            _localized = text (nearestLocation [getMarkerPos _marker, "NameCity"]);
          };
          case( (_x select [0,4]) == "STR_"):
          {
            _localized = localize _x;
          };
        };
      };
    };
    _ret pushBack _localized;
  } forEach( _arr);
  format _ret;
};

_textX = _textRaw;
if( _textRaw isEqualType []) then {
  _textX = [_textRaw] call _recursive_localize_format;
};

_taskTitle = _taskTitleRaw;
if( _taskTitleRaw isEqualType []) then {
  _taskTitle = [_taskTitleRaw] call _recursive_localize_format;
};


systemChat ( str [ _textRaw, _taskTitleRaw] );
systemChat ( str [ _taskId, [_textX,_taskTitle,_mrkDest] ] );
[ _taskId,
  [_textX,_taskTitle,_mrkDest]
  ] call BIS_fnc_taskSetDescription;

