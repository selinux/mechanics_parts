
/* =====================================================================================
 *
 *       Filename:  laser_focal_support.scad
 *
 *    Description:  support for two laser beam (red)
 *
 *        Version:  1.0
 *        Created:  28 07 2015
 *       Revision:  none
 *
 *       Compiler:  gcc
 *         Author:  Sebastien Chassot (sinux), sebastien.chassot@etu.hesge.ch
 *        Company:  HES-SO hepia section ITI (soir)
 *
 * ===================================================================================== */


difference(){
    /* main part */
    union(){
        linear_extrude(height=2, $fn=50)
            import("laser_focal_support_0.dxf");
                        

        linear_extrude(height=10, $fn=50)
            import("laser_focal_support_1.dxf");
    }                
 
    /* remove angle */
    rotate([0,90,60]){
        translate([0,0,0]){   
            linear_extrude(height=50, center=true, $fn=50){       
                import("laser_focal_support_2.dxf");
            }
            
        }
        
    }

    /* remove angle */
    rotate([0,90,150]){
        translate([0,0,0]){
            linear_extrude(height=50, center=true, $fn=50){
                import("laser_focal_support_2.dxf");
            }
        }
    }
}
 
 