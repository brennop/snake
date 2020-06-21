extern vec2 pos;
extern vec2 resolution;
extern vec2 size;
extern float rotation;

float rect(vec2 position, vec2 scale) {
  scale = 0.5 - scale * 0.5;
  vec2 shaper = step(scale, position) * step(scale, 1.0 - position);
  return shaper.x * shaper. y;
}

mat2 rotate(float angle) {
  return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

vec4 effect(vec4 color, Image image, vec2 texture_coords, vec2 screen_coords) {
  vec2 position = screen_coords / resolution - 0.5;
  position -= pos / resolution;
  vec2 scale = size / resolution;
  position = mod(position * resolution, resolution) / resolution;
  
  position -= vec2(0.5);
  position = rotate(rotation) * position;
  position += vec2(0.5);

  float rectangle = rect(position, vec2(scale.x));

  return vec4(rectangle);
}

