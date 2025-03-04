/process/explosion
	var/list/work_queue
	var/ticks_without_work = 0
	var/list/explosion_turfs
	var/explosion_in_progress
	var/powernet_update_pending = FALSE

/process/explosion/setup()
	name = "explosion"
	schedule_interval = 0.5 SECONDS
	work_queue = list()
	fires_at_gamestates = list(GAME_STATE_PLAYING, GAME_STATE_FINISHED)
	priority = PROCESS_PRIORITY_HIGH
	always_runs = TRUE
	processes.explosion = src

/process/explosion/fire()
	if (!work_queue)
		setup()	// fix for process failing to re-init after termination

	if (!(work_queue.len))
		ticks_without_work++
/*		if (powernet_update_pending && ticks_without_work > 5)
			makepowernets()
			powernet_update_pending = FALSE*/
		return

	ticks_without_work = 0
	powernet_update_pending = TRUE

	for (current in work_queue)
		var/datum/explosiondata/data = current

		if (data.is_rec)
			explosion_rec(data.epicenter, data.rec_pow)
		else
			explosion(data)

		work_queue -= data

		PROCESS_TICK_CHECK

// this process does not use current_list, which will be == null
/process/explosion/reset_current_list()
	return

/process/explosion/proc/explosion(var/datum/explosiondata/data)
	var/turf/epicenter = data.epicenter
	var/devastation_range = data.devastation_range
	var/heavy_impact_range = data.heavy_impact_range
	var/light_impact_range = data.light_impact_range
	var/flash_range = data.flash_range
	var/adminlog = data.adminlog
	var/z_transfer = data.z_transfer
	var/power = data.rec_pow

	if (config.use_recursive_explosions)
		explosion_rec(epicenter, power)
		return

	var/start = world.timeofday
	epicenter = get_turf(epicenter)
	if (!epicenter) return

	// Handles recursive propagation of explosions.
	if (devastation_range > 2 || heavy_impact_range > 2)
		if (HasAbove(epicenter.z) && z_transfer & UP)
			explosion(GetAbove(epicenter), max(0, devastation_range - 2), max(0, heavy_impact_range - 2), max(0, light_impact_range - 2), max(0, flash_range - 2), FALSE, UP)
		if (HasBelow(epicenter.z) && z_transfer & DOWN)
			explosion(GetAbove(epicenter), max(0, devastation_range - 2), max(0, heavy_impact_range - 2), max(0, light_impact_range - 2), max(0, flash_range - 2), FALSE, DOWN)

	var/max_range = max(devastation_range, heavy_impact_range, light_impact_range, flash_range)

	// Play sounds; we want sounds to be different depending on distance so we will manually do it ourselves.
	// Stereo users will also hear the direction of the explosion!
	// Calculate far explosion sound range. Only allow the sound effect for heavy/devastating explosions.
	// 3/7/14 will calculate to 80 + 35
	var/far_dist = 0
	far_dist += heavy_impact_range * 5
	far_dist += devastation_range * 20
	// Play sounds; we want sounds to be different depending on distance so we will manually do it ourselves.

	// Stereo users will also hear the direction of the explosion!

	// Calculate far explosion sound range. Only allow the sound effect for heavy/devastating explosions.

	// 3/7/14 will calculate to 80 + 35
	var/volume = 10 + (power * 20)

	var/frequency = get_rand_frequency()
	var/closedist = round(max_range + 7 - 2, 1)

	//Whether or not this explosion causes enough vibration to send sound or shockwaves through the station
	var/vibration = TRUE

	if (vibration)
		for (var/player in player_list)
			var/mob/M = player
			// Double check for client
			var/reception = 2//Whether the person can be shaken or hear sound
			//2 = BOTH
			//1 = shockwaves only
			//0 = no effect
			if (M && M.client)
				var/turf/M_turf = get_turf(M)

				if (M_turf && M_turf.z == epicenter.z)

					if (!reception)
						continue

					var/dist = get_dist(M_turf, epicenter)
					if (reception == 2 && (M.ear_deaf <= 0 || !M.ear_deaf))//Dont play sounds to deaf people
						// If inside the blast radius + 7 - 2
						if (dist <= closedist)
							M.playsound_local(epicenter, get_sfx("explosion"), min(100, volume), TRUE, frequency, falloff = 5) // get_sfx() is so that everyone gets the same sound
							//You hear a far explosion if you're outside the blast radius. Small bombs shouldn't be heard all over the station.

						else
							volume = M.playsound_local(epicenter, 'sound/effects/explosionfar.ogg', volume, TRUE, frequency, falloff = 1000)
							//Playsound local will return the final volume the sound is actually played at
							//It will return FALSE if the sound volume falls to FALSE due to falloff or pressure
							//Also return zero if sound playing failed for some other reason

					//Deaf people will feel vibrations though
					if (volume > 0)//Only shake camera if someone was close enough to hear it
						shake_camera(M, min(60,max(2,(power*18*0.25) / dist)), min(3.5,((power*3*0.25) / dist)),0.05)
						//Maximum duration is 6 seconds, and max strength is 3.5
						//Becuse values higher than those just get really silly

	if (adminlog)
		message_admins("Explosion with size ([devastation_range], [heavy_impact_range], [light_impact_range]) in area [epicenter.loc.name] ([epicenter.x],[epicenter.y],[epicenter.z]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[epicenter.x];Y=[epicenter.y];Z=[epicenter.z]'>JMP</a>)")
		log_game("Explosion with size ([devastation_range], [heavy_impact_range], [light_impact_range]) in area [epicenter.loc.name] ")

	if (heavy_impact_range > 0)
		var/datum/effect/system/explosion/E = new/datum/effect/system/explosion()
		E.set_up(epicenter)
		E.start()

	var/x0 = epicenter.x
	var/y0 = epicenter.y
	var/z0 = epicenter.z

	for (var/turf/T in trange(max_range, epicenter))
		var/dist = sqrt((T.x - x0)**2 + (T.y - y0)**2)

		if (dist < devastation_range)		dist = 1
		else if (dist < heavy_impact_range)	dist = 2
		else if (dist < light_impact_range)	dist = 3
		else								continue
		var/found_epicenter = FALSE
		var/found_target = FALSE
		for (var/obj/structure/vehicleparts/frame/FE in epicenter)
			found_epicenter = TRUE
		for (var/obj/structure/vehicleparts/frame/FT in T)
			found_target = TRUE
		if (found_target == found_epicenter)
			T.ex_act(dist)
			if (T && !data.objects_with_immunity.Find(T))
				for (var/something in T.contents)	//bypass type checking since only atom/movable can be contained by turfs anyway
					var/atom/movable/AM = something
					if (data.objects_with_immunity.Find(AM))
						continue
					if (AM && AM.simulated)	AM.ex_act(dist)
					if (istype(AM, /mob/living/carbon/human))
						var/mob/living/carbon/human/H = AM
						if (H)
							switch(dist)
								if (1)
									H.maim()
									H.maim()
									H.adjustFireLoss(rand(35,70))
								if (2)
									if (prob(50))
										H.maim()
									H.adjustFireLoss(rand(25,35))
								if (3)
									if (prob(50))
										H.adjustFireLoss(rand(15,20))
	if (prob(25))
		new/obj/effect/fire(epicenter)
	var/took = (world.timeofday-start)/10
	//You need to press the DebugGame verb to see these now....they were getting annoying and we've collected a fair bit of data. Just -test- changes  to explosion code using this please so we can compare
	if (Debug2)	world.log << "## DEBUG: Explosion([x0],[y0],[z0])(d[devastation_range],h[heavy_impact_range],l[light_impact_range]): Took [took] seconds."

