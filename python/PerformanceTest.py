from FlatGrid import FlatGrid
from NestedGrid import NestedGrid
from Curve import Curve
from time import process_time

def test_performance(template_class, t_width, t_height, grid_class, g_width, g_height):
	template = template_class(t_width, t_height)
	curve = Curve(-1.0, 1.0, 0.0, 1.0)
	template.radiate_value_around_position(template.center, template.center[0], curve)
	grid = grid_class(g_width, g_height)
	start = process_time()
	for i in range(grid.width):
		for j in range(grid.height):
			grid.add_grid_at_pos(template, (i, j))
	duration = process_time() - start
	print(duration)

test_performance(NestedGrid, 9, 9, NestedGrid, 350, 350)
test_performance(FlatGrid, 9, 9, FlatGrid, 350, 350)

test_performance(NestedGrid, 57, 57, NestedGrid, 57, 57)
test_performance(FlatGrid, 57, 57, FlatGrid, 57, 57)