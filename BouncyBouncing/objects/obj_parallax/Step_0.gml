/// @description parallax

layer_x(near, lerp(0, camera_get_view_x(view), .5))
layer_x(far, lerp(0, camera_get_view_x(view), .7))
layer_x(farthest, lerp(0, camera_get_view_x(view), .85))



layer_y(near, lerp(0, camera_get_view_y(view)-150, .9))
layer_y(far, lerp(0, camera_get_view_y(view)-150, .95))
layer_y(farthest, lerp(0, camera_get_view_y(view)-150, .99))
