/// @description Insert description here
// You can write your code in this editor


enum PlayerState {
	Playing,
	Done
}

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

// Speed and so on
hsp = 0;
vsp = 0;
jump_vel = 4*32
move_vel = 2*32

// frames on floor
frames_on_floor = 5
current_floor_frame = 5


player_reset = function() {
	current_jump_boost = 1.0	
}
