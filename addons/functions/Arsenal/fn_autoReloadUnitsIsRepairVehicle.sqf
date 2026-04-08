
params [ "_vehicle"];
getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "transportRepair") > 0;
