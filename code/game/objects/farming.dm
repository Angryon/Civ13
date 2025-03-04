/obj/item/stack/farming/seeds
	name = "seeds"
	desc = "Some seeds."
	icon = 'icons/farming/plants.dmi'
	icon_state = "seeds"
	w_class = 1
	value = 1
	amount = 1
	max_amount = 100
	singular_name = "seed"
	color = "#543200"
	var/plant = "tomato"
	var/list/biomes = list("tundra", "temperate", "sea", "desert", "jungle","savanna","taiga","semiarid")
	var/list/seasons = list("WINTER", "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")

/obj/item/stack/farming/seeds/mushroom
	name = "mushroom spores"
	plant = "mushroom"
	icon_state = "mushroomseeds"
	color = null
	seasons = list("WINTER", "SUMMER", "SPRING", "FALL", "Wet Season")
	biomes = list("temperate", "sea", "tundra", "taiga", "jungle","savanna")

/obj/item/stack/farming/seeds/tomato
	name = "tomato seeds"
	plant = "tomato"
	color = "#fba032"
	biomes = list("temperate", "sea","semiarid", "desert", "jungle","savanna")
	seasons = list("SUMMER", "SPRING", "Wet Season", "Dry Season")

/obj/item/stack/farming/seeds/tobacco
	name = "tobacco seeds"
	plant = "tobacco"
	color = "#d88046"
	biomes = list("desert", "jungle","savanna","semiarid")

/obj/item/stack/farming/seeds/sugarcane
	name = "sugarcane seeds"
	plant = "sugarcane"
	color = "#f8ed8b"
	biomes = list("jungle","savanna","sea")

/obj/item/stack/farming/seeds/wheat
	name = "wheat seeds"
	plant = "wheat"
	color = "#fdb14e"
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season")
	biomes = list("temperate", "tundra", "taiga", "sea")
/obj/item/stack/farming/seeds/apple
	name = "apple seeds"
	plant = "apple"
	color = "#b14b0b"
	biomes = list("temperate", "tundra", "taiga", "sea","semiarid")

/obj/item/stack/farming/seeds/orange
	name = "orange seeds"
	plant = "orange"
	color = "#fbe151"
	biomes = list("temperate", "tundra", "taiga", "desert", "sea","semiarid")

/obj/item/stack/farming/seeds/cabbage
	name = "cabbage seeds"
	plant = "cabbage"
	color = "#682a03"
	biomes = list("temperate", "tundra", "taiga", "sea","semiarid")

/obj/item/stack/farming/seeds/hemp
	name = "hemp seeds"
	plant = "hemp"
	color = "#b7542a"
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")

/obj/item/stack/farming/seeds/tea
	name = "tea seeds"
	plant = "tea"
	color = "#995b0b"
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")
	biomes = list("jungle","savanna","sea","semiarid")

/obj/item/stack/farming/seeds/banana
	name = "banana seeds"
	plant = "banana"
	color = "#ffe135"
	biomes = list("jungle","savanna")

/obj/item/stack/farming/seeds/potato
	name = "seed potato"
	desc = "a potato selected for breeding because of its characteristics."
	plant = "potato"
	icon_state = "potato"
	color = null

/obj/item/stack/farming/seeds/carrot
	name = "carrot seeds"
	plant = "carrot"
	color = "#c13100"

/obj/item/stack/farming/seeds/rice
	name = "rice seeds"
	desc = "rice seeds selected for their characteristics."
	plant = "rice"
	icon_state = "riceseeds"
	color = null
	biomes = list("jungle","savanna","sea")

/obj/item/stack/farming/seeds/corn
	name = "corn seeds"
	plant = "corn"
	color = "#eec41b"
	biomes = list("temperate", "jungle","savanna", "desert", "sea", "semiarid", "taiga")
	seasons = list( "SUMMER", "SPRING", "Wet Season", "Dry Season")

