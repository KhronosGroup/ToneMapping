# Tone Mappers
A collection of tone mappers for the display of 3D graphics, specifically for converting HDR linear light from PBR that has orders of magnitude larger range than the best HDR TVs, down to SDR or other display device output ranges.

## PBR Neutral
A tone mapper designed specifically for PBR color accuracy, to get sRGB colors in the output render that match as faithfully as possible the input sRGB baseColor under gray-scale lighting. This is aimed toward product photography use cases, where the scene is well-exposed and HDR color values are mostly restricted to small specular highlights. 
