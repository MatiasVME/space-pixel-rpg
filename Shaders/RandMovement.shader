shader_type canvas_item;

void vertex() {
	VERTEX.x += cos(TIME + VERTEX.x + VERTEX.y) * 2.0;
	VERTEX.y += sin(TIME + VERTEX.y + VERTEX.x) * 2.0;
}