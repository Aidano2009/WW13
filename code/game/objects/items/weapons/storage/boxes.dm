/*
 *	Everything derived from the common cardboard box.
 *	Basically everything except the original is a kit (starts full).
 *
 *	Contains:
 *		Empty box, starter boxes (survival/engineer),
 *		Latex glove and sterile mask boxes,
 *		Syringe, beaker, dna injector boxes,
 *		Blanks, flashbangs, and EMP grenade boxes,
 *		Tracking and chemical implant boxes,
 *		Prescription glasses and drinking glass boxes,
 *		Condiment bottle and silly cup boxes,
 *		Donkpocket and monkeycube boxes,
 *		ID and security PDA cart boxes,
 *		Handcuff, mousetrap, and pillbottle boxes,
 *		Snap-pops and matchboxes,
 *		Replacement light boxes.
 *
 *		For syndicate call-ins see uplink_kits.dm
 */

/obj/item/weapon/storage/box
	name = "box"
	desc = "It's just an ordinary box."
	icon_state = "box"
	item_state = "syringe_kit"
	var/foldable = /obj/item/stack/material/cardboard	// BubbleWrap - if set, can be folded (when empty) into a sheet of cardboard

// BubbleWrap - A box can be folded up to make card
/obj/item/weapon/storage/box/attack_self(mob/user as mob)
	if (..()) return

	//try to fold it.
	if ( contents.len )
		return

	if ( !ispath(foldable) )
		return
	var/found = FALSE
	// Close any open UI windows first
	for (var/mob/M in range(1))
		if (M.s_active == src)
			close(M)
		if ( M == user )
			found = TRUE
	if ( !found )	// User is too far away
		return
	// Now make the cardboard
	user << "<span class='notice'>You fold [src] flat.</span>"
	new foldable(get_turf(src))
	qdel(src)

/obj/item/weapon/storage/box/survival/
	New()
		..()
		new /obj/item/clothing/mask/breath( src )
		new /obj/item/weapon/tank/emergency_oxygen( src )

/obj/item/weapon/storage/box/engineer/
	New()
		..()
		new /obj/item/clothing/mask/breath( src )
		new /obj/item/weapon/tank/emergency_oxygen/engi( src )

/obj/item/weapon/storage/box/gloves
	name = "box of latex gloves"
	desc = "Contains white gloves."
	icon_state = "latex"

	New()
		..()
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)

/obj/item/weapon/storage/box/masks
	name = "box of sterile masks"
	desc = "This box contains masks of sterility."
	icon_state = "sterile"

	New()
		..()
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)


/obj/item/weapon/storage/box/syringes
	name = "box of syringes"
	desc = "A box full of syringes."
	icon_state = "syringe"

	New()
		..()
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )

/obj/item/weapon/storage/box/beakers
	name = "box of beakers"
	icon_state = "beaker"

	New()
		..()
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )

/obj/item/weapon/storage/box/beakers_large
	name = "box of large beakers"
	icon_state = "beaker"

	New()
		..()
		new /obj/item/weapon/reagent_containers/glass/beaker/large( src )
		new /obj/item/weapon/reagent_containers/glass/beaker/large( src )
		new /obj/item/weapon/reagent_containers/glass/beaker/large( src )
		new /obj/item/weapon/reagent_containers/glass/beaker/large( src )
		new /obj/item/weapon/reagent_containers/glass/beaker/large( src )
		new /obj/item/weapon/reagent_containers/glass/beaker/large( src )
		new /obj/item/weapon/reagent_containers/glass/beaker/large( src )

/obj/item/weapon/storage/box/blanks
	name = "box of blank shells"
	desc = "It has a picture of a gun and several warning symbols on the front."

	New()
		..()
		new /obj/item/ammo_casing/shotgun/blank(src)
		new /obj/item/ammo_casing/shotgun/blank(src)
		new /obj/item/ammo_casing/shotgun/blank(src)
		new /obj/item/ammo_casing/shotgun/blank(src)
		new /obj/item/ammo_casing/shotgun/blank(src)
		new /obj/item/ammo_casing/shotgun/blank(src)
		new /obj/item/ammo_casing/shotgun/blank(src)

/obj/item/weapon/storage/box/beanbags
	name = "box of beanbag shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/shotgun/beanbag(src)
		new /obj/item/ammo_casing/shotgun/beanbag(src)
		new /obj/item/ammo_casing/shotgun/beanbag(src)
		new /obj/item/ammo_casing/shotgun/beanbag(src)
		new /obj/item/ammo_casing/shotgun/beanbag(src)
		new /obj/item/ammo_casing/shotgun/beanbag(src)
		new /obj/item/ammo_casing/shotgun/beanbag(src)

