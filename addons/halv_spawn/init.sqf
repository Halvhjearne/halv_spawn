/*
	custom spawn init.sqf
	DebugPic script added ...
	by Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

//==== Set script path if needed =====\\
_scriptpath = "addons\halv_spawn\";


//=DONT TUOCH THIS=\\
if(isServer)then{
/*================*/


//if _deletedefaultteleporters is true, it deletes all default teleporter objects and replaces them with new ones forcing players to select spawn from the dialog
//if you want to use the default teleporters instead, set this to false ... however the default teleporters will always have the default teleport scroll action attached
	_deletedefaultteleporters = true;
//new teleporter object, this is if you want a diffrent object than the default console i set
	_newteleClass = "Land_InfoStand_V2_F";
//set object texture (full path), also accepts colour defs like "#(argb,8,8,3)color(0.123,1,0.3,0.3)", "" for nothing/default
	_objecttexture = "addons\halv_spawn\HAND.jpg";
//sides to set object texture to, [] for none
	_objecttexturesides = [1];

//This is the teleporterobjects to search for, if you want them deleted
	_teleobjs = ["Transport_C_EPOCH","Transport_W_EPOCH","Transport_E_EPOCH","Transport_S_EPOCH","Transport_N_EPOCH","Transport_EPOCH"];

	_pic1 = [
//North wall
//build this picture/texture? (true / false)
		false,
//Change to your picture/path here
		"custom\problemsolving.jpg"
	];
	_pic2 = [
	//East wall
//build this picture/texture? (true / false)
		false,
//Change to your picture/path here
		"custom\dkflag.jpg"
	];
	_pic3 = [
	//South wall
//build this picture/texture? (true / false)
		false,
//Change to your picture/path here
		"custom\loadscreen.jpg"
	];
	_pic4 = [
	//West wall
//build this picture/texture? (true / false)
		false,
//Change to your picture/path here
		"custom\dkflag.jpg"
	];

//==================================== Dont Touch anything below this point ====================================\\

	_respawnwest = getMarkerPos "respawn_west";
	_HALV_deftele = getArray(configFile >> "CfgEpoch" >> worldname >> "telePos");
	_deftelepos = [];
	{_deftelepos pushBack (_x select 3)}forEach _HALV_deftele;
	diag_log format["[halv_spawn] waiting for default 'Debug_static_F' to be build in %1 @ (%2) %3",worldName,mapGridPosition _respawnwest,_respawnwest];
	waitUntil {sleep 1;(count(_respawnwest nearObjects ["Debug_static_F",30]) > 0)};
	if(count _HALV_deftele > 0)then{waitUntil {sleep 1;((count(_respawnwest nearObjects ["Transport_EPOCH", 35])) isEqualTo (count _HALV_deftele))};};
	_objects = _respawnwest nearObjects ["Transport_EPOCH", 35];
	_box = nearestObject [_respawnwest, "Debug_static_F"];
	_teleobjs = [];
	if(count _objects > 0)then{
		diag_log format["[halv_spawn] found some default teleporters ... _deletedefaultteleporters: '%1'",_deletedefaultteleporters];
		{
			if(_deletedefaultteleporters)then{
				_pos = getPos _x;
				_pos = [_pos select 0,_pos select 1,1];
				_dir = getDir _x;
				deleteVehicle _x;
				_obj = createVehicle [_newteleClass,_pos,[], 0, "CAN_COLLIDE"];
				switch(typeOf _x)do{
					case "Transport_E_EPOCH":{_obj setDir (_dir + 90);};
					case "Transport_W_EPOCH":{_obj setDir (_dir - 90);};
					default{_obj setDir _dir;};
				};
				_obj setPosATL _pos;
				if !(_objecttexture isEqualTo "")then{{_obj setObjectTextureGlobal [_x,_objecttexture];}forEach _objecttexturesides;};
				_teleobjs pushBack _obj;
			}else{
				_teleobjs pushBack _x;
			};
		}forEach _objects;

	}else{
		diag_log format["[halv_spawn] did not find any default teleporters in world %1 ... building from preset building coords",worldName];
		{
			_rpos = _box modelToWorld (_x select 0);
			_rDir = (getDir _box)+(_x select 1);
			_obj = createVehicle [_newteleClass,_rpos,[], 0, "CAN_COLLIDE"];
			_obj setDir _rDir;
			_obj setPos _rpos;
			if !(_objecttexture isEqualTo "")then{{_obj setObjectTextureGlobal [_x,_objecttexture];}forEach _objecttexturesides;};
			_teleobjs pushBack _obj;
		}forEach[[[-0.337891,8.4668,-10.3362],0],[[14.6621,0.367188,-10.3362],90],[[-15.4375,0.166016,-10.3362],270]];
	};

	_alltextures = [[_pic1 select 0,_pic1 select 1,[-0.4,10,-4],0],[_pic2 select 0,_pic2 select 1,[16.5,.4,-4],90],[_pic3 select 0,_pic3 select 1,[-0.4,-9.5,-4],180],[_pic4 select 0,_pic4 select 1,[-17.2,.1,-4],270]];
	_pics = 0;
	{
		if(_x select 0)then{
			_pic = (_x select 1);
			_rPos = _box modelToWorld (_x select 2);
			_rDir = (getDir _box)+(_x select 3);
			_obj = createVehicle ["UserTexture10m_F", _rPos, [], 0, "CAN_COLLIDE"];
			_obj setDir _rDir;
			_obj setPos _rPos;
			_obj enableSimulation false;
			_obj setObjectTextureGlobal [0,_pic];
//			diag_log format["[DebugPic]: build texture @ %1 [%2,%3] texture '%4'",worldName,_obj,_rPos,_rDir];
			_pics = _pics + 1;
		};
	}forEach _alltextures;
	HALV_senddeftele = [_teleobjs,_deftelepos];
	publicVariable "HALV_senddeftele";
	diag_log format["[halv_spawn] sendt teleporters and default positions to clients, %1 textures build",_pics];
};

if(hasInterface && !isDedicated)then{
	[_scriptpath] execVM (_scriptpath+"spawndialog.sqf");
};
