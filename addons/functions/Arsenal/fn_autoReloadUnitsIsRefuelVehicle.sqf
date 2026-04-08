
params [ "_vehicle"];
getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "transportFuel") > 0;
