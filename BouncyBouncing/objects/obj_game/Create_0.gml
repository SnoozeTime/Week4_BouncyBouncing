/// @description 

audio_master_gain(0)
global.game_speed = 1.0
global.game_paused = false

tile_map = layer_tilemap_get_id("Walls")
current_player_start = noone

reset_level = function() {}


display_set_gui_size(view_width, view_height)


// Set up the pixel font
small_pixel_font = font_add("ThaleahFat.ttf",12, false, false, 32, 128)

audio_play_sound(snd_bg_level, 0, true)