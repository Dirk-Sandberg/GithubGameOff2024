extends Area2D

@export var hint_text = ""
@export var interactable_hint_scene: PackedScene
@export var interact_function_owner: Node2D

var hint_scene: RichTextLabel
var interactable = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interactable:
		interact()
 
func interact():
	if interact_function_owner and interact_function_owner.has_method("interact"):
		interact_function_owner.interact()

func _on_body_entered(body: Node2D) -> void:
	if hint_scene: hint_scene.show()
	else:
		hint_scene = interactable_hint_scene.instantiate()
		hint_scene.text += hint_text
		print(hint_text)
		print(hint_scene.text)
		add_child(hint_scene)
	interactable = true


func _on_body_exited(body: Node2D) -> void:
	hint_scene.hide()
	interactable = false
