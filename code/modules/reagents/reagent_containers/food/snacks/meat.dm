/obj/item/weapon/reagent_containers/food/snacks/meat
	name = "meat"
	desc = "A slab of meat."
	icon_state = "meat"
	health = 180
	filling_color = "#FF1C1C"
	center_of_mass = list("x"=16, "y"=14)
	raw = TRUE
	var/rotten = FALSE
	non_vegetarian = TRUE
	decay = 15*600
	New()
		..()
		reagents.add_reagent("protein", 5)
		bitesize = 3
	satisfaction = -6
/obj/item/weapon/reagent_containers/food/snacks/meat/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (!roasted && !rotten && (istype(W,/obj/item/weapon/material/knife) || istype(W,/obj/item/weapon/material/kitchen/utensil/knife)))
		new /obj/item/weapon/reagent_containers/food/snacks/rawcutlet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/rawcutlet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/rawcutlet(src)
		user << "You cut the meat into thin strips."
		qdel(src)
	else
		..()
/obj/item/weapon/reagent_containers/food/snacks/meat/New()
	..()
	spawn(3000) //5 minutes
		icon_state = "rottenmeat"
		name = "rotten [name]"
		if (reagents)
			reagents.remove_reagent("protein", 2)
			reagents.add_reagent("food_poisoning", 1)
		rotten = TRUE
		satisfaction = -10
		spawn(1000)
			if (isturf(loc) && prob(30))
				var/scavengerspawn = rand(1,3)
				if(scavengerspawn ==  1)
					new/mob/living/simple_animal/mouse(get_turf(src))
				else if(scavengerspawn ==  2)
					new/mob/living/simple_animal/cockroach(get_turf(src))
				else
					new/mob/living/simple_animal/fly(get_turf(src))
		spawn(3600)
			qdel(src)

// Seperate definitions because some food likes to know if it's human.
// TODO: rewrite kitchen code to check a var on the meat item so we can remove
// all these sybtypes.
/obj/item/weapon/reagent_containers/food/snacks/meat/human
	name = "human meat"
	desc = "Tastes like chicken."

/obj/item/weapon/reagent_containers/food/snacks/meat/monkey
	name = "monkey meat"
	desc = "Tastes like human."

/obj/item/weapon/reagent_containers/food/snacks/meat/turtle
	name = "turtle meat"
	desc = "Tastes like... something."

/obj/item/weapon/reagent_containers/food/snacks/meat/poisonfrog
	name = "poisonous frog meat"
	desc = "Probably not a good idea to put it in the stew."
	var/uses = 4
	New()
		..()
		reagents.add_reagent("food_poisoning", 15)
		reagents.add_reagent("cyanide", 25)

/obj/item/weapon/reagent_containers/food/snacks/rawfish
	name = "raw fish"
	desc = "A fresh fish. Should probably cook it first."
	icon_state = "rawfish"
	health = 180
	filling_color = "#606060"
	center_of_mass = list("x"=16, "y"=14)
	raw = TRUE
	var/rotten = FALSE
	non_vegetarian = TRUE
	New()
		..()
		reagents.add_reagent("protein", 4)
		reagents.add_reagent("food_poisoning", 1)
		bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/rawfish/salmon
	name = "raw salmon"
	desc = "A fresh salmon. Should probably cook it first."
	icon_state = "salmon"

/obj/item/weapon/reagent_containers/food/snacks/rawfish/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (!roasted && !rotten && (istype(W,/obj/item/weapon/material/knife) || istype(W,/obj/item/weapon/material/kitchen/utensil/knife)))
		new /obj/item/weapon/reagent_containers/food/snacks/fishfillet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/fishfillet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/fishfillet(src)
		user << "You cut the fish into thin fillets."
		qdel(src)
	else
		..()

/obj/item/weapon/reagent_containers/food/snacks/rawfish/salmon/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (!roasted && !rotten && (istype(W,/obj/item/weapon/material/knife) || istype(W,/obj/item/weapon/material/kitchen/utensil/knife)))
		new /obj/item/weapon/reagent_containers/food/snacks/salmonfillet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/salmonfillet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/salmonfillet(src)
		user << "You cut the salmon into thin fillets."
		qdel(src)
	else
		..()

/obj/item/weapon/reagent_containers/food/snacks/rawfish/New()
	..()
	spawn(3000) //5 minutes
		if (!src)
			return
		icon_state = "rottenfish"
		name = "rotten [name]"
		if (reagents)
			reagents.remove_reagent("protein", 2)
			reagents.add_reagent("food_poisoning", 1)
		rotten = TRUE
		spawn(1000)
			if (isturf(loc) && prob(30))
				var/scavengerspawn = rand(1,3)
				if(scavengerspawn ==  1)
					new/mob/living/simple_animal/mouse(get_turf(src))
				else if(scavengerspawn ==  2)
					new/mob/living/simple_animal/cockroach(get_turf(src))
				else
					new/mob/living/simple_animal/fly(get_turf(src))
		spawn(3600)
			qdel(src)


/obj/item/weapon/reagent_containers/food/snacks/rawcrab
	name = "crab meat"
	desc = "Fresh crab meat. Looks tasty."
	icon_state = "raw_crabmeat"
	health = 180
	filling_color = "#7F0000"
	center_of_mass = list("x"=16, "y"=14)
	raw = TRUE
	var/rotten = FALSE
	non_vegetarian = TRUE
	satisfaction = -15
	New()
		..()
		reagents.add_reagent("protein", 4)
		reagents.add_reagent("food_poisoning", 1)
		bitesize = 3


/obj/item/weapon/reagent_containers/food/snacks/rawcrab/New()
	..()
	spawn(3000) //5 minutes
		if (!src)
			return
		icon_state = "rotraw_crabmeat"
		name = "rotten [name]"
		if (reagents)
			reagents.remove_reagent("protein", 2)
			reagents.add_reagent("food_poisoning", 1)
		rotten = TRUE
		spawn(1000)
			if (isturf(loc) && prob(30))
				var/scavengerspawn = rand(1,3)
				if(scavengerspawn ==  1)
					new/mob/living/simple_animal/mouse(get_turf(src))
				else if(scavengerspawn ==  2)
					new/mob/living/simple_animal/cockroach(get_turf(src))
				else
					new/mob/living/simple_animal/fly(get_turf(src))
		spawn(3600)
			qdel(src)


/obj/item/weapon/reagent_containers/food/snacks/cockroach
	name = "cockroach"
	desc = "A dead cockroach. No, please don't make me eat it..."
	icon_state = "cockroach"
	health = 180
	filling_color = "#773B00"
	raw = TRUE
	var/rotten = FALSE
	non_vegetarian = TRUE
	satisfaction = -20
	New()
		..()
		reagents.add_reagent("protein", 1)
		reagents.add_reagent("food_poisoning", 1)
		bitesize = 3


/obj/item/weapon/reagent_containers/food/snacks/cockroach/New()
	..()
	spawn(3000) //5 minutes
		if (!src)
			return
		icon_state = "rotten_cockroach"
		name = "rotten [name]"
		if (reagents)
			reagents.add_reagent("food_poisoning", 1)
		rotten = TRUE
		spawn(3600)
			qdel(src)