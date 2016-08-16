/* ======================================================================
 *
 *       Filename:  axeX_bottom_profile.scad
 *
 *    Description:  bottom support for X,Z axe
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

axeX_bottom();


/* body X extrude */
module axeX_bottom() {

    difference() {
        /* body X extrude */
        intersection() {
            rotate([90, 0, 0])
                linear_extrude(height = 200, center = true, $fn=50)
                        import("../profiles/axeX_bottom_profile-s1.dxf");
    
            linear_extrude(height = 200, center = true, $fn=50)
                    import("../profiles/axeX_bottom_profile-s0.dxf");
        }
        
        intersection() {
            linear_extrude(height = 200, $fn=50)
                import("../profiles/axeX_bottom_profile-s2.dxf");
            rotate([90, 0, 0])
                linear_extrude(height = 200, center = true, $fn=50)
                    import("../profiles/axeX_bottom_profile-s3.dxf");
        }


        translate([20, 0, 53])
            cylinder(d=22, h=20);

        translate([-26, 0, 27])
            rotate([0, 0, -90])
                linear_extrude(height = 100, center = false, $fn=50)
                    import("../profiles/axeX_bottom_profile-s4.dxf");
        translate([-26, 0, 8])
            rotate([0, 0, -90])
                linear_extrude(height = 100, center = false, $fn=50)
                    import("../profiles/axeX_bottom_profile-s5.dxf");

        rotate([0,35,0])
            translate([28,0,0])
                cylinder(d=50,h=150, center=true);
        
        translate([7.5, -43-.15, 46])
            cube([20.3,20.3,50]);
        translate([7.5, 23-.15, 46])
            cube([20.3,20.3,50]);

        /* hole axe Z */
        translate([-26, 38, 0])
            cylinder(d = 7.5, center = true, h=50);
        translate([-26, -38, 0])
            cylinder(d = 7.5, center = true, h=50);
  
        rotate([90, 0, 0])
            translate([20, 32, 43])
                 cylinder(d = 30, h = 10, $fn=80);
        rotate([90, 0, 0])
            translate([20, 32, -53])
                 cylinder(d = 30, h = 10, $fn=80);
        
        translate([0,0,53]) {
                rotate([0,90,0]) {
                    translate([0, 33, 0])
                        cylinder(d = 5.3, h = 50, center = true, $fn = 80);
                    translate([0, -33, 0])
                        cylinder(d = 5.3, h = 50, center = true, $fn = 80);
                }       
        }        
        
        translate([-2.5, 0, 52])
            cube([10, 80, 50], center = true); 

    }
}