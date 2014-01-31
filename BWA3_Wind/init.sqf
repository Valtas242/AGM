// BWA3 Realism - Wind Simulation
// (C) 2013 KoffeinFlummi. See LICENSE.


// Fired EH
BWA3_Wind_fnc_firedEH = {
  _unit = _this select 0;
  _weaponType = _this select 1;
  _ammoType = _this select 4;
  _round = _this select 6;

  if (!local _unit) exitwith {};
  if (!isPlayer _unit) exitwith {};
  if !(_unit == player) exitwith {};
  if (_round isKindOf "GrenadeHand") exitWith {};

  _coefficient = 1;
  if (_round isKindOf "GrenadeCore") then {
    _coefficient = 0.3;
  };
  _interval = 0.05;
  _oldtime = time;

  // HUMIDITY
  _humidity = (fogParams select 0 + rain) / 2;
  // CORIOLIS FORCE
  _latitude = abs getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
  _speed = cos _latitude * 456.1; // Eastward angular speed in m/s

  _velocity = velocity _round;
  _velocityX = _velocity select 0;
  _velocityY = _velocity select 1;
  _velocityZ = _velocity select 2;
  _velocityNewX = _velocityX - _velocityX * _humidity * 0.3;
  _velocityNewY = _velocityY - _velocityY * _humidity * 0.3;
  _velocityNewZ = _velocityZ - _velocityZ * _humidity * 0.3;
  _round setVelocity [_velocityNewX, _velocityNewY, _velocityNewZ];


  // WIND
  while {!isNull _round and alive _round} do {
    _windX = wind select 0;
    _windY = wind select 1;

    _velocity = velocity _round;
    _velocityX = _velocity select 0;
    _velocityY = _velocity select 1;
    _velocityZ = _velocity select 2;
    
    // Use actual time delay between iterations instead of set interval to account for ultra-low framerates.
    _newtime = time;
    _deltaTime = _newtime - _oldtime;

    _velocityNewX = _velocityX + _coefficient * _windX * _deltaTime;
    _velocityNewY = _velocityY + _coefficient * _windY * _deltaTime;

    _round setVelocity [_velocityNewX, _velocityNewY, _velocityZ];

    _oldtime = time;
    sleep _interval;
  };
  
};


// Wind Reading
0 spawn {
  while {true} do {
    waitUntil {inputAction "Compass" > 0 or inputAction "CompassToggle" > 0};
    _windStrength = sqrt((wind select 0) ^ 2 + (wind select 1) ^ 2);
    _windOrigin = (windDir + 180) % 360;
    _strengthString = "";
    _colorString = "";
    _originString = "";

    switch true do {
      case (_windStrength <= 0.5) : {_strengthString = "No measurable"; _colorString = "FFFFFF";};
      case (_windStrength <= 3) :   {_strengthString = "Very light"; _colorString = "CCFFFF";};
      case (_windStrength <= 5) :   {_strengthString = "Light"; _colorString = "99FF99";};
      case (_windStrength <= 7) :   {_strengthString = "Moderate"; _colorString = "99FF00";};
      default                       {_strengthString = "Strong"; _colorString = "FF6600";};
    };

    _originString = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"] select (round ((_windOrigin % 360) / 45) % 8);

    if (_windStrength <= 0.5) then {
      hintSilent "No measurable wind";
    } else {
      hintSilent parseText format["<t color='#%1'>%2</t> wind from the %3", _colorString, _strengthString, _originString];
    };

    sleep 0.05;
    hint "";
  };
};