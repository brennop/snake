extern vec2 pos;
extern vec2 resolution;
extern vec2 size;
extern float rotation;

//
// adapted from here
// https://thndl.com/square-shaped-shaders.html
//
// i have very little understanding of how this works
// but it works 🤷
//

mat2 rotate(float angle) {
  return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

vec4 effect(vec4 color, Image image, vec2 texture_coords, vec2 screen_coords) {
  float aspect = resolution.x / resolution.y;
  vec2 uv = screen_coords / resolution.y + 0.5;

  uv -= vec2(pos.x * aspect, pos.y) / resolution;
  uv = mod(uv * resolution, vec2(resolution.x * aspect, resolution.y)) / resolution;
  uv -= 0.5;
  uv *= rotate(-rotation);

  // scale to size
  uv *= (resolution.x/size);

  float radius = 0.6;
  float scale = 0.4;

  float r = step(radius, length(max(abs(uv) - scale, 0.0)));

  float s = 1.0 - r;

  return vec4(s);
}

