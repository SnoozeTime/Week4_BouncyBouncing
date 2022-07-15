/// @description

#macro view view_camera[0]

camera_set_view_size(view, view_width, view_height)


if not editor_mode {
	if (instance_exists(obj_player)) {
	
		// keep camera inside the room
		var _x = clamp(obj_player.x - view_width/2, buff, room_width-view_width-buff)
		var _y =  clamp(obj_player.y - view_height/2, buff, room_height-view_height-buff)
	
		// Screen shake
		_x += random_range(-shake_remain, shake_remain)
		_y += random_range(-shake_remain, shake_remain)
		shake_remain = max(0, shake_remain - ((1/shake_length)*shake_magnitude))
	
	
		var _cur_x = camera_get_view_x(view)
		var _cur_y = camera_get_view_y(view)
	
		// Lerp position of camera to have smooth movement.
		var _spd = .1;
	
	
		camera_set_view_pos(view, 
			lerp(_cur_x, _x, _spd),
			lerp(_cur_y, _y, _spd))
	}
} else {
	// When not in play mode, move the camera when mouse is at the edge of the screen
	#region Camera movement in Editor mode


	var _cur_x = camera_get_view_x(view)
	var _cur_y = camera_get_view_y(view)
	if _cur_x+20 > mouse_x and mouse_x >= _cur_x {
		_cur_x -= 1	
	} else if _cur_x + view_width - 20 < mouse_x and mouse_x <= _cur_x + view_width {
		_cur_x += 1	
	}
	
	if _cur_y+20 > mouse_y and mouse_y >= _cur_y {
		_cur_y -= 1	
	} else if _cur_y + view_height - 20 < mouse_y and mouse_y <= _cur_y + view_height {
		_cur_y += 1	
	}

		// keep camera inside the room
	_cur_x = clamp(_cur_x, 0, room_width-view_width)
	_cur_y =  clamp(_cur_y, 0, room_height-view_height)
	camera_set_view_pos(view, _cur_x, _cur_y)

	#endregion
	
}
