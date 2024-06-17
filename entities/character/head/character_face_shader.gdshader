shader_type spatial;

uniform sampler2D face : source_color;
uniform sampler2D face_blink : source_color;

uniform float blink_offset : hint_range(0, 1) = 0.;
uniform float blink_speed = 2.;
uniform float blink_frequency = 2.;

void fragment() {
	float blink_time = fract((TIME + blink_offset) * blink_speed) * (1. / blink_frequency);
	blink_time = round(min(blink_time, 1));
	
	vec4 face_color = texture(face, UV);
	vec4 face_blink_color = texture(face_blink, UV);
	
	vec4 result = mix(face_blink_color, face_color, blink_time);
	
	ALBEDO = result.rgb;
	ALPHA = result.a;
}
