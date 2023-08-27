from FlatGrid import FlatGrid
from NestedGrid import NestedGrid
from DictGrid import DictGrid
from NestedNumpyGrid import NestedNumpyGrid as npNestedGrid
from Curve import Curve
from time import process_time

def test_performance(template, grid, curve):
	template.radiate_value_around_position(template.center, template.center[0], curve)
	start = process_time()
	for i in range(grid.width):
		for j in range(grid.height):
			grid.add_grid_at_pos(template, (i, j))
	duration = process_time() - start
	print(duration)

curve = Curve(-1.0, 1.0, 0.0, 1.0)

test_performance(NestedGrid(9, 9), NestedGrid(600, 600), curve)
test_performance(FlatGrid(9, 9), FlatGrid(600, 600), curve)
test_performance(DictGrid(9, 9), DictGrid(600, 600), curve)
test_performance(npNestedGrid(9, 9), npNestedGrid(600, 600), curve)

test_performance(NestedGrid(75, 75), NestedGrid(75, 75), curve)
test_performance(FlatGrid(75, 75), FlatGrid(75, 75), curve)
test_performance(DictGrid(75, 75), DictGrid(75, 75), curve)
test_performance(npNestedGrid(75, 75), npNestedGrid(75, 75), curve)