extends Label

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", position + Vector2.UP*10, 0.50)
