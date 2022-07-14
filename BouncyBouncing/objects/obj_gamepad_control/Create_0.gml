/// @description Insert description here
// You can write your code in this editor
var _maxpads = gamepad_get_device_count();

for (var i = 0; i < _maxpads; i++)
{
    if (gamepad_is_connected(i))
    {
        // do stuff with pad "i"
		log("GAMEPAD " + string(i))
    }
} 