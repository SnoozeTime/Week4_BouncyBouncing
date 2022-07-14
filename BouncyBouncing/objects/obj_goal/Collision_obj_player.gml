/// @description Level is finished !

with obj_player {
	if my_state == PlayerState.Playing {
		with obj_level_control {
			level_done()
		}
	}
}