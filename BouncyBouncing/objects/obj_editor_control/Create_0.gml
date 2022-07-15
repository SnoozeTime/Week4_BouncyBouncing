/// @description Insert description here
// You can write your code in this editor

event_inherited()


included_file_path = "C:/Users/benoi/source/repos/Platformer/Week4_BouncyBouncing/BouncyBouncing/datafiles/"
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
		collision_layer_name = "Tiles_1"	
	}
	instance_create_layer(x, y, layer, obj_level_control)
	with current_player_start {
		visible = false	
	}
	
	with obj_camera {
		editor_mode = false	
	}
}

stop_game = function() {
	instance_destroy(obj_level_control)	
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
filename_input = instance_create_layer(20, 20, layer, gui_textinput)
filename_input.visible = false
filename_input.depth = -1

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


alarm[0] = room_speed

