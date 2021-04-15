extends Node
var X_X = 1.0
var X_Y = 2.0
var X_Z = 0.0
var Y_X = -2.0
var Y_Y = -1.0
var Y_Z = 1.0
var Z_X = 1.0
var Z_Y = -1.0
var Z_Z = 2.0
var X_XX = -2.0
var X_XY = -1.0
var X_XZ = -2.0
var X_YY = -1.0
var X_YZ = -2.0
var X_ZZ = 1.0
var Y_XX = -2.0
var Y_XY = -1.0
var Y_XZ = 1.0
var Y_YY = 0.0
var Y_YZ = -1.0
var Y_ZZ = -1.0
var Z_XX = 1.0
var Z_XY = -1.0
var Z_XZ = -2.0
var Z_YY = -1.0
var Z_YZ = -1.0
var Z_ZZ = -2.0

var X_XYZ = 0.0
var Y_XYZ = 0.0
var Z_XYZ = 0.0
var shape_seed=201
const min_coefficient = -5.0
const max_coefficient = 5.0
const repetition = [["Y","X"],["Z","X"],["Z","Y"]]
func _ready():
	generate_coefficients()
func generate_coefficients():
	seed(shape_seed)
	for i in ["X","Y","Z"]:
		for j in ["X","Y","Z"]:
			set("%s_%s" % [i,j], rand_range(min_coefficient, max_coefficient))
			for k in ["X","Y","Z"]:
				if [j,k] in repetition:
					if [j,k] == ["Y","X"]:
						set("%s_XYZ" % i, rand_range(min_coefficient, max_coefficient))
					continue
				set("%s_%s%s" % [i,j,k], rand_range(min_coefficient, max_coefficient))
