#macro TILE_TM 7
#macro TILE_TL 6
#macro TILE_TR 8

#macro TILE_MM 10
#macro TILE_ML 11
#macro TILE_MR 9
// diagonal
#macro TILE_MIDDLE_TL 15
#macro TILE_MIDDLE_TR 16
#macro TILE_MIDDLE_BL 18
#macro TILE_MIDDLE_BR 17


#macro TILE_BM 13
#macro TILE_BL 12
#macro TILE_BR 14


//24


function editor_get_tile_index(_x, _y, _tile_map, _idx_map) {
		// get all the neighbours 
		var _tm_w = tilemap_get_width(_tile_map)
		var _tm_h = tilemap_get_height(_tile_map)
		var _has_left = _x > 0 and editor_is_valid_tile(_tile_map,_x-1, _y)
		var _has_right = _x < _tm_w-1 and editor_is_valid_tile(_tile_map,_x+1, _y)
		var _has_top = _y > 0 and editor_is_valid_tile(_tile_map,_x, _y-1)
		var _has_bottom = _y < _tm_h-1 and editor_is_valid_tile(_tile_map,_x, _y+1)
		var _has_top_left = _x > 0 and _y > 0 and editor_is_valid_tile(_tile_map,_x-1, _y-1)
		var _has_top_right = _x < _tm_w-1 and _y > 0  and editor_is_valid_tile(_tile_map,_x+1, _y-1)
		var _has_bottom_left = _x > 0 and _y < _tm_h-1 and editor_is_valid_tile(_tile_map,_x-1, _y+1)
		var _has_bottom_right = _x < _tm_w-1 and _y < _tm_h-1 and editor_is_valid_tile(_tile_map,_x+1, _y+1)
		
		var _idx = _has_top_left + _has_top * 2 + _has_top_right * 4 + _has_left * 8 + _has_right * 16 + _has_bottom_left * 32 + _has_bottom * 64 + _has_bottom_right * 128
		if ds_map_exists(_idx_map, _idx) {
			return 	ds_map_find_value(_idx_map, _idx)
		} else {	
			return 0
		}
		
		//if not _has_top and not _has_bottom {
		//	// single tile 
		//	if not _has_left and not _has_right {
		//		return TILE_TM
		//	} 
			
		//	// tile left
		//	else if not _has_left and _has_right {	
		//		return TILE_TL
		//	}
			
		//	// tile right
		//	else if _has_left and not _has_right {
		//		return TILE_TR
		//	}
			
		//	// inside
		//	else if _has_left and _has_right {
		//		return TILE_TM	
		//	}
		//} else if _has_top and not _has_bottom {
			
			
		//	// BOTTOM LAYER
		//	// ----------------------------------
			
		//	// single tile 
		//	if not _has_left and not _has_right {
		//		return TILE_BM
		//	} 
			
		//	// tile left
		//	else if not _has_left and _has_right {	
		//		return TILE_BL
		//	}
			
		//	// tile right
		//	else if _has_left and not _has_right {
		//		return TILE_BR
		//	}
			
		//	// inside
		//	else if _has_left and _has_right {
		//		return TILE_BM	
		//	}
		//} else if _has_bottom and not _has_top {
			
		//	// TOP LAYER
		//	// ----------------------------------
			
		//	// single tile 
		//	if not _has_left and not _has_right {
		//		return TILE_TM
		//	} 
			
		//	// tile left
		//	else if not _has_left and _has_right {	
		//		return TILE_TL
		//	}
			
		//	// tile right
		//	else if _has_left and not _has_right {
		//		return TILE_TR
		//	}
			
		//	// inside
		//	else if _has_left and _has_right {
		//		return TILE_TM	
		//	}
		//} else if _has_top and _has_bottom {
			
			
		//	// MIDDLE LAYER
		//	// ----------------------------------
			
		//	// Here let's check diagonals as well :)
			
		//	// single tile 
		//	if not _has_left and not _has_right {
		//		return TILE_MM
		//	} 
			
		//	// tile left
		//	else if not _has_left and _has_right {	
		//		return TILE_ML
		//	}
			
		//	// tile right
		//	else if _has_left and not _has_right {
		//		return TILE_MR
		//	}
			
		//	// inside
		//	else if _has_left and _has_right {
				
		//		if not _has_top_left {
					
		//			return TILE_MIDDLE_TL
		//		} else if not _has_top_right {
					
		//			return TILE_MIDDLE_TR
		//		} else if not _has_bottom_left {
					
		//			return TILE_MIDDLE_BL
		//		} else if not _has_bottom_right {
					
		//			return TILE_MIDDLE_BR
		//		} else {
				
		//			return TILE_MM	
		//		}
		//	}	
		//}
}

/**
 * Tiles idx should differ if they are in the center or at the edges...
**/
function editor_adjust_tiles_idx(tile_map, _idx_map){

	for (var _x=0; _x < tilemap_get_width(tile_map); _x++) {
		for (var _y=0; _y < tilemap_get_width(tile_map); _y++) {
			
			if !editor_is_valid_tile(tile_map, _x, _y) {
				continue	
			}
			tilemap_set(tile_map, editor_get_tile_index(_x, _y, tile_map, _idx_map), _x, _y)	
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


