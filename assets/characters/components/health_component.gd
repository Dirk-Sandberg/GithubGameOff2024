extends Node2D
class_name HealthComponent

signal died
signal hit

@export var max_hp = 10.0
#@export var animation_player: AnimationPlayer

@onready var hp = max_hp
@export var is_player = false

var dead = false

func _ready():
	if is_player:
		$TextureProgressBar.texture_progress = load("res://assets/ui/blue-hp-texture.png")
	await get_tree().process_frame
	
	update_hp_bar()

func take_damage(damage):
	if dead: return

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
