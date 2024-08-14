extends RigidBody3D

const STONES = preload("res://stones.glb")

func get_rock():
	var stones = STONES.instantiate()
	var node = stones.get_child(randi_range(0, 9))
	return node

func _ready() -> void:
	var mesh: MeshInstance3D = get_rock()
	var cshape: CollisionShape3D = CollisionShape3D.new()
	cshape.shape = mesh.create_trimesh_shape()
	var body: StaticBody3D = StaticBody3D.new()
	body.add_child(cshape)
	mesh.add_child(body)
	mesh.reparent(self)
	position = Vector3(0, 10, 0)
	
	
