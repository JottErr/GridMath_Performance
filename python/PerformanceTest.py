from FlatGrid import FlatGrid
from NestedGrid import NestedGrid
from DictGrid import DictGrid
from FlatDictGrid import FlatDictGrid
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
print("NestedGrid")
for i in range(30):
	test_performance(NestedGrid(9, 9), NestedGrid(600, 600), curve)
print("FlatGrid")
for i in range(30):
	test_performance(FlatGrid(9, 9), FlatGrid(600, 600), curve)
print("DictGrid")
for i in range(30):
	test_performance(DictGrid(9, 9), DictGrid(600, 600), curve)
print("FlatDictGrid")
for i in range(30):
	test_performance(FlatDictGrid(9, 9), FlatDictGrid(600, 600), curve)
print("npNestedGrid")
for i in range(30):
	test_performance(npNestedGrid(9, 9), npNestedGrid(600, 600), curve)