/*
	custom spawn script
	by Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

#include "spawn_settings.sqf";
if(isNil "Halv_fill_spawn")exitWith{};
createdialog "Halv_spawn_dialog";

if(_halv_spawn_startmode == 0 && _halv_allowgearselect)then{
	call HALV_fill_gear;
}else{
	call Halv_fill_spawn;
};
