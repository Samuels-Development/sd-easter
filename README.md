
![EasterEgg](https://user-images.githubusercontent.com/99494967/229825960-0e314f8b-aae6-429c-8750-b7a231e5b176.jpg)

This is a slight re-write of sd-christmas with new props etc. to suit the easter theme.

TL;DR, Collect Eggs and exchange them for Small, Medium and Large Baskets with randomized Loot in them!

# Common Issue
- Restarting the resource while in-game will break the prop spawns!

# Requirments
- qb-core
- qb-menu
- qb-target


# Installation

Step 1: Add easter into your resources folder (and ensure it if needed in your server.cfg)

Step 2: Add the following items into your qb-core/shared/items.lua:

				  
	["easteregg"] 					 = {["name"] = "easteregg", 					["label"] = "Easter Egg", 			    ["weight"] = 0, 		["type"] = "item", 		["image"] = "easteregg.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = ""},
    ['easteregg2'] 				 	 = {['name'] = 'easteregg2', 			  	    ['label'] = 'easter Egg', 			    ['weight'] = 0, 		['type'] = 'item', 		['image'] = 'easteregg2.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ['easteregg3'] 				 	 = {['name'] = 'easteregg3', 			  	    ['label'] = 'Easter Egg', 			    ['weight'] = 0, 		['type'] = 'item', 		['image'] = 'easteregg3.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ['easteregg4'] 				 	 = {['name'] = 'easteregg4', 			  	    ['label'] = 'Easter Egg', 			    ['weight'] = 0, 		['type'] = 'item', 		['image'] = 'easteregg4.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ['easteregg5'] 				 	 = {['name'] = 'easteregg5', 			  	    ['label'] = 'Easter Egg', 			    ['weight'] = 0, 		['type'] = 'item', 		['image'] = 'easteregg5.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    
    ['easterbasket_small'] 			= {['name'] = 'easterbasket_small', 			  	  	['label'] = 'Small Easter Basket', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'easterbasket_small.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ['easterbasket_medium'] 		= {['name'] = 'easterbasket_medium', 			  	  	['label'] = 'Medium Easter Basket', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'easterbasket_medium.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ['easterbasket_large'] 		    = {['name'] = 'easterbasket_large', 			  	  	['label'] = 'Large Easter Basket', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'easterbasket_large.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},

    ['chocolatebunny'] 		       = {['name'] = 'chocolatebunny', 			  	  	['label'] = 'Chocolate Bunny', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'chocolatebunny.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ['bunny'] 		               = {['name'] = 'bunny', 			  	  	['label'] = 'Stuffed Bunny', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bunny.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ['jellybeans'] 		           = {['name'] = 'jellybeans', 			  	  	['label'] = 'Jelly Beans', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'jellybeans.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
    ["mm"] 				 			 = {["name"] = "mm",  		     				["label"] = "M&Ms",	 					["weight"] = 200, 		["type"] = "item", 		["image"] = "mm.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   	["combinable"] = nil,   ["description"] = "M&Ms" },
	

Now you're done and ready to start collecting!


# Credits

Kaylaa#6145 - For initially rewriting sd-christmas.
BzZz 🐝#9999 -  https://bzzz.tebex.io/ (For the Easter props!)

# Previous Credits
marcinhu#0001 - https://marcinhu.tebex.io/ (For giving me the idea and helping out by sending some of the coordinates for his script..) 
