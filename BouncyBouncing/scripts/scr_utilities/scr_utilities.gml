
function log(_msg){
	show_debug_message(string(current_time) + ": " + string(_msg))
}

// Interpolate string.
// For example:
// "{} is a {}", ["Benoit", "Dude"] should return "Benoit is a Dude"
function string_interpolate(_format, _args) {
	
	var _res = _format
	for (var _i = 0; _i < array_length(_args); _i++) {
		_res = string_replace(_res, "{}", string(_args[_i]))
	}
	
	return _res
}