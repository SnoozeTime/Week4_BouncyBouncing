/// @description Insert description here
// You can write your code in this editor

draw_sprite_stretched(spr_textbox_outside, 0, x-1, y, 1, box_height)
draw_sprite_stretched(spr_textbox_inside, 0, x, y, box_width, box_height)
draw_sprite_stretched(spr_textbox_outside, 0, x+box_width, y, 1, box_height)
draw_set_color(c_black)

var _text = text
if has_focus {
	_text += cursor	
}	

draw_set_valign(fa_middle)
draw_set_font(obj_game.small_pixel_font)
draw_text(x+1, y+box_height/2, _text)

if label != "" {
	draw_set_valign(fa_middle)
	draw_set_color(c_black)
	draw_text(x, y-box_height/2+5, label)
}
