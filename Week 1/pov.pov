#include "textures.inc"

global_settings { ambient_light rgb 1}

camera { sky <0,0,1> direction <-1,0,0> right <-4/3,0,0> location <10,5,2> look_at <0,0,0> angle 40 }

sky_sphere { pigment { Bright_Blue_Sky } }

light_source { <7,8,9>, color rgb <1,1,1> fade_distance 20 fade_power 2 } 

intersection { 
	cone { <0,0,-2>, 2, <0,0,2>, 0 pigment { color rgb <1,0,0> } }
	plane { <2,1.5,2>, 0.7 finish { ambient 0 diffuse 0 reflection 1 } texture { Aluminum } }
}