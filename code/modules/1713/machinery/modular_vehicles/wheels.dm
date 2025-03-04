//////////////DRIVING WHEELS///////////////////////

/obj/item/vehicleparts/wheel/modular
	name = "vehicle wheel"
	desc = "Used to steer a vehicle."
	icon_state = "wheel_b"
	var/obj/structure/bed/chair/drivers/drivingchair = null
	var/obj/structure/vehicleparts/frame/control = null
	var/lastdirchange = 0
/obj/item/vehicleparts/wheel/modular/proc/turndir(var/mob/living/mob = null, var/newdir = "left")
	if (world.time <= lastdirchange)
		return FALSE
	lastdirchange = world.time+15
	if (control && control.axis && (control.axis.moving == FALSE || control.axis.currentspeed == 0))
		return FALSE
	for(var/obj/effect/pseudovehicle/O in control.axis.components)
		for(var/obj/structure/vehicleparts/frame/VP in O.loc)
			if (VP.axis != control.axis)
				if (mob)
					mob << "<span class='warning'>You can't turn, something is in the way!</span>"
				return FALSE
		for(var/obj/effect/pseudovehicle/PV in O.loc)
			if (PV.link != control.axis)
				if (mob)
					mob << "<span class='warning'>You can't turn, something is in the way!</span>"
				return FALSE
	if (newdir == "left")
		control.axis.do_matrix(dir,TURN_LEFT(control.axis.dir), newdir)
	else
		control.axis.do_matrix(dir,TURN_RIGHT(control.axis.dir), newdir)
	return TRUE

/obj/structure/bed/chair/drivers/ex_act(severity)
	switch(severity)
		if (1.0)
			if (prob(40))
				Destroy()
				return
		if (2.0)
			if (prob(10))
				Destroy()
				return
		if (3.0)
			return

/obj/structure/bed/chair/drivers/Destroy()
	if (wheel)
		wheel.control.axis.wheel = null
		qdel(wheel)
	visible_message("<span class='danger'>The [name] gets destroyed!</span>")
	qdel(src)

/obj/item/vehicleparts/wheel/modular/attack_self(mob/living/carbon/human/H)
	if(!control)
		return
	if(!control.axis)
		return
	if (!(control.loc in range(1,loc)))
		H.remove_from_mob(src)
		src.forceMove(drivingchair)
		return
	if (!control.axis.engine || !control.axis.engine.fueltank)
		return
	if (!control.axis.engine.on && control.axis.engine.fueltank && control.axis.engine.fueltank.reagents && control.axis.engine.fueltank.reagents.total_volume > 0)
		control.axis.currentspeed = 0
		control.axis.engine.turn_on(H)
		if (isemptylist(control.axis.corners))
			control.axis.check_corners()
		if (isemptylist(control.axis.matrix))
			control.axis.check_matrix()
		playsound(loc, 'sound/machines/diesel_starting.ogg', 35, FALSE, 2)
		spawn(40)
			if (control.axis.engine && control.axis.engine.on)
				control.axis.engine.running_sound()
		return
	else if (control.axis && control.axis.engine && control.axis.engine.fueltank && control.axis.engine.fueltank.reagents.total_volume <= 0)
		H << "There is not enough fuel!"
		return
	if (control.axis.currentspeed < 0)
		control.axis.currentspeed = 0
	control.axis.currentspeed++
	if (control.axis.currentspeed>control.axis.speeds)
		control.axis.currentspeed = control.axis.speeds

	else
		var/spd = control.axis.get_speed()
		control.axis.vehicle_m_delay = spd
		if (control.axis.currentspeed == 1 && !control.axis.moving)
			control.axis.moving = TRUE
			H << "You put on the first gear."
			playsound(loc, 'sound/effects/lever.ogg',40, TRUE)
			control.axis.add_transporting()
			control.axis.startmovementloop()
		if (spd <= 0)
			return
		else
			H << "You increase the speed."
			playsound(loc, 'sound/effects/lever.ogg',40, TRUE)
			control.axis.vehicle_m_delay = spd
			return


/obj/item/vehicleparts/wheel/modular/secondary_attack_self(mob/living/carbon/human/user)
	if (!control || !control.axis)
		return
	if (control && control.axis && control.axis.engine && control.axis.engine.fueltank && (control.axis.currentspeed <= 0 || control.axis.engine.fueltank.reagents.total_volume <= 0))
		if (control.axis.engine.on)
			user << "You turn off the [control.axis.engine]."
			control.axis.engine.on = FALSE
			control.axis.moving = FALSE
			control.axis.currentspeed = 0
			control.axis.engine.update_icon()
			return

		return
	else
		var/spd = control.axis.get_speed()
		control.axis.currentspeed--
		spd = control.axis.get_speed()
		if (spd <= 0 || control.axis.currentspeed == 0)
			control.axis.moving = FALSE
			user << "You stop the [control.axis]."
			for (var/obj/structure/vehicleparts/movement/W in control.axis.wheels)
				W.update_icon()
			return
		else
			control.axis.vehicle_m_delay = spd
			user << "You reduce the speed."
			playsound(loc, 'sound/effects/lever.ogg',40, TRUE)
			return

/obj/structure/bed/chair/drivers
	name = "driver's seat"
	desc = "Where you drive the vehicle."
	icon = 'icons/obj/vehicleparts.dmi'
	icon_state = "driver_car"
	anchored = FALSE
	var/obj/item/vehicleparts/wheel/modular/wheel = null
	New()
		..()
		wheel = new/obj/item/vehicleparts/wheel/modular(src)
		wheel.drivingchair = src

