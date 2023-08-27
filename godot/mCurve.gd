class_name mCurve
extends RefCounted


var slope: float ## Slope of the curve
var exponent: float ## Exponent of the curve
var x_shift: float ## Shift on the x-Axis of the curve
var y_shift: float ## Shift on the y-Axis of the curve


func _init(p_slope: float, p_exponent: float, p_x_shift: float, p_y_shift: float) -> void:
	slope = p_slope
	exponent = p_exponent
	x_shift = p_x_shift
	y_shift = p_y_shift

## Calculates the value of the function for a given x value.
func calculate_value(x_value: float) -> float:
	return slope * pow((x_value + x_shift), exponent) + y_shift

