/*
	Save the current level to a file (buffer?)
*/ 
function editor_save(){

	with obj_editor_control {
		var _buf = buffer_create(4096, buffer_fixed, 1)
		var _b_written = 0
		// map width and height. OK u8
		var w = tilemap_get_width(tile_map) 
		var h = tilemap_get_height(tile_map) 
	
		buffer_write(_buf, buffer_u8, w)
		log("Write w " + string(w))
		buffer_write(_buf, buffer_u8, h)
		log("Write h " + string(h))
		_b_written += 2
	
		// write to intermediary buffer.
		var _buf_length = w * h
		var _tm_buf = buffer_create(_buf_length, buffer_fixed, 1)
		// Index of tilemap.
		for (var _x=0; _x < w; _x++) {
			for (var _y=0; _y < h; _y++) {
				// Do no write -1 or 0
				if editor_is_valid_tile(tile_map, _x, _y) {
					buffer_write(_tm_buf, buffer_u8, _x)
					buffer_write(_tm_buf, buffer_u8, _y)
					buffer_write(_tm_buf, buffer_u8, tilemap_get(tile_map, _x, _y))
					log(string_interpolate("Write {} at {},{}", [ tilemap_get(tile_map, _x, _y), _x, _y]))
					_b_written += 3
				}
			}
		}
		
		// Write length first
		var _data_len = buffer_tell(_tm_buf)
		buffer_write(_buf, buffer_u16, _data_len)
		_b_written += 2
		log("Write datalen=" + string(_data_len))
		// Copy tilemap data
		buffer_copy(_tm_buf, 0, _data_len, _buf, buffer_tell(_buf))
		buffer_seek(_buf, buffer_seek_relative, _data_len)
		
		// Object spawn
		// if set, next is 1, else 0
		if current_player_start != noone {
			buffer_write(_buf, buffer_bool, true)
			buffer_write(_buf, buffer_u16, current_player_start.x)
			buffer_write(_buf, buffer_u16, current_player_start.y)
			_b_written += 5
		} else {
			buffer_write(_buf, buffer_bool, false)
			_b_written += 1
		}
		
		// Now save to file.
		
		log("BUFFER LENGTH = " + string(buffer_tell(_buf)))
		log("Wrote " + string(_b_written) + " bytes")
		buffer_save(_buf, included_file_path+"Level1.level");
		buffer_delete(_buf)
	}
}

function editor_load() {
	with obj_game {
		reset_level()
		
		
		var _buf = buffer_load("Level1.level")
		
		log("BUFFER LENGTH = " + string(buffer_tell(_buf)))
		// Tilemap
		// ------------------------------------
		var w = buffer_read(_buf, buffer_u8)
		
		log("Read w=" + string(w))
		var h = buffer_read(_buf, buffer_u8)
		log("Read h=" + string(h))
		tilemap_set_width(tile_map, w)
		tilemap_set_height(tile_map, h)
		// fill with 0
		editor_reset_tilemap(tile_map)
		
		var _tm_bytes = buffer_read(_buf, buffer_u16)
		
		log("Read datalen=" + string(_tm_bytes))
		
		while _tm_bytes > 0 {
			var _x  = buffer_read(_buf, buffer_u8)
			var _y  = buffer_read(_buf, buffer_u8)
			var _idx  = buffer_read(_buf, buffer_u8)
			tilemap_set(tile_map, _idx, _x, _y)
			
			log(string_interpolate("Read {} at {},{}", [ _idx, _x, _y]))
			_tm_bytes -= 3	
		}
		
		// Objects
		// -----------------------
		log(buffer_tell(_buf))
		var _has_spawn = buffer_read(_buf, buffer_bool)
		log(_has_spawn)
		if _has_spawn {
			var _spawn_x = buffer_read(_buf, buffer_u16)
			var _spawn_y= buffer_read(_buf, buffer_u16)
			current_player_start = instance_create_layer(_spawn_x, _spawn_y, layer, obj_spawn)
		}
		
		buffer_delete(_buf)
	}
	
}
