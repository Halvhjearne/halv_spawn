/*
	spawn dialog misc settings
	By Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

//UID's for lvl 1 spawn's
_level1UIDs = [];
//UID's for lvl 2 spawn's
_level2UIDs = [];
//this is to allow any lvl 2 to spawn on lvl 1, comment out to seperate the two
_level1UIDs = _level1UIDs + _level2UIDs;

//Spawn area radius, setting this low might make bis_fnc_findsafepos fail and place the player in the middle of the map
_area = 1250;

//force halo jump or ground spawn 0 = user choice, 1 = forced HALO, 2 = forced Ground
_HALV_forcespawnMode = 0;
_jumpheight = 1250;

//this is the distance (in meters) it will check for the players dead bodys, set to -1 to disable
_bodyCheckDist = 2500;

//execVM script (like credits) on spawn? "pathto\script\filename.sqf" or "" to disable
_script = "addons\halv_spawn\credits.sqf";

//start screen 0 = start on select gear screen, anything else will start it on select map screen
_halv_spawn_startmode = 0;

//if false then gear select screen/button is disabled
_halv_allowgearselect = true;

//if false, this disables adding gear, so no gear is added 
//if gear select is disabled and this is false, no random gear is added to player on spawn
//to add random gear from the arrays, set this to true and disable gear selection
_addgear = true;

//this is to clear all gear, before adding the new gear
//best to keep this true, if you allow gear selection
//if you do not allow gear selection, set this to false, or player will start with nothing
_removedefault = true;

//if true, it will always adds a map to the player on spawn (else player will not have a map, if not added to list)
_addmap = true;

//////////////////////////paintshop settings//////////////////////////
//if you do not have the paintshop on your server, just set it to false below
//if true adds paintshop colours on spawn, if below var is set correct as in your paintshop settings
_addcolours = true;
