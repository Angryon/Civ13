/////////////////XVIII CENTURY STUFF/////////////////////////////
/obj/item/ammo_casing/musketball
	name = "musketball cartridge"
	icon_state = "musketball_gunpowder"
	spent_icon = null
	projectile_type = /obj/item/projectile/bullet/rifle/musketball
	weight = 0.02
	caliber = "musketball"
	value = 3

/obj/item/ammo_casing/stoneball
	name = "stone ball projectile"
	icon_state = "stoneball"
	spent_icon = null
	projectile_type = /obj/item/projectile/bullet/rifle/stoneball
	weight = 0.03
	caliber = "stoneball"
	value = 3

/obj/item/ammo_casing/musketball_pistol
	name = "pistol cartridge"
	projectile_type = /obj/item/projectile/bullet/rifle/musketball_pistol
	weight = 0.015
	icon_state = "musketball_pistol_gunpowder"
	spent_icon = null
	caliber = "musketball_pistol"
	value = 2

/obj/item/ammo_casing/blunderbuss
	name = "blunderbuss cartridge"
	icon_state = "blunderbuss_gunpowder"
	spent_icon = null
	projectile_type = /obj/item/projectile/bullet/rifle/blunderbuss
	weight = 0.035
	caliber = "blunderbuss"
	value = 3
//arrows

/obj/item/ammo_casing/arrow
	name = "arrow shaft"
	desc = "A headless arrow, not very effective."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "arrow"
	spent_icon = null
	projectile_type = /obj/item/projectile/arrow/arrow
	weight = 0.15
	caliber = "arrow"
	slot_flags = SLOT_BELT
	value = 2
	var/volume = 5
/obj/item/ammo_casing/arrow/gods
	name = "gods finger"
	desc = "A arrow that radiates holy wrath."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "arrow_god"
	projectile_type = /obj/item/projectile/arrow/arrow/fire/gods
	weight = 0.18

/obj/item/ammo_casing/arrow/stone
	name = "stone arrow"
	desc = "An arrow with a stone tip."
	icon_state = "arrow_stone"
	projectile_type = /obj/item/projectile/arrow/arrow/stone
	weight = 0.17

/obj/item/ammo_casing/arrow/copper
	name = "copper arrow"
	desc = "An arrow with a copper tip."
	icon_state = "arrow_copper"
	projectile_type = /obj/item/projectile/arrow/arrow/copper
	weight = 0.16

/obj/item/ammo_casing/arrow/iron
	name = "iron arrow"
	desc = "An arrow with a iron tip."
	icon_state = "arrow_iron"
	projectile_type = /obj/item/projectile/arrow/arrow/iron
	weight = 0.16

/obj/item/ammo_casing/arrow/bronze
	name = "bronze arrow"
	desc = "An arrow with a bronze tip."
	icon_state = "arrow_bronze"
	projectile_type = /obj/item/projectile/arrow/arrow/bronze
	weight = 0.16

/obj/item/ammo_casing/arrow/steel
	name = "steel arrow"
	desc = "An arrow with a steel tip."
	icon_state = "arrow_steel"
	projectile_type = /obj/item/projectile/arrow/arrow/steel
	weight = 0.17

/obj/item/ammo_casing/arrow/modern
	name = "fiberglass arrow"
	desc = "A modern, high-velocity arrow."
	icon_state = "arrow_modern"
	projectile_type = /obj/item/projectile/arrow/arrow/modern
	weight = 0.15

/obj/item/ammo_casing/arrow/vial
	name = "vial arrow"
	desc = "An iron-tipped arrow with a glass vial attached to the tip."
	icon_state = "arrow_vial"
	projectile_type = /obj/item/projectile/arrow/arrow/vial
	weight = 0.18
	volume = 15
//Crossbow

/obj/item/ammo_casing/bolt
	name = "bolt shaft"
	desc = "A tipless crossbow bolt, not very effective."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "bolt"
	spent_icon = null
	projectile_type = /obj/item/projectile/arrow/bolt
	weight = 0.17
	caliber = "bolt"
	slot_flags = SLOT_BELT
	value = 2
	var/volume = 5

/obj/item/ammo_casing/bolt/iron
	name = "iron bolt"
	desc = "A crossbow bolt with a iron tip."
	icon_state = "arrow_iron"
	projectile_type = /obj/item/projectile/arrow/bolt/iron
	weight = 0.17

