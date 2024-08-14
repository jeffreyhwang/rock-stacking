extends RigidBody3D

const STONE_1 = preload("res://stone_1.glb")

func _ready():
	var stone = STONE_1.instantiate()
	var mesh: MeshInstance3D = stone.get_child(0).duplicate()
	mesh.create_trimesh_collision()
	add_child(mesh)
	print_debug("hi")
