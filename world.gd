extends Node3D
const ROCK = preload("res://rock.tscn")
@onready var world: Node3D = $"."
var control_rock
var rocks = []
const GENERATED_ROCK = preload("res://generated_rock.tscn")
const ROCK_2 = preload("res://rock_2.tscn")
const RIGID_BODY_3D = preload("res://rigid_body_3d.tscn")
const RIGID_BODY_3D_2 = preload("res://rigid_body_3d2.tscn")
@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_pivot: Node3D = $CameraPivot

func drop_all_rocks():
	for rock in rocks:
		rock.gravity_scale = 1
		rock.linear_damp = 0
		rock.set_angular_damp(0.0)
	return
	
func _input(event: InputEvent) -> void:
	return

func _process(delta: float) -> void:
	if (Input.is_action_pressed("camera_down")):
		camera_pivot.position.y = lerp(camera_pivot.position.y, camera_pivot.position.y - .2, delta)
	if (Input.is_action_pressed("camera_up")):
		camera_pivot.position.y = lerp(camera_pivot.position.y, camera_pivot.position.y + .2, delta)
	if (Input.is_action_pressed("camera_left")):
		camera_pivot.position.x = lerp(camera_pivot.position.x, camera_pivot.position.x - .2, delta)
	if (Input.is_action_pressed("camera_right")):
		camera_pivot.position.x = lerp(camera_pivot.position.x, camera_pivot.position.x + .2, delta)
	if (Input.is_action_pressed("rotate_camera_left")):
		camera_pivot.rotation.y = lerp_angle(camera_pivot.rotation.y, camera_pivot.rotation.y - deg_to_rad(30), delta)
	if (Input.is_action_pressed("rotate_camera_right")):
		camera_pivot.rotation.y = lerp_angle(camera_pivot.rotation.y, camera_pivot.rotation.y - deg_to_rad(-30), delta)
	if (Input.is_action_just_pressed("spawn_rock")):
		control_rock = RIGID_BODY_3D_2.instantiate()
		control_rock.global_position = Vector3(camera_pivot.global_position.x, camera_pivot.global_position.y + 2, camera_pivot.global_position.z)
		control_rock.gravity_scale = 0
		control_rock.set_angular_damp(100.0)
		world.add_child(control_rock)
		rocks.append(control_rock)
		print("added")

	if (Input.is_action_just_pressed("drop_rock") && control_rock != null):
		drop_all_rocks()
		control_rock.gravity_scale = 1
		control_rock.linear_damp = 0
		control_rock.set_angular_damp(0.0)
		control_rock = null  # Release control of the rock

	if control_rock == null: return
	control_rock.linear_damp = 4
	# Apply a small continuous force for movement, allowing interaction with other rocks
	var movement = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("move_forward"):
		movement.z -= 1
	if Input.is_action_pressed("move_backward"):
		movement.z += 1
	if Input.is_action_pressed("move_higher"):
		movement.y += 1
	if Input.is_action_pressed("move_lower"):
		movement.y -= 1

	control_rock.apply_impulse(movement * .1)
