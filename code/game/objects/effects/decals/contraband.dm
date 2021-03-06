
// CONTRABAND

/obj/item/weapon/contraband
	name = "contraband item"
	desc = "You probably shouldn't be holding this."
	icon = 'icons/obj/contraband.dmi'
	force = FALSE


/obj/item/weapon/contraband/poster
	name = "rolled-up poster"
	desc = "The poster comes with its own automatic adhesive mechanism, for easy pinning to any vertical surface."
	icon_state = "rolled_poster"
	var/serial_number = FALSE
	var/ruined = FALSE
	var/datum/poster/design = null

/obj/item/weapon/contraband/poster/New(turf/loc, var/datum/poster/new_design = null)
	if (!new_design)
		design = pick(poster_designs)
	else
		design = new_design
	..(loc)

/obj/item/weapon/contraband/poster/placed
	icon_state = "random"
	anchored = TRUE
	New(turf/loc)
		if (icon_state != "random")
			for (var/datum/poster/new_design in poster_designs)
				if (new_design.icon_state == icon_state)
					return ..(loc, new_design)
		..()
		if (iswall(loc) && !pixel_x && !pixel_y)
			for (var/dir in cardinal)
				if (isfloor(get_step(src, dir)))
					switch(dir)
						if (NORTH) pixel_y = -32
						if (SOUTH) pixel_y = 32
						if (EAST)  pixel_x = 32
						if (WEST)  pixel_x = -32

/obj/item/weapon/contraband/poster/attack_hand(mob/user as mob)
	if (!anchored)
		return ..()

	if (ruined)
		return

	switch(WWinput(user, "Do I want to rip the poster from the wall?", "You think...", "Yes", list("Yes", "No")))
		if ("Yes")
			if (!Adjacent(user))
				return
			visible_message("<span class='warning'>[user] rips [src] in a single, decisive motion!</span>" )
			playsound(loc, 'sound/items/poster_ripped.ogg', 100, TRUE)
			ruined = TRUE
			icon = initial(icon)
			icon_state = "poster_ripped"
			name = "ripped poster"
			desc = "You can't make out anything from the poster's original print. It's ruined."
			add_fingerprint(user)
		if ("No")
			return

/obj/item/weapon/contraband/poster/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wirecutters))
		playsound(loc, 'sound/items/Wirecutter.ogg', 100, TRUE)
		if (ruined)
			user << "<span class='notice'>You remove the remnants of the poster.</span>"
			qdel(src)
		else
			roll_and_drop()
			user << "<span class='notice'>You carefully remove the poster from the wall.</span>"
		return

/obj/item/weapon/contraband/poster/proc/roll_and_drop()
	anchored = FALSE
	pixel_x = FALSE
	pixel_y = FALSE
	icon = initial(icon)
	icon_state = initial(icon_state)
	name = initial(name)


//Places the poster on a wall
/obj/item/weapon/contraband/poster/afterattack(var/turf/wall/W, var/mob/user, var/adjacent, var/clickparams)
	if (!adjacent)
		return

	//must place on a wall and user must not be inside a closet/mecha/whatever
	if (!istype(W) || !W.Adjacent(user))
		user << "<span class='warning'>You can't place this here!</span>"
		return

	var/turf/new_loc = null

	var/placement_dir = get_dir(user, W)
	if (placement_dir in cardinal)
		new_loc = user.loc
	else
		placement_dir = reverse_dir[placement_dir]
		for (var/t_dir in cardinal)
			if (!t_dir&placement_dir) continue
			if (iswall(get_step(W, t_dir)))
				if (iswall(get_step(W, placement_dir-t_dir)))
					break
				else
					new_loc = get_step(W, placement_dir-t_dir)
					break
			else
				if (iswall(get_step(W, placement_dir-t_dir)))
					new_loc = get_step(W, t_dir)
					break
				else
					new_loc = user.loc
					break
	if (!new_loc)
		user << "<span class='warning'>You can't place poster there</span>"

	//Looks like it's uncluttered enough. Place the poster.
	user << "<span class='notice'>You start placing the poster on the wall...</span>"
	if (do_after(usr, 17, src))
		user.drop_from_inventory(src, new_loc)
		placement_dir = get_dir(W, new_loc)
		if (placement_dir&NORTH)
			pixel_y = -32
		else if (placement_dir&SOUTH)
			pixel_y = 32
		if (placement_dir&WEST)
			pixel_x = 32
		else if (placement_dir&EAST)
			pixel_x = -32
		anchored = TRUE
		flick("poster_being_set", src)
		playsound(W, 'sound/items/poster_being_created.ogg', 100, TRUE)
		design.set_design(src)

/datum/poster
	// Name suffix. Poster - [name]
	var/name=""
	// Description suffix
	var/desc=""
	var/icon_state=""
	var/icon = 'icons/obj/contraband.dmi'

/datum/poster/proc/set_design(var/obj/item/weapon/contraband/poster/P)
	P.name = "poster - [name]"
	P.desc = desc
	P.icon_state = icon_state
	P.icon = icon
	return TRUE
