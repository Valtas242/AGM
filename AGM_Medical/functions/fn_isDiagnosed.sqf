/*
 * Author: KoffeinFlummi
 *
 * Checks if a unit is diagnosed and if that's even necessary.
 *
 * Arguments:
 * 0: Unit to be treated.
 *
 * Return Value:
 * Is unit diagnosed? (Bool)
 */

private ["_unit"];

_unit = _this select 0;

if !((call AGM_Core_fnc_player) getVariable ["AGM_Medical_RequireDiagnosis", AGM_Medical_RequireDiagnosis > 0]) exitWith {true};
if !(_unit getVariable "AGM_isUnconscious") exitWith {true};

(_unit getVariable ["AGM_isDiagnosed", true])
