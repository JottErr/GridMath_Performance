extends Node


func _ready() -> void:
	var testcurve := mCurve.new(-1.0, 1.0, 0.0, 1.0)

	test_performance(NestedGrid.new(9, 9), NestedGrid.new(600, 600), testcurve)
	test_performance(NestedGridRect.new(9, 9), NestedGridRect.new(600, 600), testcurve)
	test_performance(FlatGrid.new(9, 9), FlatGrid.new(600, 600), testcurve)
	test_performance(DictGrid.new(9, 9), DictGrid.new(600, 600), testcurve)

	test_performance(NestedGrid.new(75, 75), NestedGrid.new(75, 75), testcurve)
	test_performance(NestedGridRect.new(75, 75), NestedGridRect.new(75, 75), testcurve)
	test_performance(FlatGrid.new(75, 75), FlatGrid.new(75, 75), testcurve)
	test_performance(DictGrid.new(75, 75), DictGrid.new(75, 75), testcurve)


func test_performance(template, grid, curve: mCurve) -> void:
	template.radiate_value_around_position(template.center, template.center.x, curve)
	var start := Time.get_ticks_usec()
	for i in range(grid.width):
		for j in range(grid.height):
			grid.add_grid_at_pos(template, Vector2(i, j))
	var duration := Time.get_ticks_usec() - start
	print(duration / 1000000.0)
