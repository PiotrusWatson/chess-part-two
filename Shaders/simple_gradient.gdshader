shader_type canvas_item;
render_mode blend_mix;
uniform sampler2D gradient;

void fragment() {
	COLOR.a = texture(TEXTURE, UV).a;
	vec2 my_uv = vec2(UV.y*10.0, UV.x*10.0);
	COLOR.rgb = COLOR.rgb * texture(gradient, my_uv).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
