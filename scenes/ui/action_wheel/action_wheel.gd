extends Control

var tween: Tween
var highlighted_idx = -1
var descriptions = [
	"Melee attack. Press 1 to confirm.",
	"Melee attack. Press 2 to confirm.",
	"Melee attack. Press 3 to confirm.",
	"Melee attack. Press 4 to confirm.",
	"End turn. Press 5 to confirm."
]
@onready var player = get_tree().get_first_node_in_group("player")
func _ready() -> void:
	hide()

func display():
	highlighted_idx = -1
	if TurnManager.is_player_turn():
		%EndTurnContainer.show()
	else:
		%EndTurnContainer.hide()

	if GV.awaiting_tutorial_ability1:
		%Icon2.hide()
		%Icon3.hide()
		%Icon4.hide()
	elif GV.awaiting_tutorial_ability2:
		%Icon2.show()
		%Icon3.hide()
		%Icon4.hide()
	else:
		%Icon1.show()
		%Icon2.show()
		%Icon3.show()
		%Icon4.show()
		
	show()

func go_away():
	unhighlight_all()
	hide()
	highlighted_idx = -1

func update_label(idx):
	%Label.text = Abilities.abilities[idx].description
	#%Label.text = descriptions[idx]
	
func _unhandled_input(event: InputEvent) -> void:
	if not visible: return

	if event.is_action_pressed("one"):
		highlight_skill(0)
	if event.is_action_pressed("two"):
		highlight_skill(1)
	if event.is_action_pressed("three"):
		highlight_skill(2)
	if event.is_action_pressed("four"):
		highlight_skill(3)
	if event.is_action_pressed("five") and TurnManager.is_player_turn():
		highlight_skill(4)

func confirm_choice(idx):
	if idx == 4:
		go_away()
		end_turn()
	else:
		var ability = Abilities.abilities[idx]
		ability.cast()
		#owner.change_state(ability["player_animation_name"])
		#owner.change_state("attack")
		
		go_away()

func highlight_skill(idx):
	if highlighted_idx == idx:
		confirm_choice(idx)
		return
	highlighted_idx = idx

	update_label(idx)
	#var icons = [%Icon1, %Icon2, %Icon3, %Icon4]
	var numbers = [%Number1, %Number2, %Number3, %Number4, %Number5]
	var number_node = numbers[idx]
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
	var numbers = [%Number1, %Number2, %Number3, %Number4, %Number5]
	for number in numbers:
		number.modulate = Color.WHITE

	if tween:
		tween.stop()
		tween = null
	
func end_turn():
	TurnManager.player_turn_ended.emit()
	#turn_ended.emit()