/obj/item/stack/farming/seeds/poppy
	name = "poppy seeds"
	desc = "Seeds of the opium poppy."
	plant = "poppy"
	color = "#5f5c54"
	biomes = list("jungle","savanna", "desert")

/obj/item/stack/farming/seeds/peyote
	name = "peyote seeds"
	plant = "peyote"
	color = "#26241d"
	biomes = list("desert")

/obj/item/stack/farming/seeds/coffee
	name = "coffee seeds"
	plant = "coffee"
	color = "#713b09"
	biomes = list("jungle","savanna", "desert","semiarid")

/obj/item/stack/farming/seeds/tree
	name = "tree seeds"
	plant = "tree"
	color = "#c86d1e"
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")

/obj/item/stack/farming/seeds/cotton
	name = "cotton seeds"
	plant = "cotton"
	color = "#e4e0dc"
	biomes = list("temperate", "desert", "sea","semiarid")
	seasons = list( "SUMMER", "SPRING", "Wet Season", "Dry Season")

/obj/item/stack/farming/seeds/grapes
	name = "grape seeds"
	plant = "grapes"
	color = "#23232d"
	biomes = list("temperate", "desert", "sea","semiarid")
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")

/obj/item/stack/farming/seeds/olives
	name = "olive seeds"
	plant = "olives"
	color = "#343400"
	biomes = list("temperate", "desert", "sea","semiarid")

/obj/item/stack/farming/seeds/coca
	name = "coca seeds"
	plant = "coca"
	color = "#8b0000"
	biomes = list("jungle","savanna")

/obj/structure/farming/plant
	name = "plant"
	desc = "a generic plant."
	icon = 'icons/farming/plants.dmi'
	icon_state = "tomato-grow1"
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	var/stage = 1
	var/counter = 0
	var/harvest_verb = "harvest"
	var/readyStageMin = 7
	var/readyStageMax = 10
	var/plant = "tomato"
	flammable = TRUE
	not_movable = TRUE
	not_disassemblable = TRUE
	var/list/biomes = list("tundra", "taiga", "temperate", "sea","semiarid", "desert", "jungle","savanna")
	var/list/seasons = list("WINTER", "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")
	var/vstatic = FALSE // to "freeze" the image, so it can be used as a prop
	var/fertilized = FALSE
	var/water = 60
	var/max_water = 60

/obj/structure/farming/plant/New()
	..()
	water = max_water

/obj/structure/farming/plant/tomato
	name = "tomato plant"
	desc = "a tomato plant."
	icon_state = "tomato-grow1"
	plant = "tomato"
	biomes = list("temperate", "sea","semiarid", "desert", "jungle","savanna")
	seasons = list("SUMMER", "SPRING", "Wet Season", "Dry Season")
	max_water = 55

/obj/structure/farming/plant/hemp
	name = "hemp plant"
	desc = "a hemp plant. Good to make ropes and uh, other things."
	icon_state = "hemp-grow1"
	plant = "hemp"
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")
	max_water = 60

/obj/structure/farming/plant/corn
	name = "corn plant"
	desc = "a corn plant."
	icon_state = "corn-grow1"
	plant = "corn"
	biomes = list("temperate", "jungle","savanna", "desert", "sea","semiarid", "taiga")
	seasons = list( "SUMMER", "SPRING", "Wet Season", "Dry Season")
	max_water = 70

/obj/structure/farming/plant/wheat
	name = "wheat plant"
	desc = "a wheat plant."
	icon_state = "wheat-grow1"
	plant = "wheat"
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season")
	biomes = list("temperate", "tundra", "taiga", "sea")
	max_water = 50

/obj/structure/farming/plant/potato
	name = "potato plant"
	desc = "a potato plant."
	icon_state = "potato-grow1"
	plant = "potato"
	max_water = 75

/obj/structure/farming/plant/carrot
	name = "carrot plant"
	desc = "a carrot plant."
	icon_state = "carrot-grow1"
	plant = "carrot"
	max_water = 75

