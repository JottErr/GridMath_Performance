#include "Curve.h"
#include <cmath>

Curve::Curve(float slope, float exponent, float x_shift, float y_shift)
	: slope(slope), exponent(exponent), x_shift(x_shift), y_shift(y_shift) {
}

float Curve::calculate_value(float x_value) const {
	return slope * std::pow((x_value + x_shift), exponent) + y_shift;
}
