extends CanvasLayer

var shake_str_multiplier = 1.0
#var strength = 0.0

var curStrength = 0;

func shake(str = 0.75):
	curStrength = str

func _process(delta):
	curStrength = max(curStrength - delta, 0);
	#if (Input.is_action_just_pressed("action_wheel")):
		#curStrength = strength * shake_str_multiplier;

	$ColorRect.material.set_shader_parameter("ShakeStrength", max(curStrength,0))
