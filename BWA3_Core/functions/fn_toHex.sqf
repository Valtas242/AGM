/*
Author: commy2

Description:
Converts number to hexadecimal number

Arguments:
A number

Return Value:
A hexadecimal number, String
*/

private ["_number", "_sign", "_hex", "_rest"];

_number = _this;
_sign = if (_number < 0) then {"-"} else {""};

_number = round abs _number;
_hex = if (_number == 0) then {"0"} else {""};

while {_number > 0} do {
	_rest = _number mod 16;
	_rest = switch _rest do {
		case 10 : {"A"};
		case 11 : {"B"};
		case 12 : {"C"};
		case 13 : {"D"};
		case 14 : {"E"};
		case 15 : {"F"};
		default {str _rest};
	};
	_number = floor (_number / 16);

	_hex = _rest + _hex;
};
_sign + _hex