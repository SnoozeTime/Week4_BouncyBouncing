

spawn = obj_spawn

// Set player position


respawn = function() {
	with obj_player {
		x = other.spawn.x
		y = other.spawn.y
	}
}

respawn()

level_done = function() {
	with obj_player {
		my_state = PlayerState.Done
	}
}