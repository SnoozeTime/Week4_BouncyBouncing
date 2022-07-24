/// @description Insert description here
// You can write your code in this editor

// Where we play th death anim
sequence_layer = layer_create(depth)
active_sequence = noone

enum PlayerState {
	Playing,
	AlmostDone,
	Done,
	Dead,
}


can_dash = true
dash_speed = 8*32
is_dashing = false
dash_duration = .2

collision_layer_name = "Walls"

on_floor = false
my_state = PlayerState.Playing

// animation is based on jump
image_speed = 0

y_remain = 0.0
x_remain = 0.0

// inputs
left = 0
right = 1

// Timing press
current_jump_boost = 1
has_pressed_boost = false
boost_increment = .2
boost_decrement = .4
jump_counter = 0
max_boost = 2.0

// Speed and so on
hsp = 0;
vsp = 0;
jump_vel = 5*32
move_vel = 3*32

// frames on floor
frames_on_floor = 5
current_floor_frame = 5


player_reset = function() {
	current_jump_boost = 1.0
	my_state = PlayerState.Playing
	visible = true
	if active_sequence != noone {
		layer_sequence_destroy(active_sequence)
		active_sequence = noone	
	}
}

on_death = function() {
	if my_state != PlayerState.Dead {
		my_state = PlayerState.Dead
		visible = false
		audio_play_sound(snd_death, 0, false)
		if active_sequence == noone {
			active_sequence = layer_sequence_create(sequence_layer, x, y, seq_player_death)
		}
	}
}


on_victory = function() {
	if my_state != PlayerState.AlmostDone and my_state != PlayerState.Done {
		my_state = PlayerState.AlmostDone
	}
}

on_jump_success = function() {
	current_jump_boost += boost_increment
	current_jump_boost = min(current_jump_boost, max_boost)
	alarm[1] = 3
	global.game_paused = true
}