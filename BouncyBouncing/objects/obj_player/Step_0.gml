/// @description Player control

var _dt = delta_time / 1000000;


var _jump = jump_counter>0 and on_floor
if _jump {
	if not has_pressed_boost {
		has_pressed_boost = true
	}
}

character_get_inputs()

hsp = (right-left) * move_vel * _dt

// 1m = 32 pixels
var _grav = 32*9.8
// https://maddythorson.medium.com/celeste-and-towerfall-physics-d24bd2ae0fc5

vsp += _dt * _grav

var _dy = vsp*_dt

if my_state == PlayerState.Playing {
	character_move_x(hsp)
}

character_move_y(_dy)

// Check if on ground.
// -------------------
if scr_tile_meeting(x, y+1, "Walls") {
	on_floor = true
	
	vsp = 0
	current_floor_frame -= 1

	// If level is done, let's not trigger a jump
	if my_state == PlayerState.Playing {
		if current_floor_frame == 0 {
		
			// Boost!
			if has_pressed_boost {
				current_jump_boost += boost_increment	
			} else {
				current_jump_boost = max(current_jump_boost-boost_decrement, 1.0)
			}
		
			current_floor_frame = frames_on_floor
			vsp = -current_jump_boost*jump_vel	
		}
	}
} else {
	has_pressed_boost = false
	on_floor = false
	
}


// Animation !
// ---------------
#region Animation
if on_floor {
	if my_state == PlayerState.Playing {
		image_index = 0
		if current_floor_frame < 3 {
			image_index = 1	
		}
	} else {
		// FINISH ANIMATION	
		image_index = 0
	}
} else {
	// apex
	if abs(vsp) < 40 {
		image_index = 4	
		//my_state = PlayerState.floating
	} else if vsp < 0 {
		//my_state = PlayerState.rising
		image_index = 2
	} else {
		//my_state = PlayerState.falling
		if vsp > 30 and vsp < 60 {
			image_index = 3
		} else {
			image_index = 5
		}
		
	}
}

if hsp < 0 {
	image_xscale = -1	
} else if hsp > 0 {
	image_xscale = 1	
}
#endregion

jump_counter = max(0, jump_counter-1)