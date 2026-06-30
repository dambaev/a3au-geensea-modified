params [ "_old_tierWar"];

if( !isServer) exitWith {};

if (isNil {A3A_faction_occ}) then {
  waitUntil { sleep 1; !(isNil {A3A_faction_occ})};
};
if (isNil {A3A_faction_inv}) then {
  waitUntil { sleep 1; !(isNil {A3A_faction_inv})};
};

_tierWarIncreased = {
  params [ "_new_tierWar"];
  switch (_new_tierWar) do
  {
    case 1:
    {
      _vehiclesPlanesTransport = A3A_faction_occ get "vehiclesPlanesTransport";
      _vehiclesPlanesTransport = _vehiclesPlanesTransport - ["RHS_C130J"];
      _vehiclesPlanesTransport pushBackUnique "rhsgref_cdf_reg_Mi8amt";
      A3A_faction_occ set ["vehiclesPlanesTransport", _vehiclesPlanesTransport, false];

      _vehiclesPlanesTransport = A3A_faction_inv get "vehiclesPlanesTransport";
      _vehiclesPlanesTransport = _vehiclesPlanesTransport - ["RHS_C130J"];
      _vehiclesPlanesTransport pushBackUnique "RHS_CH_47F_10";
      A3A_faction_inv set ["vehiclesPlanesTransport", _vehiclesPlanesTransport, false];

      publicVariable "A3A_faction_occ";
      publicVariable "A3A_faction_inv";
    };
    case 7:
    {
      _aa_vehicles = A3A_faction_occ get "vehiclesAA";
      _aa_vehicles pushBackUnique "CUP_B_nM1097_AVENGER_AFU";
      _aa_vehicles pushBackUnique "CUP_B_M6LineBacker_AFU";
      A3A_faction_occ set ["vehiclesAA", _aa_vehicles, false];

      _tanks_vehicles = A3A_faction_occ get "vehiclesTanks";
      _tanks_vehicles pushBackUnique "CUP_B_Leopard_1A3GRNCROSS_UA";
      _tanks_vehicles pushBackUnique "CUP_B_Leopard2A6_UA";
      _tanks_vehicles pushBackUnique "CUP_B_M1A1_AFU";
      A3A_faction_occ set ["vehiclesTanks", _tanks_vehicles, false];

      _ifvs_vehicles = A3A_faction_occ get "vehiclesIFVs";
      _ifvs_vehicles pushBackUnique "CUP_B_M2Bradley_AFU";
      _ifvs_vehicles pushBackUnique "CUP_B_M2A3Bradley_AFU";
      A3A_faction_occ set ["vehiclesIFVs", _ifvs_vehicles, false];

      _apcs_vehicles = A3A_faction_occ get "vehiclesAPCs";
      _apcs_vehicles pushBackUnique "CUP_B_M2Bradley_AFU";
      _apcs_vehicles pushBackUnique "CUP_B_M2A3Bradley_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1240_M134_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1240_OGPK_M2_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1240_OGPK_Mk19_AFU";
      _apcs_vehicles pushBackUnique "M1240A1_OGPK_M2_AFU";
      _apcs_vehicles pushBackUnique "M1240A1_OGPK_M240_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1240A1_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1245_CROWS_M134_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1245_CROWS_M134_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1245_CROWS_M2_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1245_Unarmed_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1245_RearM240_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1277_M2_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1277_Mk19_AFU";
      _apcs_vehicles pushBackUnique "CUP_M1277_M134_AFU";
      A3A_faction_occ set ["vehiclesAPCs", _apcs_vehicles, false];
    };

    case 8:
    {
      _planesCAS_vehicles = A3A_faction_occ get "vehiclesPlanesCAS";
      _planesCAS_vehicles pushBackUnique "PRACS_F16CJR";
      A3A_faction_occ set ["vehiclesPlanesCAS", _planesCAS_vehicles, false];

      _planesAA_vehicles = A3A_faction_occ get "vehiclesPlanesAA";
      _planesAA_vehicles pushBackUnique "PRACS_F16CJ";
      A3A_faction_occ set ["vehiclesPlanesAA", _planesAA_vehicles, false];

      A3A_faction_occ set ["vehicleSam", "B_SAM_System_03_F", false];
      A3A_faction_occ set ["vehicleRadar", "B_Radar_System_01_F", false];

      _vehiclesPlanesTransport = A3A_faction_occ get "vehiclesPlanesTransport";
      _vehiclesPlanesTransport = _vehiclesPlanesTransport - ["rhsgref_cdf_reg_Mi8amt"];
      _vehiclesPlanesTransport pushBackUnique "RHS_C130J";
      A3A_faction_occ set ["vehiclesPlanesTransport", _vehiclesPlanesTransport, false];

      _vehiclesPlanesTransport = A3A_faction_inv get "vehiclesPlanesTransport";
      _vehiclesPlanesTransport = _vehiclesPlanesTransport - ["RHS_CH_47F_10"];
      _vehiclesPlanesTransport pushBackUnique "RHS_C130J";
      A3A_faction_inv set ["vehiclesPlanesTransport", _vehiclesPlanesTransport, false];

      publicVariable "A3A_faction_occ";
      publicVariable "A3A_faction_inv";
    };
    default {};
  };
};

