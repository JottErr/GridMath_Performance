class_name NestedGridRect
extends RefCounted


## Rectangle that stores position, width and height of the grid in cells as ints
var rect: Rect2i
var grid: Array[Array] ## Nested 2D Array that holds the values for each cell.


func _init(p_width: int, p_height: int, position := Vector2i.ZERO) -> void:
	rect = Rect2i(position.x, position.y, p_width, p_height)
	grid = _create_new_grid()


## Creates a new grid structure of type [code]Array[Array][/code] with size of 
## width. Fills this Array with colums that are of type [code]Array[float][/code]
## with size of height. Columns are initialized with a value of 0.0 at every
## index.
func _create_new_grid() -> Array[Array]:
	var new_grid: Array[Array] = []
	var column: Array[float] = []
	column.resize(rect.size.y)
	for x in range(rect.size.x):
		new_grid.append(column.duplicate())
	return new_grid


## Sets the value of a cell in the grid at the specified position.
func set_cell_value(position: Vector2, value: float) -> void:
	var x: int = position.x
	var y: int = position.y
	if x >= 0 and position.x < rect.size.x and y >= 0 and y < rect.size.y:
		grid[x][y] = value


## Gets the value of a cell in the grid at the specified position.
func get_cell_value(position: Vector2) -> float:
	var x: int = position.x
	var y: int = position.y
	if x >= 0 and position.x < rect.size.x and y >= 0 and y < rect.size.y:
		return grid[x][y]
	return 0.0


## Clears the grid by setting all values in the existing grid to 0.0
func clear_grid() -> void:
	for x in range(rect.size.x):
		for y in range(rect.size.y):
			grid[x][y] = 0.0


## Get width of the grid in cells
func get_width() -> int:
	return rect.size.x


## Get height of the grid in cells
func get_height() -> int:
	return rect.size.y


## Get center cell of the grid in local coordinates
func get_center() -> Vector2i:
	return rect.get_center() - rect.position


## Calculates a value for each cell in the grid that is within a specified 
## radius around a given position. A Curve is used to calculate the fall-off of 
## the values based on the distance of the cell from the position.
func radiate_value_around_position(position: Vector2, radius: float, curve: mCurve, 
		magnitude: float = 1.0) -> void:
	
	var lim_box := Rect2i(position, Vector2i(1, 1)) #create box at position
	lim_box = lim_box.grow(radius) #grow in every direction
	lim_box = rect.intersection(lim_box) #shrink box to respect borders of this grid
	
	for x in range(lim_box.position.x, lim_box.end.x):
		for y in range(lim_box.position.y, lim_box.end.y):
			var distance: float = Vector2(x, y).distance_to(rect.get_center()) #flipped
			distance = min(1.0, distance / radius)
			grid[x][y] = curve.calculate_value(distance) * magnitude


## Adds a another grid to this grid. The specified position describes a cell in 
## this grid. The center of the other grid is located at that position. The 
## other grid is scaled by the magnitude. 
func add_grid_at_pos(other_grid: NestedGridRect, position: Vector2i, magnitude := 1.0) -> void:
	var other_pos := Vector2i(position - other_grid.get_center()) #get top left pos
	var lim_box := Rect2i(other_pos, other_grid.rect.size)
	lim_box = rect.intersection(lim_box)
	#if the other map would hold the position, this could be reduced to 1 line
	#var overlap := rect.intersection(other_grid.rect)
	
	for x in range(lim_box.position.x, lim_box.end.x):
		for y in range(lim_box.position.y, lim_box.end.y):
			var other_x: int = x - other_pos.x
			var other_y: int = y - other_pos.y
			var value: float = other_grid.grid[other_x][other_y]
			grid[x][y] += value * magnitude


func grid_to_string() -> String:
	var result := ""
	for y in range(rect.size.y):
		for x in range(rect.size.x):
			result += str(grid[x][y]).pad_decimals(1) + " "
		result += "\n"
	return result
