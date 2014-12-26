class CfgPatches {
	class AGM_NightVision {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.60;
		requiredAddons[] = {"AGM_Core"};
		version = "0.94.1";
		versionStr = "0.94.1";
		versionAr[] = {0,94,1};
		author[] = {"commy2", "KoffeinFlummi"};
		authorUrl = "https://github.com/commy2/";
	};
};

class CfgFunctions {
	class AGM_NightVision {
		class AGM_NightVision {
			file = "\AGM_nightvision\functions";
			class blending;
			class decreaseNVGBrightness;
			class increaseNVGBrightness;
		};
	};
};

class Extended_PostInit_EventHandlers {
	class AGM_NightVision {
		clientInit = "call compile preprocessFileLineNumbers '\AGM_nightvision\clientInit.sqf'";
	};
};

class Extended_Fired_EventHandlers {
	class AllVehicles {
		class AGM_NightVision_Blending {
			clientFired = "if (vehicle player == _this select 0) then {_this call AGM_NightVision_fnc_blending}";
		};
	};
};

class AGM_Core_Default_Keys {
	class increaseNVGBrightness {
		displayName = "$STR_AGM_NightVision_IncreaseNVGBrightness";
		condition = "true";
		statement = "[_vehicle] call AGM_NightVision_fnc_increaseNVGBrightness";
		key = 201;
		shift = 0;
		control = 0;
		alt = 1;
		allowHolding = 1;
	};
	
	class decreaseNVGBrightness {
		displayName = "$STR_AGM_NightVision_DecreaseNVGBrightness";
		condition = "true";
		statement = "[_vehicle] call AGM_NightVision_fnc_decreaseNVGBrightness";
		key = 209;
		shift = 0;
		control = 0;
		alt = 1;
		allowHolding = 1;
	};
};
