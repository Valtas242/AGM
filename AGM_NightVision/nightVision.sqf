//by commy2

while {true} do {
	AGM_NightVision_ppEffectNVGBrightness ppEffectEnable false;

	waitUntil {currentVisionMode player == 1};

	AGM_NightVision_ppEffectNVGBrightness ppEffectEnable true;

	while {currentVisionMode player == 1} do {
		// Detect if curator interface is open and disable effects
		if (!isNull(findDisplay 312)) then {
			AGM_NightVision_ppEffectNVGBrightness ppEffectEnable false;
			waitUntil {isNull(findDisplay 312)};
			AGM_NightVision_ppEffectNVGBrightness ppEffectEnable true;
		};
		sleep 0.1;
	};
};
