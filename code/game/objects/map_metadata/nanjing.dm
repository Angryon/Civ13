#define NO_WINNER "The battle is still going on."
/obj/map_metadata/nanjing
	ID = MAP_NANJING
	title = "Nanjing (120x200x2)"
	lobby_icon_state = "ww2"
	caribbean_blocking_area_types = list(/area/caribbean/no_mans_land/invisible_wall/)
	respawn_delay = 1200
	squad_spawn_locations = FALSE
	faction_organization = list(
		JAPANESE,
		CHINESE)
	available_subfactions = list(
		)
	roundend_condition_sides = list(
		list(CHINESE) = /area/caribbean/russian/land/inside/command,
		list(JAPANESE) = /area/caribbean/japanese/land/inside/command,
		)
	age = "1939"
	ordinal_age = 6
	faction_distribution_coeffs = list(JAPANESE = 0.4, CHINESE = 0.6)
	battle_name = "battle of Nanjing"
	mission_start_message = "<font size=4>All factions have <b>8 minutes</b> to prepare before the ceasefire ends!<br>The Japanese will win if they capture the <b>Chinese command</b>. The Chinese will win if they manage to defend their command for <b>30 minutes!</b>.</font>"
	faction1 = JAPANESE
	faction2 = CHINESE
	valid_weather_types = list(WEATHER_NONE, WEATHER_RAIN)
	songs = list(
		"Neue Deutsche Welle (Remix):1" = 'sound/music/neue_deutsche_welle.ogg',)

/obj/map_metadata/nanjing/job_enabled_specialcheck(var/datum/job/J)
	..()
	if (J.is_ww2 == TRUE && J.is_tanker == FALSE)
		. = TRUE
	else
		. = FALSE

/obj/map_metadata/nanjing/faction1_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 4800 || admin_ended_all_grace_periods)

/obj/map_metadata/nanjing/faction2_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 4800 || admin_ended_all_grace_periods)


/obj/map_metadata/nanjing/roundend_condition_def2name(define)
	..()
	switch (define)
		if (JAPANESE)
			return "Japanese"
		if (CHINESE)
			return "Chinese"
/obj/map_metadata/nanjing/roundend_condition_def2army(define)
	..()
	switch (define)
		if (JAPANESE)
			return "Japanese"
		if (CHINESE)
			return "Chinese"

/obj/map_metadata/nanjing/army2name(army)
	..()
	switch (army)
		if ("Japanese")
			return "Japanese"
		if ("Chinese")
			return "People's Liberation Army"


/obj/map_metadata/nanjing/cross_message(faction)
	if (faction == CHINESE)
		return "<font size = 4>The Chinese may now cross the invisible wall!</font>"
	else if (faction == JAPANESE)
		return "<font size = 4>The Japanese may now cross the invisible wall!</font>"

/obj/map_metadata/nanjing/reverse_cross_message(faction)
	if (faction == CHINESE)
		return "<span class = 'userdanger'>The Chinese may no longer cross the invisible wall!</span>"
	else if (faction == JAPANESE)
		return "<span class = 'userdanger'>The Japanese may no longer cross the invisible wall!</span>"

var/no_loop_n = FALSE

/obj/map_metadata/nanjing/update_win_condition()
	if (!win_condition_specialcheck())
		return FALSE
	if (world.time >= 18000)
		if (win_condition_spam_check)
			return FALSE
		ticker.finished = TRUE
		var/message = "The <b>Chinese</b> have sucessfuly defended the city of Nanjing! The Japanese have halted the attack!"
		world << "<font size = 4><span class = 'notice'>[message]</span></font>"
		show_global_battle_report(null)
		win_condition_spam_check = TRUE
		return FALSE
	if ((current_winner && current_loser && world.time > next_win) && no_loop_r == FALSE)
		ticker.finished = TRUE
		var/message = "The <b>Japanese</b> have captured the city of Nanjing! The battle for Nanjing is over!"
		world << "<font size = 4><span class = 'notice'>[message]</span></font>"
		show_global_battle_report(null)
		win_condition_spam_check = TRUE
		no_loop_n = TRUE
		return FALSE
	// German major
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.33, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.33))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Japanese</b> have reached the Nanjing Command! They will win in {time} minutes."
				next_win = world.time + short_win_time(JAPANESE)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[1][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[2][1])
	// German minor
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.01, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.01))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Japanese</b> have reached the Nanjing Command! They will win in {time} minutes."
				next_win = world.time + short_win_time(JAPANESE)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[1][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[2][1])
	// Soviet major
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.33, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.33))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Japanese</b> have reached the Nanjing Command! They will win in {time} minutes."
				next_win = world.time + short_win_time(JAPANESE)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[2][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[1][1])
	// Soviet minor
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.01, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.01))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Japanese</b> have reached the Nanjing Command! They will win in {time} minutes."
				next_win = world.time + short_win_time(JAPANESE)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[2][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[1][1])
	else
		if (current_win_condition != NO_WINNER && current_winner && current_loser)
			world << "<font size = 3>The <b>Chinese</b> have recaptured the Nanjing Command!</font>"
			current_winner = null
			current_loser = null
		next_win = -1
		current_win_condition = NO_WINNER
		win_condition.hash = 0
	last_win_condition = win_condition.hash
	return TRUE
#undef NO_WINNER