shader_type canvas_item;

uniform vec2 tiled_factor = vec2(5.0, 5.0);
uniform float aspect_ratio = 0.5;

void vertex() {

}

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspect_ratio;
	
	vec2 waves_uv_offset;
	waves_uv_offset.x = cos(TIME + tiled_uvs.x + tiled_uvs.y) * 5.0;
	waves_uv_offset.y = sin(TIME + tiled_uvs.x + tiled_uvs.y) * 1.0;
	
	COLOR = vec4(waves_uv_offset, 1.0, 1.0);
	COLOR = texture(TEXTURE, tiled_uvs + waves_uv_offset);

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
