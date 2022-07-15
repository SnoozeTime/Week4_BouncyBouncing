/// @description
randomize()
hover_amplitude = 2 *sign(random_range(-1, 1))
hover_freq = 0.5
start_y = y


t = random_range(0.0, 1.0)


flicker_time = 2*room_speed
alarm[0] = random_range(0.0, flicker_time)
