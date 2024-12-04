extends Node

signal player_turn_ended
signal new_combatant(node: Node2D)
signal combat_started
signal combat_ended

var npcs_in_combat = []
var current_combatant: Node2D
var in_combat = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Label.hide()
	%LabelDecor.hide()

func is_player_turn():
	var player = get_tree().get_first_node_in_group("player")
	return current_combatant == player

func begin_combat(enemies):
	show_text("Begin Combat")
	in_combat = true
	combat_started.emit()
	await do_combat(enemies)

func do_combat(enemies):
	var player = get_tree().get_first_node_in_group("player")
	var camera = get_tree().get_first_node_in_group("camera")
	var combatants = [player] + enemies
	var combatants_to_remove = []
	print("Combatants this round: ", combatants)

	for combatant in combatants:
		if combatant.health_component.dead:
			combatants_to_remove.append(combatant)
			continue


		new_combatant.emit(combatant)
		await camera.finished_lerping


		if combatant == player:
			show_text("Player Turn")
			# This should only run if there are more combatants
			
		current_combatant = combatant
		combatant.get_node("TurnComponent").take_turn()
		await combatant.get_node("TurnComponent").turn_finished
	current_combatant = null

	# Remove dead enemies
	for _combatant in combatants_to_remove:
		if _combatant in enemies:
			enemies.erase(_combatant)
	if enemies == []:
		end_combat()
		return

	#for combatant in combatants_to_remove:
		#if combatant in enemies:
			#enemies.erase(combatant)

	if enemies == []:
		end_combat()
	else: do_combat(enemies)

func end_combat():
	show_text("combat over")
	combat_ended.emit()
	current_combatant = null
	npcs_in_combat = []
	in_combat = false


func show_text(t):
	%Label.show()
	%LabelDecor.show()
	%Label.text = t
	await get_tree().create_timer(2.0).timeout
	%Label.hide()
	%LabelDecor.hide()
