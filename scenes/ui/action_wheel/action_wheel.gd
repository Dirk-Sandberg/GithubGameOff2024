extends Control

var tween: Tween

func display():
	show()

func go_away():
	unhighlight_all()
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("one"):
		highlight_skill(%Number1)
	if event.is_action_pressed("two"):
		highlight_skill(%Number2)
	if event.is_action_pressed("three"):
		highlight_skill(%Number3)
	if event.is_action_pressed("four"):
		highlight_skill(%Number4)
	
func highlight_skill(number_node):
	var icons = [%Icon1, %Icon2, %Icon3, %Icon4]
	var numbers = [%Number1, %Number2, %Number3, %Number4]
	numbers.erase(number_node)
	
	for number in numbers:
		number.modulate = Color.DIM_GRAY

	if tween:
		tween.stop()
		tween = null
	tween = create_tween().set_loops()
	tween.tween_property(number_node, "modulate", Color("7ebfc6"), .5)
	tween.tween_property(number_node, "modulate", Color.WHITE, .5)

func unhighlight_all():
	var numbers = [%Number1, %Number2, %Number3, %Number4]
	for number in numbers:
		number.modulate = Color.WHITE

	if tween:
		tween.stop()
		tween = null
	
	
