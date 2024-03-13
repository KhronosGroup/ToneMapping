// Input color is non-negative and resides in the Linear Rec. 709 color space.
// Output color is also Linear Rec. 709, but in the [0, 1] range.

vec3 PBRNeutralToneMapping( vec3 color ) {
  const float startCompression = 0.8 - 0.04;
  const float desaturation = 0.15;

  const float x = min(color.r, min(color.g, color.b));
  const float offset = x < 0.08 ? x - 6.25 * x * x : 0.04;
  color -= offset;

  const float peak = max(color.r, max(color.g, color.b));
  if (peak < startCompression) return color;

  const float d = 1. - startCompression;
  const float newPeak = 1. - d * d / (peak + d - startCompression);
  color *= newPeak / peak;

  const float g = 1. - 1. / (desaturation * (peak - newPeak) + 1.);
  return mix(color, vec3(1, 1, 1), g);
}