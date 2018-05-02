/obj/item/weapon/grenade
	name = "grenade"
	desc = "A hand held grenade, with an adjustable timer."
	w_class = 2.0
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade"
	item_state = "grenade"
	throw_speed = 4
	throw_range = 8
	flags = CONDUCT
	slot_flags = SLOT_BELT|SLOT_MASK
	var/active = FALSE
	var/det_time = 50
	var/loadable = TRUE

/obj/item/weapon/grenade/proc/clown_check(var/mob/living/user)
	if((CLUMSY in user.mutations) && sprob(50))
		user << "<span class='warning'>Huh? How does this thing work?</span>"

		activate(user)
		add_fingerprint(user)
		spawn(5)
			prime()
		return FALSE
	return TRUE


/*/obj/item/weapon/grenade/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (istype(target, /obj/item/weapon/storage)) return ..() // Trying to put it in a full container
	if (istype(target, /obj/item/weapon/gun/grenadelauncher)) return ..()
	if((user.get_active_hand() == src) && (!active) && (clown_check(user)) && target.loc != loc)
		user << "<span class='warning'>You prime the [name]! [det_time/10] seconds!</span>"
		active = TRUE
		icon_state = initial(icon_state) + "_active"
		playsound(loc, 'sound/weapons/armbomb.ogg', 75, TRUE, -3)
		spawn(det_time)
			prime()
			return
		user.set_dir(get_dir(user, target))
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
	return*/


/obj/item/weapon/grenade/examine(mob/user)
	if(..(user, FALSE))
		if(det_time > 1)
			user << "The timer is set to [det_time/10] seconds."
			return
		if(det_time == null)
			return
		user << "\The [src] is set for instant detonation."


/obj/item/weapon/grenade/attack_self(mob/user as mob)
	if(!active)
		if(clown_check(user))
			user << "<span class='warning'>You prime \the [name]! [det_time/10] seconds!</span>"

			activate(user)
			add_fingerprint(user)
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.throw_mode_on()
	return


/obj/item/weapon/grenade/proc/activate(mob/user as mob)
	if(active)
		return

	if(user)
		msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

	icon_state = initial(icon_state) + "_active"
	active = TRUE
	playsound(loc, 'sound/weapons/armbomb.ogg', 75, TRUE, -3)

	spawn(det_time)
		visible_message("<span class = 'warning'>\The [src] goes off!</span>")
		prime()
		return

/obj/item/weapon/grenade/proc/fast_activate()
	det_time = round(det_time/10)
	activate()

/obj/item/weapon/grenade/proc/prime()
	if (active)
	//	playsound(loc, 'sound/items/Welder2.ogg', 25, TRUE)
		var/turf/T = get_turf(src)
		if(T)
			T.hotspot_expose(700,125)


/obj/item/weapon/grenade/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(isscrewdriver(W))
		switch(det_time)
			if (1)
				det_time = 10
				user << "<span class='notice'>You set the [name] for TRUE second detonation time.</span>"
			if (10)
				det_time = 30
				user << "<span class='notice'>You set the [name] for 3 second detonation time.</span>"
			if (30)
				det_time = 50
				user << "<span class='notice'>You set the [name] for 5 second detonation time.</span>"
			if (50)
				det_time = TRUE
				user << "<span class='notice'>You set the [name] for instant detonation.</span>"
		add_fingerprint(user)
	..()
	return

/obj/item/weapon/grenade/attack_hand()
	walk(src, null, null)
	..()
	return

var/list/tile2grenades = list()
/obj/item/weapon/grenade/ex_act(severity)
	switch (severity)
		if (1.0)
			if (tile2grenades[loc] >= 5)
				return
			fast_activate()
			if (!tile2grenades.Find(loc))
				tile2grenades[loc] = 0
			++tile2grenades[loc]
			spawn (50)
				if (tile2grenades[loc])
					tile2grenades[loc] = 0
		if (2.0)
			if (prob(50))
				return ex_act(1.0)
		if (3.0)
			if (prob(5))
				return ex_act(1.0)

/obj/item/weapon/grenade/bullet_act(var/obj/item/projectile/proj)
	if (proj && !proj.nodamage)
		return ex_act(1.0)
	return FALSE