/process/explosion/proc/explosion_rec(turf/epicenter, power)
	if (power <= 0) return
	epicenter = get_turf(epicenter)
	if (!epicenter) return

	message_admins("Explosion with size ([power]) in area [epicenter.loc.name] ([epicenter.x],[epicenter.y],[epicenter.z])")
	log_game("Explosion with size ([power]) in area [epicenter.loc.name] ")

	playsound(epicenter, 'sound/effects/explosionfar.ogg', 100, TRUE, round(power*2,1) )
	playsound(epicenter, "explosion", 100, TRUE, round(power,1) )

	explosion_in_progress = TRUE
	explosion_turfs = list()

	explosion_turfs[epicenter] = power

	//This steap handles the gathering of turfs which will be ex_act() -ed in the next step. It also ensures each turf gets the maximum possible amount of power dealt to it.
	for (var/direction in cardinal)
		var/turf/T = get_step(epicenter, direction)
		explosion_spread(T, power - epicenter.explosion_resistance, direction)

	//This step applies the ex_act effects for the explosion, as planned in the previous step.
	for (var/turf in explosion_turfs)
		var/turf/T = turf
		if (explosion_turfs[T] <= 0) continue
		if (!T) continue

		//Wow severity looks confusing to calculate... Fret not, I didn't leave you with any additional instructions or help. (just kidding, see the line under the calculation)
		var/severity = 4 - round(max(min( 3, ((explosion_turfs[T] - T.explosion_resistance) / (max(3,(power/3)))) ) ,1), TRUE)								//sanity			effective power on tile				divided by either 3 or one third the total explosion power
								//															One third because there are three power levels and I
								//															want each one to take up a third of the crater
		var/x = T.x
		var/y = T.y
		var/z = T.z
		T.ex_act(severity)
		if (!T)
			T = locate(x,y,z)
		for (var/something in T.contents)
			var/atom/movable/AM = something
			AM.ex_act(severity)

	explosion_in_progress = FALSE

/process/explosion/proc/explosion_spread(turf/s, power, direction)
	if (power <= 0)
		return

	if (explosion_turfs[s] >= power)
		return //The turf already sustained and spread a power greated than what we are dealing with. No point spreading again.
	explosion_turfs[s] = power

	var/spread_power = power - s.explosion_resistance //This is the amount of power that will be spread to the tile in the direction of the blast

	for (var/obj/O in s)
		if (O.explosion_resistance)
			spread_power -= O.explosion_resistance

	var/turf/T = get_step(s, direction)
	explosion_spread(T, spread_power, direction)
	T = get_step(s, turn(direction,90))
	explosion_spread(T, spread_power, turn(direction,90))
	T = get_step(s, turn(direction,-90))
	explosion_spread(T, spread_power, turn(direction,90))

/process/explosion/proc/queue(var/datum/explosiondata/data)
	if (!data) return
	work_queue += data

/process/explosion/statProcess()
	..()
	stat(null, "[work_queue.len] datums in explosion queue")

/process/explosion/htmlProcess()
	return ..() + "[work_queue.len] datums in explosion queue"

/datum/explosiondata
	var/turf/epicenter
	var/devastation_range
	var/heavy_impact_range
	var/light_impact_range
	var/flash_range
	var/adminlog
	var/z_transfer
	var/is_rec
	var/rec_pow
	var/list/objects_with_immunity = list()