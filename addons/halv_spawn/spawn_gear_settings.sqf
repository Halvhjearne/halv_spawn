/*
	spawn dialog misc settings
	By Halv
	
	General Note:
	I attempted to lock DLC items for players that does not have marksman cannot choose DLC items,
	but ...
	it is still best NOT to add any DLC items to this script
	as i cannot garentee that it will not pick those items
	when the player chooses a random gearset
*/

//UID's for lvl 1 gear
_level1UIDs = [];
//UID's for lvl 2 gear
_level2UIDs = [];
//this is to allow lvl 2 to use any lvl 1 gear, comment out to seperate the two
_level1UIDs = _level1UIDs + _level2UIDs;

_geararr = [
	[
//this is the array of secondary weapons the player can choose from, this has to be "weapon" type items
		[
			"hgun_ACPC2_F","ruger_pistol_epoch","1911_pistol_epoch","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F",
			"hgun_Pistol_Signal_F","Hatchet"//,"ChainSaw"
		],
//this is how many magazines is added for secondary weapon
		4
	], 
	[
//this is the array of primary weapons the player can choose from, this has to be "weapon" type items
		[
			"SMG_01_F","SMG_02_F","hgun_PDW2000_F","Rollins_F","speargun_epoch","m16_EPOCH","m16Red_EPOCH","AKM_EPOCH","sr25_epoch",
			"l85a2_epoch","l85a2_pink_epoch","l85a2_ugl_epoch"
		],
//this is how many magazines is added for primary weapon
		3
	],
	[
//this is the array for "tool" items the player can choose from, this has to be "item" type items
		[
			"FAK","FAK","Heal_EPOCH","Defib_EPOCH","Repair_EPOCH","MeleeSledge","Plunger"
		],
//this is how many "tool" items the player is allowed to choose
		2
	],
//this is the array of "weapon" items the player can choose from, this has to be "weapon" type items
	[
		[
			"EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9",
			"ItemCompass","ItemWatch","Binocular","ItemMap","NVG_EPOCH","ItemGPS"
		],
//this is how many "weapon" items the player is allowed to choose
		3
	],
	[
		[
//this is the array of "magazines" items the player can choose from, this has to be "magazine" type items
			"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","EnergyPack","SmokeShellOrange","SmokeShellBlue","SmokeShellPurple","SmokeShellYellow",
			"SmokeShellGreen","SmokeShellRed","SmokeShell","lighter_epoch","ItemSodaRbull","meatballs_epoch","WhiskeyNoodle","ItemSodaOrangeSherbet","sweetcorn_epoch",
			"scam_epoch","HeatPack","ColdPack","SheepCarcass_EPOCH","GoatCarcass_EPOCH","Pelt_EPOCH","ChickenCarcass_EPOCH","RabbitCarcass_EPOCH","Venom_EPOCH",
			"SnakeCarcass_EPOCH","ItemKiloHemp","ItemScraps","ItemCoolerE","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","FoodWalkNSons","honey_epoch",
			"emptyjar_epoch","FoodBioMeat","sardines_epoch","FoodSnooter","Towelette"
		],
//this is how many "magazines" items the player is allowed to choose
		4
	],
	[
//this is the array of headgear the player can choose from
		"H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH",
		"H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH",
		"H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH",
		"H_69_EPOCH","H_70_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH",
		"H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH",
		"H_92_EPOCH","H_11_EPOCH","H_28_EPOCH","H_34_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_104_EPOCH",
		"wolf_mask_epoch","pkin_mask_epoch"
	],
	[
//this is the array of vests the player can choose from
 		"V_1_EPOCH","V_2_EPOCH","V_3_EPOCH","V_4_EPOCH","V_5_EPOCH","V_6_EPOCH","V_13_EPOCH","V_14_EPOCH","V_15_EPOCH","V_16_EPOCH","V_17_EPOCH",
		"V_18_EPOCH","V_19_EPOCH","V_20_EPOCH","V_21_EPOCH","V_22_EPOCH","V_25_EPOCH","V_26_EPOCH","V_27_EPOCH","V_28_EPOCH","V_29_EPOCH","V_30_EPOCH",
		"V_31_EPOCH","V_32_EPOCH","V_36_EPOCH","V_40_EPOCH"
	],
	[
//these are the arrays for Uniforms the player can choose from
		[
//only male Uniforms here
			"U_O_CombatUniform_ocamo","U_B_Survival_Uniform",
			"U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_O_PilotCoveralls","U_C_Poor_1","U_C_WorkerCoveralls","U_C_Journalist","U_C_Scientist",
			"U_OrestesBody","U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon",
			"U_C_Poloshirt_redwhite","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader","U_C_Driver_1","U_C_Driver_2","U_C_Driver_3","U_C_Driver_4",
			"U_C_Driver_1_black","U_C_Driver_1_blue","U_C_Driver_1_green","U_C_Driver_1_red","U_C_Driver_1_white","U_C_Driver_1_yellow","U_C_Driver_1_orange",
			"U_C_Driver_1_red"
		],
		[
//only female Uniforms here
			"U_CamoRed_uniform","U_CamoBrn_uniform","U_CamoBlue_uniform","U_Camo_uniform",
			"U_Wetsuit_uniform","U_Wetsuit_White","U_Wetsuit_Blue","U_Wetsuit_Purp","U_Wetsuit_Camo"
		]
	],
	[
//this is the array of Goggles the player can choose from
		"G_Tactical_Clear","G_Shades_Black","G_Shades_Blue","G_Sport_Blackred","G_Spectacles","G_Spectacles_Tinted","G_Lowprofile","G_Shades_Green","G_Shades_Red",
		"G_Squares","G_Squares_Tinted","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Sport_Greenblack","G_Sport_Checkered","G_Sport_Red","G_Tactical_Black"
	],
	[
//this is the array of Backpacks the player can choose from
		"B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg",
		"smallbackpack_red_epoch","smallbackpack_green_epoch","smallbackpack_teal_epoch","smallbackpack_pink_epoch","B_Parachute"
	]
];

//Donor locked items

//if you want an item locked for lvl 1 donor, add it to this array
_lvl1items = [
	"U_O_CombatUniform_ocamo","B_Parachute","wolf_mask_epoch","pkin_mask_epoch","U_B_Survival_Uniform","EnergyPack","m16_EPOCH","AKM_EPOCH","ItemSodaPurple",
	"ItemSodaMocha","EpochRadio8","honey_epoch"
];

//if you want an item locked for lvl 2 donor, add it to this array
_lvl2items = [
	"NVG_EPOCH","l85a2_pink_epoch","m16Red_EPOCH","EpochRadio9"
];
