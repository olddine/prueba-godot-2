extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# MOVIMIENTO DE CAMARA 

const CAM_ROT_SPEED = 0.001
const CAM_X_ROT_MIN = -90.0
const CAM_X_ROT_MAX = 90.0
 
var cam_x_rot = 0.0
var cam_y_rot = 0.0

var rot_speed = 5.0
var mouse_sensitivity = 0.05

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		print("hola")
		rotate_y(deg_to_rad(-event.relative.x*mouse_sensitivity))
		$Collision/camnode.rotate_y(deg_to_rad(-event.relative.x * CAM_ROT_SPEED))
		$Collision/camnode.orthonormalized()
		
		cam_x_rot = clamp(cam_x_rot - event.relative.y * CAM_ROT_SPEED, deg_to_rad(CAM_X_ROT_MIN), deg_to_rad(CAM_X_ROT_MAX))
		cam_y_rot = clamp(cam_y_rot - event.relative.x * CAM_ROT_SPEED, deg_to_rad(CAM_X_ROT_MIN), deg_to_rad(CAM_X_ROT_MAX))
		
		$Collision/camnode/arm.rotation.x = cam_x_rot
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		pass
	
	
func _physics_process(delta):
	# Ad the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		$body.rotation.y = lerp_angle($body.rotation.y,atan2(-direction.x, -direction.z) - rotation.y, delta * rot_speed)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
