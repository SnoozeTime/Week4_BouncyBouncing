function solid_move(_dx, _dy){
	
	x_remain += _dx
	y_remain += _dy
	
	
	var _move_x = round(x_remain)
	var _move_y = round(y_remain)
	
	
	if _move_x != 0 or _move_y != 0 {
		
		var _player_riding = false
		with obj_player {
			_player_riding = actor_is_riding(other)	
		}
		
		
		if _move_y != 0 {
			y_remain -= _move_y
			y += _move_y
			
			with obj_player {
				
				
				if _move_y < 0 {
				
					if place_meeting(x, y, other) {
						// push top
						character_move_y(other.bbox_top-bbox_bottom, actor_squish)
					} else if _player_riding {
						// carry up
						character_move_y(_move_y)
					}
				} else if _move_y > 0 {
					if place_meeting(x, y, other) {
						// push bottom
						// OVERLAP
						character_move_y(other.bbox_bottom-bbox_top, actor_squish)
					} else if _player_riding {
						// carry up
						character_move_y(_move_y)
					}
					
				}
			}
		}
	}
}