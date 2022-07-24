event_inherited()

// Set player position

alarm[0] = 5

current_player_start = obj_spawn


respawn = function() {
	with obj_player {
		x = other.current_player_start.x
		y = other.current_player_start.y
		player_reset()
	}
}

level_done = function() {
	with obj_player {
		on_victory()
	}
}

player_death = function() {
	alarm[1] = room_speed * 1.5	
}