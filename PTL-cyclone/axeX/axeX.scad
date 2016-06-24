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

include <libs/MCAD/stepper.scad>
include <libs/MCAD/nuts_and_bolts.scad>
use <libs/linear_bearing.scad>


    
/* body X extrude */
difference(){
    intersection() {
        rotate([90, 0, 0])
            linear_extrude(height = 100, center = true, $fn=50)
                    import("axeX_bottom_profile-0.dxf");

        linear_extrude(height = 200, center = true, $fn=50)
                import("axeX_bottom_profile-2.dxf");
    }

    intersection() {
        rotate([90, 0, 0])
            linear_extrude(height = 100, center = true, $fn=50)
                    import("axeX_bottom_profile-1.dxf");

        linear_extrude(height = 200, center = true, $fn=50)
                import("axeX_bottom_profile-3.dxf");
    }
    
    /* hole axe Z */
    translate([-26, 38, 14])
        cylinder(d = 7.5, h=50, $fn = 50);
    translate([-26, -38, 14])
        cylinder(d = 7.5, h=50, $fn = 50);
    
    /* bottom hole */
    translate([24, 0, 0])
        rotate([0,15,0])
        cylinder(d = 20, h = 70, center = true, $fn = 50);
}

screw = 3.5;
nuts = 6.5;

translate([0,0,174])
    rotate([180, 0, 0])
        difference(){
            /* body X extrude */
            intersection() {
                rotate([90, 0, 0])
                    linear_extrude(height = 100, center = true, $fn=50)
                            import("axeX_top_profile-0.dxf");

                linear_extrude(height = 200, center = true, $fn=50)
                        import("axeX_top_profile-1.dxf");
            }

            /* hole axe Z */
            translate([-26, 38, 0])
                cylinder(d = 7.5, center = true, h=50);
            translate([-26, -38, 0])
                cylinder(d = 7.5, center = true, h=50);
    
            /* motor hole */
            translate([21, 0, 0])
                cylinder(d = 25.5, center = true, h=50);
            translate([0, -20, 8])
                cube([55, 40, 40]);
    
            /* motor screw holes */
            translate([21, 0, 0]) {
                translate([15.52, 15.52, 5]) {
                    cylinder(d = screw, center = true, h=50);
                    cylinder(d = nuts, h = 5, $fn = 6);
            }
            translate([15.52, -15.52, 5]) {
                    cylinder(d = screw, center = true, h=50);
                    cylinder(d = nuts, h = 5, $fn = 6);
            }
            translate([-15.52, 15.52, 5]) {
                cylinder(d = screw, center = true, h=50);
                cylinder(d = nuts, h = 5, $fn = 6);
            }
            translate([-15.52, -15.52, 5]) {
                cylinder(d = screw, center = true, h=50);
                cylinder(d = nuts, h = 5, $fn = 6);
            }
        }
}

translate([-30, 0,-20]) {

	color([0.2,0.2,0.2]) %cylinder(r1=30/2, r2=50/2, h=40, $fn=80);
	translate([0,0,40])
		color([0.2,0.2,0.2]) %cylinder(d=50, h=90, $fn=80);
	translate([0,0,50+80])
		color([0.2,0.2,0.2]) %cylinder(d1=50, d2=30, h=10, $fn=80);
	translate([0,0,-20])
		color([0.4,0.4,0.4]) %cylinder(d1=12, d2=10, h=20, $fn=80);
	translate([0,0,-20-20])
		color([0.9,0.9,0.9]) %cylinder(d1=0.5, d2=3, h=20, $fn=80);
}

translate([20, 0, 172])
    motor(Nema17, NemaMedium, dualAxis=false);
translate([20, 0, 40])
    color([0.5, 0.5, 0.5]) %cylinder(d=10, h=130, $fn=50);
rotate([-90, 0, 0])
    translate([20, -20, 160])
        motor(Nema17, NemaMedium, dualAxis=false);

translate([-27, 38, 8]) {
    color([0.4, 0.4, 0.4]) %cylinder(d=8, h=170, $fn=50);
    translate([0, 0, 15])linearBearing(model="LM8UU");
    translate([0, 0, 60])linearBearing(model="LM8UU");
}
translate([-27, -38, 8]) {
    color([0.4, 0.4, 0.4]) %cylinder(d=8, h=170, $fn=50);
    translate([0, 0, 15])linearBearing(model="LM8UU");
    translate([0, 0, 60])linearBearing(model="LM8UU");
}

rotate([90, 0, 0]) {
        color([0.4, 0.4, 0.4]) %cylinder(d=8, h=300, center=true, $fn=50);
        translate([0, 0, -50])linearBearing(model="LM8UU");
        translate([0, 0, 25])linearBearing(model="LM8UU");
}
translate([40, 0, 158])
    rotate([90, 0, 0]) {
            color([0.4, 0.4, 0.4]) %cylinder(d=8, h=300, center=true, $fn=50);
            translate([0, 0, -50])linearBearing(model="LM8UU");
            translate([0, 0, 25])linearBearing(model="LM8UU");
    }
translate([20, 0, 20])
rotate([90, 0, 0])
    color([0.4, 0.4, 0.4]) %cylinder(d=10, h=300, center=true, $fn=50);
