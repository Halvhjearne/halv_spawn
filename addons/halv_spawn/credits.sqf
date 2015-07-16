if(isServer)exitWith{};
/*
	Simple Credits script
	by Halv
*/
sleep 2.5; // sleep before the welcome message starts (in seconds)

_alltext = [
	[
		//Title
		"Welcome to",
		//Title Color
		"#71C700", //green light
		[
			//Sub Text(s)
			"   Halv's",
			"- Epoch Warfare Server -"
		]
	],
	[
		"Teamspeak ]I[ Server :",
		"#c77000", //orange rust
		[
			"halv.ddns.net:9995"
		]
	],
	[
		"Server Admins :",
		"#25B25B", //Green
		[
			"Halv"," ","Deathstroke"
		]
	],
	[
		"Main Rules :",
		"#C80000", //Red dark
		[
			"No Shooting Into SafeZones!"," ","Play fair!"," ","Dont be a douche!"
		]
	],
	[
		"Server Mods :",
		"#0096ff", //Blue Light
		[
			"AI + Missions","Call In Airdrops","Capture Points","Earplugs (+/-)","HALO Eject A2 Style","Select Gear / HALO Spawn",
			"Special (no limit) Traders","Lift and Tow","No DLC Locked Vehicles","Repair/Re-Arm Stations","Vehicle/Uniform/Bag Paint Shops",

			"And Much more ..."
		]
	],
	[
		"Server Scripted by :",
		"#C80000", //Red dark
		[
			"- Halv -"
		]
	],
	[
		"Awsome translations by:",
		"#c77000", //orange rust
		[
			"alden",
			"Matez31cz",
			"Kerozen",
			"Suppe",
			"W4lly",
			"Tophi",
			"",
			"And many others i forgot to mention ..."
		]
	],
	[
		"Server Restarts :",
		"#ffff00", //Yellow
		[
			"4 Hour Schedule"," "," (not set times)"
			//"00:00","04:00","08:00","12:00","16:00","20:00","GMT + 1"
		]
	],
	[
		"Support / Help / Donor Info:",
		"#71C700", //green light
		[
			"All Found on","Halv's Blog"," ","halv.ddns.net"," ","or Ts3:"," ","halv.ddns.net:9995"
		]
	],
	[
		"Intro Song:",
		"#322CE6", //Blue Dark
		[
			"Sick Bubblegum"," ","- by Rob Zombie -"
		]
	]
];

{
	sleep 2;
	_memberFunction = _x select 0;
	_color = _x select 1;
	_memberNames = _x select 2;
	_finalText = format ["<t size='0.65'color='%2'align='left'shadow='1'>%1<br /></t><t size='0.1'><br /></t><t size='0.5'shadow='1'color='#EBEBEB'align='left'>", _memberFunction,_color];
	{_finalText =_finalText + format ["%1<br />", _x]} forEach _memberNames;
	_finalText = _finalText + "</t>";
	_onScreenTime = (count _memberNames) * 0.5;
	if(_onScreenTime < 6)then{_onScreenTime = 5};
	[_finalText,[safezoneX + safezoneW - 0.5,0.35],[safezoneY + safezoneH - 0.8,0.7],_onScreenTime,0.5] spawn BIS_fnc_dynamicText;
	sleep (_onScreenTime);
} forEach _alltext;
