class_name NestedGrid
extends RefCounted

var width: int ## Width of the grid in cells
var height: int ## Height of the grid in cells
var center: Vector2 ## Center cell of the grid
var grid: Array[Array] ## Nested 2D Array that holds the values for each cell.


func _init(p_width: int, p_height: int) -> void:
	width = p_width 
	height = p_height 
	center = Vector2(width / 2, height / 2) 
	grid = _create_new_grid()


## Creates a new grid structure of type [code]Array[Array][/code] with size of 
## width. Fills this Array with colums that are of type [code]Array[float][/code]
## with size of height. Columns are initialized with a value of 0.0 at every
## index.
func _create_new_grid() -> Array[Array]:
	var new_grid: Array[Array] = []
	var column: Array[float] = []
	column.resize(height)
	for x in range(width):
		new_grid.append(column.duplicate())
	return new_grid


## Sets the value of a cell in the grid at the specified position.
func set_cell_value(position: Vector2, value: float) -> void:
	var x: int = position.x
	var y: int = position.y
	if x >= 0 and position.x < width and y >= 0 and y < height:
		grid[x][y] = value


## Gets the value of a cell in the grid at the specified position.
func get_cell_value(position: Vector2) -> float:
	var x: int = position.x
	var y: int = position.y
	if x >= 0 and position.x < width and y >= 0 and y < height:
		return grid[x][y]
	return 0.0


## Clears the grid by setting all values in the existing grid to 0.0
func clear_grid() -> void:
	for x in range(width):
		for y in range(height):
			grid[x][y] = 0.0


## Calculates a value for each cell in the grid that is within a specified 
## radius around a given position. A Curve is used to calculate the fall-off of 
## the values based on the distance of the cell from the position.
func radiate_value_around_position(position: Vector2, radius: float, curve: mCurve, 
		magnitude: float = 1.0) -> void:
	#get square bounding box for circle with given radius
	var start_x: float = position.x - radius
	var start_y: float = position.y - radius
	var end_x: float = position.x + radius + 1
	var end_y: float  = position.y + radius + 1
	#limit bounding box to respect borders of this grid
	#this allows to skip validating coords for every single cell 
	var min_x: int = max(0, start_x)
	var min_y: int = max(0, start_y)
	var max_x: int = min(end_x, width)
	var max_y: int = min(end_y, height)
	
	#set values of all cells in limited bounding box
	for x in range(min_x, max_x):
		for y in range(min_y, max_y):
			var distance: float = center.distance_to(Vector2(x, y))
			distance = min(1.0, distance / radius)
			grid[x][y] = curve.calculate_value(distance) * magnitude


## Adds a another grid to this grid. The specified position describes a cell in 
## this grid. The center of the other grid is located at that position. The 
## other grid is scaled by the magnitude. 
func add_grid_at_pos(other_grid: NestedGrid, position: Vector2, magnitude := 1.0) -> void:
	#get local coords of topleft/botright cell of the source_map
	var start_x: float = position.x - other_grid.center.x
	var start_y: float = position.y - other_grid.center.y
	var end_x: float = position.x + other_grid.center.x + 1
	var end_y: float  = position.y + other_grid.center.y + 1
	#clamp start/end coords to the size of this map to only loop over existing cells
	var min_x: int = max(0, start_x)
	var min_y: int = max(0, start_y)
	var max_x: int = min(end_x, width)
	var max_y: int = min(end_y, height)
	
	for x in range(min_x, max_x):
		for y in range(min_y, max_y):
			var other_x: int = x - start_x
			var other_y: int = y - start_y
			var value: float = other_grid.grid[other_x][other_y]
			grid[x][y] += value * magnitude


func grid_to_string() -> String:
	var result := ""
	for y in range(height):
		for x in range(width):
			result += str(grid[x][y]).pad_decimals(1) + " "
		result += "\n"
	return result
