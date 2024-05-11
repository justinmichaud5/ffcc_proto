extends CharacterBody3D

@onready var visuals = $Visuals

const SPEED = 10.0
const ACCELERATION = 0.5
const DECCELERATION = 2.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 0.4

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, ACCELERATION)

		var angle = Vector2(-input_dir.x, input_dir.y).angle()
		visuals.rotation.y = lerp_angle(visuals.rotation.y, angle , TURN_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, DECCELERATION)
		velocity.z = move_toward(velocity.z, 0, DECCELERATION)

	move_and_slide()
