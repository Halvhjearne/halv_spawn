
class Halv_spawn_dialog
{
	idd=7777;
	moveingenabled=false;
	class controls
	{
		class HALV_spawn_backtext: HALV_IGUIBack
		{
			idc = -1;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.840914 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.0219945 * safezoneH;
		};
		class HALV_spawn_frametext: HALV_RscFrame
		{
			idc = -1;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.840914 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.0219945 * safezoneH;
		};
		class HALV_spawn_back: HALV_IGUIBack
		{
			idc = -1;
			x = 0.180412 * safezoneW + safezoneX;
			y = 0.115097 * safezoneH + safezoneY;
			w = 0.628866 * safezoneW;
			h = 0.769807 * safezoneH;
		};
		class HALV_spawn_frame: HALV_RscFrame
		{
			idc = -1;
			text = "Spawn Menu by Halv";
			x = 0.180412 * safezoneW + safezoneX;
			y = 0.115097 * safezoneH + safezoneY;
			w = 0.628866 * safezoneW;
			h = 0.769807 * safezoneH;
		};
		class HALV_spawn_mapframe: HALV_RscFrame
		{
			idc = -1;
			x = 0.35567 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.438144 * safezoneW;
			h = 0.725818 * safezoneH;
		};
		class HALV_spawn_map: HALV_RscMapControl
		{
			idc = 7775;
			text = "";
			x = 0.35567 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.438144 * safezoneW;
			h = 0.725818 * safezoneH;
		};
		class HALV_spawn_listboxframe: HALV_RscFrame
		{
			idc = -1;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.18108 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.659834 * safezoneH;
		};
		class HALV_spawn_list: HALV_RscListBox
		{
			idc = 7776;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.18108 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.659834 * safezoneH;
			onLBSelChanged = "if(HALV_SELECTSPAWN)then{_this call Halv_moveMap}; false";
			onLBDblClick = "if(HALV_SELECTSPAWN)then{_this call Halv_spawn_player}else{_this call HALV_player_removelisteditem;}; false";
		};
		class HALV_spawn_haloframe: HALV_RscFrame
		{
			idc = -1;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.0773196 * safezoneW;
			h = 0.043989 * safezoneH;
		};
		class HALV_spawn_butframe: HALV_RscFrame
		{
			idc = -1;
			x = 0.273196 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.0824742 * safezoneW;
			h = 0.043989 * safezoneH;
		};
		class HALV_spawn_butselectspawn: HALV_RscCheckbox
		{
			idc = 7781;
			x = 0.273196 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.0824742 * safezoneW;
			h = 0.043989 * safezoneH;
//\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa
			strings[] = {"$STR_HALV_HALO"};
//\a3\soft_f_beta\Truck_01\Data\UI\Truck_01_covered_CA.paa
			checked_strings[] = {"$STR_HALV_GROUND"};
			onCheckBoxesSelChanged = "if(_this select 2 == 0)then{HALV_HALO = true;systemChat localize ""STR_HALV_HALO_SELECTED"";}else{HALV_HALO = false;systemChat localize ""STR_HALV_GROUND_SELECTED"";};false";
			tooltip = "$STR_HALV_PRESSSELECT_HALO_OR_GROUND";
			colorTextSelect[] = {0.6,0.298,0,1};
		};//102,51,0 - 0.4,0.2,0 //153,76,0 - 0.6,0.298,0
		class HALV_spawn_halocheck: HALV_RscCheckbox
		{
			idc = 7780;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.0773196 * safezoneW;
			h = 0.043989 * safezoneH;
			strings[] = {"$STR_HALV_SELECT_GEAR"};
			checked_strings[] = {"$STR_HALV_SELECT_SPAWN"};
			onCheckBoxesSelChanged = "_this call HALV_switch_spawngear;false";
			colorText[] = {0.8,0,0,0.8};
			tooltip = "$STR_HALV_SELECT_GEAR_OR_SPAWN";
		};
		class HALV_spawn_text: HALV_RscStructuredText
		{
			idc = -1;
			text = "$STR_HALV_TS3";
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.840914 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.0219945 * safezoneH;
		};

		class HALV_gear_list: HALV_CT_TREE
		{
			idc = 7779;
			x = 0.35567 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.438144 * safezoneW;
			h = 0.725818 * safezoneH;
			onTreeDblClick = "_this call Halv_ontreedoubleclick; false";
			onTreeSelChanged = "_this call Halv_ontreeselected; false";
		};
	};
};
