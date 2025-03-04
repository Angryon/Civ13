//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/structure/closet/crate
	name = "crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/storage.dmi'
	icon_state = "crate"
	icon_opened = "crateopen"
	icon_closed = "crate"
	climbable = TRUE
	mouse_drop_zone = TRUE
	var/rigged = FALSE
	var/storagecap = 10

// climbing crates - Kachnov
/obj/structure/closet/crate/MouseDrop_T(mob/target, mob/user)
	if (!opened)
		var/mob/living/H = user
		if (istype(H) && can_climb(H) && target == user)
			do_climb(target)
		else
			return ..(target, user)
	else
		return ..(target, user)

/obj/structure/closet/crate/can_open()
	return TRUE

/obj/structure/closet/crate/can_close()
	return TRUE

/obj/structure/closet/crate/open()
	if (opened)
		return FALSE
	if (!can_open())
		return FALSE

	playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
	for (var/obj/O in src)
		O.forceMove(get_turf(src))
	icon_state = icon_opened
	opened = TRUE

	if (climbable)
		structure_shaken()
	return TRUE

/obj/structure/closet/crate/close()
	if (!opened)
		return FALSE
	if (!can_close())
		return FALSE

	playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
	var/itemcount = FALSE
	for (var/obj/O in get_turf(src))
		if (itemcount >= storagecap)
			break
		if (O.density || O.anchored)
			continue
		if (istype(O, /obj/structure))
			continue
		O.forceMove(src)
		itemcount++

	icon_state = icon_closed
	opened = FALSE
	return TRUE

/obj/structure/closet/crate/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (istype(mover, /obj/item/projectile))
		return TRUE
	return !density

/obj/structure/closet/crate/ex_act(severity)
	switch(severity)
		if (1.0)
			for (var/obj/O in contents)
				qdel(O)
			qdel(src)
			return
		if (2.0)
			for (var/obj/O in contents)
				if (prob(50))
					qdel(O)
			qdel(src)
			return
		if (3.0)
			if (prob(50))
				qdel(src)
			return
		else
	return


/obj/structure/closet/crate/bin
	name = "large bin"
	desc = "A large bin."
	icon_state = "largebin"
	icon_opened = "largebinopen"
	icon_closed = "largebin"

/obj/structure/closet/crate/large
	name = "large crate"
	desc = "A hefty metal crate."
	icon = 'icons/obj/storage.dmi'
	icon_state = "largemetal"
	icon_opened = "largemetalopen"
	icon_closed = "largemetal"

/obj/structure/closet/crate/large/close()
	. = ..()
	if (.)//we can hold up to one large item
		for (var/obj/structure/S in loc)
			if (S == src)
				continue
			if (!S.anchored)
				S.forceMove(src)
				break
	return

/obj/structure/closet/crate/lead
	name = "lead safe"
	desc = "A large lead safe, good to store radioactive things."
	icon_state = "largermetal"
	icon_opened = "largermetal"
	icon_closed = "largermetal"

	//ROBERT'S CARTS//
/obj/structure/closet/crate/cart
	name = "cart"
	desc = " A large crate, good for transporting large amounts of objects"
	icon = 'icons/obj/carts.dmi'
	icon_state= "w_cart_o"
	icon_opened ="w_cart_o"
	icon_closed = "w_cart_c"
	//COPPER AGE WOODEN CART//
/obj/structure/closet/crate/cart/wooden
	name ="wooden cart"
	desc = " A wooden cart, it's small and flimsy"
	icon_state= "w_cart_o"
	icon_opened ="w_cart_o"
	icon_closed = "w_cart_c"
	storagecap = 20
	//COPPER AGE WOODEN CART//
	//DARK AGE STONE CART//
/obj/structure/closet/crate/cart/stone
	name ="stone cart"
	desc = " A stone cart, it's small, some stone components make it sturdier than a wooden cart"
	icon_state= "s_cart_o"
	icon_opened ="s_cart_o"
	icon_closed = "s_cart_c"
	storagecap = 30
	//DARK AGE STONE CART//
	//RENAISSANCE AGE COPPER CART//
/obj/structure/closet/crate/cart/copper
	name ="copper cart"
	desc = " A copper cart, it's small, some copper components make it sturdier than a stone cart"
	icon_state= "c_cart_o"
	icon_opened ="c_cart_o"
	icon_closed = "c_cart_c"
	storagecap = 40
	//RENAISSANCE AGE COPPER CART//
	//NAPOLEONIC AGE BRONZE CART//
/obj/structure/closet/crate/cart/bronze
	name ="bronze cart"
	desc = " A bronze cart, it's medium sized, some bronze components make it sturdier than a stone cart"
	icon_state= "b_cart_o"
	icon_opened ="b_cart_o"
	icon_closed = "b_cart_c"
	storagecap = 50
	//NAPOLEONIC AGE BRONZE CART//
	//EARLY MODERN AGE STEEL CART//
/obj/structure/closet/crate/cart/steel
	name ="shopping cart"
	desc = " A shopping cart, it's medium sized, it's steel frame make it sturdy and light"
	icon_state= "st_cart_o"
	icon_opened ="st_cart_o"
	icon_closed = "st_cart_c"
	storagecap = 60
	//EARLY MODERN AGE STEEL CART//
	//ROBERT'S CARTS//