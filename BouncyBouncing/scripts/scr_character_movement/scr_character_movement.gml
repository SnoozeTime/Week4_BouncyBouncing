

#macro JUMP_COUNTER_FRAMES 13

function  character_get_inputs() {

	left = keyboard_check(vk_left) or keyboard_check(ord("A"))
	right = keyboard_check(vk_right) or keyboard_check(ord("D"))
	
	if keyboard_check_pressed(vk_space) {
		jump_counter = JUMP_COUNTER_FRAMES	
	}
	
	if keyboard_check_pressed(vk_shift) {
		if not is_dashing and can_dash {
			audio_play_sound(snd_dash, 0, false)
			can_dash = false
			is_dashing = true
			alarm[0] = dash_duration * room_speed
			sprite_index = spr_character_dash
		}
	}
}


function character_move_x(_dx){
	x_remain += _dx
	var _move = round(x_remain)
	if _move != 0 {
		x_remain -= _move
		var _sign = sign(_move)
	
		while _move != 0 {
		
			if scr_tile_meeting(x+_sign, y, collision_layer_name) || place_meeting(x+_sign, y, obj_par_solid) {
				break	
			} else {
				x += _sign
				_move -= _sign
			}
		}
	
	}
}


function actor_is_riding(_solid) {
	return place_meeting(x, y+1, _solid) 
}


function actor_squish() {
	on_death()	
}

function character_move_y(_dy, _cb = noone) {
	
	y_remain += _dy
	var _move = round(y_remain)
	if _move != 0 {
		y_remain -= _move
		var _sign = sign(_move)
	
		while _move != 0 {
		
			if scr_tile_meeting(x, y+_sign, collision_layer_name) or place_meeting(x, y+_sign, obj_par_solid) {
				vsp = 0
				if _cb != noone {
					_cb()
				}
				break	
			} else {
				y += _sign
				_move -= _sign
			}
		}
	
	}	
}