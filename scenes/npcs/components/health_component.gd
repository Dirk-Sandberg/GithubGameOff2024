extends Node2D
class_name HealthComponent

signal died
signal hit

@export var max_hp = 10.0
#@export var animation_player: AnimationPlayer

@onready var hp = max_hp
@export var is_player = false
var damage_label_scene = preload("res://scenes/npcs/components/damage_label/damage_label.tscn")
var dead = false

func _ready():
	if is_player:
		$TextureProgressBar.texture_progress = load("res://assets/ui/blue-hp-texture.png")
	await get_tree().process_frame
	
	update_hp_bar()

func take_damage(damage):
	if dead: return

	var dmg_label = damage_label_scene.instantiate()
	dmg_label.text = str(damage)
	owner.add_child(dmg_label)

	hp -= damage
	if owner.has_node("States/Hurt"):
		owner.change_state("hurt")
	#if animation_player:
		#animation_player.play("hurt")
	if hp <= 0:
		die()
	else:
		hit.emit()
	update_hp_bar()

func update_hp_bar():
	$TextureProgressBar.value = hp / max_hp

func die():
	died.emit()
	dead = true
	if owner.has_node("States/Dead"):
		owner.change_state("dead")
