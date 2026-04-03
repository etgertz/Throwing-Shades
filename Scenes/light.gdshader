shader_type canvas_item;

uniform sampler2D window_texture;
uniform vec2 light_source = vec2(0.5, 0.0); // position of light origin in UV space
uniform int samples = 50;
uniform float density = 0.5;
uniform float weight = 0.1;
uniform float decay = 0.96;
uniform float exposure = 0.3;

void fragment(){
    vec2 uv = UV;
    vec2 delta = (uv - light_source) * (1.0 / float(samples)) * density;
    float illumination = 1.0;
    vec4 color = vec4(0.0);

    for(int i = 0; i < samples; i++){
        uv -= delta;
        vec4 sample = texture(window_texture, uv);
        sample *= illumination * weight;
        color += sample;
        illumination *= decay;
    }
    COLOR = color * exposure;
}
