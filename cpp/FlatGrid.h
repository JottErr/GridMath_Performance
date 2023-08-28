#ifndef FLATGRID_H
#define FLATGRID_H

#include "Curve.h"
#include "Vector2i.h"
#include <cmath>

class FlatGrid {
private:
	int width;
	int height;
	Vector2i center;
	float* grid;
public:
	FlatGrid(int width, int height);
	~FlatGrid();

	inline bool has_cell(const Vector2i& position) const {
		return position.x >= 0 && position.x < width && position.y >= 0 && position.y < height;
	}
	void set_cell_value(const Vector2i& position, float value);
	float get_cell_value(const Vector2i& position) const;
	void clear_grid();
	int get_width() const { return width; };
	int get_height() const { return height; };
	Vector2i get_center() const { return center; };
	void radiate_value_around_position(const Vector2i& position, int radius, const Curve& curve, float magnitude = 1.0f);
	void add_grid_at_pos(const FlatGrid& other_grid, const Vector2i& position, float magnitude = 1.0f);

};

#endif // FLATGRID_H