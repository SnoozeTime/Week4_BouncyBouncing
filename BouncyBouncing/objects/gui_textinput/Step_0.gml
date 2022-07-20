/// @description

event_inherited()

if has_focus {
	if string_width(keyboard_string) < box_width {
		if is_number {
			text = string_digits(keyboard_string)
		} else {
			text = keyboard_string
		}
	} else {
		keyboard_string = text
	}
}

