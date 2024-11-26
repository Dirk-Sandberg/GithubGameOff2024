extends CharacterBody2D
class_name Player

@onready var action_wheel: VBoxContainer = $ActionWheel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pivot: Node2D = $Pivot
@onready var health_component: HealthComponent = $HUD/HealthComponent
@onready var shockwave: Sprite2D = $Pivot/Shockwave
@onready var dark_shockwave: Sprite2D = $Pivot/DarkShockwave
@onready var explosion_attack_box: AttackHitboxComponent = $Pivot/ExplosionAttackBox

@onready var states = {
	"idle": $States/Idle,
	"run": $States/Run,
	"attack": $States/Attack,
	"jump": $States/Jump,
	"fall": $States/Fall,
	"hurt": $States/Hurt,
	"dead": $States/Dead,
	"charge": $States/Charge,
	"explode": $States/Explode,
}
var state: Node
var state_str: String
var can_move = true
var max_move_time = 2.0
var wants_to_spawn_ghost = false
@onready var current_move_time_left = max_move_time
var last_floor_pos = Vector2.ZERO
var ghost: PlayerGhost


func _ready() -> void:
	get_node("TurnComponent").turn_started.connect(on_turn_started)
	TurnManager.combat_started.connect(on_combat_started)
	TurnManager.combat_ended.connect(on_combat_ended)
	shockwave.hide()
	dark_shockwave.hide()
	change_state("idle")

func on_combat_started():
	can_move = false

func on_combat_ended():
	can_move = true

func on_turn_started():
	# Autocast any pending abilities
	if Abilities.auto_cast_upon_next_turn:
		Abilities.auto_cast_upon_next_turn.cast()
	else:
		# Allow movement if no autocast abilities
		current_move_time_left = max_move_time
		update_movement_bar()
		wants_to_spawn_ghost = true
		can_move = true

func spawn_ghost():
	wants_to_spawn_ghost = false
	var ghost_scene = preload("res://scenes/player/player_ghost.tscn")
	ghost = get_tree().get_first_node_in_group("player_ghost")
	if not ghost:
		ghost = ghost_scene.instantiate()
		add_sibling(ghost)
		ghost.global_position = global_position + Vector2(9, -10)
	ghost.hide()

func change_state(new_state: String):
	if state: state.exit(self)
	
	var old_state = state
	var old_state_str = state_str
	state = states[new_state]
	state_str = new_state
	state.enter(self, old_state, old_state_str)


func _physics_process(delta: float) -> void:

	if wants_to_spawn_ghost and is_on_floor(): 
		spawn_ghost()

	var new_state: String = state.physics_process(self, delta)
	if new_state:
		change_state(new_state)

	if TurnManager.current_combatant == self and velocity:
		current_move_time_left -= delta
		update_movement_bar()
		if ghost and is_instance_valid(ghost): ghost.show()
	
	if is_on_floor():
		last_floor_pos = global_position
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_wheel"):
		if action_wheel.visible == false:
			show_action_wheel()
		else:
			hide_action_wheel()

func show_action_wheel():
	action_wheel.display()

func hide_action_wheel():
	action_wheel.go_away()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	global_position = last_floor_pos

func reset_movement():
	current_move_time_left = max_move_time
	update_movement_bar()

func update_movement_bar():
	can_move = not is_on_floor() or current_move_time_left >= -0.10 # Grace period

	%MovementProgressBar.value = current_move_time_left/max_move_time
	if %MovementProgressBar.value == 1.0:
		%MovementProgressBar.hide()
	else:
		%MovementProgressBar.show()

func explode():
	ScreenShake.shake()
	explosion_attack_box.apply_damage(11)
