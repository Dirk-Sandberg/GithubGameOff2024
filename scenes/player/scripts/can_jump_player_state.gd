extends BasePlayerState
class_name CanMoveState


#Need a CanMove player state for X/Y movement

@export var BASE_SPEED = 60.0

func enter(owner: CharacterBody2D):
	pass

func exit(owner: CharacterBody2D):
	pass

func physics_process(owner: CharacterBody2D, delta: float) -> String:
	#var velocity = owner.velocity

	# Handle jump.
	if Input.is_action_just_pressed("jump") and owner.is_on_floor():
		return "jump"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	var speed = BASE_SPEED
	if direction:
		owner.velocity.x = direction * speed
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, speed)

	owner.move_and_slide()

	# Look left/right
	if owner.velocity.x:
		owner.pivot.scale.x = sign(owner.velocity.x)

	return ""
