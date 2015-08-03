/*
	spawn dialog location settings
	By Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

//allow spawn near players jammer? only one is registered, so no point in multiple jammers
//I have had reports about players not loading when using this, so if you have problems, try to set this to false
_spawnNearJammer = true;
//this is the area to search for jammers, reduce if you do not want players spawning on the edge of the map
//Increas with care as it can increase load times with high numbers default: 10000
_jamarea = 10000;

//This will allow spawn near group leader, but group system in epoch is bugged
_spawnNearGroup = true;

//adds the default spawns locations
_adddefaultspawns = true;

Halv_spawns = switch(toLower worldName)do{
//altis spawns
	case "altis":{
		[
/*
		[
			[20548.4,8888.25],
			2,
			"My custom spawn name for panagia"
		],	// 'Panagia' donor lvl 2 required to spawn here
		[
			[20548.4,8888.25]
		],	//minimal array for 'Panagia', name is found by the script and no donor / lvl requirements to spawn here
*/
			[[20548.4,8888.25],2],	// 'Panagia'" //donor
			[[20788.2,6733.91]],	// 'Selakano'
			[[20241.1,11659.6],1],	// 'Chalkeia' //reg
			[[16786.2,12619.4]],	// 'Pyrgos'
			[[18111.2,15242.3]],	// 'Charkia'
			[[21358.5,16361],2],	// 'Kalochori'" //donor
			[[23211.4,19957.7]],	// 'Ioannina'
			[[25696.9,21348.6],2],	// 'Sofia' //donor
			[[26990.8,23202.2]],	// 'Molos'
			[[16278.7,17267.4],1],	// 'Telos' //reg
			[[14039.2,18730.9]],	// 'Athira'
			[[14602.8,20791.3]],	// 'Frini'
			[[9436.79,20304.4]],	// 'Abdera'
			[[4559.19,21406.7],2],	// 'Oreokastro' //donor
			[[4040.33,17281.3]],	// 'Agios Konstantinos'
			[[9275.09,15899.8],1],	// 'Agios Dionysios' //reg
			[[12477.4,14316.7]],	// 'Neochori'
			[[3529.11,13054.8]],	// 'Kavala'
			[[9045.54,11960.8]],	// 'Zaros'
			[[9259.52,8062.07],1]	//'Sfaka' //reg

		]
	};
//stratis spawns
	case "stratis":{
		[
			[[1949.69,5522.03]],
			[[3024.14,5973.37]],
			[[3725.39,7114.48]],
			[[5008.42,5907.77]],
			[[6429.73,5395.64]],
			[[5356.9,3792.62]],
			[[4362.02,3831.27]],
			[[3292.59,2934.25]],
			[[2778.96,1746.92]],
			[[2625.43,608.782]],
			[[2424.63,1142.45]],
			[[2120.67,1920.52]],
			[[2005.55,2702.73]],
			[[1922.96,3569.01]],
			[[1983.26,4178.85]]
		]
	};
	case "chernarus":
	{
		[
//these are old a2 positions taken directly from ebays essv2 (thanks ebay) 
//... Richie says they will work, so ill leave them here for now ...
			//Chernarus
			[[4932,1989]],		//"Balota",
			[[12048,8352]],		//"Berezino",
			[[6901,2509]],		//"Chernogorsk",
			[[10294,2191]],		//"Elektrozavodsk",
			[[2236,1923]],		//"Kamenka",
			[[12071,3591]],		//"Kamyshovo",
			[[3608,2152]],		//"Komarovo",
			[[7952,3205]],		//"Prigorodky",
			[[9153,3901]],		//"Pusta",
			[[13510,5249]],		//"Solnichny",
			// Above are defaults
			[[7068,11221],1],	//"Devil's Castle",
			[[9711,8962],1],	//"Gorka",
			[[5939,10195],2],	//"Grishino",
			[[8421,6643],2],	//"Guglovo",
			[[8812,11642],2],	//"Gvozdno",
			[[5301,8548],2],	//"Kabanino",
			[[11053,12361],2],	//"Krasnostav",
			[[13407,4175],2],	//"Krutoy",
			[[2718,10094],1],	//"Lopatino",
			[[4984,12492],2],	//"Petrovka",
			[[4582,6457],2],	//"Pogorevka",
			[[3626,8976],2],	//"Vybor",
			[[6587,6026],2],	//"Vyshnoye",
			[[2692,5284],1],	//"Zelenogorsk",
			// still viable?
			[[1607,7804,0],2,"Bandit Base"],	//"Bandit Base",
			[[12944,12767,0],2,"Hero Hideout"]//"Hero Hideout",
		]
	};
	case "bornholm":{
		[
			[[4238.39,19928.1]],	//Sandvig
			[[6320.51,17166.1],2],	//Tejn
			[[11500,14697.5],1],	//Gudhjem
			[[17798.6,9953]],		//Svaneke
			[[17989.7,7962.99]],	//Aarsdale
			[[17380.4,5070.29],1],	//Nexøe
			[[16711.7,2652.2]],		//Snogebæk
//			[[15368.7,390.873]],	//Dueodde
			[[11191.5,1591.41]],	//Sømarken
			[[4251.74,4553.86]],	//Arnager
			[[1521.58,7508.99]],	//Rønne
			[[1634,12926.4]],		//Hasle
//			[[19687.1,22105],2],		//Christians ø, not working, player will most likely spawn in map center.
			[[2884.57,17167.5],1]	//Vang
		]
	};
	case "australia":{
		[
			[[17470.4,33464.90],0,"Darwin"],
			[[37882.1,19902.9],0,"Brisbane"],
			[[5471.57,18521.3],0,"Perth"],
			[[22093.7,25537.9],0,"Alice Springs"],
			[[20772.5,12830.5],0,"Port Lincoln"],
			[[25223.7,12851.9],0,"Adelaide"],
			[[31069.2,10465.7],0,"Melbourne"],
			[[36506.2,12936.5],0,"Sydney"],
			[[28516.1,35189.4],0,"Weipa"],
			[[32017.5,29801.8],0,"CairnsWeipa"],
			[[31111.3,19988.5],0,"Toowoomba"],
			[[27615.3,16953.2],0,"Broken Hills"],
			[[35386.5,8526.27],0,"Eden"],
			[[33097.9,3692.18],0,"Tasmania"]
		]
	};
/* //create new world spawns, use lower case letters only or it will not be detected (only [x,y] needed)
	case "myworldname":{
		[
			[[0,0],2,"customname"],	//spawn locked for everyone but lvl 2, customname is "customname"
			[[0,0],1],				//spawn locked for everyone but lvl 1
			[[0,0],0,"customname"],	//spawn open for all, customname is "customname"
			[[0,0]]					//minimal spawn, open for all
		]
	};
*/
	default{[]};
};
