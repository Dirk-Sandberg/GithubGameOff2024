extends RigidBody3D

@export var camera_y_offset = 24
var basically_not_rotating_dist = .10
var finished_spinning = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#randomize()
	#rand_from_seed()
	#linear_velocity = Vector3(randi_range(5, 10), randi_range(5, 10), randi_range(5, 10))
	var max_angle = 10
	angular_velocity = Vector3(randi_range(0, max_angle), randi_range(0, max_angle), randi_range(0, max_angle))
	linear_velocity = Vector3(0, 10, 0)
	position.x = randi_range(0, 10000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if finished_spinning: return

	$Camera3D.position = Vector3(position.x, camera_y_offset, position.z)
	#$Camera3D.position = Vector3(position.x, 15 + position.y, position.z)
	$DirectionalLight3D.position = Vector3(position.x, 1000 + position.y, position.z)
	if angular_velocity.distance_squared_to(Vector3.ZERO) < basically_not_rotating_dist:
		finish_spinning()

func finish_spinning():
	finished_spinning = true
	var planes = [$Sketchfab_model/Area3D, $Sketchfab_model/Area20, $Sketchfab_model/Area8]
	#for plane: Area3D in planes:
		#print(plane.angl)
	#print(rotation_degrees)
	#rotate_y(-rotation.y)
	# Add a ray to every face pointing normal to surface
	# Also add a ray pointing "up" on every face?
	# For ray in rays:
	# Find most vertical ray
