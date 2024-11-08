extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var states = {
	"sleep": $States/Sleep,
	"move": $States/MoveTowardsPlayer,
	"attack": $States/Attack1,
	"wake": $States/Wake,
	"idle": $States/Idle
}
var state: Node

func _ready() -> void:
	change_state("sleep")
	TurnManager.combat_started.connect(on_combat_begin)

func on_combat_begin():
	change_state("wake")

func change_state(new_state: String):
	if state: state.exit(self)
	
	var old_state = state
	state = states[new_state]
	state.enter(self, old_state)


func _physics_process(delta: float) -> void:
	var new_state: String = state.physics_process(self, delta)
	if new_state:
		change_state(new_state)
