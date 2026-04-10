
params [ "_vehicle"];
getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "attendant") > 0;
