extends Node

signal new_combatant(node: Node2D)

var npcs_in_combat = []
var current_combatant: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Label.hide()
	%Decor.hide()


func begin_combat(enemies):
	show_text("Begin Combat")
	do_combat(enemies)

func do_combat(enemies):
	var player = get_tree().get_first_node_in_group("player")
	var combatants = [player] + enemies
	var combatants_to_remove = []
	for combatant in combatants:
		if combatant.health_component.dead:
			combatants_to_remove.append(combatant)
			continue
		if combatant == player:
			show_text("Player Turn")
		current_combatant = combatant
		combatant.get_node("TurnComponent").take_turn()
		new_combatant.emit(combatant)
		await combatant.get_node("TurnComponent").turn_finished
	current_combatant = null

	# Remove dead enemies
	for combatant in combatants_to_remove:
		enemies.erase(combatant)

	if player not in combatants:
		end_combat()
	elif combatants == [player]:
		end_combat()
	else: do_combat(enemies)

func end_combat():
	show_text("combat over")

func show_text(t):
	%Label.show()
	%Decor.show()
	%Label.text = t
	await get_tree().create_timer(2.0).timeout
	%Label.hide()
	%Decor.hide()