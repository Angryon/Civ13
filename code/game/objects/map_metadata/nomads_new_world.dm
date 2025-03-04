#define NO_WINNER "The round is proceeding normally."
/obj/map_metadata/nomads_new_world
	ID = MAP_NOMADS_NEW_WORLD
	title = "Nomads (New World) (500x200x2)"
	lobby_icon_state = "civ13"
	caribbean_blocking_area_types = list(/area/caribbean/no_mans_land/invisible_wall/sea)
	respawn_delay = 6000 // 10 minutes!
	squad_spawn_locations = FALSE
//	min_autobalance_players = 90
	faction_organization = list(
		CIVILIAN,)
	available_subfactions = list(
		)
	roundend_condition_sides = list(
		list(CIVILIAN) = /area/caribbean/british
		)
	age = "5000 B.C."
	civilizations = TRUE
	var/tribes_nr = 1
	faction_distribution_coeffs = list(CIVILIAN = 1)
	battle_name = "the civilizations"
	mission_start_message = "<big>Human population is expanding fast, and this continent feels small to you - Maybe there is more land to the West? What dangers will it hold? It's up to you to find out, if you dare...</big><br><b>Wiki Guide: http://civ13.com/wiki/index.php/Nomads</b>"
	ambience = list('sound/ambience/jungle1.ogg')
	faction1 = CIVILIAN
	availablefactions = list("Nomad")
	songs = list(
		"Words Through the Sky:1" = 'sound/music/words_through_the_sky.ogg',)
	research_active = TRUE
	nomads = TRUE
	gamemode = "Classic (Stone Age Start)"
	var/list/arealist_r = list()
	var/list/arealist_g = list()
/obj/map_metadata/nomads_new_world/New()
	..()
	var/list/totalturfs = get_area_turfs(/area/caribbean/nomads/forest/Jungle)
	totalturfs += get_area_turfs(/area/caribbean/nomads/forest/savanna)
	spawn(1200)
		for (var/i = 1, i <= 100)
			var/turf/areaspawn = safepick(totalturfs)
			if (istype(areaspawn,/turf/floor/beach/water/jungle))
				new/obj/structure/piranha(areaspawn)
				i++
	spawn(600)
		for (var/i = 1, i <= 23)
			var/turf/areaspawn2 = safepick(totalturfs)
			if (istype(areaspawn2,/turf/floor/grass) || istype(areaspawn2,/turf/floor/dirt))
				new/obj/structure/anthill(areaspawn2)
				i++
	spawn(18000)
		seasons()

/obj/map_metadata/nomads_new_world/faction2_can_cross_blocks()
	return (ordinal_age >= 2)

/obj/map_metadata/nomads_new_world/faction1_can_cross_blocks()
	return (ordinal_age >= 2)

/obj/map_metadata/nomads_new_world/cross_message(faction)
	if (faction == CIVILIAN)
		return "<big><b>As the world technological level advances, new shipbuilding techniques make us at last be able to navigate the oceans...</b></big>"