/obj/structure/farming/plant/poppy
	name = "poppy plant"
	desc = "a opium poppy plant."
	icon_state = "poppy-grow1"
	plant = "poppy"
	biomes = list("jungle","savanna", "desert")
	max_water = 75

/obj/structure/farming/plant/cabbage
	name = "cabbage plant"
	desc = "a cabbage plant."
	icon_state = "cabbage-grow1"
	plant = "cabbage"
	biomes = list("temperate", "tundra", "taiga", "sea","semiarid")
	max_water = 70

/obj/structure/farming/plant/apple
	name = "apple tree"
	desc = "an apple tree."
	icon_state = "orange-grow1"
	plant = "apple"
	biomes = list("temperate", "tundra", "taiga", "sea","semiarid")
	max_water = 75

/obj/structure/farming/plant/orange
	name = "orange tree"
	desc = "an orange tree."
	icon_state = "orange-grow1"
	plant = "orange"
	biomes = list("temperate", "tundra", "taiga", "desert", "sea","semiarid")
	max_water = 75

/obj/structure/farming/plant/tobacco
	name = "tobacco plant"
	desc = "a tobacco plant."
	icon_state = "tobacco-grow1"
	plant = "tobacco"
	biomes = list("desert", "jungle","savanna", "semiarid")
	max_water = 55

/obj/structure/farming/plant/sugarcane
	name = "sugarcane"
	desc = "a sugar cane. You can extract sugar from it."
	icon_state = "sugarcane-grow1"
	plant = "sugarcane"
	biomes = list("jungle","savanna", "sea")
	max_water = 60

/obj/structure/farming/plant/tea
	name = "tea"
	desc = "a tea plant."
	icon_state = "tea-grow1"
	plant = "tea"
	biomes = list("jungle","savanna","sea","semiarid")
	max_water = 50

/obj/structure/farming/plant/peyote
	name = "peyote"
	desc = "a peyote cactus plant."
	icon_state = "peyote-grow1"
	plant = "peyote"
	biomes = list("desert")
	max_water = 100

/obj/structure/farming/plant/coffee
	name = "coffee"
	desc = "a coffee plant."
	icon_state = "coffee-grow1"
	plant = "coffee"
	biomes = list("jungle","savanna", "desert", "semiarid")
	max_water = 80

/obj/structure/farming/plant/cotton
	name = "cotton"
	desc = "a cotton plant."
	icon_state = "cotton-grow1"
	plant = "cotton"
	harvest_verb = "pick"
	biomes = list("temperate", "desert", "sea","semiarid")
	seasons = list( "SUMMER", "SPRING", "Wet Season", "Dry Season")
	max_water = 50

/obj/structure/farming/plant/grapes
	name = "grapes"
	desc = "a grape vine plant."
	icon_state = "grapes-grow1"
	plant = "grapes"
	biomes = list("temperate", "desert", "sea","semiarid")
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")
	max_water = 65
/obj/structure/farming/plant/tree
	name = "tree"
	desc = "a tree, grown for wood."
	icon_state = "tree-grow1"
	plant = "tree"
	harvest_verb = "cut some logs from"
	seasons = list( "SUMMER", "SPRING", "FALL", "Wet Season", "Dry Season")
	max_water = 80

/obj/structure/farming/plant/rice
	name = "rice"
	desc = "a rice plant."
	icon_state = "rice-grow1"
	plant = "rice"
	harvest_verb = "harvest"
	biomes = list("jungle","savanna","sea")
	max_water = 30

/obj/structure/farming/plant/banana
	name = "banana"
	desc = "a banana plant."
	icon_state = "banana-grow1"
	plant = "banana"
	biomes = list("jungle","savanna")
	max_water = 45

/obj/structure/farming/plant/coca
	name = "coca"
	desc = "a coca plant. Produces coca leaves that can be refined to cocaine."
	icon_state = "coca-grow1"
	plant = "coca"
	biomes = list("jungle","savanna")
	max_water = 75