/obj/item/ammo_casing/bolt/bronze
	name = "bronze bolt"
	desc = "A crossbow bolt with a bronze tip."
	icon_state = "arrow_bronze"
	projectile_type = /obj/item/projectile/arrow/bolt/bronze
	weight = 0.17

/obj/item/ammo_casing/bolt/steel
	name = "steel bolt"
	desc = "A crossbow bolt with a steel tip."
	icon_state = "arrow_steel"
	projectile_type = /obj/item/projectile/arrow/bolt/steel
	weight = 0.18

/obj/item/ammo_casing/bolt/modern
	name = "fiberglass bolt"
	desc = "A modern, high-velocity crossbow bolt."
	icon_state = "arrow_modern"
	projectile_type = /obj/item/projectile/arrow/bolt/modern
	weight = 0.16

 //Sling
/obj/item/ammo_casing/stone
	name = "rock"
	desc = "Use a sling to launch it."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "rock"
	spent_icon = null
	projectile_type = /obj/item/projectile/arrow/stone
	weight = 0.22
	caliber = "stone"
	value = 1

//ARROWHEADS

/obj/item/ammo_casing/arrow/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/stack/arrowhead))
		if(istype(W, /obj/item/stack/arrowhead/stone))
			new/obj/item/ammo_casing/arrow/stone(user.loc)
		else if(istype(W, /obj/item/stack/arrowhead/copper))
			new/obj/item/ammo_casing/arrow/copper(user.loc)
		else if(istype(W, /obj/item/stack/arrowhead/iron))
			new/obj/item/ammo_casing/arrow/iron(user.loc)
		else if(istype(W, /obj/item/stack/arrowhead/bronze))
			new/obj/item/ammo_casing/arrow/bronze(user.loc)
		else if(istype(W, /obj/item/stack/arrowhead/steel))
			new/obj/item/ammo_casing/arrow/steel(user.loc)
		else if(istype(W, /obj/item/stack/arrowhead/vial))
			new/obj/item/ammo_casing/arrow/vial(user.loc)
		else
			new/obj/item/ammo_casing/arrow/gods(user.loc)
		playsound(loc, 'sound/machines/click.ogg', 25, TRUE)
		user << "<span class = 'notice'>You attach the [W] to the [src]</span>"
		qdel(W)
		qdel(src)
	if (istype(W, /obj/item/weapon/reagent_containers))
		return //do nothing if not reagent container
	else
		if(volume < src.reagents)
			user << "<span class = 'notice'>You dip the [W] into the [src]</span>"
			W.reagents.trans_to_obj(src, volume - src.reagents)
	..()

/obj/item/stack/arrowhead
	name = "god's finger"
	desc = "Radiates holy wrath, attach it to an arrow shaft."
	icon = 'icons/obj/items.dmi'
	icon_state = "gods_arrowhead"

/obj/item/stack/arrowhead/stone
	name = "stone arrowhead"
	desc = "Attach it to a arrow shaft."
	icon_state = "stone_arrowhead"

/obj/item/stack/arrowhead/copper
	name = "copper arrowhead"
	desc = "Attach it to a arrow shaft."
	icon_state = "copper_arrowhead"

/obj/item/stack/arrowhead/iron
	name = "iron arrowhead"
	desc = "Attach it to a arrow shaft."
	icon_state = "iron_arrowhead"

/obj/item/stack/arrowhead/bronze
	name = "bronze arrowhead"
	desc = "Attach it to a arrow shaft."
	icon_state = "bronze_arrowhead"

/obj/item/stack/arrowhead/steel
	name = "steel arrowhead"
	desc = "Attach it to a arrow shaft."
	icon_state = "steel_arrowhead"

/obj/item/stack/arrowhead/vial
	name = "vial arrowhead"
	desc = "Attach it to a arrow shaft."
	icon_state = "vial_arrowhead"

//AMMO WITH GUNPOWDER
/obj/item/stack/ammopart
	var/resultpath = /obj/item/ammo_casing/musketball
	amount = 1
	max_amount = 20
	singular_name = "projectile"
	value = 0

/obj/item/stack/ammopart/stoneball
	name = "stone projectile"
	desc = "A round stone ball, to be used in handcannons, arquebuses and matchlock muskets."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "stoneball"
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_WEAK
	resultpath = /obj/item/ammo_casing/stoneball
	value = 1
	weight = 0.15
	max_amount = 5

