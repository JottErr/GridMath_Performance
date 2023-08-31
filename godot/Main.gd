extends Node


func _ready() -> void:
	var testcurve := mCurve.new(-1.0, 1.0, 0.0, 1.0)
	print("NestedGrid")
	for i in range(30):
		print(test_performance(NestedGrid.new(9, 9), NestedGrid.new(600, 600), testcurve))
	print("FlatGrid")
	for i in range(30):
		print(test_performance(FlatGrid.new(9, 9), FlatGrid.new(600, 600), testcurve))
	print("DictGrid")
	for i in range(30):
		print(test_performance(DictGrid.new(9, 9), DictGrid.new(600, 600), testcurve))


func test_performance(template, grid, curve: mCurve) -> String:
	template.radiate_value_around_position(template.get_center(), template.get_center().x, curve)
	var start := Time.get_ticks_usec()
	for i in range(grid.get_width()):
		for j in range(grid.get_height()):
			grid.add_grid_at_pos(template, Vector2(i, j))
	var duration := Time.get_ticks_usec() - start
	return str(duration / 1000000.0)
