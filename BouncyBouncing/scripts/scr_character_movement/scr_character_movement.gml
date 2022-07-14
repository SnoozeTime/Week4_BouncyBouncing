

#macro JUMP_COUNTER_FRAMES 13

function  character_get_inputs() {

	left = keyboard_check(vk_left) or keyboard_check(ord("A"))
	right = keyboard_check(vk_right) or keyboard_check(ord("D"))
	
	if keyboard_check_pressed(vk_space) {
		jump_counter = JUMP_COUNTER_FRAMES	
	}
}


function character_move_x(_dx){
	x_remain += _dx
	var _move = round(x_remain)
	if _move != 0 {
		x_remain -= _move
		var _sign = sign(_move)
	
		while _move != 0 {
		
			if scr_tile_meeting(x+_sign, y, "Walls") {
				break	
			} else {
				x += _sign
				_move -= _sign
			}
		}
	
	}
}

function character_move_y(_dy) {
	
	y_remain += _dy
	var _move = round(y_remain)
	if _move != 0 {
		y_remain -= _move
		var _sign = sign(_move)
	
		while _move != 0 {
		
			if scr_tile_meeting(x, y+_sign, "Walls") {
				break	
			} else {
				y += _sign
				_move -= _sign
			}
		}
	
	}	
}