/obj/item/stack/ammopart/musketball
	name = "musketball projectiles"
	desc = "A round musketball, to be used in flintlock muskets."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "musketball"
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	resultpath = /obj/item/ammo_casing/musketball
	value = 2
	weight = 0.08

/obj/item/stack/ammopart/musketball_pistol
	name = "pistol projectiles"
	desc = "A small, round musketball, to be used in flintlock pistols."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "musketball_pistol"
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	resultpath = /obj/item/ammo_casing/musketball_pistol
	value = 1
	weight = 0.05

/obj/item/stack/ammopart/blunderbuss
	name = "blunderbuss projectiles"
	desc = "A bunch of small iron projectiles. Can fill blunderbusses."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "blunderbuss"
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	resultpath = /obj/item/ammo_casing/blunderbuss
	value = 2
	weight = 0.1
/obj/item/stack/ammopart/casing
	max_amount = 40
	singular_name = "casing"
	value = 1
	weight = 0.05
	var/gunpowder = 0
	var/gunpowder_max = 2
	var/bulletn = FALSE

/obj/item/stack/ammopart/casing/rifle
	name = "empty rifle casing"
	desc = "An empty brass casing."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "riflecasing_empty"
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	resultpath = null
	gunpowder_max = 1.5
	var/inputbtype = "normal"

/obj/item/stack/ammopart/casing/pistol
	name = "empty pistol casing"
	desc = "A small empty brass casing."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "pistolcasing_empty"
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	resultpath = null
	gunpowder_max = 1

/obj/item/stack/ammopart/casing/artillery
	name = "empty artillery casing"
	desc = "A large empty brass casing."
	icon = 'icons/obj/cannon_ball.dmi'
	icon_state = "casing"
	force = WEAPON_FORCE_HARMLESS+1
	throwforce = WEAPON_FORCE_HARMLESS+2
	resultpath = null
	gunpowder_max = 5
	max_amount = 1
	value = 4

/obj/item/stack/ammopart/casing/tank
	name = "empty cannon casing"
	desc = "A large empty brass casing."
	icon = 'icons/obj/cannon_ball.dmi'
	icon_state = "shell_tank_casing"
	force = WEAPON_FORCE_HARMLESS+1
	throwforce = WEAPON_FORCE_HARMLESS+2
	resultpath = null
	gunpowder_max = 5
	max_amount = 1
	value = 4
	var/caliber = 75

/obj/item/stack/ammopart/casing/artillery/wired
	name = "wired empty artillery casing"
	desc = "A large empty brass casing. Has some wired crudely attached"
	icon = 'icons/obj/cannon_ball.dmi'
	icon_state = "casing_wired"
	force = WEAPON_FORCE_HARMLESS+1
	throwforce = WEAPON_FORCE_HARMLESS+2
	resultpath = null
	gunpowder_max = 5
	max_amount = 1
	value = 4

/obj/item/stack/ammopart/casing/artillery/wired/advanced
	name = "advanced empty artillery casing"
	desc = "A large empty brass casing. Some electronics are wired to it."
	icon = 'icons/obj/cannon_ball.dmi'
	icon_state = "casing_advanced"
	force = WEAPON_FORCE_HARMLESS+1
	throwforce = WEAPON_FORCE_HARMLESS+2
	resultpath = null
	gunpowder_max = 5
	max_amount = 1
	value = 4

/obj/item/stack/ammopart/casing/artillery/wired/advanced/filled
	name = "uranium filled artillery casing"
	desc = "A large brass casing. Wired up to some uranium and electronics."
	icon = 'icons/obj/cannon_ball.dmi'
	icon_state = "casing"
	force = WEAPON_FORCE_HARMLESS+1
	throwforce = WEAPON_FORCE_HARMLESS+2
	resultpath = null
	gunpowder_max = 5
	max_amount = 1
	value = 4

/obj/item/stack/ammopart/casing/grenade
	name = "empty grenade casing"
	desc = "A large empty grenade casing."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "casing"
	force = WEAPON_FORCE_HARMLESS+4
	throwforce = WEAPON_FORCE_HARMLESS+7
	resultpath = null
	gunpowder_max = 2
	max_amount = 1
	value = 4
	var/finished = FALSE
	var/stype = "explosive"

/obj/item/ammo_casing/a65x50
	name = "6.5x50mm bullet"
	desc = "A brass casing containing powder and a lead bullet."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/a65x50
	caliber = "a65x50"
	value = 5

/obj/item/ammo_casing/a65x50/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a65x50/weak
	caliber = "a65x50_weak"

