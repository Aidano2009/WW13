/obj/item/weapon/material/kitchen
	icon = 'icons/obj/kitchen.dmi'

/*
 * Utensils
 */
/obj/item/weapon/material/kitchen/utensil
	w_class = TRUE
	thrown_force_divisor = TRUE
//	origin_tech = "materials=1"
	attack_verb = list("attacked", "stabbed", "poked")
	sharp = TRUE
	edge = TRUE
	force_divisor = 0.1 // 6 when wielded with hardness 60 (steel)
	thrown_force_divisor = 0.25 // 5 when thrown with weight 20 (steel)
	var/loaded      //Descriptive string for currently loaded food object.
	var/scoop_food = TRUE

/obj/item/weapon/material/kitchen/utensil/New()
	..()
	if (prob(60))
		pixel_y = rand(0, 4)
	create_reagents(5)
	return

/obj/item/weapon/material/kitchen/utensil/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if (!istype(M))
		return ..()

	if (user.a_intent != I_HELP || !scoop_food)
		if (user.targeted_organ == "eyes")
			if ((CLUMSY in user.mutations) && prob(50))
				M = user
			return eyestab(M,user)
		else if (user.targeted_organ == "head" && (sharp || edge) && ishuman(M))
			M.resolve_item_attack(src, user, user.targeted_organ)
		else
			return ..()

	if (reagents.total_volume > 0)
		reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
		if (M == user)
			if (!M.can_eat(loaded))
				return
			else if (M.get_fullness() > 580)
				user << "<span class='danger'>You cannot force any more food to go down your throat.</span>"
				return
			M.visible_message("<span class='notice'>\The [user] eats some [loaded] from \the [src].</span>")
		else
			user.visible_message("<span class='warning'>\The [user] begins to feed \the [M]!</span>")
			if (!(M.can_force_feed(user, loaded) && do_mob(user, M, 5 SECONDS)))
				return
			else if (M.get_fullness() > 580)
				user << "<span class='danger'>You cannot force any more food to go down [M]'s throat.</span>"
				return
			M.visible_message("<span class='notice'>\The [user] feeds some [loaded] to \the [M] with \the [src].</span>")
		playsound(M.loc,'sound/items/eatfood.ogg', rand(10,40), TRUE)
		overlays.Cut()
		return
	else
		user << "<span class='warning'>You don't have anything on \the [src].</span>"	//if we have help intent and no food scooped up DON'T STAB OURSELVES WITH THE FORK
		return

/obj/item/weapon/material/kitchen/utensil/fork
	name = "fork"
	desc = "It's a fork. Sure is pointy."
	icon_state = "fork"

/obj/item/weapon/material/kitchen/utensil/fork/plastic
	default_material = "plastic"

/obj/item/weapon/material/kitchen/utensil/spoon
	name = "spoon"
	desc = "It's a spoon. You can see your own upside-down face in it."
	icon_state = "spoon"
	attack_verb = list("attacked", "poked")
	edge = FALSE
	sharp = FALSE
	force_divisor = 0.1 //2 when wielded with weight 20 (steel)

/obj/item/weapon/material/kitchen/utensil/spoon/plastic
	default_material = "plastic"

/*
 * Knives
 */
/obj/item/weapon/material/kitchen/utensil/knife
	name = "knife"
	desc = "A knife for eating with. Can cut through any food."
	icon_state = "knife"
	force_divisor = 0.1 // 6 when wielded with hardness 60 (steel)
	scoop_food = FALSE
	slot_flags = SLOT_BELT|SLOT_POCKET

/obj/item/weapon/material/kitchen/utensil/knife/attack(target as mob, mob/living/user as mob)
	if ((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>You accidentally cut yourself with \the [src].</span>"
		user.take_organ_damage(20)
		return
	return ..()

/obj/item/weapon/material/kitchen/utensil/knife/plastic
	default_material = "plastic"

/*
 * Rolling Pins
 */

/obj/item/weapon/material/kitchen/rollingpin
	name = "rolling pin"
	desc = "Used to knock out the Bartender."
	icon_state = "rolling_pin"
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")
	default_material = "wood"
	force_divisor = 0.7 // 10 when wielded with weight 15 (wood)
	thrown_force_divisor = TRUE // as above
	hitsound = "swing_hit"

/obj/item/weapon/material/kitchen/rollingpin/attack(mob/living/M as mob, mob/living/user as mob)
	if ((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>\The [src] slips out of your hand and hits your head.</span>"
		user.drop_from_inventory(src)
		user.take_organ_damage(10)
		user.Paralyse(2)
		return
	return ..()