/obj/structure/bed/chair/drivers/tank
	name = "tank driver's seat"
	icon_state = "driver_tank"

/obj/structure/bed/chair/drivers/user_unbuckle_mob(mob/user)
	var/mob/living/M = unbuckle_mob()
	if (M)
		if (M != user)
			M.visible_message(\
				"<span class='notice'>[M.name] was unbuckled by [user.name]!</span>",\
				"<span class='notice'>You were unbuckled from [src] by [user.name].</span>",\
				"<span class='notice'>You hear metal clanking.</span>")
		else
			M.visible_message(\
				"<span class='notice'>[M.name] unbuckled themselves!</span>",\
				"<span class='notice'>You unbuckle yourself from [src].</span>",\
				"<span class='notice'>You hear metal clanking.</span>")
		add_fingerprint(user)
		for(var/obj/item/vehicleparts/wheel/modular/MW in M)
			M.remove_from_mob(MW)
			MW.forceMove(src)
			if (wheel && wheel.control && wheel.control.axis && wheel.control.axis.engine && wheel.control.axis.engine.on)
				wheel.control.axis.engine.on = FALSE
				wheel.control.axis.moving = FALSE
				wheel.control.axis.currentspeed = 0
				wheel.control.axis.engine.update_icon()
				user << "You stop the [wheel.control.axis]."
				for (var/obj/structure/vehicleparts/movement/W in wheel.control.axis.wheels)
					W.update_icon()
	return M

/obj/structure/bed/chair/drivers/update_icon()
	return

/obj/structure/bed/chair/drivers/post_buckle_mob()
	if (buckled_mob && istype(buckled_mob, /mob/living/carbon/human) && buckled_mob.put_in_active_hand(wheel) == FALSE)
		buckled_mob << "Your hands are full!"
		return

/obj/structure/bed/chair/drivers/attackby(var/obj/item/I, var/mob/living/carbon/human/H)
	if (buckled_mob && H == buckled_mob && istype(I, /obj/item/vehicleparts/wheel/modular))
		H.remove_from_mob(I)
		I.forceMove(src)
		user_unbuckle_mob(H)
		return
	else
		..()
/obj/structure/bed/chair/drivers/attack_hand( var/mob/living/carbon/human/H)
	if (wheel && buckled_mob && H == buckled_mob && wheel.loc != H)
		if (buckled_mob.put_in_active_hand(wheel))
			H << "You grab the wheel."
			return
	else
		..()

////////GUNNER/LOADER CHAIR////////////

/obj/structure/bed/chair/gunner
	name = "gunner's seat"
	desc = "a seat next to the gun trigger."
	icon_state = "officechair_white"
	anchored = FALSE
/obj/structure/bed/chair/gunner/update_icon()
	return
/obj/structure/bed/chair/loader
	name = "loader's seat"
	desc = "A seat at the gun loader's position."
	icon_state = "officechair_white"
	anchored = FALSE
/obj/structure/bed/chair/loader/update_icon()
	return
//////////COMMANDER CHAIR/////////////
/obj/structure/bed/chair/commander
	name = "commander's seat"
	desc = "The vehicle commander's seat, with a perisope."
	anchored = FALSE
	icon = 'icons/obj/vehicleparts.dmi'
	icon_state = "commanders_seat"
	var/obj/item/weapon/attachment/scope/adjustable/binoculars/periscope/periscope = null
	New()
		..()
		periscope = new/obj/item/weapon/attachment/scope/adjustable/binoculars/periscope(src)
		periscope.commanderchair = src

/obj/structure/bed/chair/commander/user_unbuckle_mob(mob/user)
	var/mob/living/M = unbuckle_mob()
	if (M)
		if (M != user)
			M.visible_message(\
				"<span class='notice'>[M.name] was unbuckled by [user.name]!</span>",\
				"<span class='notice'>You were unbuckled from [src] by [user.name].</span>",\
				"<span class='notice'>You hear metal clanking.</span>")
		else
			M.visible_message(\
				"<span class='notice'>[M.name] unbuckled themselves!</span>",\
				"<span class='notice'>You unbuckle yourself from [src].</span>",\
				"<span class='notice'>You hear metal clanking.</span>")
		add_fingerprint(user)
		for(var/obj/item/weapon/attachment/scope/adjustable/binoculars/periscope/PS in M)
			M.remove_from_mob(PS)
			PS.forceMove(src)
	return M

/obj/structure/bed/chair/commander/update_icon()
	return

/obj/structure/bed/chair/commander/post_buckle_mob()
	if (buckled_mob && istype(buckled_mob, /mob/living/carbon/human) && buckled_mob.put_in_active_hand(periscope) == FALSE)
		buckled_mob << "Your hands are full!"
		return

/obj/structure/bed/chair/commander/attackby(var/obj/item/I, var/mob/living/carbon/human/H)
	if (buckled_mob && H == buckled_mob && istype(I, /obj/item/weapon/attachment/scope/adjustable/binoculars/periscope))
		H.remove_from_mob(I)
		I.forceMove(src)
		user_unbuckle_mob(H)
		return
	else
		..()
/obj/structure/bed/chair/commander/attack_hand( var/mob/living/carbon/human/H)
	if (buckled_mob && H == buckled_mob && periscope.loc != H)
		if (buckled_mob.put_in_active_hand(periscope))
			H << "You look through the periscope."
			return
	else
		..()
