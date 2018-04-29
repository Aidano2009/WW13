var/process/movement/movement_process = null

/process/movement

/process/movement/setup()
	name = "mob movement"
	schedule_interval = 0.3
	start_delay = 10
	fires_at_gamestates = list(GAME_STATE_PREGAME, GAME_STATE_SETTING_UP, GAME_STATE_PLAYING, GAME_STATE_FINISHED)
	movement_process = src
	subsystem = TRUE

/process/movement/fire()
	SCHECK
	for(last_object in living_mob_list|dead_mob_list)

		var/mob/M = last_object

		if(isnull(M))
			continue

		if (!M.movement_process_dirs.len)
			continue

		if(!M.client)
			continue

		if(isnull(M.gcDestroyed))
			try
				var/diag = FALSE
				var/movedir = M.movement_process_dirs[M.movement_process_dirs.len]
				if (M.movement_process_dirs.len > 1)
					var/secdir = M.movement_process_dirs[M.movement_process_dirs.len-1]
					var/list/dirs = list(movedir, secdir)
					if (dirs.Find(NORTH) && dirs.Find(WEST))
						movedir = NORTHWEST
						diag = TRUE
					else if (dirs.Find(NORTH) && dirs.Find(EAST))
						movedir = NORTHEAST
						diag = TRUE
					else if (dirs.Find(SOUTH) && dirs.Find(WEST))
						movedir = SOUTHWEST
						diag = TRUE
					else if (dirs.Find(SOUTH) && dirs.Find(EAST))
						movedir = SOUTHEAST
						diag = TRUE
				M.client.Move(get_step(M, movedir), movedir, diag)
			catch(var/exception/e)
				catchException(e, M)
		else
			catchBadType(M)
			mob_list -= M

		SCHECK

/process/movement/statProcess()
	..()
	stat(null, "[mob_list.len] mobs")

/process/mob/htmlProcess()
	return ..() + "[mob_list.len] mobs"