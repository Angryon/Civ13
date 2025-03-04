/mob/living/simple_animal/pachy
	icon = 'icons/mob/animal_64.dmi'
	name = "Pachycephalosaurus"
	desc = "Pachy for short. Looks friendly"
	icon_state = "pachycephalosaurus"
	icon_living = "pachycephalosaurus"
	icon_dead = "pachycephalosaurus_dead"
	icon_gib = "pachycephalosaurus_dead"
	speak = list("skreee!","skrrrrr!","krrrr")
	speak_emote = list("rawr", "hiss")
	emote_hear = list("rawrs","hisses")
	emote_see = list("stares ferociously", "grunts")
	speak_chance = TRUE
	turns_per_move = 8
	see_in_dark = 6
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	meat_amount = 6
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicked"
	health = 140
	mob_size = MOB_LARGE
	layer = 3.99
	a_intent = I_HURT
	can_ride = TRUE

