/// @description Insert description here
// You can write your code in this editor

var _mouse_pressed = false
var _mouse_released = false


// Switch draw modes.
if draw_mode != DrawMode.Playing {
	
	if !display_gui {
		
		var _mouse_pressed = mouse_check_button_pressed(mb_left)
		var _mouse_released = mouse_check_button_released(mb_left)

		for (var _ki = 0; _ki < array_length(mode_keys); _ki++) {
			if keyboard_check_pressed(mode_keys[_ki]) {
				draw_mode = vk_to_mode[? mode_keys[_ki]]
				break
			}
		}
		
		if keyboard_check_pressed(vk_space) {
			draw_mode = DrawMode.Playing
			start_game()
		}
	}
	
	if keyboard_check_pressed(vk_escape) {
		toggle_gui()
	}
} else {
	
	if keyboard_check_pressed(vk_escape) {
		draw_mode = DrawMode.Walls
		stop_game()
	}
}

	


switch draw_mode {
	
	#region Place Player Start
	case DrawMode.PlayerStart:
		if _mouse_pressed {
			if current_player_start == noone {
				current_player_start = instance_create_layer(mouse_x, mouse_y, layer, obj_spawn)	
			}
			
			with current_player_start {
				x = mouse_x
				y = mouse_y
				visible = true
			}
		}
	break
	#endregion
	
	#region draw tiles
	case DrawMode.Walls:
		if _mouse_pressed {
			draw_start = closest_mouse()
			show_area = true
		}

		if _mouse_released {
			show_area = false
			var _rect = get_draw_rect()
			editor_set_tiles_in_rect(tile_map, _rect, 1)
		}
	break
	#endregion

	// remove tiles
	#region remove tiles
	case DrawMode.WallsRemove:
		if _mouse_pressed {
			draw_start = closest_mouse()
			show_area = true
		}

		if _mouse_released {
			show_area = false
			var _rect = get_draw_rect()
			editor_set_tiles_in_rect(tile_map, _rect, 0)
		}
	
	break
	#endregion
}
