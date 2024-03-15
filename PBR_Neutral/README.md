# Khronos PBR Neutral Tone Mapper
For details on how this tone mapper was developed and what problems it solves, please see the [write-up](https://modelviewer.dev/examples/tone-mapping), complete with interactive graphics. You can also test it interactively against other tone mappers with your own GLBs and HDR lighting [here](https://tone-mapping.glitch.me/). Included files:
- **pbrNeutral.glsl** the official equations defining this tone mapping function.
- **config.ocio** an OpenColorIO configuration defining an approximation of this tone mapper.
- **pbrNeutral.cube** the LUT referenced by config.ocio.
- **lut-writer.mjs** a script for generating the pbrNeutral.cube LUT and verifying the analytical inverse function.

Currently this tone mapper only supports output to sRGB, but the goal is to expand that in the future. This tone mapper does not apply any gamut mapping, as it is assumed the PBR workflow uses Rec. 709 gamut for both input color textures and lighting (as in glTF), and thus the linear output is already contained within Rec. 709. 