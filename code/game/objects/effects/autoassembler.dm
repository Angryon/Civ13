//automatically assembles a vehicle in a certain range.
//requirements: 1 engine, 1 fueltank, 1 axis, 1 driving seat. All must have frames in their respective tiles.

/obj/effect/autoassembler
	name = "auto assembler"
	desc = "automatically assembles a vehicle in range."
	icon = 'icons/mob/screen/effects.dmi'
	icon_state = "AA"
	invisibility = 101
	anchored = TRUE
	density = TRUE
	opacity = FALSE
	var/rangef = 2

/obj/effect/autoassembler/New()
	..()
	spawn(10)
		var/rangeto = range(rangef,loc)
		//first we assign the axis
		var/done1 = FALSE
		var/obj/structure/vehicleparts/frame/central = null
		for (var/obj/structure/vehicleparts/axis/A in rangeto)
			if (!done1)
				for (var/obj/structure/vehicleparts/frame/F in A.loc)
					if (!done1)
						A.MouseDrop(F)
						done1 = TRUE
						central = F
		if (!central)
			world.log << "<b>Axis error! ([x],[y])</b>"
			return FALSE
		//now connect all the frames
		for (var/obj/structure/vehicleparts/frame/A in rangeto)
			if (!A.axis)
				A.axis = central.axis
				A.color_code = central.color_code
				var/found = FALSE
				for (var/obj/structure/vehicleparts/frame/F in central.axis.components)
					if (F == src)
						found = TRUE
				if (!found)
					central.axis.components += A
				A.anchored = TRUE
				A.dir = central.axis.components
				A.name = central.axis.name
		for (var/obj/structure/vehicleparts/frame/AA in loc)
			if (!AA.axis)
				AA.axis = central.axis
				AA.color_code = central.color_code
				var/found = FALSE
				for (var/obj/structure/vehicleparts/frame/F in central.axis.components)
					if (F == src)
						found = TRUE
				if (!found)
					central.axis.components += AA
				AA.anchored = TRUE
				AA.dir = central.axis.components
				AA.name = central.axis.name
		for (var/turf/T in rangeto)
			var/doneps = FALSE
			for (var/obj/structure/vehicleparts/frame/FRE in T)
				if (FRE.axis)
					doneps = TRUE
			if (!doneps)
				var/obj/effect/pseudovehicle/PV = new/obj/effect/pseudovehicle(T)
				PV.link = central.axis
				PV.dir = central.axis.dir
				central.axis.components += PV
		//then the engine
		var/done2 = FALSE
		for (var/obj/structure/engine/internal/E in rangeto)
			if (!done2)
				for (var/obj/structure/vehicleparts/frame/F in E.loc)
					if (!done2)
						central.axis.engine = E
						E.anchored = TRUE
						E.icon = 'icons/obj/vehicleparts.dmi'
						E.engineclass = "engine"
						E.update_icon()
						done2 = TRUE
		for (var/obj/structure/vehicleparts/movement/sails/S in rangeto)
			for (var/obj/structure/vehicleparts/frame/ship/F in S.loc)
				central.axis.masts += S
				S.anchored = TRUE
				S.dir = central.axis.dir
				S.update_icon()
//		if (!done2)
//			world.log << "<b>Engine error! ([x],[y])</b>"
//			return FALSE
		//then the fueltank
		var/done3 = FALSE
		for (var/obj/item/weapon/reagent_containers/glass/barrel/fueltank/E in rangeto)
			if (!done3)
				central.axis.engine.fueltank = E
				E.anchored = TRUE
				done3 = TRUE
//		if (!done3)
//			world.log << "<b>Fueltank error! ([x],[y])</b>"
//			return FALSE
		//finally, the drivers seat
		var/done4 = FALSE
		for (var/obj/structure/bed/chair/drivers/D in rangeto)
			if (!done4)
				for (var/obj/structure/vehicleparts/frame/F in D.loc)
					if (!done4)
						D.anchored = TRUE
						D.dir = dir
						central.axis.wheel = D.wheel
						central.axis.wheel.control = F
						done4 = TRUE
		for (var/obj/structure/vehicleparts/shipwheel/D in rangeto)
			if (!done4)
				for (var/obj/structure/vehicleparts/frame/ship/F in D.loc)
					if (!done4)
						D.anchored = TRUE
						D.dir = dir
						D.ship = central.axis
						done4 = TRUE
//		if (!done4)
//			world.log << "<b>Driver's Seat error! ([x],[y])</b>"
//			return FALSE
		sleep(2)
		if (isemptylist(central.axis.corners))
			central.axis.check_corners()
		if (isemptylist(central.axis.matrix))
			central.axis.check_matrix()
		//and the tracks
		for (var/obj/structure/vehicleparts/movement/M in rangeto)
			if (!istype(M, /obj/structure/vehicleparts/movement/sails))
				for (var/obj/structure/vehicleparts/frame/F in M.loc)
					M.MouseDrop(F)
		for (var/obj/structure/lamp/lamp_small/tank/TL in rangeto)
			for (var/obj/structure/vehicleparts/frame/F in TL.loc)
				TL.connection = central.axis.engine
		for (var/obj/structure/vehicleparts/VP in range(7,src))
			VP.dir = central.axis.dir
			VP.update_icon()
//		world.log << "[central.axis] assembly complete."
		qdel(src)
		return TRUE