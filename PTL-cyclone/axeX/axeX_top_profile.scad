/* ======================================================================
 *
 *       Filename:  axeX_top_profile.scad
 *
 *    Description:  top support for X,Z axe and motor
 *
 *        Version:  1.0
 *        Created:  24 07 2016
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

/* body X extrude */
module axeX_top() {

    difference() {
        /* body X extrude */
        intersection() {
            rotate([90, 0, 0])
                linear_extrude(height = 200, center = true, $fn=50)
                        import("../profiles/axeX_top_profile-s1.dxf");
    
            linear_extrude(height = 200, center = true, $fn=50)
                    import("../profiles/axeX_top_profile-s0.dxf");
        }

        translate([0,0,8+100/2])
            cube([200, 46, 100], center=true);
        translate([35, -38, 33])
            cube([30,10,50]);
        translate([35, 28, 33])
            cube([30,10,50]);
        
        
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
                
        translate([0,0,43]) {
                rotate([0,90,0]) {
                    translate([0, 33, 0])
                        cylinder(d = 5.3, h = 100, center = true, $fn = 80);
                    translate([0, -33, 0])
                        cylinder(d = 5.3, h = 100, center = true, $fn = 80);
                }
       }                
    }
    translate([17.5, 0, 8]) {
        translate([0, 33, 0])
            linear_extrude(height = 4, $fn=50)
            import("../profiles/profile_20x20_negatif.dxf");
        translate([0, -33, 0])
            linear_extrude(height = 4, $fn=50)
            import("../profiles/profile_20x20_negatif.dxf");
    }
}