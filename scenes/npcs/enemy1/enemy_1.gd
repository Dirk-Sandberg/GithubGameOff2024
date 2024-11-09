extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: HealthComponent = $BossHUD/HealthComponent
@onready var sprite_2d: Sprite2D = $Pivot/Sprite2D
@onready var pivot: Node2D = $Pivot

@onready var states = {
	"sleep": $States/Sleep,
	"move": $States/MoveTowardsPlayer,
	"attack": $States/Attack1,
	"wake": $States/Wake,
	"idle": $States/Idle,
	"dead": $States/Dead
}
var state: Node
var aggroed = false

func _ready() -> void:
	change_state("sleep")
	TurnManager.combat_started.connect(on_combat_begin)
	$BossHUD.hide()

func on_combat_begin():
	$BossHUD.show()

func change_state(new_state: String):
	if state: state.exit(self)
	
	var old_state = state
	state = states[new_state]
	state.enter(self, old_state)


func _physics_process(delta: float) -> void:
	var new_state: String = state.physics_process(self, delta)
	if new_state:
		change_state(new_state)

func shake():
	apply_damage()
	ScreenShake.shake()

func aggro():
	if aggroed: return
	aggroed = true
	change_state("wake")
	

func _on_aggro_area_body_entered(body: Node2D) -> void:
	aggro()

func apply_damage():
	$Pivot/AttackBoxComponent.apply_damage(1)