/obj/structure/farming/plant/mushroom
	name = "mushroom"
	desc = "a bunch of mushrooms. Can be grown inside and underground."
	icon_state = "mushroom-grow1"
	plant = "mushroom"
	harvest_verb = "harvest"
	seasons = list("WINTER", "SUMMER", "SPRING", "FALL", "Wet Season")
	biomes = list("temperate", "sea", "tundra", "taiga", "jungle","savanna")
	max_water = 55
/obj/structure/farming/plant/olives
	name = "olive"
	desc = "an olive tree."
	icon_state = "olives-grow1"
	plant = "olives"
	biomes = list("temperate", "desert", "sea","semiarid")
	max_water = 70

//stages: 1-6 growth, 7 harvest, 8 dead
/obj/structure/farming/plant/New()
	..()
	growth()
	var/turf/T = get_turf(src)
	if (T.radiation >= 5)
		radiation = 5

/obj/structure/farming/plant/proc/readyHarvest()
	if (stage >= readyStageMin && stage <= readyStageMax)
		return TRUE

/obj/structure/farming/plant/proc/spawnSeeds()
	var/seedpath = "/obj/item/stack/farming/seeds/[plant]"
	new seedpath(loc, 2)

/obj/structure/farming/plant/proc/spawnProduce()
	var/fruitpath = "/obj/item/weapon/reagent_containers/food/snacks/grown/[plant]"
	var/obj/item/I = new fruitpath(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/I2 = new fruitpath(loc)
		I2.radiation = radiation/2
/obj/structure/farming/plant/proc/growth()
	if (!vstatic)
		if (stage < 12)
			water_proc()
			if (stage < readyStageMin)
				icon_state = "[plant]-grow[stage]"
				desc = "A young [plant] plant."
				name = "young [plant] plant"
			else if (readyHarvest())
				icon_state = "[plant]-harvest"
				desc = "A ready to harvest [plant] plant."
				name = "ready [plant] plant"
			else
				icon_state = "[plant]-dead"
				desc = "A dead [plant] plant."
				name = "dead [plant] plant"
			spawn(600)
				if (src && get_area(get_turf(src)))
					if (get_area(get_turf(src)).location == 0)
						if (istype(src, /obj/structure/farming/plant/mushroom))
							stage += 1
					else
						var/currcl = get_area(get_turf(src)).climate
						var/count = 0
						for (var/i in biomes)
							if (i == currcl)
								if (currcl == "jungle" || currcl == "desert" || currcl == "savanna")
									count++
								for (var/k in seasons)
									if (season == k)
										count++
						if (count > 0 || (map.ID != MAP_NOMADS_CONTINENTAL && map.ID != MAP_NOMADS_PANGEA && map.ID != MAP_NOMADS_NEW_WORLD))
							stage += 1
					growth()

/obj/structure/farming/plant/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage < readyStageMin) // destroy
			user << "<span class = 'warning'>You uproot the [name].</span>"
			qdel(src)
		else if (readyHarvest()) // harvest
			spawnSeeds()
			spawnProduce()
			user << "<span class = 'warning'>You [harvest_verb] the [name].</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead [name].</span>"
			qdel(src)

/obj/structure/farming/plant/proc/water_proc()
	for(var/turf/floor/beach/water/WT in range(2,src))
		if (!WT.salty)
			water = max_water //water within 2 tiles means no need to manually water the plants.
			return
	for(var/turf/floor/trench/flooded/TR in range(2,src))
		if (TR.flooded && !TR.salty)
			water = max_water //water within 2 tiles means no need to manually water the plants.
			return
	var/area/A = get_area(loc)
	if (findtext(A.icon_state, "rain") || findtext(A.icon_state, "monsoon"))
		water += 15
		return
	else if (findtext(A.icon_state, "snow_storm"))
		stage = 11
		icon_state = "[plant]-dead"
		desc = "A frozen [plant] plant."
		name = "frozen [plant] plant"
		return
	else if (findtext(A.icon_state, "sandstorm"))
		stage = 11
		icon_state = "[plant]-dead"
		desc = "A destroyed [plant] plant."
		name = "destroyed [plant] plant"
		return
	var/currcl = get_area(get_turf(src)).climate
	if (currcl == "desert" || currcl == "savanna" || currcl == "semiarid")
		water -= 25
	else
		water -= 15

	if (map.heat_wave)
		water -= 10

	if (water <= 0)
		stage = 11
		icon_state = "[plant]-dead"
		desc = "A dry [plant] plant."
		name = "dry [plant] plant"
		return
	return
