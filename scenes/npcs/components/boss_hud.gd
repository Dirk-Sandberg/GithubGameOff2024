extends CanvasLayer

@onready var health_component: HealthComponent = $HealthComponent
@onready var decal: Sprite2D = $Decal
@onready var boss_title: Label = $BossTitle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.died.connect(on_died)
	pass # Replace with function body.

func on_died():
	hide()
