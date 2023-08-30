#include "NestedGrid.h"
#include <algorithm>

NestedGrid::NestedGrid(int width, int height)
	: width(width), height(height) {
	center = Vector2i(width / 2, height / 2);
	grid = new float* [width];
	for (int x = 0; x < width; x++) {
		grid[x] = new float[height]();
	}
}

NestedGrid::~NestedGrid() {
	for (int x = 0; x < width; x++) {
		delete[] grid[x];
	}
	delete[] grid;
}

void NestedGrid::set_cell_value(const Vector2i &position, float value) {
	if (has_cell(position)) {
		grid[position.x][position.y] = value;
	}
}

float NestedGrid::get_cell_value(const Vector2i &position) const {
	if (has_cell(position)) {
		return grid[position.x][position.y];
	}
	return 0.0f;
}

void NestedGrid::clear_grid() {
	for (int y = 0; y < height; y++) {
		for (int x = 0; x < width; x++) {
			grid[x][y] = 0.0f;
		}
	}
}

void NestedGrid::radiate_value_around_position(const Vector2i &position, int radius, const Curve &curve, float magnitude) {
	int start_x = position.x - radius;
	int start_y = position.y - radius;
	int end_x = position.x + radius + 1;
	int end_y = position.y + radius + 1;

	int min_x = std::max(0, start_x);
	int min_y = std::max(0, start_y);
	int max_x = std::min(end_x, width);
	int max_y = std::min(end_y, height);

	for (int y = min_y; y < max_y; y++) {
		for (int x = min_x; x < max_x; x++) {
			float distance = std::hypotf(position.x - x, position.y - y);
			distance = std::min(1.0f, distance / radius);
			float value = curve.calculate_value(distance);
			grid[x][y] = value * magnitude;
		}
	}
}

void NestedGrid::add_grid_at_pos(const NestedGrid &other_grid, const Vector2i &position, float magnitude) {
	int start_x = position.x - other_grid.get_center().x;
	int start_y = position.y - other_grid.get_center().y;
	int end_x = position.x + other_grid.get_center().x + 1;
	int end_y = position.y + other_grid.get_center().y + 1;

	int min_x = std::max(0, start_x);
	int min_y = std::max(0, start_y);
	int max_x = std::min(end_x, width);
	int max_y = std::min(end_y, height);

	for (int y = min_y; y < max_y; y++) {
		for (int x = min_x; x < max_x; x++) {
			int other_x = x - start_x;
			int other_y = y - start_y;
			float other_value = other_grid.grid[other_x][other_y];
			grid[x][y] += other_value * magnitude;
		}
	}
}