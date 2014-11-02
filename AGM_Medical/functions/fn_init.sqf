/*
Author: KoffeinFlummi

Do I really need to explain what this does?!
*/

_this spawn {
  _unit = _this select 0;

  sleep 1;
  if !(local _unit) exitWith {};

  if (_unit == call AGM_Core_fnc_player) then {
    _unit setVariable ["tf_globalVolume", 1];
    _unit setVariable ["tf_voiceVolume", 1, True];
    _unit setVariable ["tf_unable_to_use_radio", False, True];

    _unit setVariable ["acre_sys_core_isDisabled", False, True];
    _unit setVariable ["acre_sys_core_globalVolume", 1];
  };

  [_unit, "AGM_Unconscious", false] call AGM_Core_fnc_setCaptivityStatus;
  _unit setVariable ["AGM_isDiagnosed", False, True];   // Is the unit diagnosed?
  _unit setVariable ["AGM_canTreat", True, False];      // Can unit treat others?
  _unit setVariable ["AGM_isTreatable", True, True];    // Can unit be treated/diagnosed?
  _unit setVariable ["AGM_Blood", 1, True];             // Amount of blood in the body.
  _unit setVariable ["AGM_isBleeding", False, True];    // Is the unit losing blood? (Rate is determined by damage.)
  _unit setVariable ["AGM_Painkiller", 1, True];        // How much painkillers the guy is on. (smaller = more)
  _unit setVariable ["AGM_Pain", 0, True];              // Amount of pain the unit is in.
  _unit setVariable ["AGM_isUnconscious", False, True]; // figure it out
  _unit setVariable ["AGM_Unconscious", False, True];   // deprecated since v0.95
  _unit setVariable ["AGM_isOverdosing", False];
  _unit setVariable ["AGM_Transporting", objNull];

  [false] call AGM_Core_fnc_disableUserInput;

  _unit spawn {
    while {alive _this} do {
      [_this] call AGM_Medical_fnc_itemCheck;
      sleep 1;
    };
  };
};
