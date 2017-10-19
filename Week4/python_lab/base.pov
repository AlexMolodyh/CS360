#include "Colors.inc"

camera{  
    //Look at whole page
    location <0, 6, -2>
    look_at <0, 0, -.5>
}

light_source { <10, 10, -5> White }    
   
//This is the paper with the 3 punch holes
difference {    
    //Paper
    box { <-2, 0, -3>, <2, .05, 3> pigment { White }
    finish { ambient 0.4 } }
    
    //Top, middle, and bottom punch holes     
    cylinder { <-1.8, -.01, 2.7> <-1.8, .05, 2.7>, .1 open } 
    cylinder { <-1.8, -.01, 0> <-1.8, .05, 0>, .1 open }
    cylinder { <-1.8, -.01, -2.7> <-1.8, .05, -2.7>, .1 open }  
}     
  
//The pencil
union { 
    //The eraser                                                  
    cylinder { <-.092, .16, 2.7>, <0, .16, 2.5>, .1 pigment { Pink } }     
    
    //The yellow stick
    cylinder { <0, .16, 2.5>, <1.4, .16, -.5>, .1 pigment { Yellow } finish { ambient 0.37 }}  
    
    //And two cones that make up the gray sharpened part and the black tip
    union {
        cone {
            <1.4, .16, -.5>, .1
            <1.49, .16, -.7>, .05
            pigment { Grey } 
        }
        cone {
            <1.49, .16, -.7>, .05
            <1.547, .16, -.83>, .01
            pigment { Black }
        }
    } 
    
    
}