extends MeshInstance
class_name MorphedMesh
export var mat: ShaderMaterial
static func _morph_point(pos):
	var x = pos.x
	var y = pos.y
	var z = pos.z
	x += ShapeOptions.X_X*pos.x
	x += ShapeOptions.X_Y*pos.y
	x += ShapeOptions.X_Z*pos.z
	y += ShapeOptions.Y_X*pos.x
	y += ShapeOptions.Y_Y*pos.y
	y += ShapeOptions.Y_Z*pos.z
	z += ShapeOptions.Z_X*pos.x
	z += ShapeOptions.Z_Y*pos.y
	z += ShapeOptions.Z_Z*pos.z
	x += ShapeOptions.X_XX*pos.x*pos.x
	x += ShapeOptions.X_XY*pos.x*pos.y
	x += ShapeOptions.X_XZ*pos.x*pos.z
	x += ShapeOptions.X_YY*pos.y*pos.y
	x += ShapeOptions.X_YZ*pos.y*pos.z
	x += ShapeOptions.X_ZZ*pos.z*pos.z
	y += ShapeOptions.Y_XX*pos.x*pos.x
	y += ShapeOptions.Y_XY*pos.x*pos.y
	y += ShapeOptions.Y_XZ*pos.x*pos.z
	y += ShapeOptions.Y_YY*pos.y*pos.y
	y += ShapeOptions.Y_YZ*pos.y*pos.z
	y += ShapeOptions.Y_ZZ*pos.z*pos.z
	z += ShapeOptions.Z_XX*pos.x*pos.x
	z += ShapeOptions.Z_XY*pos.x*pos.y
	z += ShapeOptions.Z_XZ*pos.x*pos.z
	z += ShapeOptions.Z_YY*pos.y*pos.y
	z += ShapeOptions.Z_YZ*pos.y*pos.z
	z += ShapeOptions.Z_ZZ*pos.z*pos.x
	return Vector3(x, y, z)
func _ready():
	var m: PrimitiveMesh = mesh
	var a = m.get_mesh_arrays()
	print(a[0][0])
	for i in [0,1]:
		if i == null:
			continue
		for j in range(len(a[i])):
			a[i][j] = _morph_point(a[i][j])
	var am = ArrayMesh.new()
	am.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, a)
	mesh = am
	material_override = mat
	
	
	
