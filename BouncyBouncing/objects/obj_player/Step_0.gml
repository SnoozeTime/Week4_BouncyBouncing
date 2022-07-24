/// @description Player control

var _dt = delta_time / 1000000;

if not global.game_paused {

	if my_state != PlayerState.Dead {
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
	
		if is_dashing {
			_dy = 0
			// where are we headed
			hsp = image_xscale *  dash_speed * _dt
		}

		if my_state == PlayerState.Playing {
			character_move_x(hsp)
		}

		character_move_y(_dy)

		// Check if on ground.
		// -------------------
		if scr_tile_meeting(x, y+1, collision_layer_name) or place_meeting(x, y+1, obj_par_solid) {
			on_floor = true
			
			if not is_dashing {
				can_dash = true	
			}
	
			vsp = 0
			current_floor_frame -= 1

			// If level is done, let's not trigger a jump
			if my_state == PlayerState.Playing {
				if current_floor_frame == 0 {
		
					// Boost!
					if has_pressed_boost {
						on_jump_success()
						audio_play_sound(snd_boost_jump, 0, false)
					} else {
						current_jump_boost = max(current_jump_boost-boost_decrement, 1.0)
						audio_play_sound(snd_normal_jump, 0, false)
					}
		
					current_floor_frame = frames_on_floor
					vsp = -current_jump_boost*jump_vel	
					instance_create_layer(x, y, layer, obj_dust)
				}
			}
		} else {
			has_pressed_boost = false
			on_floor = false
		}

	}
	
	
	if my_state == PlayerState.AlmostDone and on_floor {
		my_state = PlayerState.Done
		visible = false
		if active_sequence == noone {
			active_sequence = layer_sequence_create(sequence_layer, x, y, seq_player_victory)
		}
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

	if is_dashing {
		image_index = 0
	}


	if hsp < 0 {
		image_xscale = -1	
	} else if hsp > 0 {
		image_xscale = 1	
	}
	#endregion


	// DEATH SEQUENCE
	if active_sequence != noone {
		if layer_sequence_is_finished(active_sequence) {
			layer_sequence_destroy(active_sequence)
			active_sequence = noone
		}
	}

	// ----

	jump_counter = max(0, jump_counter-1)
}