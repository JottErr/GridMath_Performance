from FlatGrid import FlatGrid
from NestedGrid import NestedGrid
from DictGrid import DictGrid
from NestedNumpyGrid import NestedNumpyGrid as npNestedGrid
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

test_performance(NestedGrid, 9, 9, NestedGrid, 600, 600)
test_performance(FlatGrid, 9, 9, FlatGrid, 600, 600)
test_performance(DictGrid, 9, 9, DictGrid, 600, 600)
test_performance(npNestedGrid, 9, 9, npNestedGrid, 600, 600)

test_performance(NestedGrid, 75, 75, NestedGrid, 75, 75)
test_performance(FlatGrid, 75, 75, FlatGrid, 75, 75)
test_performance(DictGrid, 75, 75, DictGrid, 75, 75)
test_performance(npNestedGrid, 75, 75, npNestedGrid, 75, 75)