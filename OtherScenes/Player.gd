extends KinematicBody
var sensitivity = -0.001
export var speed = 1.0
export var gravity = 0.1
export var jump_speed = 1
var last_mouse_pos: Vector2
var velocity = Vector3.ZERO
var cm = true
var cl = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	last_mouse_pos = get_viewport().get_mouse_position()
	translation = MorphedMesh._morph_point(translation)+Vector3(0,5,0)

func _unhandled_input(event):
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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if Input.is_action_just_pressed("shape_reset"):
		translation = MorphedMesh._morph_point(translation)+Vector3(0,5,0)
		velocity = Vector3.ZERO
	var move_vector = Vector3.ZERO
	if Input.is_action_pressed("shape_forwards"):
		move_vector += Vector3.FORWARD
	if Input.is_action_pressed("shape_left"):
		move_vector += Vector3.LEFT
	if Input.is_action_pressed("shape_right"):
		move_vector += Vector3.RIGHT
	if Input.is_action_pressed("shape_back"):
		move_vector += Vector3.BACK
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
