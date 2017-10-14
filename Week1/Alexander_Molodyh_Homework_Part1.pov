#include "Colors.inc"

camera{  
    //Look at eraser        
    //location <0, 2, 2>
    //look_at <0, 0, 2.7>
         
    //Look at whole page
    location <0, 6, -2>
    look_at <0, 0, -.5>
    
    //Look at tip of pencil 
    //location <2, 2, -.5>
    //look_at <1.4, .16, -.4>
}

light_source { <10, 10, -5> White }     

//background { color rgb<1,1,1>*0.02 }

difference {  
    box { <-2, 0, -3>, <2, .05, 3> pigment { White }
    finish { ambient 0.4 } }   
                
    cylinder { <-1.8, -.01, 2.7> <-1.8, .05, 2.7>, .1 open } 
    cylinder { <-1.8, -.01, 0> <-1.8, .05, 0>, .1 open }
    cylinder { <-1.8, -.01, -2.7> <-1.8, .05, -2.7>, .1 open }  
}     

union {                                                  
    cylinder { <-.092, .16, 2.7>, <0, .16, 2.5>, .1 pigment { Pink } }
    cylinder { <0, .16, 2.5>, <1.4, .16, -.5>, .1 pigment { Yellow } finish { ambient 0.37 }}
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