extends Node



func _ready() -> void:
	var testcurve := mCurve.new(-1.0, 1.0, 0.0, 1.0)
	test_performance(NestedGrid.new(9, 9), NestedGrid.new(600, 600), testcurve)
	test_performance(NestedGrid.new(75, 75), NestedGrid.new(75, 75), testcurve)


func test_performance(template: NestedGrid, grid: NestedGrid, curve: mCurve) -> void:
	template.radiate_value_around_position(template.center, template.center.x, curve)
	var start := Time.get_ticks_usec()
	for i in range(grid.width):
		for j in range(grid.height):
			grid.add_grid_at_pos(template, Vector2(i, j))
	var duration := Time.get_ticks_usec() - start
	print(duration / 1000000.0)
