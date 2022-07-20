/// @description 

event_inherited()
box_width = 70
box_height = 20
text = ""
cursor = "|"
delay = 20
alarm[0] = delay

onFocus = function() {
	keyboard_string = text
}

is_mouse_in_bounds = function() {
	if mouse_check_button(mb_left) {
		var _has_focus = false
		var _mouse_x = device_mouse_x_to_gui(0)
		var _mouse_y = device_mouse_y_to_gui(0)
		if _mouse_x > x and _mouse_x < x+box_width {
			if _mouse_y > y and _mouse_y < y+box_height {
				_has_focus = true
				onFocus()
			}
		}
		
		return _has_focus
	}
	
	return has_focus
}

