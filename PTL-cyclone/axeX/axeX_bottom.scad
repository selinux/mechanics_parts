/* ======================================================================
 *
 *       Filename:  axeX_bottom.scad
 *
 *    Description:  bottom support for X axe screw and bearing
 *
 *        Version:  1.0
 *        Created:  11 06 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================
 */
include <../libs/MCAD/motors.scad>

screw = 4.5;
nuts = 8;

//axeX_top();
//axeX_bottom();
axeX();
module axeX() {
    difference() {
        union() {
            translate([0, 0, 200])
                rotate([180, 0, 0])
                    axeX_top();
            axeX_bottom();
        }
    translate([40, 0, 200-16])
        rotate([90, 0, 0])
            cylinder(d =16, h = 200, center = true, $fn = 80);
    translate([20, -26, 19])
        rotate([90, 0, 0])
            cylinder(d =25, h = 50, $fn = 80);
    }
    translate([20, 26+50, 19])
        rotate([90, 0, 0])
            cylinder(d =25, h = 50, $fn = 80);
    }
}
/* body X extrude */
module axeX_bottom() {

    difference(){
        /* body X extrude */
        intersection() {
            rotate([90, 0, 0])
                linear_extrude(height = 384, center = true, $fn=50)
                    import("../profiles/axeX_bottom-s0.dxf");

            linear_extrude(height = 384, center = true, $fn=50)
                import("../profiles/axeX_bottom-s2.dxf");
            
            rotate([90, 0, 90])
                linear_extrude(height = 384, center = true, $fn=50)
                    import("../profiles/axeX_bottom-s4.dxf");  
        }
        
        intersection() {
            rotate([90, 0, 0])
                linear_extrude(height = 384, center = true, $fn=50)
                        import("../profiles/axeX_bottom-s1.dxf");
    
            linear_extrude(height = 384, center = true, $fn=50)
                    import("../profiles/axeX_bottom-s3.dxf");
        }

        /* hole axe Z */
        translate([-26, 38, 0])
            cylinder(d = 7.5, center = true, h=50);
        translate([-26, -38, 0])
            cylinder(d = 7.5, center = true, h=50);
        /* bottom hole */
        translate([24, 0, 0])
            rotate([0,15,0])
            cylinder(d = 20, h = 70, center = true, $fn = 50);
    
    }
}

module axeX_top() {
    difference() {
        /* body X extrude */
        intersection() {
            intersection() {
                rotate([90, 0, 0])
                    linear_extrude(height = 100, center = true, $fn=50)
                            import("../profiles/support_motor_axeX-s0.dxf");
        
                linear_extrude(height = 60, center = true, $fn=50)
                        import("../profiles/support_motor_axeX-s1.dxf");
            }
            rotate([90, 0, 90])
                linear_extrude(height = 200, center = true, $fn=50)
                        import("../profiles/support_motor_axeX-s2.dxf");
        }
        /* screw holes */
        translate([-33.5, 33, 4])
            rotate([90, 0, 0])
                union() {
                    cylinder(d=3.5, h=40, center=true, $fn=50);
                    cylinder(d=6.5, h=20, $fn=6);
                }
        translate([-33.5, -33, 4])
            rotate([-90, 0, 0])
                union() {
                    cylinder(d=3.5, h=40, center=true, $fn=50);
                    cylinder(d=6.5, h=20, $fn=6);
                }        

        /* hole axe Z */
        translate([-26, 38, 0])
            cylinder(d = 7.5, center = true, h=50);
        translate([-26, -38, 0])
            cylinder(d = 7.5, center = true, h=50);
        
        /* motor hole */
        translate([21, 0, 0])
            linear_extrude(height = 2*6, $fn=50)
                rotate([0, 0, 90])
                    stepper_motor_mount(17,slide_distance=3, mochup=true, 
        tolerance=0);
    }
}