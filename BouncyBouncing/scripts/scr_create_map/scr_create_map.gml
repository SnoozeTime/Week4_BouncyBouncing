/**
 * Tiles idx should differ if they are in the center or at the edges...
**/
function editor_adjust_tiles_idx(tile_map){


	for (var _x=0; _x < tilemap_get_width(tile_map); _x++) {
		for (var _y=0; _y < tilemap_get_width(tile_map); _y++) {
			
			if !editor_is_valid_tile(tile_map, _x, _y) {
				continue	
			}
			
			// get the neighbours left and right.
			var _has_left = _x > 0 and editor_is_valid_tile(tile_map,_x-1, _y)
			var _has_right = _x < tilemap_get_width(tile_map)-1 and editor_is_valid_tile(tile_map,_x+1, _y)
			
			
			// single tile 
			if not _has_left and not _has_right {
				tilemap_set(tile_map, 1, _x, _y)	
			} 
			
			// tile left
			else if not _has_left and _has_right {	
				tilemap_set(tile_map, 2, _x, _y)	
			}
			
			// tile right
			else if _has_left and not _has_right {
				tilemap_set(tile_map, 3, _x, _y)	
			}
			
			// inside
			else if _has_left and _has_right {
				tilemap_set(tile_map, 1, _x, _y)	
			}
			
		}
	}
}

function editor_is_valid_tile(_tile_map, _x, _y) {
	var _data = tilemap_get(tile_map, _x, _y)
	return _data != 0 and _data != -1
}

function editor_reset_tilemap(tile_map) {
	for (var _x=0; _x < tilemap_get_width(tile_map); _x++) {
		for (var _y=0; _y < tilemap_get_width(tile_map); _y++) {
			tilemap_set(tile_map, 0, _x, _y)	
		}
	}
}


