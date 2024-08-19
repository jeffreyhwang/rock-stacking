extends RigidBody3D
const BOINK = preload("res://boink.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	if (state.get_contact_count() >= 1):  #this check is needed or it will throw errors 
		var local_collision_pos = state.get_contact_local_position(0)
		var boink = BOINK.instantiate()
		boink.position = local_collision_pos
		boink.one_shot = true
		add_child(boink)
		boink.emitting = true
		
