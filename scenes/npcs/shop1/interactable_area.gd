extends Area2D

@export var hint_text = ""
@export var interactable_hint_scene: PackedScene
var hint_scene: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if hint_scene: hint_scene.show()
	else:
		hint_scene = interactable_hint_scene.instantiate()
		hint_scene.text += hint_text
		print(hint_text)
		print(hint_scene.text)
		add_child(hint_scene)


func _on_body_exited(body: Node2D) -> void:
	hint_scene.hide()