_tierWarDecreased = {
  params [ "_new_tierWar"];
  switch (_new_tierWar) do
  {
    case 3:
    {
      _aa_vehicles = A3A_faction_occ get "vehiclesAA";
      _aa_vehicles = _aa_vehicles - [ "CUP_B_nM1097_AVENGER_AFU"];
      _aa_vehicles = _aa_vehicles - [ "CUP_B_M6LineBacker_AFU" ];
      A3A_faction_occ set ["vehiclesAA", _aa_vehicles, false];

      _tanks_vehicles = A3A_faction_occ get "vehiclesTanks";
      _tanks_vehicles = _tanks_vehicles - [ "CUP_B_Leopard_1A3GRNCROSS_UA"];
      _tanks_vehicles = _tanks_vehicles - [ "CUP_B_Leopard2A6_UA"];
      _tanks_vehicles = _tanks_vehicles - [ "CUP_B_M1A1_AFU"];
      A3A_faction_occ set ["vehiclesTanks", _tanks_vehicles, false];

      _ifvs_vehicles = A3A_faction_occ get "vehiclesIFVs";
      _ifvs_vehicles = _ifvs_vehicles - [ "CUP_B_M2Bradley_AFU"];
      _ifvs_vehicles = _ifvs_vehicles - [ "CUP_B_M2A3Bradley_AFU"];
      A3A_faction_occ set ["vehiclesIFVs", _ifvs_vehicles, false];

      _apcs_vehicles = A3A_faction_occ get "vehiclesAPCs";
      _apcs_vehicles = _apcs_vehicles - [ "CUP_B_M2Bradley_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_B_M2A3Bradley_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1240_M134_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1240_OGPK_M2_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1240_OGPK_Mk19_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "M1240A1_OGPK_M2_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "M1240A1_OGPK_M240_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1240A1_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1245_CROWS_M134_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1245_CROWS_M134_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1245_CROWS_M2_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1245_Unarmed_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1245_RearM240_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1277_M2_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1277_Mk19_AFU"];
      _apcs_vehicles = _apcs_vehicles - [ "CUP_M1277_M134_AFU"];
      A3A_faction_occ set ["vehiclesAPCs", _apcs_vehicles, false];
    };

    case 4:
    {
      _planesCAS_vehicles = A3A_faction_occ get "vehiclesPlanesCAS";
      _planesCAS_vehicles = _planesCAS_vehicles - [ "PRACS_F16CJR"];
      A3A_faction_occ set ["vehiclesPlanesCAS", _planesCAS_vehicles, false];

      _planesAA_vehicles = A3A_faction_occ get "vehiclesPlanesAA";
      _planesAA_vehicles = _planesAA_vehicles - [ "PRACS_F16CJ" ];
      A3A_faction_occ set ["vehiclesPlanesAA", _planesAA_vehicles, false];

      _vehiclesPlanesTransport = A3A_faction_occ get "vehiclesPlanesTransport";
      _vehiclesPlanesTransport = _vehiclesPlanesTransport - ["RHS_C130J"];
      _vehiclesPlanesTransport pushBackUnique "rhsgref_cdf_reg_Mi8amt";
      A3A_faction_occ set ["vehiclesPlanesTransport", _vehiclesPlanesTransport, false];

      _vehiclesPlanesTransport = A3A_faction_inv get "vehiclesPlanesTransport";
      _vehiclesPlanesTransport = _vehiclesPlanesTransport - ["RHS_C130J"];
      _vehiclesPlanesTransport pushBackUnique "RHS_CH_47F_10";
      A3A_faction_inv set ["vehiclesPlanesTransport", _vehiclesPlanesTransport, false];

      A3A_faction_occ set ["vehicleSam", "", false];
      A3A_faction_occ set ["vehicleRadar", "", false];

      publicVariable "A3A_faction_occ";
      publicVariable "A3A_faction_inv";
    };
    default {};
  };
};

switch (true) do
{
  case ( tierWar > _old_tierWar):
  {
    while { _old_tierWar <= tierWar} do {
      _old_tierWar = _old_tierWar + 1;
      [ _old_tierWar] call _tierWarIncreased;
    };
  };
  case (tierWar < _old_tierWar):
  {
    while { _old_tierWar >= tierWar} do {
      _old_tierWar = _old_tierWar - 1;
      [ _old_tierWar] call _tierWarDecreased;
    };
  };
  default {};
};
