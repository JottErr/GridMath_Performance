#ifndef CURVE_H
#define CURVE_H

class Curve {
private:
	const float slope;
	const float exponent;
	const float x_shift;
	const float y_shift;
public:
	Curve(float slope, float exponent, float x_shift, float y_shift);

	float calculate_value(float x_value) const;
};

#endif // !CURVE_H