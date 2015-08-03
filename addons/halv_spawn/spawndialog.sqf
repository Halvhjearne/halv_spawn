/*
	spawndialog
	by Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

#include "spawn_gear_settings.sqf";
_scriptpath = _this select 0;
_rspawnw = getMarkerPos "respawn_west";
_HALV_Center = getMarkerPos "center";
// Makes the script start when player is ingame
waitUntil{!isNil "Epoch_my_GroupUID"};
waitUntil{!isNil "HALV_senddeftele"};

//exit if player is not near a spawn
if(player distance _rspawnw > 35)exitWith{Halv_moveMap = nil;Halv_fill_spawn = nil;Halv_near_cityname = nil;Halv_spawn_player = nil;Halv_spawns = nil;HALV_senddeftele = nil;HALV_HALO = nil;HALV_SELECTSPAWN = nil;HALV_fill_gear = nil;HALV_fnc_returnnameandpic = nil;HALV_fill_gear = nil;Halv_ontreedoubleclick = nil;Halv_ontreeselected = nil;HALV_GEAR_TOADD = nil;HALV_player_removelisteditem = nil;HALV_addiweaponwithammo = nil;HALV_fnc_halo = nil;HALV_playeraddcolours = nil;diag_log "Spawn Menu Aborted...";};
diag_log format["[halv_spawn] waiting for new teleports to be build in %1 ...",worldName];
{_x addAction [format["<img size='1.5'image='\a3\Ui_f\data\IGUI\Cfg\Actions\ico_cpt_start_on_ca.paa'/> <t color='#0096ff'>%1</t><t > </t><t color='#00CC00'>%2</t>",localize "STR_HALV_SCROLL_SELECT",localize "STR_HALV_SCROLL_SPAWN"],(_scriptpath+"opendialog.sqf"),_x, -9, true, true, "", "player distance _target < 5"];}forEach (HALV_senddeftele select 0);
diag_log format["[halv_spawn] addAction added to %1",HALV_senddeftele];
waitUntil {!dialog};

_diagTiackTime = diag_tickTime;
diag_log format["Loading Spawn Menu ... %1",_diagTiackTime];

_pregearcheck = profileNamespace getVariable ["HALVSPAWNLASTGEAR",[[],[],[],[],[],[],[],[],[],[]]];
if !(_pregearcheck isEqualTo [[],[],[],[],[],[],[],[],[],[]])then{
	_gchanged = false;
	_PID = getPlayerUID player;
	{
		_garray = _x;
		_serverarr = switch(_forEachIndex)do{
			case 0:{[(_geararr select 0)select 0,1]};
			case 1:{[(_geararr select 1)select 0,1]};
			case 2:{[(_geararr select 2)select 0,(_geararr select 2)select 1]};
			case 3:{[(_geararr select 3)select 0,(_geararr select 3)select 1]};
			case 4:{[(_geararr select 4)select 0,(_geararr select 4)select 1]};
			case 5:{[_geararr select 5,1]};
			case 6:{[_geararr select 6,1]};
			case 7:{[((_geararr select 7)select 0)+((_geararr select 7)select 1),1]};
			case 8:{[_geararr select 8,1]};
			case 9:{[_geararr select 9,1]};
		};
		{
			_item = _x;
//			diag_log str[_item,_serverarr,_garray];
			if (!(_x in (_serverarr select 0)) || _x in _lvl1items && !(_PID in _level1UIDs) || _x in _lvl2items && !(_PID in _level2UIDs))exitWith{
				_gchanged = true;
			};
		}forEach _garray;
		if (_gchanged || count _garray > (_serverarr select 1))exitWith{
			profileNamespace setVariable ["HALVSPAWNLASTGEAR",nil];
		};
	}forEach _pregearcheck;
};

#include "spawn_locations.sqf";

HALV_HALO = true;
HALV_GEAR_TOADD = [[],[],[],[],[],[],[],[],[],[]];

Halv_near_cityname = {
	_nearestCity = nearestLocations [_this, ["NameCityCapital","NameCity","NameVillage","NameLocal"],1000];
	_textCity = "Wilderness";
	if (count _nearestCity > 0) then {
		{if !(toLower(text _x) in ["military"])exitWith{_textCity = text _x};}count _nearestCity;
	};
	_textCity
};

//if(_spawnNearJammer)then{
if(false)then{
	{
		if((_x getVariable ["BUILD_OWNER", "-1"]) in [getPlayerUID player, Epoch_my_GroupUID])exitWith{//[getPlayerUID player, Epoch_my_GroupUID]
			_jamvar = getPos _x;
			diag_log format["[halv_spawn] found a player jammer @ %1",_jamvar];
			_name = _jamvar call Halv_near_cityname;
			Halv_spawns pushBack [_jamvar,6,format["%1 (%2)",_name,localize "STR_HALV_NEAR_JAMMER"]];
		}; 
	}forEach (_HALV_Center nearObjects ["PlotPole_EPOCH",_jamarea]);
};

if(_spawnNearGroup)then{
	_leader = leader(group player);
	if (count units(group player) > 1 && !(_leader isEqualTo player)) then{
		_grouppos = getPos _leader;
		_name = _grouppos call Halv_near_cityname;
		Halv_spawns pushBack [_grouppos,7,format["%1 (%2)",_name,localize "STR_HALV_NEAR_GROUP"]];
	};
};

if(_adddefaultspawns)then{
	{
		_pos = _x;
		Halv_spawns pushBack [_pos];
	}forEach (HALV_senddeftele select 1);
};

_string = "
	disableSerialization;
	_lb = _this select 0;
	_index = _this select 1;
	_value = _lb lbValue _index;
	_zoom = 1;
	_spawn = "+(str _HALV_Center)+";
	if !(_value in [-1,-2,-3]) then {
		_spawn = (Halv_spawns select _value)select 0;
		_zoom = .15;
	};
	_ctrl = (findDisplay 7777) displayCtrl 7775;
	ctrlMapAnimClear _ctrl;
	_ctrl ctrlMapAnimAdd [1,_zoom,_spawn];
	ctrlMapAnimCommit _ctrl;
";
Halv_moveMap = compile _string;

_string = "
	_ammo = [] + getArray (configFile >> 'cfgWeapons' >> _this >> 'magazines');
	if (count _ammo > 0) then {
		_ammoamount = if(_this in ("+(str((_geararr select 1) select 0))+"))then{"+(str((_geararr select 1) select 1))+"}else{"+(str((_geararr select 0) select 1))+"};
		for '_i' from 1 to _ammoamount do {
			_rnd = _ammo select 0;
			player addMagazine _rnd;
		};
	};
	player addWeapon _this;
	player selectWeapon _this;
	reload player;
";
HALV_addiweaponwithammo = compile _string;

HALV_fnc_halo = {
	waitUntil{animationState player == "halofreefall_non"};
	sleep 1;
	HALV_openchute = false;
	_action = player addAction [localize "STR_HALO_OPEN_CHUTE",{HALV_openchute = true;}];

	waitUntil{sleep 1;(HALV_openchute || !(alive player) || isTouchingGround player)};

	player removeAction _action;

	if !(HALV_openchute)exitWith{
		player setDammage 1;
		HALV_openchute = nil;
	};

	HALV_openchute = nil;

	private "_chute";

	_pos = getPosATL player;
	_pos set [2,(_pos select 2)+2];
	if (_pos select 2 < 10) then{
		_chute = createVehicle ["NonSteerable_Parachute_F", _pos, [], 0, "FLY"];
	}else{
		_chute = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
	};

	sleep 0.2;

	_chute setDir (getDir player);
	_chute setPosATL _pos;
	_chute disableCollisionWith player;
	player moveInDriver _chute;
	_chute setVelocity [0,0,0];
	waitUntil{vehicle player isEqualTo _chute};
	if (animationState player != "para_pilot") then{
		player switchMove "para_pilot";
	};

	waitUntil {isTouchingGround player || !alive player};

	if (!isNull _chute) then{
		_chute setVelocity [0,0,0];
		sleep 0.5;
		if ((vehicle player) isEqualTo _chute) then { moveOut player };
		sleep 1.5;
		deleteVehicle _chute;
	};
};

HALV_playeraddcolours = {
	_pcolor = profileNamespace getVariable ["HALV_BAGCOLOR",[]];
	if (!(_pcolor isEqualTo []) && !(Backpack player in ["","B_Parachute","B_O_Parachute_02_F","B_I_Parachute_02_F","B_B_Parachute_02_F"]))then{
		_bag = (unitBackpack player);
		if(count(getObjectTextures _bag) > 0)then{
			_defaultsides = [];
			{
				if (_x != "")then{
					_defaultsides pushBack [_forEachIndex,_x];
				};
			}forEach getObjectTextures _bag;
			{_bag setObjectTextureGlobal _x;}forEach _pcolor;
			_bag setVariable ["HALV_DEFAULTTEX",_defaultsides,true];
		}else{
			_txt = (gettext (configFile >> "cfgvehicles" >> (Backpack player) >> "displayName"));
			systemChat format["%1 could not be painted ...",_txt];
			diag_log format["%1 could not be painted ...",Backpack player];
		};
	};

	_pcolor = profileNamespace getVariable ["HALV_UNIFORMCOLOR",[]];
	if (!(_pcolor isEqualTo []) && !(Uniform player in ["","U_Test1_uniform","U_Test_uniform"]))then{
		if(count(getObjectTextures player) > 0)then{
			_defaultsides = [];
			{
				if (_x != "")then{
					_defaultsides pushBack [_forEachIndex,_x];
				};
			}forEach getObjectTextures player;
			{player setObjectTextureGlobal _x;}forEach _pcolor;
			player setVariable ["HALV_DEFAULTTEX",_defaultsides,true];
		}else{
			_txt = (gettext (configFile >> "cfgvehicles" >> (Uniform player) >> "displayName"));
			systemChat format["%1 could not be painted ...",_txt];
			diag_log format["%1 could not be painted ...",Uniform player];
		};
	};
};

Halv_spawn_player = {
	#include "spawn_settings.sqf";
	#include "spawn_gear_settings.sqf";
	disableSerialization;
	private ["_spawn","_cityname","_val"];
	_lb = _this select 0;
	_index = _this select 1;
	_value = _lb lbValue _index;
	if(_value isEqualTo -1)exitWith{};
	if(_value isEqualTo -2)exitWith{systemChat (localize "STR_HALV_CANTSPAWNNEARBODY")};
	if(_value isEqualTo -3)then{
		_spawn = (Halv_spawns call BIS_fnc_selectRandom) select 0;
		_val= 0 ;
		_cityname = _spawn call Halv_near_cityname;
	}else{
		_spawn = (Halv_spawns select _value)select 0;
		_val = if(count (Halv_spawns select _value) > 1)then{(Halv_spawns select _value)select 1}else{0};
		_cityname = if(count (Halv_spawns select _value) > 2)then{(Halv_spawns select _value)select 2}else{_spawn call Halv_near_cityname};
	};
	_pUID = getPlayerUID player;
	if(_val isEqualTo 1 && !(_pUID in _level1UIDs))exitWith{systemChat localize "STR_HALV_NEEDTOBEREG"};
	if(_val isEqualTo 2 && !(_pUID in _level2UIDs))exitWith{systemChat localize "STR_HALV_NEEDTOBEDONER"};
	closeDialog 0;
	if(_removedefault)then{
		removeAllWeapons player;removeAllItems player;removeAllAssignedItems player;
		{player removeMagazine _x;}count (magazines player);
		removeUniform player;removeVest player;removeBackpack player;removeGoggles player;removeHeadGear player;
	};
	if (!(HALV_GEAR_TOADD isEqualTo [[],[],[],[],[],[],[],[],[],[]]) && !(HALV_GEAR_TOADD isEqualTo (profileNamespace getVariable ["HALVSPAWNLASTGEAR",[[],[],[],[],[],[],[],[],[],[]]])))then{
		profileNamespace setVariable ["HALVSPAWNLASTGEAR",HALV_GEAR_TOADD];
	};
	diag_log str['HALV_GEAR_TOADD',HALV_GEAR_TOADD];
	if(_addgear)then{
		_addedgear = [[],[],[],[],[],[],[],[],[],[]];;
		if(count (HALV_GEAR_TOADD select 9) < 1)then{
			_item = (_geararr select 9) call BIS_fnc_selectRandom;
			player addbackpack _item;
			(_addedgear select 9) pushBack ['random',_item];
		}else{
			player addbackpack ((HALV_GEAR_TOADD select 9)select 0);
			(_addedgear select 9) pushBack ((HALV_GEAR_TOADD select 9)select 0);
		};

		if(count (HALV_GEAR_TOADD select 8) < 1)then{
			_item = (_geararr select 8) call BIS_fnc_selectRandom;
			player addgoggles _item;
			(_addedgear select 8) pushBack ['random',_item];
		}else{
			player addgoggles ((HALV_GEAR_TOADD select 8)select 0);
			(_addedgear select 8) pushBack ((HALV_GEAR_TOADD select 8)select 0);
		};
		_sel = if((typeOf player) == "Epoch_Female_F")then{1}else{0};
		if(count (HALV_GEAR_TOADD select 7) < 1)then{
			_item = ((_geararr select 7) select _sel) call BIS_fnc_selectRandom;
			player forceAddUniform _item;
			(_addedgear select 7) pushBack ['random',_item];
		}else{
			player forceAddUniform ((HALV_GEAR_TOADD select 7)select 0);
			(_addedgear select 7) pushBack ((HALV_GEAR_TOADD select 7)select 0);
		};

		if(count (HALV_GEAR_TOADD select 6) < 1)then{
			_item = (_geararr select 6) call BIS_fnc_selectRandom;
			player addVest _item;
			(_addedgear select 6) pushBack ['random',_item];
		}else{
			player addVest ((HALV_GEAR_TOADD select 6)select 0);
			(_addedgear select 6) pushBack ((HALV_GEAR_TOADD select 6)select 0);
		};

		if(count (HALV_GEAR_TOADD select 5) < 1)then{
			_item = (_geararr select 5) call BIS_fnc_selectRandom;
			player addheadgear _item;
			(_addedgear select 5) pushBack ['random',_item];
		}else{
			player addheadgear ((HALV_GEAR_TOADD select 5)select 0);
			(_addedgear select 5) pushBack ((HALV_GEAR_TOADD select 5)select 0);
		};

		if(count (HALV_GEAR_TOADD select 4) < (_geararr select 4) select 1)then{
			_missing = ((_geararr select 4) select 1) - (count (HALV_GEAR_TOADD select 4));
			for "_i" from 1 to _missing do {
				_item = ((_geararr select 4) select 0) call BIS_fnc_selectRandom;
				player addMagazine _item; 
				(_addedgear select 4) pushBack ['random',_item];
			};
			{player addMagazine _x;(_addedgear select 4) pushBack _x;}forEach (HALV_GEAR_TOADD select 4);
		}else{
			{player addMagazine _x;(_addedgear select 4) pushBack _x;}forEach (HALV_GEAR_TOADD select 4);
		};

		if(count (HALV_GEAR_TOADD select 3) < (_geararr select 3) select 1)then{
			_missing = ((_geararr select 3) select 1) - (count (HALV_GEAR_TOADD select 3));
			for "_i" from 1 to _missing do {
				_item = ((_geararr select 3) select 0) call BIS_fnc_selectRandom;
				_radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
				_hasradio = if((_item in _radios) && {_x in _radios}count((weapons player)+(assignedItems player)) > 0)then{true}else{false};
				if(_item in ((weapons player)+(assignedItems player)) || _hasradio)then{
					player addItem _item;
				}else{
					player addWeapon _item;
				};
				(_addedgear select 3) pushBack ['random',_item];
			};
			{
				_item = _x;
				_radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
				_hasradio = if((_item in _radios) && {_x in _radios}count((weapons player)+(assignedItems player)) > 0)then{true}else{false};
				if(_item in ((weapons player)+(assignedItems player)) || _hasradio)then{
					player addItem _item;
					(_addedgear select 3) pushBack ['addItem',_item];
				}else{
					player addWeapon _item;
					(_addedgear select 3) pushBack ['addWeapon',_item];
				};
			}forEach (HALV_GEAR_TOADD select 3);
		}else{
			{
				_item = _x;
				_radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
				_hasradio = if((_item in _radios) && {_x in _radios}count((weapons player)+(assignedItems player)) > 0)then{true}else{false};
				if(_item in ((weapons player)+(assignedItems player)) || _hasradio)then{
					player addItem _item;
					(_addedgear select 3) pushBack ['addItem',_item];
				}else{
					player addWeapon _item;
					(_addedgear select 3) pushBack ['addWeapon',_item];
				};
			}forEach (HALV_GEAR_TOADD select 3);
			
		};

		if(count (HALV_GEAR_TOADD select 2) < (_geararr select 2) select 1)then{
			_missing = ((_geararr select 2) select 1) - (count (HALV_GEAR_TOADD select 2));
			for "_i" from 1 to _missing do {
				_item = ((_geararr select 2) select 0) call BIS_fnc_selectRandom;
				player addItem _item;
				(_addedgear select 2) pushBack ['random',_item];
			};
			{player addItem _x;(_addedgear select 2) pushBack _x;}forEach (HALV_GEAR_TOADD select 2);
		}else{
			{player addItem _x;(_addedgear select 2) pushBack _x;}forEach (HALV_GEAR_TOADD select 2);
		};

		if(count (HALV_GEAR_TOADD select 0) < 1)then{
			_item = ((_geararr select 0) select 0) call BIS_fnc_selectRandom;
			_item call HALV_addiweaponwithammo;
			(_addedgear select 0) pushBack ['random',_item];
		}else{
			((HALV_GEAR_TOADD select 0)select 0) call HALV_addiweaponwithammo;
			(_addedgear select 0) pushBack ((HALV_GEAR_TOADD select 0)select 0);
		};

		if(count (HALV_GEAR_TOADD select 1) < 1)then{
			_item = ((_geararr select 1) select 0) call BIS_fnc_selectRandom;
			_item call HALV_addiweaponwithammo;
			(_addedgear select 1) pushBack ['random',_item];
		}else{
			((HALV_GEAR_TOADD select 1)select 0) call HALV_addiweaponwithammo;
			(_addedgear select 1) pushBack ((HALV_GEAR_TOADD select 1)select 0);
		};
		diag_log str['_addedgear:',_addedgear];
	};
	if(_addmap)then{player addWeapon "ItemMap";};
	
//	diag_log format["[halv_spawn] PlayerGear: weapons: %1 items: %2 assignedItems: %4 magazines: %3",weapons player,items player,magazines player,assignedItems player];

	_spawn set [2,0];
	_position = [0,0,0];
	_t = diag_tickTime;
//	systemChat "Searching for position ...";
	_try = 0;
	while{true}do{
		_try = _try +1;
		_position = [_spawn,0,_area,2,0,2000,0] call BIS_fnc_findSafePos;
		if(_position distance _spawn > 0 && _position distance _spawn < _area || _try isEqualTo 100)exitWith{if(_try isEqualTo 100)then{_position = _spawn;};};
	};
//	systemChat format["Found position in %2 try(s) ... %1 seconds",diag_tickTime - _t,_try];
	if(_try isEqualTo 100)then{
		_failtxt = "[halv_spawn] BIS_fnc_findSafePos Failed to find position in 100 try's ... reverted to exact position!";
		systemChat _failtxt;
		diag_log format["%1 %2",_failtxt,_spawn];
	};
	_selectorforce = false;
	if(_HALV_forcespawnMode < 1)then{if(HALV_HALO)then{_selectorforce = true;};}else{if(_HALV_forcespawnMode isEqualTo 1)then{_selectorforce = true;};};
	if(_selectorforce)then{
		_position set [2,_jumpheight];
		player setPosATL _position;
		[] spawn HALV_fnc_halo;
		titleText [format[localize "STR_HALV_HALOSPAWNEDNEAR",_cityname,name player],"PLAIN DOWN"];
		[]spawn{
			sleep 4;
			titleText [localize "STR_HALV_SCROLLOPENCHUTE","PLAIN DOWN"];
			systemChat localize "STR_HALV_SCROLLOPENCHUTE";
			waitUntil{sleep 1;(getPosATL player) select 2 < 1 && (speed player) > -1 && (speed player) < 1};
			sleep 2;
			if !(alive player)then{
				["<img align= 'center' size='8' image='\a3\Ui_f\data\gui\cfg\Debriefing\enddefault_ca.paa'/>",0,0,15,0,0,8406] spawn bis_fnc_dynamicText;
			};
		};
	}else{
		player setPos _position;
		titleText[format[localize "STR_HALV_SPAWNEDNEAR",_cityname,name player],"PLAIN DOWN"];
	};
	if (_script != "")then{execVM _script;};
	if(_addcolours)then{_servername call HALV_playeraddcolours;};
	Halv_moveMap = nil;Halv_fill_spawn = nil;Halv_near_cityname = nil;Halv_spawn_player = nil;Halv_spawns = nil;HALV_senddeftele = nil;HALV_HALO = nil;HALV_SELECTSPAWN = nil;HALV_fill_gear = nil;HALV_fnc_returnnameandpic = nil;HALV_fill_gear = nil;Halv_ontreedoubleclick = nil;Halv_ontreeselected = nil;HALV_GEAR_TOADD = nil;HALV_player_removelisteditem = nil;HALV_addiweaponwithammo = nil;HALV_fnc_halo = nil;HALV_playeraddcolours = nil;
};

HALV_switch_spawngear = {
	#include "spawn_settings.sqf";
	if((_this select 2) isEqualTo 0)then{
		systemchat localize 'STR_HALV_SELECT_SPAWN';
		call Halv_fill_spawn;
	}else{
		if (_halv_allowgearselect)then{
			systemchat localize 'STR_HALV_SELECT_GEAR';
			systemChat localize 'STR_HALV_NONEEDTOSELECTALL';
			call HALV_fill_gear;
		};
	};
};

Halv_fill_spawn = {
	#include "spawn_settings.sqf";
	HALV_SELECTSPAWN = true;
	disableSerialization;
	_ctrl = (findDisplay 7777) displayCtrl 7779;_ctrl ctrlShow false;
	_ctrl = (findDisplay 7777) displayCtrl 7781;
	if(_HALV_forcespawnMode > 0)then{
		if(_HALV_forcespawnMode isEqualTo 2)then{_ctrl ctrlSetChecked true;};
		_ctrl ctrlEnable false;
	}else{
		_ctrl ctrlEnable true;
	};
	if !(_halv_allowgearselect)then{
		_ctrl = (findDisplay 7777) displayCtrl 7780;
		if !(ctrlChecked _ctrl)then{_ctrl ctrlSetChecked true;};
		_ctrl ctrlEnable false;
		_ctrl ctrlSetTooltip "";
	};
	_ctrl = (findDisplay 7777) displayCtrl 7775;_ctrl ctrlShow true;
	_ctrl = (findDisplay 7777) displayCtrl 7776;
	lbClear _ctrl;
	_pUID = getPlayerUID player;
	_bodies = [];
	{if ((!isNull _x) && {(_x getVariable["bodyUID","0"]) == _pUID}) then {_bodies pushBack (getPosATL _x);};}forEach allDead;
	{
		_pos = _x select 0;
		_lvl = if(count _x > 1)then{_x select 1}else{0};
		_name = if(count _x > 2)then{_x select 2}else{_pos call Halv_near_cityname};
		_fi = _forEachIndex;
		_index = _ctrl lbAdd _name;
		_ctrl lbSetValue [_index,_fi];
		_ctrl lbSetTooltip [_index, localize "STR_HALV_DOUBLECLICKTOSPAWN"];
		{
			if(_x distance _pos < _bodyCheckDist)exitWith{
				_lvl = 5;
				_ctrl lbSetValue [_index,-2];
			};
		}forEach _bodies;
		switch (_lvl) do{
			case 1:{
				if(_pUID in _level1UIDs)then{
					_ctrl lbSetColor [_index,[0,1,0,.8]];
					_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_star_ca.paa"];
					_ctrl lbSetTooltip [_index,localize "STR_HALV_DOUBLECLICKTOSPAWNREG"];
					_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
				}else{
					_ctrl lbSetColor [_index,[1,0,0,.8]];
					_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_locked_ca.paa"];
					_ctrl lbSetTooltip [_index,localize "STR_HALV_REGDONORONLY"];
					_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
				};
			};
			case 2:{
				if(_pUID in _level2UIDs)then{
					_ctrl lbSetColor [_index,[0,1,0,.8]];
					_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_star_ca.paa"];
					_ctrl lbSetTooltip [_index,localize "STR_HALV_DOUBLECLICKTOSPAWNDON"];
					_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
				}else{
					_ctrl lbSetColor [_index,[1,0,0,.8]];
					_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\cfg\Debriefing\dlclockicon_ca.paa"];
					_ctrl lbSetTooltip [_index,localize "STR_HALV_DONORONLY"];
					_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
				};
			};
			case 5:{
				_ctrl lbSetColor [_index,[1,0,0,.8]];
				_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\cfg\Debriefing\enddeath_ca.paa"];
				_ctrl lbSetTooltip [_index,localize "STR_HALV_LOCKEDBODY"];
				_ctrl lbSetPictureColorSelected [_index, [1, 0, 0, 1]];
			};
			case 6:{
				_ctrl lbSetColor [_index,[0,0.5,1,.7]];
				_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_star_ca.paa"];
				_ctrl lbSetTooltip [_index,localize "STR_HALV_DOUBLECLICKTOSPAWNJAM"];
				_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
			};
			case 7:{
				_ctrl lbSetColor [_index,[0,0.5,1,.7]];//Blue
				_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_star_ca.paa"];
				_ctrl lbSetTooltip [_index, "STR_HALV_DOUBLECLICKTOSPAWNGROUP"];
				_ctrl lbSetPictureColorSelected [_index, [0, 0, 0, 1]];
			};
			default{
				_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_none_ca.paa"];
				_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
			};
		};
		_ctrl lbSetPictureColor [_index, [1, 1, 1, 1]];
	}forEach Halv_spawns;
	lbSort _ctrl;

	_index = _ctrl lbAdd "";
	_ctrl lbSetValue [_index,-1];
	_index = _ctrl lbAdd (localize "STR_HALV_RANDOM");
	_ctrl lbSetColor [_index,[0,0.5,1,.7]];
	_ctrl lbSetValue [_index,-3];
	_ctrl lbSetPicture [_index,"\a3\Ui_f\data\IGUI\Cfg\Actions\ico_cpt_start_on_ca.paa"];
	_ctrl lbSetPictureColor [_index, [1, 1, 1, 1]];
	_ctrl lbSetPictureColorSelected [_index, [0, 0, 0, 1]];
	_ctrl lbSetTooltip [_index,localize "STR_HALV_DOUBLECLICKFORRANSPAWN"];
	_ctrl lbSetCurSel _index;
};

HALV_fnc_returnnameandpic = {
	_pic = "";
	_txt = "";
	_libtxt = "";
	_type = "";
	{
		if(isClass(configFile >> _x >> _this))exitWith{
			_type = _x;
			_pic = (gettext (configFile >> _type >> _this >> 'picture'));
			_txt = (gettext (configFile >> _type >> _this >> 'displayName'));
			_libtxt = (gettext (configFile >> _type >> _this >> 'Library' >> 'libTextDesc'));
		};
	}forEach ["cfgweapons","cfgmagazines","cfgvehicles","cfgglasses"];
	_return = [_txt,_pic,_libtxt,_type];
	_return
};

HALV_player_removelisteditem = {
	disableSerialization;
	_ctrl = _this select 0;
	_lb = _this select 1;
	if(_lb isEqualTo 0)exitWith{call Halv_fill_spawn;};
	if(_lb isEqualTo 1)exitWith{
		HALV_GEAR_TOADD = profileNamespace getVariable ["HALVSPAWNLASTGEAR",[[],[],[],[],[],[],[],[],[],[]]];
		call Halv_fill_spawn;
	};
};

Halv_ontreeselected = {
	#include "spawn_gear_settings.sqf";
	disableSerialization;
	_treectrl = _this select 0;
	_path = _this select 1;
	if (count _path < 2)exitWith{};
	_val = _treectrl tvValue _path;
	if(_val < 0)exitWith{
		_txt = switch(_val)do{
			case -1:{localize "STR_HALV_REGDONORONLY"};
			case -2:{localize "STR_HALV_DONORONLY"};
			case -3:{"You need Marksman DLC to use this item"};
			default{"VIP"};
		};
		systemChat _txt;
		['<t align= ''right'' size=''0.4''>'+_txt+' </t>',0.6,0.885 * safezoneH + safezoneY,15,0,0,8407] spawn bis_fnc_dynamicText;
	};
	_item = '';
	_row = (_path select 0);
	_arr = _geararr select _row;
	if((typeName (_arr select 0)) == "ARRAY")then{
		_sel = if(_row isEqualTo 7 && ((typeOf player) == "Epoch_Female_F"))then{1}else{0};
		_item = (_arr select _sel)select _val;
	}else{
		_item = _arr select _val;
	};
	if(_item == '')exitWith{};
	_arr = _item call HALV_fnc_returnnameandpic;
	_txt = 'Halv Spawn';
	if ((_arr select 2) != '') then {_txt = _arr select 2;}else{if ((_arr select 0) != '') then {_txt = _arr select 0;};};
	['<t align= ''right'' size=''0.4''>'+_txt+'</t>',0.53,0.885 * safezoneH + safezoneY,15,0,0,8407] spawn bis_fnc_dynamicText;
	_pic = '';
	if ((_arr select 1) != '') then {_pic = _arr select 1};
	if((toLower _pic) in ['','pictureheal','picturepapercar','picturething','picturestaticobject']) exitWith {};
	['<img align= ''right'' size=''2.4'' image='''+_pic+'''/>',0.54 * safezoneW + safezoneX,0.76 * safezoneH + safezoneY,15,0,0,8406] spawn bis_fnc_dynamicText;

};

Halv_ontreedoubleclick = {
	private "_item";
	#include "spawn_gear_settings.sqf";
	disableSerialization;
	_treectrl = _this select 0;
	_path = _this select 1;
	if(count _path < 2)exitWith{};
	_value = _treectrl tvValue _path;
	if(_value in [-1,-2])exitWith{
		switch(_value)do{
			case -2:{systemChat localize "STR_HALV_DONORONLY";};
			case -1:{systemChat localize "STR_HALV_REGDONORONLY";};
		};
	};
	_row = (_path select 0);
	_tvcount = _treectrl tvCount [_row];
	_max = 0;
	_current = 0;
	if(_row < 2)then{
		for "_i" from 0 to (_tvcount)-1 do {
			_treectrl tvDelete [_row,0];
		};
	}else{
		_treectrl tvDelete _path;
	};
	_arr = _geararr select _row;
	if((typeName (_arr select 0)) == "ARRAY")then{
		_item = (_arr select 0)select _value;
		_max = (_arr select 1);
		if(_row isEqualTo 7)then{
			_max = 0;
			if((typeOf player) == "Epoch_Female_F")then{
				_item = (_arr select 1)select _value;
			};
		};
		(HALV_GEAR_TOADD select _row) pushBack _item;
		_current = count (HALV_GEAR_TOADD select _row);
	}else{
		_item = _arr select _value;
		(HALV_GEAR_TOADD select _row) pushBack _item;
		for "_i" from 0 to (_tvcount)-1 do {
			_treectrl tvDelete [_row,0];
		};
	};
	if(_max isEqualTo _current || _row isEqualTo 7)then{
		for "_i" from 0 to (_tvcount)-1 do {
			_treectrl tvDelete [_row,0];
		};
	};
	_done = false;
	_tvcount = _treectrl tvCount [_row];
	if(_tvcount < 1)then{
		_count = _treectrl tvCount [];
		for "_i" from 0 to (_count)-1 do {
			_tcount = _treectrl tvCount [_i];
			if(_tcount > 0)exitWith{_treectrl tvExpand [_i];};
			if(_i isEqualTo (_count-1))exitWith{_done = true;};
		};
	};
	if(_done)exitWith{call Halv_fill_spawn;};
	_lb = (findDisplay 7777) displayCtrl 7776;
	_namepic = _item call HALV_fnc_returnnameandpic;
	_index = _lb lbAdd (_namepic select 0);
	_lb lbSetPicture [_index,(_namepic select 1)];
	_lb lbSetPictureColor [_index, [1, 1, 1, 1]];
	_lb lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
};

HALV_fill_gear = {
	#include "spawn_gear_settings.sqf";
	HALV_SELECTSPAWN = false;
	HALV_GEAR_TOADD = [[],[],[],[],[],[],[],[],[],[]];
	disableSerialization;
	_ctrl = (findDisplay 7777) displayCtrl 7780;
	if !(ctrlChecked _ctrl)then{_ctrl ctrlSetChecked true;};
	_ctrl = (findDisplay 7777) displayCtrl 7775;_ctrl ctrlShow false;
	_ctrl = (findDisplay 7777) displayCtrl 7776;
	lbClear _ctrl;
	_index = _ctrl lbAdd (localize "STR_HALV_RANDOM");
	_ctrl lbSetColor [_index,[0,0.5,1,.7]];
	_ctrl lbSetPicture [_index,"\a3\Ui_f\data\IGUI\Cfg\Actions\ico_cpt_start_on_ca.paa"];
	_ctrl lbSetPictureColor [_index, [1, 1, 1, 1]];
	_ctrl lbSetPictureColorSelected [_index, [0, 0, 0, 1]];
	if !((profileNamespace getVariable ["HALVSPAWNLASTGEAR",[[],[],[],[],[],[],[],[],[],[]]]) isEqualTo [[],[],[],[],[],[],[],[],[],[]])then{
		_index = _ctrl lbAdd (localize "STR_HALV_LASTUSED");
		_ctrl lbSetColor [_index,[0,0.5,1,.7]];
		_ctrl lbSetPicture [_index,"\a3\Ui_f\data\gui\cfg\CommunicationMenu\transport_ca.paa"];
		_ctrl lbSetPictureColor [_index, [1, 1, 1, 1]];
		_ctrl lbSetPictureColorSelected [_index, [0, 0, 0, 1]];
	};
	_ctrl lbSetCurSel _index;
	_puid = getPlayerUID player;
	_ctrl = (findDisplay 7777) displayCtrl 7779;_ctrl ctrlShow true;
	tvClear _ctrl;
	{
		_row = _forEachIndex;
		_txt = "";
		_pic = "";
		switch (_row)do {
			case 0:{_txt = format[localize "STR_HALV_PISTOLS",(_geararr select 0)select 1];_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\handgun_ca.paa";};
			case 1:{_txt = format[localize "STR_HALV_RIFLES",(_geararr select 1)select 1];_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\primaryweapon_ca.paa";};
			case 2:{_txt = format[localize "STR_HALV_TOOLS",(_geararr select 2)select 1];_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_debug_ca.paa";};
			case 3:{_txt = format[localize "STR_HALV_ITEMS",(_geararr select 3)select 1];_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\watch_ca.paa";};//itemacc_ca
			case 4:{_txt = format[localize "STR_HALV_MAGAZINES",(_geararr select 4)select 1];_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\cargomag_ca.paa";};
			case 5:{_txt = localize "STR_HALV_HEADGEAR";_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\headgear_ca.paa";};
			case 6:{_txt = localize "STR_HALV_VESTS";_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa";};
			case 7:{_txt = localize "STR_HALV_UNIFORMS";_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa";};
			case 8:{_txt = localize "STR_HALV_GOGGLES";_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\goggles_ca.paa";};
			case 9:{_txt = localize "STR_HALV_BACKPACKS";_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa";};
		};
		_ctrl tvAdd [[],_txt];
		_ctrl tvSetPicture [[_row],_pic];
		_arr = _x;
		if((typeName (_x select 0)) == "ARRAY")then{
			_arr = _x select 0;
			if(_row isEqualTo 7 && ((typeOf player) == "Epoch_Female_F"))then{
				_arr = (_x select 1);
			};
		};
		{
			_fi = _forEachIndex;
			_namepic = _x call HALV_fnc_returnnameandpic;
			_value = _fi;
			if(_x in (_lvl1items+_lvl2items))then{
				if(_x in _lvl1items)exitWith{
					if!(_puid in _level1UIDs)then{
						_ctrl tvAdd [[_row],format["%1 (%2)",_namepic select 0,localize "STR_HALV_REGDONORONLY"]];
						_value = -1;
					}else{
						_ctrl tvAdd [[_row],format["%1 (Reg / Donor)",_namepic select 0]];
					};
				};
				if(_x in _lvl2items)exitWith{
					if !(_puid in _level2UIDs)then{
						_ctrl tvAdd [[_row],format["%1 (%2)",_namepic select 0,localize "STR_HALV_DONORONLY"]];
						_value = -2;
					}else{
						_ctrl tvAdd [[_row],format["%1 (Donor)",_namepic select 0]];
					};
				};
			}else{
				_ctrl tvAdd [[_row],format["%1",_namepic select 0]];
			};
			if(332350 in getDLCs 2)then{
				if((toLower(getText(configFile >> "CfgWeapons" >> _x >> 'DLC'))) == 'mark')then{
					_ctrl tvSetValue [[_row,_fi], -3];
				}else{
					_ctrl tvSetValue [[_row,_fi], _value];
				};
			}else{
				_ctrl tvSetValue [[_row,_fi], _value];
			};
			_ctrl tvSetPicture [[_row,_fi],_namepic select 1];
		}forEach _arr;
		_ctrl tvSort [[_row],false ];
	}forEach _geararr;
	_ctrl tvExpand [0];
	_ctrl tvSetCurSel [0];
};

diag_log format["Spawn Menu Loaded ... %1 - %2",diag_tickTime,diag_tickTime - _diagTiackTime];
