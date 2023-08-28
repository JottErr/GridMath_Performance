#ifndef VECTOR2I_H
#define VECTOR2I_H

struct Vector2i {
	int x;
	int y;

	Vector2i() : x(0), y(0) {}
	Vector2i(const int p_x, const int p_y) : x(p_x), y(p_y) {}
};

#endif // !VECTOR2I_H