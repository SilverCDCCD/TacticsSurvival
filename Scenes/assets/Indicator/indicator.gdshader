shader_type spatial;
render_mode unshaded;

uniform float brightness = 1.0;
uniform vec3 color = vec3(1, 1, 0);

bool inCorner(vec2 loc) {
	if (loc.x < .05 || loc.x > .95) {
		return loc.y < .15 || loc.y > .85;
	}
	else if (loc.y < .03 || loc.y > .97) {
		return loc.x < .15 || loc.x > .85;
	}
	else return false;
}

void fragment() {
	ALBEDO = color * brightness;
	ALPHA = (inCorner(UV)) ? 0.5 : 0.0;
}

void vertex() {
	VERTEX *= 0.9 + (cos(TIME * 8.0) * 0.1);
}
