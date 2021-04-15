extends KinematicBody
var sensitivity = -0.001
export var speed = 1.0
export var gravity = 0.1
export var jump_speed = 1
const ARROW_CAMERA_REACTIVITY = 0.025
var last_mouse_pos: Vector2
var velocity = Vector3.ZERO
var cm = true
var cl = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if !OS.has_feature("no_mouse"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	last_mouse_pos = get_viewport().get_mouse_position()
	translation = MorphedMesh._morph_point(translation)+Vector3(0,5,0)

func _unhandled_input(event):
	if OS.has_feature("no_mouse"):
		return
	if event is InputEventMouseMotion:
		var diff = event.relative * sensitivity
		$Camera.rotation.y += diff.x
		$Camera.rotation.x += diff.y
	if event.is_action_pressed("shape_mouse"):
		cm = !cm
		if !cm:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _move_mouse():
	$Camera.rotation.y -= Input.get_action_strength("cam_right") * ARROW_CAMERA_REACTIVITY
	$Camera.rotation.y += Input.get_action_strength("cam_left") * ARROW_CAMERA_REACTIVITY
	$Camera.rotation.x += Input.get_action_strength("cam_up") * ARROW_CAMERA_REACTIVITY
	$Camera.rotation.x -= Input.get_action_strength("cam_down") * ARROW_CAMERA_REACTIVITY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if OS.has_feature("no_mouse"):
		_move_mouse()
	$Camera.rotation.x = clamp($Camera.rotation.x, -PI/2, PI/2)
	if Input.is_action_just_pressed("shape_reset"):
		translation = MorphedMesh._morph_point(translation)+Vector3(0,5,0)
		velocity = Vector3.ZERO
	var move_vector = Vector3.ZERO
	move_vector += Vector3.FORWARD * Input.get_action_strength("shape_forwards")
	move_vector += Vector3.LEFT * Input.get_action_strength("shape_left")
	move_vector += Vector3.RIGHT * Input.get_action_strength("shape_right")
	move_vector += Vector3.BACK * Input.get_action_strength("shape_back")
	if Input.is_action_just_pressed("shape_jump") and is_on_floor():
		velocity.y = jump_speed
	if Input.is_action_just_pressed("shape_noclip"):
		cl = !cl
		$CollisionShape.set_deferred("disabled", cl)
	var horiz_speed = move_vector.normalized().rotated(Vector3.UP, $Camera.rotation.y)*speed
	velocity.x = horiz_speed.x
	velocity.z = horiz_speed.z
	velocity.y -= gravity
# warning-ignore:return_value_discarded
	velocity = move_and_slide(
		velocity, # linear_velocity
		Vector3.UP, # up_direction
		true, # stop_on_slope
		1, # max_slides
		PI/2, # floor_max_angle
		true # infinite_inertia
		)
	if translation.y > 100.0:
		translation.y -= 200.0
	if translation.y < -100.0:
		translation.y += 200.0
