

// Stop flickering at last frame.
if image_index == image_number-1 {
	image_speed = 0	
}

var _dt = delta_time / 1000000;
t+=_dt
y = start_y + hover_amplitude*sin(2*pi*hover_freq*t)
