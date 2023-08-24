from math import dist

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


class NestedGrid():
	
	def __init__(self, width, height):
		self.width = width
		self.height = height
		self.center = (int(width/2), int(height/2))
		self.grid = [[0.0 for _ in range(self.height)] for _ in range(self.width)]

	def set_cell_value(self, position, value):
		"""
		Sets the value of a cell in the grid at the specified position.
		""" 
		x, y = position
		if x >= 0 and x < self.width and y >= 0 and y < self.height:
			self.grid[x][y] = value

	def get_cell_value(self, position):
		"""
		Gets the value of a cell in the grid at the specified position.
		"""
		x, y = position
		if x >= 0 and x < self.width and y >= 0 and y < self.height:
			return self.grid[x][y]
		return 0.0
	
	def clear_grid(self):
		"""
		Clears the grid by setting all elements to 0.0.
		"""
		self.grid = [[0.0 for _ in range(self.height)] for _ in range(self.width)]

	def radiate_value_around_position(self, position, radius, curve, magnitude=1.0):
		"""
		Calculates a value for each cell in the grid that is within a specified radius around a given position.
		A Curve is used to calculate the fall-off of the values based on the distance of the cell from the position.
		"""
		start_x = position[0] - radius
		start_y = position[1] - radius
		end_x = position[0] + radius + 1
		end_y  = position[1] + radius + 1

		min_x = max(0, start_x)
		min_y = max(0, start_y)
		max_x = min(end_x, self.width)
		max_y = min(end_y, self.height)

		for x in range(int(min_x), int(max_x)):
			for y in range(int(min_y), int(max_y)):
				distance = dist(position, (x, y))
				distance = min(1.0, distance / radius)
				self.grid[x][y] = curve.calculate_value(distance) * magnitude
	
	def __str__(self):
		result = ""
		for y in range(self.height):
			for x in range(self.width):
				result += f"{self.grid[x][y]:.1f} "
			result += "\n"
		return result
