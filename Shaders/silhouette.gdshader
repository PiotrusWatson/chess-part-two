shader_type canvas_item;
uniform vec3 rgb = vec3(0.0, 0.0, 0.0);
void fragment() {
	float alpha = texture(TEXTURE, UV).a;
	COLOR = vec4(rgb, alpha);
}

