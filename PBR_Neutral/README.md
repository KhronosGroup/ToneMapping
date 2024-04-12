# Khronos PBR Neutral Tone Mapper

For details on how this tone mapper was developed and what problems it solves, please see the [write-up](https://modelviewer.dev/examples/tone-mapping), complete with interactive graphics. You can also test it interactively against other tone mappers with your own GLBs and HDR lighting [here](https://tone-mapping.glitch.me/). Included files:
- **pbrNeutral.glsl** a sample implementation of this tone mapping function.
- **config.ocio** an OpenColorIO configuration defining an approximation of this tone mapper.
- **pbrNeutral.cube** the LUT referenced by config.ocio.
- **lut-writer.mjs** a script for generating the pbrNeutral.cube LUT and verifying the analytical inverse function.

Currently this tone mapper only supports output to sRGB, but the goal is to expand that in the future. This tone mapper does not apply any gamut mapping, as it is assumed the PBR workflow uses Rec. 709 gamut for both input color textures and lighting (as in glTF), and thus the linear output is already contained within Rec. 709. 

## PBR Neutral Specification

$\mathbf c_{in}=[R,G,B]$, non-negative linear input color, in the Rec. 709 gamut.  
$F_{90}=0.04$, Fresnel reflection at normal incidence of common IoR = 1.5 materials.  
$K_s=0.8-F_{90}$, parameter controlling when highlight compression starts.  
$K_d=0.15$, parameter controlling the speed of desaturation.  

Note that all the following entities will be positive for all non-negative input.  
$x=\min\left(R,G,B\right)$  

$$f=\begin{cases} 
x-\frac{x^2}{4F_{90}} & x\leq 2F_{90} \\
F_{90} & x\gt 2F_{90}
\end{cases}$$

$p=\max\left(R-f,G-f,B-f\right)$  
$p_n=1-\frac{\left(1-K_s\right)^2}{p+1-2K_s}$  
$g=\frac{1}{K_d\left(p-p_n\right)+1}$  

$$\mathbf c_{out}=\begin{cases} 
\mathbf c_{in}-f & p\leq K_s \\
\left(\mathbf c_{in}-f\right)\frac{p_n}{p}g+[p_n,p_n,p_n] (1-g) & p\gt K_s
\end{cases}$$

$\mathbf c_{out}$ is the linear output color, still in Rec. 709, but now in the [0, 1] range.

Three notes regarding these equations:
- $\mathbf c_{out}=\mathbf c_{in}-F_{90}$ for all input colors where $0.08\leq R\leq 0.8$, $0.08\leq G\leq 0.8$, and $0.08\leq B\leq 0.8$. This gives the range of base colors for which the guarantee holds that the base color will be exactly reproduced in the output render for a shiny dielectric material facing the camera under unitary-white lighting. 
- All partial derivatives of $\mathbf c_{out}$ with respect to $\mathbf c_{in}$ are continuous over the entire domain, vanishing at the boundaries, which is what reduces visual artifacts.
- This mapping is 1:1 and onto, and analytically invertible. 