/obj/item/ammo_casing/a65x52
	name = "6.5x52mm bullet"
	desc = "A brass casing containing powder and a lead bullet."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/a65x52
	caliber = "a65x52"
	value = 5

/obj/item/ammo_casing/a8x53
	name = "8x53mm bullet"
	desc = "A brass casing containing powder and a lead bullet."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/a8x53
	caliber = "a8x53"
	value = 5

/obj/item/ammo_casing/a8x50
	name = "8x50mmR bullet"
	desc = "A brass casing containing powder and a lead bullet."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/a8x50
	caliber = "a8x50"
	value = 5

/obj/item/ammo_casing/a8x50/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a8x50/weak
	caliber = "a8x50_weak"

/obj/item/ammo_casing/c9mm_jap_revolver
	name = "9mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/c9mm_jap_revolver
	caliber = "c9mm_jap_revolver"
	value = 5

/obj/item/ammo_casing/a41
	name = ".41 Short bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.04
	projectile_type = /obj/item/projectile/bullet/pistol/a41
	caliber = "a41"
	value = 7

/obj/item/ammo_casing/a32
	name = ".32 bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.04
	projectile_type = /obj/item/projectile/bullet/pistol/a32
	caliber = "a32"
	value = 5

/obj/item/ammo_casing/a38
	name = ".38 bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.04
	projectile_type = /obj/item/projectile/bullet/pistol/a38
	caliber = "a38"
	value = 5

/obj/item/ammo_casing/a45
	name = ".45 Colt bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a45
	caliber = "a45"
	value = 7

/obj/item/ammo_casing/a45acp
	name = ".45 ACP bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a45
	caliber = "a45acp"
	value = 7

/obj/item/ammo_casing/a455
	name = ".455 Webley bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a455
	caliber = "a455"
	value = 7

/obj/item/ammo_casing/a44
	name = ".44-40 Winchester bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/a44
	caliber = "a44"
	value = 8

/obj/item/ammo_casing/a44magnum
	name = ".44 magnum bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/a44magnum
	caliber = "a44magnum"
	value = 8

/obj/item/ammo_casing/a4570
	name = ".45-70 Government bullet"
	desc = "A brass casing."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/a4570
	caliber = "a4570"
	value = 8

/obj/item/ammo_casing/a792x57
	name = "7.92x57mm bullet"
	desc = "A brass casing."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/a792x57
	caliber = "a792x57"
	value = 8

/obj/item/ammo_casing/a792x57/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a792x57/weak
	caliber = "a792x57_weak"

/obj/item/ammo_casing/a765x53
	name = "7.65x53mm bullet"
	desc = "A brass casing."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/a765x53
	caliber = "a765x53"
	value = 8

/obj/item/ammo_casing/a765x25
	name = "7.65x25mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/a765x25
	caliber = "a765x25"
	value = 8

/obj/item/ammo_casing/a7x57
	name = "7x53mm bullet"
	desc = "A brass casing."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.076
	projectile_type = /obj/item/projectile/bullet/rifle/a7x57
	caliber = "a7x57"
	value = 8

/obj/item/ammo_casing/a77x58
	name = "7.7x58mm bullet"
	desc = "A brass casing."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.076
	projectile_type = /obj/item/projectile/bullet/rifle/a77x58
	caliber = "a77x58"
	value = 8

/obj/item/ammo_casing/a77x58/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a77x58/weak
	caliber = "a77x58_weak"

/obj/item/ammo_casing/a577
	name = ".577/450 Martini-Henry bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.11
	projectile_type = /obj/item/projectile/bullet/rifle/a577
	caliber = "a577"
	value = 8


/obj/item/ammo_casing/a762x54
	name = "7.62x54mm bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/a762x54
	caliber = "a762x54"
	value = 2

/obj/item/ammo_casing/a762x54/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a762x54/weak
	caliber = "a762x54_weak"

/obj/item/ammo_casing/a303
	name = ".303 bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/a303
	caliber = "a303"
	value = 2

/obj/item/ammo_casing/a303/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a303/weak
	caliber = "a303_weak"

/obj/item/ammo_casing/a3006
	name = ".30-06 bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/a3006
	caliber = "a3006"
	value = 2

/obj/item/ammo_casing/a3006/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a3006/weak
	caliber = "a3006_weak"

/obj/item/ammo_casing/a762x38
	name = "7.62x38mmR bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a762x38
	caliber = "a762x38"
	value = 5

