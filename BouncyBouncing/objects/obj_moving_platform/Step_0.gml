/// @description Insert description here
// You can write your code in this editor


if moving_path != noone {
	target_x = path_get_point_x(moving_path, path_idx)
	target_y = path_get_point_y(moving_path, path_idx)
	
	
	if x == target_x and y == target_y {
		path_idx = (path_idx+1) % path_get_number(moving_path)
	}
	
	solid_move(sign(target_x - x), sign(target_y - y))
}
