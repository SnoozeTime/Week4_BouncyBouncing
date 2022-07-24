/// @description Insert description here
// You can write your code in this editor
event_inherited()


// Target
path_idx = 1
if moving_path != noone {

	log(string_interpolate("Points in path = {}", [path_get_number(moving_path)]))

	x = path_get_point_x(moving_path, 0)
	y = path_get_point_y(moving_path, 0)
}