/obj/structure/farming/plant/examine(mob/user)
	..(user)
	if (ishuman(user))
		var/mob/living/carbon/human/H = user
		if (H.getStatCoeff("farming")>= 1.6 && H.getStatCoeff("farming") < 2.2)
			var/water_desc = "healthy"
			if (water/max_water < 0.66 && water/max_water >= 0.33)
				water_desc = "dry"
			if (water/max_water < 0.33)
				water_desc = "wilted"
			user << "\The [src] seems <b>[water_desc]</b>."
		else if (H.getStatCoeff("farming") >= 2.2)
			user << "[src]'s water level is at <b>[water]/[max_water]</b>."
		if (H.getStatCoeff("farming")>= 1.3)
			if (fertilized)
				user << "The ground is fertilized."

//some specific, non-food plants
/obj/structure/farming/plant/hemp/spawnProduce()
	var/obj/item/stack/material/rope/I = new/obj/item/stack/material/rope(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/stack/material/rope/I2 = new/obj/item/stack/material/rope(loc)
		I2.radiation = radiation/2

/obj/structure/farming/plant/tobacco/spawnProduce()
	var/obj/item/stack/material/tobacco/I = new/obj/item/stack/material/tobacco(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/stack/material/tobacco/I2 = new/obj/item/stack/material/tobacco(loc)
		I2.radiation = radiation/2

/obj/structure/farming/plant/coca/spawnProduce()
	var/obj/item/stack/material/coca/I = new/obj/item/stack/material/coca(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/stack/material/coca/I2 = new/obj/item/stack/material/coca(loc)
		I2.radiation = radiation/2

/obj/structure/farming/plant/sugarcane/spawnProduce()
	var/obj/item/weapon/reagent_containers/food/condiment/bsugar/I = new/obj/item/weapon/reagent_containers/food/condiment/bsugar(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/weapon/reagent_containers/food/condiment/bsugar/I2 = new/obj/item/weapon/reagent_containers/food/condiment/bsugar(loc)
		I2.radiation = radiation/2

/obj/structure/farming/plant/tea/spawnProduce()
	var/obj/item/weapon/reagent_containers/food/condiment/tealeaves/I = new/obj/item/weapon/reagent_containers/food/condiment/tealeaves(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/weapon/reagent_containers/food/condiment/tealeaves/I2 = new/obj/item/weapon/reagent_containers/food/condiment/tealeaves(loc)
		I2.radiation = radiation/2

/obj/structure/farming/plant/poppy/spawnProduce()
	var/obj/item/stack/material/poppy/I = new/obj/item/stack/material/poppy(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/stack/material/poppy/I2 = new/obj/item/stack/material/poppy(loc)
		I2.radiation = radiation/2

/obj/structure/farming/plant/tree/spawnProduce()
	var/obj/item/stack/material/wood/NW = new/obj/item/stack/material/wood(loc)
	NW.amount = 3
	NW.radiation = radiation/2
	if (fertilized)
		NW.amount = 6

/obj/structure/farming/plant/cotton/spawnProduce()
	var/obj/item/stack/material/cotton/I = new/obj/item/stack/material/cotton(loc)
	I.radiation = radiation/2
	if (fertilized)
		var/obj/item/stack/material/cotton/I2 = new/obj/item/stack/material/cotton(loc)
		I2.radiation = radiation/2