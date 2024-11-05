extends Node2D

@onready var fires = [$Fire, $Fire2, $Fire3]
@onready var decors = [$Decor, $Decor2, $Decor3, $Decor4]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for fire in fires:
		fire.hide()
	for decor in decors:
		decor.hide()
	fires.pick_random().show()
	decors.pick_random().show()
