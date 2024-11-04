extends CharacterBody2D
@export var action_wheel_scene: PackedScene


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pivot: Node2D = $Pivot



@onready var states = {
	"idle": $States/Idle,
	"run": $States/Run,
	"attack": $States/Attack,
	"jump": $States/Jump,
	"fall": $States/Fall
}
var state: Node
var action_wheel: Node

func _ready() -> void:
	change_state("idle")

func change_state(new_state: String):
	if state: state.exit(self)
	
	state = states[new_state]
	state.enter(self)
	

func _physics_process(delta: float) -> void:
	var new_state: String = state.physics_process(self, delta)
	
	if new_state:
		change_state(new_state)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_wheel"):
		if not action_wheel or action_wheel.visible == false:
			show_action_wheel()
		else:
			hide_action_wheel()

func show_action_wheel():
	if not action_wheel:
		action_wheel = action_wheel_scene.instantiate()
		add_child(action_wheel)
	else:
		action_wheel.display()

func hide_action_wheel():
	action_wheel.go_away()