/obj/item/ammo_casing/a8x27
	name = "8x27mmR bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a8x27
	caliber = "a8x27"
	value = 5

/obj/item/ammo_casing/c8mmnambu
	name = "8mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/c8mmnambu
	caliber = "c8mmnambu"
	value = 2

/obj/item/ammo_casing/a9x19
	name = "9x19mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a9x19
	caliber = "a9x19"
	value = 2

/obj/item/ammo_casing/a765x25
	name = "7.65x25mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a765x25
	caliber = "a765x25"
	value = 2

/obj/item/ammo_casing/a762x25
	name = "7.62x25mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a762x25
	caliber = "a762x25"
	value = 2

/obj/item/ammo_casing/a792x33
	name = "7.92x33mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a792x33
	caliber = "a792x33"
	value = 2

/obj/item/ammo_casing/a545x39
	name = "5.45x39mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.04
	projectile_type = /obj/item/projectile/bullet/rifle/a545x39
	caliber = "a545x39"
	value = 2

/obj/item/ammo_casing/a32acp
	name = ".32 ACP bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.03
	projectile_type = /obj/item/projectile/bullet/pistol/a32acp
	caliber = "a32acp"
	value = 2

/obj/item/ammo_casing/webly445
	name = ".455 webly bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.03
	projectile_type = /obj/item/projectile/bullet/pistol/webly445
	caliber = "webly445"
	value = 2

/obj/item/ammo_casing/a556x45
	name = "5.56x45mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.04
	projectile_type = /obj/item/projectile/bullet/rifle/a556x45
	caliber = "a556x45"
	value = 2
/obj/item/ammo_casing/a762x51
	name = "7.62x51mm bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.06
	projectile_type = /obj/item/projectile/bullet/rifle/a762x51
	caliber = "a762x51"
	value = 2

/obj/item/ammo_casing/a762x51/weak
	projectile_type = /obj/item/projectile/bullet/rifle/a762x51/weak
	caliber = "a762x51_weak"

/obj/item/ammo_casing/a762x39
	name = "7.62x39mm bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.06
	projectile_type = /obj/item/projectile/bullet/rifle/a762x39
	caliber = "a762x39"
	value = 2

/obj/item/ammo_casing/a44p
	name = ".44 bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a44p
	caliber = "a44p"
	value = 2

/obj/item/ammo_casing/a57x28
	name = "a57x28mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/a57x28
	caliber = "a57x28"
	value = 2

/obj/item/ammo_casing/shotgun
	name = "buckshot shell"
	desc = "A 12 gauge buckshot."
	icon_state = "shell-bullet"
	spent_icon = "shell-casing"
	weight = 0.12
	projectile_type = /obj/item/projectile/bullet/shotgun/buckshot
	caliber = "12gauge"
	value = 2

/obj/item/ammo_casing/shotgun/slug
	name = "shotgun slug"
	desc = "A 12 gauge slug."
	icon_state = "slshell"
	spent_icon = "slshell_casing"
	projectile_type = /obj/item/projectile/bullet/shotgun/slug

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A beanbag shell."
	icon_state = "bshell"
	spent_icon = "bshell_casing"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag

//generic calibers for custom weapons
/obj/item/ammo_casing/largerifle
	name = "8mm bullet"
	desc = "A brass casing."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/largerifle
	caliber = "largerifle"
	value = 8

/obj/item/ammo_casing/smallrifle
	name = "6.5mm bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.08
	projectile_type = /obj/item/projectile/bullet/rifle/smallrifle
	caliber = "smallrifle"
	value = 8

/obj/item/ammo_casing/pistol45
	name = ".45 bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/pistol45
	caliber = "pistol45"
	value = 2
/obj/item/ammo_casing/pistol9
	name = "9mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/pistol/pistol9
	caliber = "pistol9"
	value = 2

/obj/item/ammo_casing/intermediumrifle
	name = "7.5mm bullet"
	desc = "A brass casing."
	icon_state = "clip-bullet"
	spent_icon = "clip-casing"
	weight = 0.05
	projectile_type = /obj/item/projectile/bullet/rifle/intermediumrifle
	caliber = "intermediumrifle"
	value = 8

/obj/item/ammo_casing/smallintermediumrifle
	name = "5.5mm bullet"
	desc = "A brass casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistolcasing"
	weight = 0.04
	projectile_type = /obj/item/projectile/bullet/rifle/smallintermediumrifle
	caliber = "smallintermediumrifle"
	value = 2
