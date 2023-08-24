class Curve():

	def __init__(self, slope, exponent, x_shift, y_shift):
		self.slope = slope
		self.exponent = exponent
		self.x_shift = x_shift
		self.y_shift = y_shift

	def calculate_value(self, x_value):
		"""
		Calculates the value of the function for a given x value.
		"""
		return self.slope * pow((x_value + self.x_shift), self.exponent) + self.y_shift