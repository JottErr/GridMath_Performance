#include "Curve.h"
#include "FlatGrid.h"
#include <chrono>
#include <iostream>

void performance_test(FlatGrid &template_grid, FlatGrid &grid, const Curve &curve) {
	template_grid.radiate_value_around_position(template_grid.get_center(), template_grid.get_center().x, curve, 1.0f);
	auto start = std::chrono::high_resolution_clock::now();
	for (int i = 0; i < grid.get_width(); i++) {
		for (int j = 0; j < grid.get_height(); j++) {
			grid.add_grid_at_pos(template_grid, Vector2i(i, j));
			//template_grid.add_into_map_at_pos(testboard, position);
		}
	}
	auto end = std::chrono::high_resolution_clock::now();
	auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
	std::cout << "Laufzeit: " << duration << " Mikrosekunden" << std::endl;
}

int main() {
	const Curve testcurve = { -1.0f, 1.0f, 0.0f, 1.0f };
	FlatGrid t = FlatGrid(75, 75);
	FlatGrid g = FlatGrid(75, 75);
	performance_test(t, g, testcurve);
	char waiter;
	std::cin >> waiter;

	return 0;
}