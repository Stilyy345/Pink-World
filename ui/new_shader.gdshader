shader_type canvas_item;

uniform float speed = 2.5;
uniform float frequency = 8.0;

void fragment() {
	vec4 base = texture(TEXTURE, UV);

	// ако няма пиксел (прозрачно) → нищо не рисуваме
	if (base.a < 0.01) {
		discard;
	}

	float t = TIME * speed;

	float r = 0.5 + 0.5 * sin(t + UV.x * frequency);
	float g = 0.5 + 0.5 * sin(t + UV.x * frequency + 2.1);
	float b = 0.5 + 0.5 * sin(t + UV.x * frequency + 4.2);

	COLOR = vec4(r, g, b, base.a);
}