/obj/map_metadata/nomads_new_world/proc/seasons()
	if (season == "FALL")
		season = "WINTER"
		world << "<big>The <b>Winter</b> has started. In the hot climates, the wet season has started.</big>"
			change_weather_somehow()
		for (var/turf/floor/dirt/flooded/D)
			D.ChangeTurf(/turf/floor/beach/water/flooded)
		for (var/turf/floor/dirt/ploughed/flooded/D in get_area_turfs(/area/caribbean/nomads/forest/Jungle))
			D.ChangeTurf(/turf/floor/beach/water/flooded)
		for (var/turf/floor/dirt/ploughed/flooded/D2 in get_area_turfs(/area/caribbean/nomads/forest/savanna))
			D2.ChangeTurf(/turf/floor/beach/water/flooded)
		for(var/obj/structure/sink/S)
			if (istype(S, /obj/structure/sink/well) || istype(S, /obj/structure/sink/puddle))
				S.dry = FALSE
				S.update_icon()
		for (var/turf/floor/beach/drywater/B in get_area_turfs(/area/caribbean/nomads/desert))
			B.ChangeTurf(/turf/floor/beach/water/swamp)
		for (var/turf/floor/beach/drywater2/C in get_area_turfs(/area/caribbean/nomads/desert))
			C.ChangeTurf(/turf/floor/beach/water/deep/swamp)
		for (var/turf/floor/dirt/jungledirt/JD in get_area_turfs(/area/caribbean/nomads/forest/Jungle))
			if (prob(50))
				JD.ChangeTurf(/turf/floor/grass/jungle)
		for (var/turf/floor/dirt/jungledirt/JD2 in get_area_turfs(/area/caribbean/nomads/forest/savanna))
			if (prob(50))
				JD2.ChangeTurf(/turf/floor/grass/jungle)
		for (var/turf/floor/dirt/burned/BD in get_area_turfs(/area/caribbean/nomads/desert))
			if (prob(75))
				BD.ChangeTurf(/turf/floor/dirt)
		for (var/turf/floor/dirt/burned/BDD in get_area_turfs(/area/caribbean/nomads/forest/Jungle))
			if (prob(75))
				BDD.ChangeTurf(/turf/floor/dirt/jungledirt)
		for (var/turf/floor/dirt/burned/BDD2 in get_area_turfs(/area/caribbean/nomads/forest/savanna))
			if (prob(75))
				BDD2.ChangeTurf(/turf/floor/dirt/jungledirt)
		for (var/turf/floor/dirt/DT in get_area_turfs(/area/caribbean/nomads/forest))
			if (!istype(DT, /turf/floor/dirt/underground))
				if (get_area(DT).climate == "temperate")
					if (prob(75))
						DT.ChangeTurf(/turf/floor/dirt/winter)
				else if (get_area(DT).climate == "tundra" || get_area(DT).climate == "taiga")
					DT.ChangeTurf(/turf/floor/dirt/winter)
		for (var/turf/floor/grass/GT in get_area_turfs(/area/caribbean/nomads/forest))
			if (get_area(GT).climate == "temperate")
				if (prob(80))
					GT.ChangeTurf(/turf/floor/winter/grass)
			else if (get_area(GT).climate == "tundra" || get_area(GT).climate == "taiga")
				GT.ChangeTurf(/turf/floor/winter/grass)
		for (var/turf/floor/dirt/DTT in get_area_turfs(/area/caribbean/nomads/snow))
			if (!istype(DTT, /turf/floor/dirt/underground))
				DTT.ChangeTurf(/turf/floor/dirt/winter)
		for (var/turf/floor/grass/GTT in get_area_turfs(/area/caribbean/nomads/snow))
			GTT.ChangeTurf(/turf/floor/winter/grass)

	else if (season == "SPRING")
		season = "SUMMER"
		world << "<big>The <b>Summer</b> has started. In the hot climates, the dry season has started.</big>"
			change_weather_somehow()
		for(var/obj/structure/sink/S in get_area_turfs(/area/caribbean/nomads/desert))
			if (istype(S, /obj/structure/sink/well) || istype(S, /obj/structure/sink/puddle))
				S.dry = TRUE
				S.update_icon()
		for (var/turf/floor/beach/water/swamp/D in get_area_turfs(/area/caribbean/nomads/desert))
			if (D.z > 1)
				D.ChangeTurf(/turf/floor/beach/drywater)
		for (var/turf/floor/beach/water/deep/swamp/DS in get_area_turfs(/area/caribbean/nomads/desert))
			if (DS.z > 1)
				DS.ChangeTurf(/turf/floor/beach/drywater2)
		for (var/turf/floor/beach/water/flooded/DF in get_area_turfs(/area/caribbean/nomads/forest/Jungle))
			if (DF.z > 1)
				DF.ChangeTurf(/turf/floor/dirt/flooded)
		for (var/turf/floor/beach/water/flooded/DF2 in get_area_turfs(/area/caribbean/nomads/forest/savanna))
			if (DF2.z > 1)
				DF2.ChangeTurf(/turf/floor/dirt/flooded)
		for (var/turf/floor/dirt/winter/DT in get_area_turfs(/area/caribbean/nomads/forest))
			if (get_area(DT).climate == "temperate")
				DT.ChangeTurf(/turf/floor/dirt)
		for (var/turf/floor/winter/grass/GT in get_area_turfs(/area/caribbean/nomads/forest))
			if (get_area(GT).climate == "temperate")
				GT.ChangeTurf(/turf/floor/grass)
	else if (season == "WINTER")
		season = "SPRING"
		world << "<big>The weather is getting warmer. It is now <b>Spring</b>. In the hot climates, the wet season continues.</big>"
		for (var/obj/structure/wild/tree/live_tree/TREES)
			TREES.change_season()
		for (var/turf/floor/dirt/winter/D in get_area_turfs(/area/caribbean/nomads/forest))
			if (get_area(D).climate == "temperate")
				if (prob(60))
					D.ChangeTurf(/turf/floor/dirt)
		for (var/turf/floor/winter/grass/G in get_area_turfs(/area/caribbean/nomads/forest))
			if (get_area(G).climate == "temperate")
				if (prob(60))
					G.ChangeTurf(/turf/floor/grass)
		spawn(150)
			change_weather(WEATHER_NONE)
			for (var/obj/structure/window/snowwall/SW1 in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(get_turf(SW1)).climate == "temperate")
					if (prob(60))
						qdel(SW1)
			for (var/obj/covers/snow_wall/SW2 in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(get_turf(SW2)).climate == "temperate")
					if (prob(60))
						qdel(SW2)
			for (var/obj/item/weapon/snowwall/SW3 in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(get_turf(SW3)).climate == "temperate")
					if (prob(60))
						qdel(SW3)
		spawn(3000)
			for (var/turf/floor/dirt/winter/D in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(D).climate == "temperate")
					D.ChangeTurf(/turf/floor/dirt)
			for (var/turf/floor/winter/grass/G in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(G).climate == "temperate")
					G.ChangeTurf(/turf/floor/grass)
			for (var/obj/structure/window/snowwall/SW1 in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(get_turf(SW1)).climate == "temperate")
					qdel(SW1)
			for (var/obj/covers/snow_wall/SW2 in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(get_turf(SW2)).climate == "temperate")
					qdel(SW2)
			for (var/obj/item/weapon/snowwall/SW3 in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(get_turf(SW3)).climate == "temperate")
					qdel(SW3)
	else if (season == "SUMMER")
		season = "FALL"
		world << "<big>The leaves start to fall and the weather gets colder. It is now <b>Fall</b>. In the hot climates, the dry season continues.</big>"
		for (var/obj/structure/wild/tree/live_tree/TREES)
			TREES.change_season()
		for (var/turf/floor/dirt/burned/BD)
			BD.ChangeTurf(/turf/floor/dirt)
		for (var/turf/floor/grass/G)
			G.update_icon()
		spawn(100)
			change_weather(WEATHER_RAIN)
		spawn(15000)
			change_weather(WEATHER_SNOW)
			for (var/turf/floor/dirt/D in get_area_turfs(/area/caribbean/nomads/forest))
				if (z == world.maxz && prob(40) && !istype(D, /turf/floor/dirt/underground) && !istype(D, /turf/floor/dirt/dust))
					D.ChangeTurf(/turf/floor/dirt/winter)
			for (var/turf/floor/grass/G in get_area_turfs(/area/caribbean/nomads/forest))
				if (get_area(G).climate == "temperate")
					if (prob(40))
						G.ChangeTurf(/turf/floor/winter/grass)
			spawn(1200)
				for (var/turf/floor/dirt/D in get_area_turfs(/area/caribbean/nomads/forest))
					if (!istype(D,/turf/floor/dirt/winter) && (get_area(D).climate == "temperate"))
						if (D.z == world.maxz && prob(50) && !istype(D,/turf/floor/dirt/underground))
							D.ChangeTurf(/turf/floor/dirt/winter)
				for (var/turf/floor/grass/G in get_area_turfs(/area/caribbean/nomads/forest))
					if (get_area(G).climate == "temperate")
						if (prob(50))
							G.ChangeTurf(/turf/floor/winter/grass)
	spawn(18000)
		seasons()


/obj/map_metadata/nomads_new_world/job_enabled_specialcheck(var/datum/job/J)
	if (J.is_nomad == TRUE)
		. = TRUE
	else
		. = FALSE
#undef NO_WINNER

