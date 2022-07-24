/// @description Insert description here
// You can write your code in this editor

event_inherited()


included_file_path = "E:/MyGames/Week4_BouncyBouncing/BouncyBouncing/datafiles/"
//"C:/Users/benoi/source/repos/Platformer/Week4_BouncyBouncing/BouncyBouncing/datafiles/"
enum DrawMode {
	
	PlayerStart,
	Walls,
	WallsRemove,
	Playing,
}
draw_mode = DrawMode.PlayerStart

vk_to_mode = ds_map_create()
ds_map_add(vk_to_mode, vk_f1, DrawMode.PlayerStart)
ds_map_add(vk_to_mode, vk_f2, DrawMode.Walls)
ds_map_add(vk_to_mode, vk_f3, DrawMode.WallsRemove)
mode_keys = ds_map_keys_to_array(vk_to_mode)
cell_size = 16
show_area = false
draw_start = [0,0]

closest_mouse = function() {
	var _x = mouse_x
	var _y = mouse_y
	
	return [ceil(_x/cell_size) * cell_size, ceil(_y/cell_size) * cell_size]
}

get_draw_rect = function() {
	var _mouse = closest_mouse()
	var _left = min(draw_start[0], _mouse[0])
	var _right = max(draw_start[0], _mouse[0])-1
	var _top = min(draw_start[1], _mouse[1])
	var _bottom = max(draw_start[1], _mouse[1])-1
	return [[_left, _top], [_right, _bottom]]
}


reset_level = function() {
	
	with current_player_start {
		instance_destroy()	
	}
	
	// reset all tiles:
	editor_reset_tilemap(tile_map)
}

start_game = function() {
	// Spawn level control and player
	with instance_create_layer(x, y, layer, obj_player) {
		//collision_layer_name = "Tiles_1"	
		x = other.current_player_start.x
		y = other.current_player_start.y
		player_reset()
	}
	//instance_create_layer(x, y, layer, obj_level_control)
	with current_player_start {
		visible = false	
	}
	
	with obj_camera {
		editor_mode = false	
	}
}

stop_game = function() {
	//instance_destroy(obj_level_control)	
	instance_destroy(obj_player)
	with obj_camera {
		editor_mode = true	
	}
	with current_player_start {
		visible = true	
	}
}


// SET UP GUI
// --------------------------------------------
#region GUI
control_panel = instance_create_layer(x, y, layer, gui_panel)
control_panel.visible = false
filename_input = instance_create_layer(30, 40, layer, gui_textinput)
with filename_input {
	visible = false
	depth = -1
	box_width = 150
	label = "Level Name"
	text = "Level1"
}

display_gui = false
toggle_gui = function() {
	control_panel.visible = !control_panel.visible
	filename_input.visible = !filename_input.visible
	display_gui = !display_gui
	with obj_camera {
		editor_mode = !other.display_gui	
	}
}
#endregion

tile_idx_map = ds_map_create()
ds_map_add(tile_idx_map, 0, 0)
ds_map_add(tile_idx_map, 2, 1)
ds_map_add(tile_idx_map, 8, 2)
ds_map_add(tile_idx_map, 10, 3)
ds_map_add(tile_idx_map, 11, 4)
ds_map_add(tile_idx_map, 16, 5)
ds_map_add(tile_idx_map, 18, 6)
ds_map_add(tile_idx_map, 22, 7)
ds_map_add(tile_idx_map, 24, 8)
ds_map_add(tile_idx_map, 26, 9)
ds_map_add(tile_idx_map, 27, 10)
ds_map_add(tile_idx_map, 30, 11)
ds_map_add(tile_idx_map, 31, 12)
ds_map_add(tile_idx_map, 64, 13)
ds_map_add(tile_idx_map, 66, 14)
ds_map_add(tile_idx_map, 72, 15)
ds_map_add(tile_idx_map, 74, 16)
ds_map_add(tile_idx_map, 75, 17)
ds_map_add(tile_idx_map, 80, 18)
ds_map_add(tile_idx_map, 82, 19)
ds_map_add(tile_idx_map, 86, 20)
ds_map_add(tile_idx_map, 88, 21)
ds_map_add(tile_idx_map, 90, 22)
ds_map_add(tile_idx_map, 91, 23)
ds_map_add(tile_idx_map, 94, 24)
ds_map_add(tile_idx_map, 95, 25)
ds_map_add(tile_idx_map, 104, 26)
ds_map_add(tile_idx_map, 106, 27)
ds_map_add(tile_idx_map, 107, 28)
ds_map_add(tile_idx_map, 120, 29)
ds_map_add(tile_idx_map, 122, 30)
ds_map_add(tile_idx_map, 123, 31)
ds_map_add(tile_idx_map, 126, 32)
ds_map_add(tile_idx_map, 127, 33)
ds_map_add(tile_idx_map, 208, 34)
ds_map_add(tile_idx_map, 210, 35)
ds_map_add(tile_idx_map, 214, 36)
ds_map_add(tile_idx_map, 216, 37)
ds_map_add(tile_idx_map, 218, 38)
ds_map_add(tile_idx_map, 219, 39)
ds_map_add(tile_idx_map, 222, 40)
ds_map_add(tile_idx_map, 223, 41)
ds_map_add(tile_idx_map, 248, 42)
ds_map_add(tile_idx_map, 250, 43)
ds_map_add(tile_idx_map, 251, 44)
ds_map_add(tile_idx_map, 254, 45)
ds_map_add(tile_idx_map, 255, 46)

#region Autotile




#endregion


alarm[0] = room_speed