/obj/item/weapon/storage/box/shotgunammo
	name = "box of shotgun slugs"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/shotgun(src)
		new /obj/item/ammo_casing/shotgun(src)
		new /obj/item/ammo_casing/shotgun(src)
		new /obj/item/ammo_casing/shotgun(src)
		new /obj/item/ammo_casing/shotgun(src)
		new /obj/item/ammo_casing/shotgun(src)
		new /obj/item/ammo_casing/shotgun(src)

/obj/item/weapon/storage/box/shotgunshells
	name = "box of shotgun shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/shotgun/pellet(src)
		new /obj/item/ammo_casing/shotgun/pellet(src)
		new /obj/item/ammo_casing/shotgun/pellet(src)
		new /obj/item/ammo_casing/shotgun/pellet(src)
		new /obj/item/ammo_casing/shotgun/pellet(src)
		new /obj/item/ammo_casing/shotgun/pellet(src)
		new /obj/item/ammo_casing/shotgun/pellet(src)

/obj/item/weapon/storage/box/stunshells
	name = "box of stun shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/shotgun/stunshell(src)
		new /obj/item/ammo_casing/shotgun/stunshell(src)
		new /obj/item/ammo_casing/shotgun/stunshell(src)
		new /obj/item/ammo_casing/shotgun/stunshell(src)
		new /obj/item/ammo_casing/shotgun/stunshell(src)
		new /obj/item/ammo_casing/shotgun/stunshell(src)
		new /obj/item/ammo_casing/shotgun/stunshell(src)

/obj/item/weapon/storage/box/practiceshells
	name = "box of practice shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/shotgun/practice(src)
		new /obj/item/ammo_casing/shotgun/practice(src)
		new /obj/item/ammo_casing/shotgun/practice(src)
		new /obj/item/ammo_casing/shotgun/practice(src)
		new /obj/item/ammo_casing/shotgun/practice(src)
		new /obj/item/ammo_casing/shotgun/practice(src)
		new /obj/item/ammo_casing/shotgun/practice(src)

/obj/item/weapon/storage/box/sniperammo
	name = "box of 14.5mm shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/a145(src)
		new /obj/item/ammo_casing/a145(src)
		new /obj/item/ammo_casing/a145(src)
		new /obj/item/ammo_casing/a145(src)
		new /obj/item/ammo_casing/a145(src)
		new /obj/item/ammo_casing/a145(src)
		new /obj/item/ammo_casing/a145(src)

/obj/item/weapon/storage/box/flashbangs
	name = "box of flashbangs"
	desc = "A box containing 7 antipersonnel flashbang grenades.<br> WARNING: These devices are extremely dangerous and can cause blindness or deafness in repeated use."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)

/obj/item/weapon/storage/box/teargas
	name = "box of pepperspray grenades"
	desc = "A box containing 7 tear gas grenades. A gas mask is printed on the label.<br> WARNING: Exposure carries risk of serious injury or death. Keep away from persons with lung conditions."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)



/obj/item/weapon/storage/box/emps
	name = "box of emp grenades"
	desc = "A box containing 5 military grade EMP grenades.<br> WARNING: Do not use near unshielded electronics or biomechanical augmentations, death or permanent paralysis may occur."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)

/obj/item/weapon/storage/box/smokes
	name = "box of smoke bombs"
	desc = "A box containing 5 smoke bombs."
	icon_state = "flashbang"

/obj/item/weapon/storage/box/smokes/New()
		..()
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)

/obj/item/weapon/storage/box/anti_photons
	name = "box of anti-photon grenades"
	desc = "A box containing 5 experimental photon disruption grenades."
	icon_state = "flashbang"

/obj/item/weapon/storage/box/rxglasses
	name = "box of prescription glasses"
	desc = "This box contains nerd glasses."
	icon_state = "glasses"

	New()
		..()
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)

/obj/item/weapon/storage/box/drinkingglasses
	name = "box of drinking glasses"
	desc = "It has a picture of drinking glasses on it."

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)

/obj/item/weapon/storage/box/condimentbottles
	name = "box of condiment bottles"
	desc = "It has a large ketchup smear on it."

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)



/obj/item/weapon/storage/box/cups
	name = "box of paper cups"
	desc = "It has pictures of paper cups on the front."
	New()
		..()
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )

