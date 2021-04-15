extends CollisionShape
func _ready():
	var p = shape.get_faces()
	print(p[0])
	for i in range(0, len(p)):
		p.set(i, MorphedMesh._morph_point(p[i]))
	print(p[0])
	var s = ConcavePolygonShape.new()
	s.set_faces(p)
	shape = s
