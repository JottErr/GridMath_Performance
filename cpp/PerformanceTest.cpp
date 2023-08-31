#include "Curve.h"
#include "FlatGrid.h"
#include "NestedGrid.h"
#include <chrono>
#include <iostream>

template <typename GridType>
void performance_test(int size_templ, int size_grid, const Curve &curve) {
	GridType template_grid(size_templ, size_templ);
	GridType grid(size_grid, size_grid);
	template_grid.radiate_value_around_position(template_grid.get_center(), template_grid.get_center().x, curve, 1.0f);
	auto start = std::chrono::high_resolution_clock::now();
	for (int i = 0; i < grid.get_width(); i++) {
		for (int j = 0; j < grid.get_height(); j++) {
			grid.add_grid_at_pos(template_grid, Vector2i(i, j));
		}
	}
	auto end = std::chrono::high_resolution_clock::now();
	auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
	std::cout << duration / 1000000.0 << std::endl;
}

int main() {
	const Curve testcurve = { -1.0f, 1.0f, 0.0f, 1.0f };
	
	std::cout << "NestedGrid" << std::endl;
	for (int i = 0; i < 30; i++) {
		performance_test<NestedGrid>(9, 600, testcurve);
	}

	std::cout << "FlatGrid" << std::endl;
	for (int i = 0; i < 30; i++) {
		performance_test<FlatGrid>(9, 600, testcurve);
	}

	char waiter;
	std::cin >> waiter;

	return 0;
}