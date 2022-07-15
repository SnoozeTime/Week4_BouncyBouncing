event_inherited()

// Set player position

alarm[0] = 5


respawn = function() {
	with obj_player {
		x = other.current_player_start.x
		y = other.current_player_start.y
		player_reset()
	}
}

level_done = function() {
	with obj_player {
		my_state = PlayerState.Done
	}
}