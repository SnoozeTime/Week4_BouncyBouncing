 /// @description
view_width = 320
view_height = 180
 
window_scale = 4
 
window_set_size(view_width * window_scale, view_height * window_scale)
alarm[0] = 1
 
surface_resize(application_surface, view_width * window_scale, view_height * window_scale)


shake_length = 0
shake_magnitude = 0 // Pixels to right/left/top/bottom
shake_remain = 0
buff = 32 // buffer