// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function editor_set_tiles_in_rect(_tilemap, _rect, _idx){
	var _tile_left = tilemap_get_cell_x_at_pixel(_tilemap, _rect[0][0], _rect[0][1])
	var _tile_top = tilemap_get_cell_y_at_pixel(_tilemap, _rect[0][0], _rect[0][1])
	var _tile_right = tilemap_get_cell_x_at_pixel(_tilemap, _rect[1][0], _rect[1][1])
	var _tile_bottom = tilemap_get_cell_y_at_pixel(_tilemap, _rect[1][0], _rect[1][1])
	
	for (var _i=_tile_left; _i <= _tile_right; _i++) {
		for (var _j=_tile_top; _j <= _tile_bottom; _j++) {
			tilemap_set(_tilemap, _idx, _i, _j)
		}
	}
			
	editor_adjust_tiles_idx(_tilemap)
}