/obj/item/weapon/storage/box/handcuffs
	name = "box of spare handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "handcuff"

	New()
		..()
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)


/obj/item/weapon/storage/box/mousetraps
	name = "box of Pest-B-Gon mousetraps"
	desc = "<b><FONT color='red'>WARNING:</FONT></b> <I>Keep out of reach of children</I>."
	icon_state = "mousetraps"

	New()
		..()
		new /obj/item/assembly/mousetrap( src )
		new /obj/item/assembly/mousetrap( src )
		new /obj/item/assembly/mousetrap( src )
		new /obj/item/assembly/mousetrap( src )
		new /obj/item/assembly/mousetrap( src )
		new /obj/item/assembly/mousetrap( src )

/obj/item/weapon/storage/box/pillbottles
	name = "box of pill bottles"
	desc = "It has pictures of pill bottles on its front."

	New()
		..()
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )


/obj/item/weapon/storage/box/snappops
	name = "snap pop box"
	desc = "Eight wrappers of fun! Ages 8 and up. Not suitable for children."
	icon = 'icons/obj/toy.dmi'
	icon_state = "spbox"
	can_hold = list(/obj/item/toy/snappop)
	New()
		..()
		for (var/i=1; i <= 8; i++)
			new /obj/item/toy/snappop(src)

/obj/item/weapon/storage/box/matches
	name = "matchbox"
	desc = "A small box of 'Space-Proof' premium matches."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	item_state = "zippo"
	w_class = TRUE
	slot_flags = SLOT_BELT
	can_hold = list(/obj/item/weapon/flame/match)

	New()
		..()
		for (var/i=1; i <= 10; i++)
			new /obj/item/weapon/flame/match(src)

	attackby(obj/item/weapon/flame/match/W as obj, mob/user as mob)
		if (istype(W) && !W.lit && !W.burnt)
			if (prob(50))
				playsound(loc, 'sound/items/matchstick_lit.ogg', 25, FALSE, -1)
				W.lit = TRUE
				W.damtype = "burn"
				W.icon_state = "match_lit"
				processing_objects.Add(W)
			else
				playsound(loc, 'sound/items/matchstick_hit.ogg', 25, FALSE, -1)
		W.update_icon()
		return
/*
/obj/item/weapon/storage/box/autoinjectors
	name = "box of injectors"
	desc = "Contains autoinjectors."
	icon_state = "syringe"
	New()
		..()
		for (var/i; i < 7; i++)
			new /obj/item/weapon/reagent_containers/hypospray/autoinjector(src)
*/
/obj/item/weapon/storage/box/lights
	name = "box of replacement bulbs"
	icon = 'icons/obj/storage.dmi'
	icon_state = "light"
	desc = "This box is shaped on the inside so that only light tubes and bulbs fit."
	item_state = "syringe_kit"
	use_to_pickup = TRUE // for picking up broken bulbs, not that most people will try

/obj/item/weapon/storage/box/lights/New()
	..()
	make_exact_fit()

/obj/item/weapon/storage/box/lights/bulbs/New()
	for (var/i = FALSE; i < 21; i++)
		new /obj/item/weapon/light/bulb(src)
	..()

/obj/item/weapon/storage/box/lights/tubes
	name = "box of replacement tubes"
	icon_state = "lighttube"

/obj/item/weapon/storage/box/lights/tubes/New()
	for (var/i = FALSE; i < 21; i++)
		new /obj/item/weapon/light/tube(src)
	..()

/obj/item/weapon/storage/box/lights/mixed
	name = "box of replacement lights"
	icon_state = "lightmixed"

/obj/item/weapon/storage/box/lights/mixed/New()
	for (var/i = FALSE; i < 14; i++)
		new /obj/item/weapon/light/tube(src)
	for (var/i = FALSE; i < 7; i++)
		new /obj/item/weapon/light/bulb(src)
	..()

/obj/item/weapon/storage/box/freezer
	name = "portable freezer"
	desc = "This nifty shock-resistant device will keep your 'groceries' nice and non-spoiled."
	icon = 'icons/obj/storage.dmi'
	icon_state = "portafreezer"
	item_state = "medicalpack"
	foldable = null
	max_w_class = 3
	can_hold = list(/obj/item/organ, /obj/item/weapon/reagent_containers/food, /obj/item/weapon/reagent_containers/glass)
	max_storage_space = 21
	use_to_pickup = TRUE // for picking up broken bulbs, not that most people will try
