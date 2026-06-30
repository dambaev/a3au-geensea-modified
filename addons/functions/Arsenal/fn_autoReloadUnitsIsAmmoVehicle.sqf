
params [ "_vehicle"];
getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "transportAmmo") > 0;
