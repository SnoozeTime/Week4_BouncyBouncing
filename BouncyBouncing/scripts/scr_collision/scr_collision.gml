// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@description tile_meeting(x,y,layer)
///@param x
///@param y
///@param layer
function scr_tile_meeting(_x, _y, _layer){

	var _tm = layer_tilemap_get_id(_layer)
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y)
	var _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y))
	var _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y)
	var _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y))
	
	for (var _i = _x1; _i <= _x2; _i++) {
		for (var _j = _y1; _j <= _y2; _j++) {
			if tile_get_index(tilemap_get(_tm, _i, _j)) {
				return true	
			}
		}	
	}
	
	return false
}


///@description scr_tile_meeting_precise(x,y,layer)
///@param x
///@param y
///@param layer
function scr_tile_meeting_precise(_x, _y, _layer){

	var _tm = layer_tilemap_get_id(_layer)
	var _checker = obj_precise_tile_checker
	if not instance_exists(_checker) {
		instance_create_depth(0, 0, 0, _checker)	
	}
	
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y)
	var _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y))
	var _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y)
	var _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y))
	
	for (var _i = _x1; _i <= _x2; _i++) {
		for (var _j = _y1; _j <= _y2; _j++) {
			var _tile = tile_get_index(tilemap_get(_tm, _i, _j))
			if _tile {
				if _tile == 1 {
					// Completely solid tile
					return true	
				}
				
				_checker.x = _i * tilemap_get_tile_width(_tm)
				_checker.y = _j * tilemap_get_tile_height(_tm)
				_checker.image_index = _tile
				if place_meeting(_x, _y, _checker) {
					return true
				}
			}
		}	
	}
	
	return false
}
